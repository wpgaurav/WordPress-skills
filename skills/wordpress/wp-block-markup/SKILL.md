---
name: wp-block-markup
description: "WordPress block markup syntax and HTML structure. Understand block delimiters, attributes, nesting, and how blocks serialize to the database. Based on Gutenberg source code."
compatibility: "WordPress 6.1+. List-item blocks required since 6.1. Verified against Gutenberg trunk April 2026."
---

# WordPress Block Markup Syntax

## When to Use

Use this skill when:
- Writing raw block markup for patterns, templates, or REST API content pushes
- Debugging block validation errors ("Block contains unexpected content")
- Converting HTML to block format programmatically
- Working with block templates in PHP
- Understanding how blocks serialize to `post_content`

## Block Grammar

WordPress blocks use HTML comments as delimiters. The content between comments is valid HTML that the parser reconstructs on load.

### Three Block Forms

```html
<!-- 1. Balanced block (opening + closing) -->
<!-- wp:paragraph -->
<p>Content here.</p>
<!-- /wp:paragraph -->

<!-- 2. Self-closing / void block (no inner HTML) -->
<!-- wp:latest-posts {"postsToShow":5} /-->

<!-- 3. Balanced block with attributes -->
<!-- wp:image {"id":123,"sizeSlug":"large"} -->
<figure class="wp-block-image size-large">
  <img src="image.jpg" alt="" class="wp-image-123"/>
</figure>
<!-- /wp:image -->
```

### Naming Rules

Core blocks omit the namespace. Custom blocks require one.

```html
<!-- wp:paragraph -->        ✓  Core block (no namespace)
<!-- wp:core/paragraph -->   ✗  Never use core/ prefix
<!-- wp:acf/callout -->      ✓  Custom block with namespace
```

## Attribute Serialization

### Two Storage Locations

Block attributes are stored in **two places**, not one:

| Location | What Goes Here | Example |
|----------|---------------|---------|
| **Comment JSON** | Values not derivable from HTML: IDs, booleans, enums, style objects, layout config | `{"id":123,"sizeSlug":"large"}` |
| **HTML content** | Values sourced from the DOM: text content, `src`, `href`, `alt`, CSS classes | `<img src="..." alt="..."/>` |

The block's `block.json` defines which attributes go where via the `source` property:

```
source: (none)     → stored in comment JSON
source: "attribute"→ read from HTML element attribute (src, href, alt, etc.)
source: "html"     → read from element innerHTML
source: "text"     → read from element textContent
```

### JSON Format Rules

```html
<!-- wp:image {"id":123,"sizeSlug":"large","linkDestination":"media"} -->
```

- Valid JSON object (double quotes, no trailing commas)
- Compact format: no spaces after colons or commas (`{"key":"val"}` not `{ "key" : "val" }`)
- Omit attributes with default values (keeps markup clean)
- Attribute order doesn't matter
- Must be single line (no line breaks in JSON)

### Common Attribute Patterns

**Colors (palette preset):**
```json
{"backgroundColor":"primary","textColor":"white"}
```
Produces: `class="has-primary-background-color has-white-color has-text-color has-background"`

**Colors (custom hex):**
```json
{"style":{"color":{"background":"#ff0000","text":"#ffffff"}}}
```
Produces: `class="has-text-color has-background" style="color:#ffffff;background-color:#ff0000"`

**Typography:**
```json
{"style":{"typography":{"fontSize":"1.5rem","fontWeight":"700","lineHeight":"1.4"}}}
```

**Typography (preset):**
```json
{"fontSize":"large"}
```
Produces: `class="has-large-font-size"`

**Spacing:**
```json
{"style":{"spacing":{"padding":{"top":"2rem","right":"1rem","bottom":"2rem","left":"1rem"},"margin":{"top":"0","bottom":"2rem"}}}}
```

**Border:**
```json
{"style":{"border":{"radius":"8px","width":"1px","color":"#e0e0e0","style":"solid"}}}
```

**Layout:**
```json
{"layout":{"type":"constrained","contentSize":"1200px"}}
{"layout":{"type":"flex","flexWrap":"nowrap","justifyContent":"space-between"}}
```

**Alignment:**
```json
{"align":"full"}
{"align":"wide"}
{"textAlign":"center"}
```

## Block Reference

### Paragraph

No special class by default. Attributes in comment only when non-default.

```html
<!-- wp:paragraph -->
<p>Plain text paragraph.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph {"dropCap":true} -->
<p class="has-drop-cap">First letter is large.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph {"align":"center"} -->
<p class="has-text-align-center">Centered text.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph {"className":"is-style-notice"} -->
<p class="is-style-notice">Custom style variant.</p>
<!-- /wp:paragraph -->

<!-- wp:paragraph {"style":{"typography":{"fontSize":"1.125rem"},"color":{"text":"#555555"}}} -->
<p class="has-text-color" style="color:#555555;font-size:1.125rem">Styled paragraph.</p>
<!-- /wp:paragraph -->
```

### Heading

`level` attribute controls `<h1>`-`<h6>`. Default is 2 (omit from JSON when level=2).

```html
<!-- wp:heading -->
<h2 class="wp-block-heading">Default H2</h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":3} -->
<h3 class="wp-block-heading">H3 Heading</h3>
<!-- /wp:heading -->

<!-- wp:heading {"level":1,"style":{"typography":{"fontSize":"3rem","fontWeight":"800"}}} -->
<h1 class="wp-block-heading" style="font-size:3rem;font-weight:800">Large H1</h1>
<!-- /wp:heading -->

<!-- wp:heading {"textAlign":"center"} -->
<h2 class="wp-block-heading has-text-align-center">Centered H2</h2>
<!-- /wp:heading -->

<!-- With HTML anchor (for TOC links) -->
<!-- wp:heading {"anchor":"my-section"} -->
<h2 class="wp-block-heading" id="my-section">My Section</h2>
<!-- /wp:heading -->
```

### List + List Item

Lists are container blocks. Each `<li>` must be wrapped with `<!-- wp:list-item -->` delimiters. This is required since WordPress 6.1.

```html
<!-- Unordered list -->
<!-- wp:list -->
<ul class="wp-block-list">
<!-- wp:list-item -->
<li>First item</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li>Second item</li>
<!-- /wp:list-item -->
</ul>
<!-- /wp:list -->

<!-- Ordered list -->
<!-- wp:list {"ordered":true} -->
<ol class="wp-block-list">
<!-- wp:list-item -->
<li>Step one</li>
<!-- /wp:list-item -->

<!-- wp:list-item -->
<li>Step two</li>
<!-- /wp:list-item -->
</ol>
<!-- /wp:list -->

<!-- Ordered with start number -->
<!-- wp:list {"ordered":true,"start":5} -->
<ol class="wp-block-list" start="5">
<!-- wp:list-item -->
<li>Fifth item</li>
<!-- /wp:list-item -->
</ol>
<!-- /wp:list -->

<!-- Nested list -->
<!-- wp:list -->
<ul class="wp-block-list">
<!-- wp:list-item -->
<li>Parent item
<!-- wp:list -->
<ul class="wp-block-list">
<!-- wp:list-item -->
<li>Nested child</li>
<!-- /wp:list-item -->
</ul>
<!-- /wp:list -->
</li>
<!-- /wp:list-item -->
</ul>
<!-- /wp:list -->
```

**Common mistake:** Omitting `<!-- wp:list-item -->` wrappers. Without them, the editor shows the list as a single Classic block or triggers block recovery.

### Image

`url`, `alt`, `caption` are sourced from the HTML. `id`, `sizeSlug`, `linkDestination` go in comment JSON.

```html
<!-- Basic image -->
<!-- wp:image {"id":123,"sizeSlug":"large"} -->
<figure class="wp-block-image size-large">
<img src="https://example.com/image.jpg" alt="Description" class="wp-image-123"/>
</figure>
<!-- /wp:image -->

<!-- With caption -->
<!-- wp:image {"id":123,"sizeSlug":"large"} -->
<figure class="wp-block-image size-large">
<img src="image.jpg" alt="" class="wp-image-123"/>
<figcaption class="wp-element-caption">Image caption here</figcaption>
</figure>
<!-- /wp:image -->

<!-- With link wrapping the image -->
<!-- wp:image {"id":123,"sizeSlug":"large","linkDestination":"custom"} -->
<figure class="wp-block-image size-large">
<a href="https://example.com"><img src="image.jpg" alt="" class="wp-image-123"/></a>
</figure>
<!-- /wp:image -->

<!-- Aligned and resized -->
<!-- wp:image {"id":123,"align":"right","width":"300px"} -->
<figure class="wp-block-image alignright is-resized">
<img src="image.jpg" alt="" class="wp-image-123" style="width:300px"/>
</figure>
<!-- /wp:image -->
```

### Table

```html
<!-- wp:table -->
<figure class="wp-block-table">
<table>
<thead>
<tr><th>Header 1</th><th>Header 2</th></tr>
</thead>
<tbody>
<tr><td>Cell 1</td><td>Cell 2</td></tr>
<tr><td>Cell 3</td><td>Cell 4</td></tr>
</tbody>
</table>
</figure>
<!-- /wp:table -->

<!-- Fixed layout with caption -->
<!-- wp:table {"hasFixedLayout":true} -->
<figure class="wp-block-table">
<table class="has-fixed-layout">
<thead><tr><th>Name</th><th>Price</th></tr></thead>
<tbody><tr><td>Item</td><td>$10</td></tr></tbody>
</table>
<figcaption class="wp-element-caption">Table caption</figcaption>
</figure>
<!-- /wp:table -->

<!-- Striped style -->
<!-- wp:table {"className":"is-style-stripes"} -->
<figure class="wp-block-table is-style-stripes">
<table>...</table>
</figure>
<!-- /wp:table -->
```

### Buttons + Button

Buttons is a container. Each button is an inner block. `url`, `linkTarget`, `rel` go in the button's comment JSON.

```html
<!-- wp:buttons -->
<div class="wp-block-buttons is-layout-flex wp-block-buttons-is-layout-flex">
<!-- wp:button -->
<div class="wp-block-button"><a class="wp-block-button__link wp-element-button" href="https://example.com">Click Me</a></div>
<!-- /wp:button -->
</div>
<!-- /wp:buttons -->

<!-- Button with target and rel -->
<!-- wp:buttons -->
<div class="wp-block-buttons is-layout-flex wp-block-buttons-is-layout-flex">
<!-- wp:button {"url":"https://example.com","linkTarget":"_blank","rel":"nofollow sponsored noopener"} -->
<div class="wp-block-button"><a class="wp-block-button__link wp-element-button" href="https://example.com" target="_blank" rel="nofollow sponsored noopener">External Link</a></div>
<!-- /wp:button -->
</div>
<!-- /wp:buttons -->

<!-- Colored button -->
<!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
<div class="wp-block-buttons is-layout-flex wp-block-buttons-is-layout-flex">
<!-- wp:button {"backgroundColor":"primary"} -->
<div class="wp-block-button"><a class="wp-block-button__link has-primary-background-color has-background wp-element-button" href="#">Primary</a></div>
<!-- /wp:button -->

<!-- wp:button {"className":"is-style-outline"} -->
<div class="wp-block-button is-style-outline"><a class="wp-block-button__link wp-element-button" href="#">Outline</a></div>
<!-- /wp:button -->
</div>
<!-- /wp:buttons -->
```

### Group

Container block for grouping other blocks. Uses `useInnerBlocksProps.save()`.

```html
<!-- Constrained layout -->
<!-- wp:group {"layout":{"type":"constrained"}} -->
<div class="wp-block-group">
<!-- wp:heading -->
<h2 class="wp-block-heading">Title</h2>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Content inside group.</p>
<!-- /wp:paragraph -->
</div>
<!-- /wp:group -->

<!-- Flex row layout -->
<!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap"}} -->
<div class="wp-block-group">
<!-- items side by side -->
</div>
<!-- /wp:group -->

<!-- Full-width with background -->
<!-- wp:group {"align":"full","backgroundColor":"light-gray","style":{"spacing":{"padding":{"top":"4rem","bottom":"4rem"}}}} -->
<div class="wp-block-group alignfull has-light-gray-background-color has-background" style="padding-top:4rem;padding-bottom:4rem">
<!-- content -->
</div>
<!-- /wp:group -->

<!-- Custom tag name (section, header, footer, main, aside, article) -->
<!-- wp:group {"tagName":"section"} -->
<section class="wp-block-group">
<!-- content -->
</section>
<!-- /wp:group -->
```

### Columns + Column

```html
<!-- wp:columns -->
<div class="wp-block-columns">
<!-- wp:column {"width":"33.33%"} -->
<div class="wp-block-column" style="flex-basis:33.33%">
<!-- wp:paragraph -->
<p>Column 1 content.</p>
<!-- /wp:paragraph -->
</div>
<!-- /wp:column -->

<!-- wp:column {"width":"66.66%"} -->
<div class="wp-block-column" style="flex-basis:66.66%">
<!-- wp:paragraph -->
<p>Column 2 content.</p>
<!-- /wp:paragraph -->
</div>
<!-- /wp:column -->
</div>
<!-- /wp:columns -->

<!-- Vertically aligned columns -->
<!-- wp:columns {"verticalAlignment":"center"} -->
<div class="wp-block-columns are-vertically-aligned-center">
<!-- wp:column -->
<div class="wp-block-column">...</div>
<!-- /wp:column -->
</div>
<!-- /wp:columns -->
```

### Quote

Quote blocks use InnerBlocks for content (since WordPress 6.3+). Citation is a separate RichText attribute.

```html
<!-- wp:quote -->
<blockquote class="wp-block-quote">
<!-- wp:paragraph -->
<p>The quote text goes here.</p>
<!-- /wp:paragraph -->
<cite>Author Name</cite>
</blockquote>
<!-- /wp:quote -->
```

### Cover

```html
<!-- wp:cover {"url":"bg.jpg","id":123,"dimRatio":50,"overlayColor":"black","minHeight":500,"align":"full"} -->
<div class="wp-block-cover alignfull" style="min-height:500px">
<span aria-hidden="true" class="wp-block-cover__background has-black-background-color has-background-dim-50 has-background-dim"></span>
<img class="wp-block-cover__image-background wp-image-123" alt="" src="bg.jpg" data-object-fit="cover"/>
<div class="wp-block-cover__inner-container">
<!-- wp:heading {"textAlign":"center","level":1} -->
<h1 class="wp-block-heading has-text-align-center">Hero Title</h1>
<!-- /wp:heading -->
</div>
</div>
<!-- /wp:cover -->
```

### Embed

URL goes as plain text inside the `wp-block-embed__wrapper` div.

```html
<!-- wp:embed {"url":"https://www.youtube.com/watch?v=dQw4w9WgXcQ","type":"video","providerNameSlug":"youtube","responsive":true,"className":"wp-embed-aspect-16-9 wp-has-aspect-ratio"} -->
<figure class="wp-block-embed is-type-video is-provider-youtube wp-block-embed-youtube wp-embed-aspect-16-9 wp-has-aspect-ratio">
<div class="wp-block-embed__wrapper">
https://www.youtube.com/watch?v=dQw4w9WgXcQ
</div>
</figure>
<!-- /wp:embed -->

<!-- With caption -->
<!-- wp:embed {"url":"https://twitter.com/user/status/123","type":"rich","providerNameSlug":"twitter"} -->
<figure class="wp-block-embed is-type-rich is-provider-twitter wp-block-embed-twitter">
<div class="wp-block-embed__wrapper">
https://twitter.com/user/status/123
</div>
<figcaption class="wp-element-caption">Tweet caption</figcaption>
</figure>
<!-- /wp:embed -->
```

### Separator

```html
<!-- Default -->
<!-- wp:separator -->
<hr class="wp-block-separator has-alpha-channel-opacity"/>
<!-- /wp:separator -->

<!-- Wide line -->
<!-- wp:separator {"className":"is-style-wide"} -->
<hr class="wp-block-separator has-alpha-channel-opacity is-style-wide"/>
<!-- /wp:separator -->
```

### Spacer

Always self-closing in older versions, but balanced block with `aria-hidden` in current Gutenberg.

```html
<!-- wp:spacer {"height":"100px"} -->
<div style="height:100px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->
```

### Code

```html
<!-- wp:code -->
<pre class="wp-block-code"><code>const x = 42;
console.log(x);</code></pre>
<!-- /wp:code -->
```

### Preformatted

```html
<!-- wp:preformatted -->
<pre class="wp-block-preformatted">Preformatted text
  preserves whitespace
    and line breaks.</pre>
<!-- /wp:preformatted -->
```

### Pullquote

```html
<!-- wp:pullquote -->
<figure class="wp-block-pullquote">
<blockquote>
<p>A highlighted quote pulled from the content.</p>
<cite>Citation Source</cite>
</blockquote>
</figure>
<!-- /wp:pullquote -->
```

### Details (Disclosure)

```html
<!-- wp:details -->
<details class="wp-block-details">
<summary>Click to expand</summary>
<!-- wp:paragraph -->
<p>Hidden content revealed on click.</p>
<!-- /wp:paragraph -->
</details>
<!-- /wp:details -->

<!-- Open by default -->
<!-- wp:details {"showContent":true} -->
<details class="wp-block-details" open>
<summary>Already expanded</summary>
<!-- wp:paragraph -->
<p>Visible by default.</p>
<!-- /wp:paragraph -->
</details>
<!-- /wp:details -->
```

### HTML (Raw)

Content is stored as-is. No validation against save() output.

```html
<!-- wp:html -->
<div class="custom-widget">
  <script>console.log('hello');</script>
</div>
<!-- /wp:html -->
```

### Video

```html
<!-- wp:video {"id":456} -->
<figure class="wp-block-video">
<video controls src="https://example.com/video.mp4"></video>
<figcaption class="wp-element-caption">Video caption</figcaption>
</figure>
<!-- /wp:video -->
```

### Audio

```html
<!-- wp:audio {"id":789} -->
<figure class="wp-block-audio">
<audio controls src="https://example.com/audio.mp3"></audio>
</figure>
<!-- /wp:audio -->
```

### Gallery

Gallery is a container of image inner blocks.

```html
<!-- wp:gallery {"linkTo":"none","columns":3} -->
<figure class="wp-block-gallery has-nested-images columns-3 is-cropped">
<!-- wp:image {"id":1,"sizeSlug":"large"} -->
<figure class="wp-block-image size-large">
<img src="img1.jpg" alt="" class="wp-image-1"/>
</figure>
<!-- /wp:image -->

<!-- wp:image {"id":2,"sizeSlug":"large"} -->
<figure class="wp-block-image size-large">
<img src="img2.jpg" alt="" class="wp-image-2"/>
</figure>
<!-- /wp:image -->
<figcaption class="wp-element-caption">Gallery caption</figcaption>
</figure>
<!-- /wp:gallery -->
```

### Media & Text

```html
<!-- wp:media-text {"mediaId":123,"mediaLink":"img.jpg","mediaType":"image"} -->
<div class="wp-block-media-text is-stacked-on-mobile">
<figure class="wp-block-media-text__media">
<img src="img.jpg" alt="" class="wp-image-123 size-full"/>
</figure>
<div class="wp-block-media-text__content">
<!-- wp:paragraph -->
<p>Content next to the image.</p>
<!-- /wp:paragraph -->
</div>
</div>
<!-- /wp:media-text -->
```

### Pattern Reference

Inserts pattern content (not a live reference). Self-closing.

```html
<!-- wp:pattern {"slug":"theme-slug/hero-section"} /-->
```

## Dynamic Blocks

Dynamic blocks render server-side via PHP. Only attributes are stored. Always self-closing.

```html
<!-- wp:latest-posts {"postsToShow":5,"displayPostDate":true} /-->
<!-- wp:site-title /-->
<!-- wp:query-loop /-->
<!-- wp:shortcode -->
[contact-form-7 id="123"]
<!-- /wp:shortcode -->
```

## Nesting Rules

### Container Blocks and Their Expected Children

| Container | Expected Inner Blocks |
|-----------|----------------------|
| `wp:list` | `wp:list-item` only |
| `wp:buttons` | `wp:button` only |
| `wp:columns` | `wp:column` only |
| `wp:gallery` | `wp:image` primarily |
| `wp:group` | Any block |
| `wp:cover` | Any block (inside `__inner-container`) |
| `wp:quote` | Any block + `<cite>` |
| `wp:details` | Any block (after `<summary>`) |
| `wp:media-text` | Any block (inside `__content`) |

### Deeply Nested Example

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"4rem","bottom":"4rem"}}}} -->
<div class="wp-block-group alignfull" style="padding-top:4rem;padding-bottom:4rem">
<!-- wp:columns -->
<div class="wp-block-columns">
<!-- wp:column -->
<div class="wp-block-column">
<!-- wp:heading {"level":3} -->
<h3 class="wp-block-heading">Card Title</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Card content.</p>
<!-- /wp:paragraph -->
</div>
<!-- /wp:column -->

<!-- wp:column -->
<div class="wp-block-column">
<!-- wp:heading {"level":3} -->
<h3 class="wp-block-heading">Card Title</h3>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Card content.</p>
<!-- /wp:paragraph -->
</div>
<!-- /wp:column -->
</div>
<!-- /wp:columns -->
</div>
<!-- /wp:group -->
```

## Validation and Block Recovery

### How Validation Works

1. Parser extracts block name, attributes, and innerHTML from stored `post_content`
2. WordPress runs the block's `save()` function with the extracted attributes
3. The output is compared to the stored innerHTML
4. If they don't match → "Block contains unexpected content" (block recovery prompt)

### Common Causes of Block Recovery Errors

| Cause | Example | Fix |
|-------|---------|-----|
| Missing list-item wrappers | `<li>` without `<!-- wp:list-item -->` | Add list-item delimiters |
| Wrong class names | `wp-block-paragraph` on `<p>` (paragraphs have no base class) | Remove the class |
| Extra attributes | `class="wp-block-heading"` when no className set | Let useBlockProps handle classes |
| HTML structure mismatch | `<div>` where `<figure>` expected | Match save() output structure |
| Missing InnerBlocks | Button directly inside buttons div without comment delimiter | Wrap each inner block |
| Stale block format | Old list format without list-items (pre-6.1) | Run block recovery in editor |

### Error Recovery Strategy

The parser uses best-effort recovery, not strict validation:
- Missing closers trigger implicit closure
- Nested unclosed blocks collapse the stack sequentially
- Leading HTML becomes freeform content
- No exceptions thrown; parsing continues with recovered state

### Deprecation Chain

When current `save()` doesn't match:
1. Check each deprecated version in reverse chronological order
2. If deprecated `save()` produces matching markup, run its `migrate()` function
3. Pass migrated attributes to current `save()` for final validation
4. Stop at first match

## PHP Block Templates

For theme templates and `register_post_type`:

```php
$template = array(
    array( 'core/heading', array(
        'level' => 2,
        'content' => 'Welcome'
    ) ),
    array( 'core/paragraph', array(
        'placeholder' => 'Add content...'
    ) ),
    array( 'core/columns', array(), array(
        array( 'core/column', array(), array(
            array( 'core/paragraph', array() )
        ) ),
        array( 'core/column', array(), array(
            array( 'core/paragraph', array() )
        ) )
    ) )
);

register_post_type( 'product', array(
    'template' => $template,
    'template_lock' => 'all' // or 'insert', 'contentOnly', false
) );
```

## Programmatic Block Generation Checklist

When generating block markup via code (REST API, scripts, migrations):

1. **Every block needs comment delimiters** — no bare HTML tags
2. **Compact JSON** — `{"key":"val"}` not `{ "key" : "val" }`
3. **List items need `<!-- wp:list-item -->`** — required since WP 6.1
4. **Button `url` goes in comment JSON** — not just in `<a href="">`
5. **Omit default attribute values** — only serialize non-defaults
6. **Match the save() output structure exactly** — wrong element types trigger recovery
7. **No `wp-block-paragraph` class on `<p>` tags** — paragraphs have no base class by default
8. **`wp-block-heading` class on headings** — the heading save() produces this
9. **`wp-element-button` class on button links** — required alongside `wp-block-button__link`
10. **`size-{slug}` class on image figures** — e.g., `size-large`, `size-full`
11. **`wp-image-{id}` class on `<img>` tags** — when image ID is known
12. **Test in the block editor** — load the post and check for yellow "Attempt Block Recovery" warnings

## Resources

- [Block Grammar Spec (PEG)](https://github.com/WordPress/gutenberg/tree/trunk/packages/block-serialization-spec-parser)
- [Block Parser (PHP)](https://github.com/WordPress/gutenberg/tree/trunk/packages/block-serialization-default-parser)
- [Block Library Save Functions](https://github.com/WordPress/gutenberg/tree/trunk/packages/block-library/src)
- [Block Attributes Reference](https://developer.wordpress.org/block-editor/reference-guides/block-api/block-attributes/)
- [Block Deprecation Guide](https://developer.wordpress.org/block-editor/reference-guides/block-api/block-deprecation/)
