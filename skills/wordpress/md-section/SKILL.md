---
name: md-section
description: "Use when converting HTML layouts to MD Section block + core block combinations for the WordPress Block Editor. Triggers: HTML-to-blocks, section layout, convert HTML to Gutenberg, pasting HTML into block editor."
---

# HTML to MD Section Block Conversion

Convert arbitrary HTML layouts into nested `marketers-delight/section` blocks combined with core WordPress blocks. Strip external CSS/JS. Preserve inline styles via block attributes.

## When to Use

- Converting an HTML template/component into block editor markup
- Building complex layouts (heroes, card grids, tab panels) in the block editor
- User pastes HTML and wants it as editable blocks
- Recreating a design using Section blocks instead of Custom HTML

## Section Block Reference

The MD Section block is a dynamic container. It renders server-side using attributes stored in the block comment delimiter. Inner blocks are stored as nested block markup.

### Block Name

`marketers-delight/section`

### Attributes

| Attribute | Type | Default | Purpose |
|-----------|------|---------|---------|
| `htmlTag` | string | `div` | Tag name: `div`, `section`, `article`, `aside`, `header`, `footer`, `main`, `nav`, `figure`, `details`, or `custom` |
| `customTag` | string | `""` | Tag name when `htmlTag` is `custom` (e.g. `dl`, `fieldset`) |
| `className` | string | `""` | Space-separated CSS classes |
| `anchor` | string | `""` | HTML `id` attribute |
| `align` | string | `""` | `wide` or `full` |
| `sectionCSS` | string | `""` | Scoped CSS block (rendered in `<style>` tag before element) |
| `htmlAttributes` | string | `""` | Safe custom attributes as `name="value"` pairs (data-*, tabindex, style, title, etc.) |
| `ariaHidden` | boolean | `false` | Sets `aria-hidden="true"` |
| `ariaLabel` | string | `""` | Sets `aria-label` |
| `ariaLabelledBy` | string | `""` | Sets `aria-labelledby` |
| `role` | string | `""` | ARIA role (banner, marquee, tabpanel, region, etc.) or `custom` |
| `customRole` | string | `""` | Role value when `role` is `custom` |
| `hidden` | boolean | `false` | Sets `hidden` attribute |

### Serialization Format

```html
<!-- wp:marketers-delight/section {"htmlTag":"section","className":"hero hero--dark","anchor":"top","ariaLabelledBy":"hero-title","sectionCSS":".hero--dark { background: #0a0a0a; color: #fff; }"} -->
<!-- inner blocks here -->
<!-- /wp:marketers-delight/section -->
```

Dynamic block: no HTML between delimiters except inner blocks. The PHP `section()` callback renders the wrapper element.

### Safe htmlAttributes

The PHP renderer whitelists these attribute names/prefixes:

**Prefixes:** `data-*`, `aria-*`
**Names:** `tabindex`, `style`, `title`, `lang`, `dir`, `translate`, `loading`, `fetchpriority`, `rel`, `target`, `width`, `height`, `viewbox`, `preserveaspectratio`, `fill`, `stroke`, `opacity`

Unsafe attributes (`onclick`, `onerror`, `src`, `href`) are silently dropped.

## Conversion Rules

### Step 1: Strip External Resources

Remove completely:
- `<link rel="stylesheet">` tags
- `<script src="...">` tags
- `<style>` blocks that define external/global CSS

### Step 2: Extract Scoped CSS

If the HTML has `<style>` blocks with classes used within the layout:
- Move those rules into the **outermost** Section block's `sectionCSS` attribute
- If CSS is section-specific, place it in that section's `sectionCSS`
- Keep `@keyframes` and `@media` rules with the CSS they belong to

### Step 3: Map Elements to Blocks

```
HTML Element                    Block
-----------------------------------------------------
<section>, <article>, <aside>,
<header>, <footer>, <nav>,
<main>, <figure>, <details>,
<div> (structural)             → marketers-delight/section

<h1>-<h6>                     → core/heading
<p>                            → core/paragraph
<ul>, <ol>                     → core/list + core/list-item
<img>                          → core/image
<video>                        → core/video
<audio>                        → core/audio
<blockquote>                   → core/quote
<pre>, <code>                  → core/code
<table>                        → core/table
<hr>                           → core/separator
<iframe> (embed)               → core/embed or core/html
<a> (wrapping block content)   → marketers-delight/section with htmlTag="a" is NOT supported; use core/group or nest a core/paragraph link
<svg> (inline, decorative)     → core/html
<dl>                           → marketers-delight/section with customTag="dl" + section children for dt/dd
```

### Step 4: Transfer Attributes

For each HTML element mapped to a Section block:

| HTML Attribute | Section Block Property |
|----------------|----------------------|
| `class="..."` | `className` |
| `id="..."` | `anchor` |
| `role="..."` | `role` (or `customRole` if not in preset list) |
| `aria-hidden="true"` | `ariaHidden: true` |
| `aria-label="..."` | `ariaLabel` |
| `aria-labelledby="..."` | `ariaLabelledBy` |
| `hidden` | `hidden: true` |
| `data-*="..."` | `htmlAttributes` string |
| `tabindex="..."` | `htmlAttributes` string |
| `style="..."` | `htmlAttributes` string (as `style="..."`) |

For core blocks, use their native attribute system (e.g., `style` object for headings/paragraphs).

### Step 5: Handle Inline Styles

Inline `style` attributes on elements mapped to Section blocks go into `htmlAttributes`:

```json
{"htmlAttributes":"style=\"--i:0\" data-panel=\"plugins\""}
```

For core blocks, convert inline styles to the block's `style` JSON object:

```html
<!-- Input -->
<h1 style="font-size: 3rem; color: #fff; line-height: 1.1;">Title</h1>

<!-- Output -->
<!-- wp:heading {"level":1,"style":{"typography":{"fontSize":"3rem","lineHeight":"1.1"},"color":{"text":"#ffffff"}}} -->
<h1 class="wp-block-heading has-text-color" style="color:#ffffff;font-size:3rem;line-height:1.1">Title</h1>
<!-- /wp:heading -->
```

## Output Format

**Always output to a file**, never inline in chat.

- Filename: `{descriptive-name}-blocks.html`
- Include only the block markup (no `<!DOCTYPE>`, no `<html>`/`<body>`)
- **No extra HTML comments.** Only block editor comments (`<!-- wp:` and `<!-- /wp:`) are allowed. Never add descriptive comments like `<!-- Hero section -->` or `<!-- Primary card -->`
- Brief summary in chat: what was converted, how many sections, any manual steps needed

## Conversion Example

### Input HTML

```html
<section class="hero" id="top" aria-labelledby="hero-title">
  <style>.hero { background: #0a0a0a; } .hero__inner { max-width: 1200px; margin: 0 auto; }</style>
  <div class="hero__bg" aria-hidden="true"></div>
  <div class="hero__inner">
    <h1 id="hero-title" style="font-size: 3rem;">I build websites</h1>
    <p>Fast, accessible, and profitable.</p>
    <div class="hero__actions" data-section="cta">
      <a href="/contact/" class="button">Start a project</a>
    </div>
  </div>
</section>
```

### Output Block Markup

```html
<!-- wp:marketers-delight/section {"htmlTag":"section","className":"hero","anchor":"top","ariaLabelledBy":"hero-title","align":"full","sectionCSS":".hero { background: #0a0a0a; } .hero__inner { max-width: 1200px; margin: 0 auto; }"} -->

<!-- wp:marketers-delight/section {"htmlTag":"div","className":"hero__bg","ariaHidden":true} -->
<!-- /wp:marketers-delight/section -->

<!-- wp:marketers-delight/section {"htmlTag":"div","className":"hero__inner"} -->

<!-- wp:heading {"level":1,"anchor":"hero-title","style":{"typography":{"fontSize":"3rem"}}} -->
<h1 class="wp-block-heading" id="hero-title" style="font-size:3rem">I build websites</h1>
<!-- /wp:heading -->

<!-- wp:paragraph -->
<p>Fast, accessible, and profitable.</p>
<!-- /wp:paragraph -->

<!-- wp:marketers-delight/section {"htmlTag":"div","className":"hero__actions","htmlAttributes":"data-section=\"cta\""} -->

<!-- wp:paragraph -->
<p><a href="/contact/" class="button">Start a project</a></p>
<!-- /wp:paragraph -->

<!-- /wp:marketers-delight/section -->

<!-- /wp:marketers-delight/section -->

<!-- /wp:marketers-delight/section -->
```

## Handling Complex Elements

### SVG (Decorative)

Inline SVGs that are decorative (`aria-hidden="true"`) convert to `core/html`:

```html
<!-- wp:html -->
<svg class="bp__circuit" aria-hidden="true" viewBox="0 0 1600 900">
  <!-- SVG content preserved as-is -->
</svg>
<!-- /wp:html -->
```

Wrap in a Section block if the SVG needs positioning classes:

```html
<!-- wp:marketers-delight/section {"htmlTag":"div","className":"bp__svg-wrap","ariaHidden":true} -->
<!-- wp:html -->
<svg>...</svg>
<!-- /wp:html -->
<!-- /wp:marketers-delight/section -->
```

### Tab Panels

Use Section blocks with `role`, `ariaLabelledBy`, and `hidden`:

```html
<!-- wp:marketers-delight/section {"htmlTag":"div","className":"panel active","anchor":"panel-plugins","role":"tabpanel","ariaLabelledBy":"tab-plugins"} -->
<!-- panel content blocks -->
<!-- /wp:marketers-delight/section -->

<!-- wp:marketers-delight/section {"htmlTag":"div","className":"panel","anchor":"panel-tools","role":"tabpanel","ariaLabelledBy":"tab-tools","hidden":true} -->
<!-- panel content blocks -->
<!-- /wp:marketers-delight/section -->
```

### Definition Lists

Use Section with `customTag`:

```html
<!-- wp:marketers-delight/section {"htmlTag":"custom","customTag":"dl","className":"stats-row"} -->
<!-- wp:marketers-delight/section {"htmlTag":"custom","customTag":"dt"} -->
<!-- wp:paragraph -->
<p>Label</p>
<!-- /wp:paragraph -->
<!-- /wp:marketers-delight/section -->
<!-- wp:marketers-delight/section {"htmlTag":"custom","customTag":"dd"} -->
<!-- wp:paragraph -->
<p>Value</p>
<!-- /wp:paragraph -->
<!-- /wp:marketers-delight/section -->
<!-- /wp:marketers-delight/section -->
```

### Images

Always use `core/image`, not a Section block:

```html
<!-- wp:image {"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large"><img src="https://example.com/photo.jpg" alt="Description" /></figure>
<!-- /wp:image -->
```

### Buttons / Links

Standalone text links inside a Section: use `core/paragraph` with an `<a>` tag inside.

Button groups: wrap in a Section block with the group class, use `core/buttons` + `core/button` inside:

```html
<!-- wp:marketers-delight/section {"htmlTag":"div","className":"hero__actions"} -->
<!-- wp:buttons -->
<div class="wp-block-buttons">
<!-- wp:button {"className":"button"} -->
<div class="wp-block-button button"><a class="wp-block-button__link wp-element-button" href="/contact/">Start a project</a></div>
<!-- /wp:button -->
<!-- wp:button {"className":"button-outline"} -->
<div class="wp-block-button button-outline"><a class="wp-block-button__link wp-element-button" href="/work/">See my work</a></div>
<!-- /wp:button -->
</div>
<!-- /wp:buttons -->
<!-- /wp:marketers-delight/section -->
```

### JavaScript Behavior

Strip `<script>` tags entirely. Note in the summary which interactive behaviors need reimplementation (tabs, accordions, marquees, etc.). Suggest:

- **Tabs:** WordPress Interactivity API or custom dropin
- **Accordion:** `<details>`/`<summary>` via Section blocks (native HTML)
- **Marquee/ticker:** CSS animation in `sectionCSS`
- **Scroll effects:** Intersection Observer via custom JS dropin

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| Putting HTML between Section block delimiters | Section is dynamic. Only inner blocks go between delimiters |
| Using Section for `<img>` | Use `core/image` |
| Using Section for `<h1>`-`<h6>` | Use `core/heading` |
| Using Section for `<p>` | Use `core/paragraph` |
| Keeping `<script>` tags | Strip completely, note in summary |
| Putting global CSS in every section's `sectionCSS` | Put shared CSS in the outermost section only |
| Using `onclick` or event handlers in `htmlAttributes` | These are blocked by the sanitizer |
| Forgetting to escape quotes in `htmlAttributes` | Use `\"` inside the JSON string: `"htmlAttributes":"data-x=\"val\""` |
| Omitting default attribute values | Only include non-default values in the JSON (no `"htmlTag":"div"` since div is default) |
| Adding descriptive HTML comments | Only `<!-- wp:` block comments allowed. No `<!-- Section name -->` or `<!-- Card -->` |
