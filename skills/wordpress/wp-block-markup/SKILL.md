---
name: wp-block-markup
description: "WordPress block markup syntax and HTML structure. Understand block delimiters, attributes, nesting, and how blocks serialize to the database."
compatibility: "WordPress 5.0+. Block grammar unchanged since introduction."
---

# WordPress Block Markup Syntax

## When to Use

Use this skill when:
- Writing raw block markup for patterns or templates
- Debugging block validation errors
- Understanding how blocks store data
- Converting HTML to block format
- Working with block templates in PHP

## Block Grammar Fundamentals

WordPress blocks use HTML comments to delimit block boundaries. The content between comments is valid HTML.

### Basic Syntax

```html
<!-- wp:{namespace}/{block-name} {attributes_json} -->
<html-content>
  ...
</html-content>
<!-- /wp:{namespace}/{block-name} -->
```

### Core Blocks (No Namespace)

Core blocks omit the namespace:

```html
<!-- wp:paragraph -->
<p>Content</p>
<!-- /wp:paragraph -->
```

Instead of:
```html
<!-- wp:core/paragraph -->  ❌ Don't use core/ prefix
```

### Custom Blocks (With Namespace)

Third-party blocks use their namespace:

```html
<!-- wp:woocommerce/product-grid {"columns":3} -->
...
<!-- /wp:woocommerce/product-grid -->
```

## Block Types

### 1. Static Blocks

Content saved in post content. Validated on load.

```html
<!-- wp:paragraph {"align":"center"} -->
<p class="has-text-align-center">Centered text content.</p>
<!-- /wp:paragraph -->
```

The `save()` function in JavaScript generates this HTML. WordPress validates stored markup matches expected output.

### 2. Dynamic Blocks

Only attributes saved. Content rendered server-side.

```html
<!-- wp:latest-posts {"postsToShow":5,"displayPostDate":true} /-->
```

Note the self-closing syntax (`/-->`). No HTML content stored.

### 3. Inner Blocks (Containers)

Blocks containing other blocks:

```html
<!-- wp:group -->
<div class="wp-block-group">
  <!-- wp:heading -->
  <h2 class="wp-block-heading">Title</h2>
  <!-- /wp:heading -->
  <!-- wp:paragraph -->
  <p>Description text.</p>
  <!-- /wp:paragraph -->
</div>
<!-- /wp:group -->
```

## Attribute Serialization

### JSON Attributes

Attributes are JSON-encoded in the opening comment:

```html
<!-- wp:image {"id":123,"sizeSlug":"large","linkDestination":"media"} -->
```

**Rules:**
- Valid JSON object (double quotes, no trailing commas)
- Omit empty/default values to keep markup clean
- Order doesn't matter
- No line breaks in JSON (must be single line)

### Common Attribute Patterns

**Colors (preset):**
```json
{"backgroundColor":"primary","textColor":"white"}
```

**Colors (custom):**
```json
{"style":{"color":{"background":"#ff0000","text":"#ffffff"}}}
```

**Typography:**
```json
{"style":{"typography":{"fontSize":"1.5rem","fontWeight":"700","lineHeight":"1.4"}}}
```

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

## HTML Output Patterns

### Class Naming

WordPress generates predictable class names:

| Block | Base Class |
|-------|------------|
| `core/paragraph` | `—` (no class by default) |
| `core/heading` | `wp-block-heading` |
| `core/image` | `wp-block-image` |
| `core/group` | `wp-block-group` |
| `core/columns` | `wp-block-columns` |
| `core/button` | `wp-block-button` |

**Dynamic classes:**
```html
<!-- Alignment -->
<div class="wp-block-group alignfull">

<!-- Colors -->
<p class="has-text-color has-primary-color has-white-background-color has-background">

<!-- Typography -->
<p class="has-large-font-size">

<!-- Custom class -->
<div class="wp-block-group my-custom-class">
```

### Style Attributes

Custom styles go in inline `style` attribute:

```html
<!-- wp:paragraph {"style":{"typography":{"fontSize":"18px"},"color":{"text":"#333"}}} -->
<p class="has-text-color" style="color:#333;font-size:18px">Text</p>
<!-- /wp:paragraph -->
```

## Nesting and Inner Blocks

### Container Block Pattern

```html
<!-- wp:group {"align":"full"} -->
<div class="wp-block-group alignfull">
  <!-- Inner blocks go here -->
  <!-- wp:heading -->
  <h2 class="wp-block-heading">Title</h2>
  <!-- /wp:heading -->
</div>
<!-- /wp:group -->
```

### Columns Structure

```html
<!-- wp:columns -->
<div class="wp-block-columns">
  <!-- wp:column {"width":"33.33%"} -->
  <div class="wp-block-column" style="flex-basis:33.33%">
    <!-- Content for column 1 -->
  </div>
  <!-- /wp:column -->
  <!-- wp:column {"width":"66.66%"} -->
  <div class="wp-block-column" style="flex-basis:66.66%">
    <!-- Content for column 2 -->
  </div>
  <!-- /wp:column -->
</div>
<!-- /wp:columns -->
```

### Deeply Nested Example

```html
<!-- wp:group {"align":"full"} -->
<div class="wp-block-group alignfull">
  <!-- wp:columns -->
  <div class="wp-block-columns">
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":"2rem"}}} -->
      <div class="wp-block-group" style="padding:2rem">
        <!-- wp:heading {"level":3} -->
        <h3 class="wp-block-heading">Card Title</h3>
        <!-- /wp:heading -->
        <!-- wp:paragraph -->
        <p>Card content goes here.</p>
        <!-- /wp:paragraph -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
  </div>
  <!-- /wp:columns -->
</div>
<!-- /wp:group -->
```

## Special Block Types

### Self-Closing Blocks

Blocks without HTML content:

```html
<!-- wp:spacer {"height":"100px"} /-->
<!-- wp:separator /-->
<!-- wp:latest-posts {"postsToShow":5} /-->
<!-- wp:social-link {"url":"https://twitter.com","service":"twitter"} /-->
```

### Void Blocks (Media)

Single HTML element, self-closing:

```html
<!-- wp:image {"id":123} -->
<figure class="wp-block-image">
  <img src="image.jpg" alt="" class="wp-image-123"/>
</figure>
<!-- /wp:image -->
```

### Blocks with Caption

```html
<!-- wp:image {"id":123} -->
<figure class="wp-block-image">
  <img src="image.jpg" alt="" class="wp-image-123"/>
  <figcaption class="wp-element-caption">Image caption here</figcaption>
</figure>
<!-- /wp:image -->
```

### Blocks with Rich Text Content

Content is HTML inside the block:

```html
<!-- wp:paragraph -->
<p>This is <strong>bold</strong> and <em>italic</em> text with a <a href="#">link</a>.</p>
<!-- /wp:paragraph -->
```

## Common Block Examples

### Paragraph

```html
<!-- Simple -->
<!-- wp:paragraph -->
<p>Plain paragraph.</p>
<!-- /wp:paragraph -->

<!-- Styled -->
<!-- wp:paragraph {"style":{"typography":{"fontSize":"1.125rem"},"color":{"text":"#555555"}}} -->
<p class="has-text-color" style="color:#555555;font-size:1.125rem">Styled paragraph.</p>
<!-- /wp:paragraph -->

<!-- With alignment -->
<!-- wp:paragraph {"align":"center"} -->
<p class="has-text-align-center">Centered paragraph.</p>
<!-- /wp:paragraph -->
```

### Heading

```html
<!-- wp:heading -->
<h2 class="wp-block-heading">H2 Heading</h2>
<!-- /wp:heading -->

<!-- wp:heading {"level":3,"textAlign":"center"} -->
<h3 class="wp-block-heading has-text-align-center">Centered H3</h3>
<!-- /wp:heading -->

<!-- wp:heading {"level":1,"style":{"typography":{"fontSize":"3rem","fontWeight":"800"}}} -->
<h1 class="wp-block-heading" style="font-size:3rem;font-weight:800">Large H1</h1>
<!-- /wp:heading -->
```

### Image

```html
<!-- Basic -->
<!-- wp:image {"id":123,"sizeSlug":"large"} -->
<figure class="wp-block-image size-large">
  <img src="image.jpg" alt="Description" class="wp-image-123"/>
</figure>
<!-- /wp:image -->

<!-- With link -->
<!-- wp:image {"id":123,"linkDestination":"custom"} -->
<figure class="wp-block-image">
  <a href="https://example.com"><img src="image.jpg" alt="" class="wp-image-123"/></a>
</figure>
<!-- /wp:image -->

<!-- Aligned -->
<!-- wp:image {"id":123,"align":"right","width":"300px"} -->
<figure class="wp-block-image alignright is-resized">
  <img src="image.jpg" alt="" class="wp-image-123" style="width:300px"/>
</figure>
<!-- /wp:image -->
```

### Group

```html
<!-- Constrained layout -->
<!-- wp:group {"layout":{"type":"constrained"}} -->
<div class="wp-block-group">
  <!-- inner blocks -->
</div>
<!-- /wp:group -->

<!-- Flex row -->
<!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap"}} -->
<div class="wp-block-group">
  <!-- items side by side -->
</div>
<!-- /wp:group -->

<!-- Full width with background -->
<!-- wp:group {"align":"full","backgroundColor":"light-gray","style":{"spacing":{"padding":{"top":"4rem","bottom":"4rem"}}}} -->
<div class="wp-block-group alignfull has-light-gray-background-color has-background" style="padding-top:4rem;padding-bottom:4rem">
  <!-- content -->
</div>
<!-- /wp:group -->
```

### Buttons

```html
<!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
<div class="wp-block-buttons">
  <!-- wp:button {"backgroundColor":"primary"} -->
  <div class="wp-block-button">
    <a class="wp-block-button__link has-primary-background-color has-background wp-element-button" href="#">Primary Button</a>
  </div>
  <!-- /wp:button -->
  <!-- wp:button {"className":"is-style-outline"} -->
  <div class="wp-block-button is-style-outline">
    <a class="wp-block-button__link wp-element-button" href="#">Outline Button</a>
  </div>
  <!-- /wp:button -->
</div>
<!-- /wp:buttons -->
```

### Cover

```html
<!-- wp:cover {"url":"bg.jpg","id":123,"dimRatio":50,"overlayColor":"black","minHeight":500,"align":"full"} -->
<div class="wp-block-cover alignfull" style="min-height:500px">
  <span aria-hidden="true" class="wp-block-cover__background has-black-background-color has-background-dim-50 has-background-dim"></span>
  <img class="wp-block-cover__image-background wp-image-123" alt="" src="bg.jpg" data-object-fit="cover"/>
  <div class="wp-block-cover__inner-container">
    <!-- Content over image -->
  </div>
</div>
<!-- /wp:cover -->
```

### List

```html
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
```

### Quote

```html
<!-- wp:quote -->
<blockquote class="wp-block-quote">
  <!-- wp:paragraph -->
  <p>The quote text goes here.</p>
  <!-- /wp:paragraph -->
  <cite>— Author Name</cite>
</blockquote>
<!-- /wp:quote -->
```

### Table

```html
<!-- wp:table {"hasFixedLayout":true} -->
<figure class="wp-block-table">
  <table class="has-fixed-layout">
    <thead>
      <tr>
        <th>Header 1</th>
        <th>Header 2</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Cell 1</td>
        <td>Cell 2</td>
      </tr>
      <tr>
        <td>Cell 3</td>
        <td>Cell 4</td>
      </tr>
    </tbody>
  </table>
</figure>
<!-- /wp:table -->
```

## Validation and Debugging

### Block Validation Process

1. WordPress parses stored markup
2. Compares to expected output from `save()` function
3. If mismatch → "Block contains unexpected content" error

### Common Causes of Invalid Blocks

1. **Changed attributes without deprecation**
2. **HTML structure mismatch** (extra/missing elements)
3. **Whitespace differences** (sometimes)
4. **Class name changes**
5. **Manual HTML edits breaking structure**

### Debugging Tips

1. Check browser console for validation errors
2. Compare stored markup vs expected output
3. Look for attribute serialization issues
4. Verify nesting structure is correct

## PHP Block Templates

For theme templates, use array syntax:

```php
$template = array(
    array( 'core/heading', array(
        'level' => 2,
        'content' => 'Welcome'
    ) ),
    array( 'core/paragraph', array(
        'placeholder' => 'Add your content here...'
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
```

Register with post type:
```php
register_post_type( 'product', array(
    'template' => $template,
    'template_lock' => 'all' // or 'insert', 'contentOnly', false
) );
```

## Pattern References

Use patterns in templates:

```html
<!-- wp:pattern {"slug":"theme-slug/hero-section"} /-->
```

This inserts the pattern content (not a reference).

## Best Practices

1. **Minimize attributes** - Only include non-default values
2. **Valid JSON** - Double quotes, no trailing commas
3. **Proper nesting** - Match opening/closing comments
4. **Semantic HTML** - Use appropriate container elements
5. **Consistent formatting** - Keep blocks readable
6. **Test in editor** - Verify blocks validate correctly

## Resources

- [Block Markup Documentation](https://developer.wordpress.org/block-editor/getting-started/fundamentals/markup-representation-block/)
- [Block Grammar Spec](https://developer.wordpress.org/block-editor/explanations/architecture/key-concepts/)
- [Block Deprecation](https://developer.wordpress.org/block-editor/reference-guides/block-api/block-deprecation/)
