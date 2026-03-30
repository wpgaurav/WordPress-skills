---
name: page-block
description: Build and push section-based pages using the Marketers Delight Page Block (`marketers-delight/page-block`) Gutenberg block with HTML, CSS, and optional JS in block attributes. Use when creating or updating WordPress pages that use Page Blocks and when generating or pushing Page Block content through the REST API.
---

# Page Block Skill

Build and push section-based pages using the Marketers Delight **Page Block** (`marketers-delight/page-block`) Gutenberg block. Each Page Block is a self-contained section with its own HTML, CSS, and optional JS pane — like a CodePen embed inside the Block Editor.

---

## What Is a Page Block?

A Page Block is a **dynamic Gutenberg block** registered by the Marketers Delight theme's `page-blocks` dropin (v4.3.0). It stores three code panes as block attributes:

| Attribute | Type | Purpose |
|-----------|------|---------|
| `content` | string | HTML (or HTML + PHP when `phpExec` is true) |
| `css` | string | Scoped CSS for this section |
| `js` | string | JavaScript for this section (runs in footer by default) |
| `jsLocation` | string | `"footer"` (default) or `"inline"` |
| `format` | boolean | Apply `wpautop()` + `do_shortcode()` formatting |
| `phpExec` | boolean | Execute PHP code in `content` (admin-only) |
| `metadata` | object | `{"name": "Section Name"}` for editor label |

### Block Comment Format (Self-Closing)

```
<!-- wp:marketers-delight/page-block {"content":"...","css":"...","js":"...","phpExec":true,"metadata":{"name":"Hero"}} /-->
```

Key details:
- **Self-closing block**: ends with `/-->` (no inner blocks, no closing tag)
- All content is stored as **JSON-escaped strings** in the block comment attributes
- Multiple Page Blocks stack sequentially with `\n\n` between them
- The block has `save: function() { return null; }` — all rendering is server-side

---

## How It Renders

### CSS Delivery
1. On `template_redirect`, the system parses all Page Blocks in post content
2. All CSS from every Page Block is **combined and output in `<head>`** as `<style id="md-page-block-css">`
3. If the page has CSS Output set to `"file"`, it generates an external minified CSS file at `/wp-content/uploads/md-page-blocks/page-block-gb-{post_id}.css`

### HTML Rendering
1. If `phpExec` is true, PHP code is executed via `eval` (temp file + include)
2. Shortcodes are processed via `do_shortcode()`
3. If `format` is true, `wpautop()` is also applied
4. HTML is minified (whitespace collapsed, comments stripped, `<pre>`/`<code>`/`<script>`/`<style>` preserved)

### JS Delivery
1. JS is collected and output in `wp_footer` as `<script>` tags
2. If JS Output is set to `"file"`, an external minified JS file is generated
3. Each script gets a unique ID based on content hash: `page-block-js-gb-{hash}`

---

## Section Architecture

Each Page Block represents one visual section of the page. The recommended structure:

```html
<section class="section-name block-double-tb" id="section-id" aria-labelledby="heading-id">
  <div class="inner">
    <!-- Section content using utility classes from style.css -->
  </div>
</section>
```

### Spacing Rules (CRITICAL — NO EXCEPTIONS)

**ALL spacing must come from `style.css` utility classes applied in HTML.** Never write `padding`, `margin`, or `gap` in section CSS. Zero exceptions.

Section CSS is **only** for: gradients, backgrounds, colors, borders, shadows, border-radius, transitions, transforms, display, flex-direction, font-family, font-weight, letter-spacing, line-height, and component-specific decoration. **Never `font-size`.**

#### Available Spacing Classes

**Padding (`block-*`):**

| Class | Value | Variants |
|-------|-------|----------|
| `block-half` | `1.0625rem` | `-tb`, `-lr`, `-top`, `-bot` |
| `block-single` | `2.125rem` | `-tb`, `-lr`, `-top`, `-bot` |
| `block-mid` | `3.1875rem` | `-tb`, `-lr`, `-top`, `-bot` |
| `block-double` | `4.25rem` | `-tb`, `-lr`, `-top`, `-bot` |

**Margin (`mt-*`, `mb-*`):**

| Class | Value |
|-------|-------|
| `mt-none` / `mb-none` | `0 !important` |
| `mt-small` / `mb-small` | `0.375rem` |
| `mt-half` / `mb-half` | `1.0625rem` |
| `mt-single` / `mb-single` | `2.125rem` |
| `mt-mid` / `mb-mid` | `3.1875rem` |
| `mt-double` / `mb-double` | `4.25rem` |
| `mr-half` / `mr-single` / `mr-double` | Right margin |
| `ml-small` | Left margin |

**Gap (`gap-*`):**

| Class | Value |
|-------|-------|
| `gap-none` | `0` |
| `gap-half` | `1.0625rem` |
| `gap-single` | `2.125rem` |
| `gap-mid` | `3.1875rem` |
| `gap-double` | `4.25rem` |

**Grid (`grid-*`):**

| Class | Columns | Responsive |
|-------|---------|------------|
| `grid-2` | 2 | 1 col at <=640px |
| `grid-3` | 3 | 2 at <=768px, 1 at <=640px |
| `grid-4` | 4 | 3 at <=992px, 2 at <=768px, 1 at <=640px |
| `columns-55-45`, `columns-60-40`, etc. | Asymmetric | 1 col at <=768px |

#### Example: Correct Spacing Usage

```html
<!-- Spacing is ALL in HTML via utility classes -->
<section class="gt-hero block-double-tb">
  <div class="inner block-half-lr">
    <h2 class="mb-half">Title</h2>
    <p class="mb-single">Description</p>
    <div class="grid-3 gap-single">
      <div class="block-single">Card with padding</div>
    </div>
    <div class="gt-actions gap-single mt-single">
      <a class="gt-button block-half" href="#">CTA</a>
    </div>
  </div>
</section>
```

```css
/* CSS has ZERO padding/margin/gap — only decoration */
.gt-hero { background: linear-gradient(...); overflow: hidden; }
.gt-button { background: var(--color-accent); border-radius: var(--radius-m); }
```

### Typography Rules (CRITICAL — NO FONT SIZES IN CSS)

**NEVER set `font-size` in section CSS files.** The theme handles all font sizing through semantic HTML elements (`h1`–`h6`, `p`, `span`, `code`) and utility classes (`small`, `caps`, etc.). Section CSS should not contain any `font-size` declarations.

**What CSS CAN set for typography:**
- `font-family` — only when overriding to `var(--font-head)`, `var(--font-mono)`, or `var(--font-serif)`
- `font-weight` — for emphasis (700, 800, 600, 500)
- `letter-spacing` — for tight headings (`-0.03em`, `-0.02em`)
- `line-height` — only via variables: `var(--lh-tight)`, `var(--lh-base)`, `var(--lh-relaxed)`
- `color` — text color

**What CSS must NEVER set:**
- `font-size` — in any form (px, rem, em, clamp, var)
- `font-size: var(--fs-*)` — still counts as setting font-size in CSS, don't do it

#### Font Families (CSS is OK)

| Variable | Value | Usage |
|----------|-------|-------|
| `var(--font-head)` | GTReallySans | Headings, titles, badges, buttons, stat numbers |
| `var(--font-body)` | InterVar/Inter | Body text (default, rarely needs explicit declaration) |
| `var(--font-serif)` | TiemposText | Subtitles, quotes, editorial accents |
| `var(--font-mono)` | SF Mono | Code blocks, technical labels |

#### Sizing comes from HTML

The theme already styles `h1`–`h6`, `p`, `code`, `pre`, `strong`, `small` elements with appropriate sizes. Use semantic HTML and the heading hierarchy drives sizing automatically.

#### Recommended Pattern

```css
/* Hero title — font-family, weight, spacing only. NO font-size. */
.gt-hero__title {
  font-family: var(--font-head);
  font-weight: 800;
  line-height: var(--lh-tight);
  letter-spacing: -0.03em;
  color: #fff;
}

/* Card title — minimal decoration */
.gt-card__title {
  font-family: var(--font-head);
  font-weight: 700;
  line-height: var(--lh-tight);
}

/* Stat number */
.gt-stat__num {
  font-family: var(--font-head);
  font-weight: 800;
  line-height: var(--lh-tight);
  letter-spacing: -0.02em;
}

/* Code snippet — only font-family override */
.gt-code {
  font-family: var(--font-mono);
}

/* Button — font-family and weight only */
.gt-button {
  font-family: var(--font-head);
  font-weight: 700;
}
```

### CSS Conventions
- Define section-scoped CSS variables at the section class level
- Use `color-mix()` for theme-aware colors that work in light/dark mode
- Use existing CSS variables from `globals.css` (`--color-primary`, `--color-text`, etc.)
- **No `@import` in CSS** — the theme already loads `globals.css`, `style.css`, and `dark-mode.css`
- **No `<link>` or `<script>` in HTML** — CSS goes in the `css` attribute, JS in `js` attribute
- Prefix component classes with `gt-` (e.g., `gt-book-hero__title`, `gt-services__card`)
- Prefer CSS-only animations (`@keyframes`, `:hover` transitions) over JS-driven scroll animations
- Include `@media (prefers-reduced-motion: reduce)` to disable animations
- Dark mode overrides at bottom of CSS via `[data-theme="dark"]` selector

### JS Conventions (Minimize JS)
- Prefer CSS-only solutions: `@keyframes` for entrance animations, `:hover`/`:focus-visible` for interactions
- Only use JS when CSS cannot achieve the effect (e.g., complex state, API calls)
- When JS is needed: wrap in IIFE, early-return if section not found, respect `prefers-reduced-motion`
- Use event delegation on section wrapper

---

## Building Page Block Content for the REST API

When pushing Page Blocks via the WordPress REST API (`POST /wp-json/wp/v2/pages/{id}`), the content must be formatted as **WordPress block markup** in the `content` field.

### Python Pattern for Pushing

```python
import json
import base64
import requests

WP_URL = "https://yoursite.com"
USERNAME = "your-username"
APP_PASSWORD = "..."  # from .env
PAGE_ID = 12345

sections = []

# Each section is a Page Block
sections.append(build_page_block(
    name="Hero",
    html='<section class="hero">...</section>',
    css='.hero { background: var(--color-bg); }',
    js='(function() { /* interactions */ })();',
    php_exec=True  # only if HTML contains <?php ?>
))

# Assemble
full_content = "\n\n".join(sections)

# Push
credentials = f"{USERNAME}:{APP_PASSWORD}"
auth_header = base64.b64encode(credentials.encode()).decode()

response = requests.post(
    f"{WP_URL}/wp-json/wp/v2/pages/{PAGE_ID}",
    json={"content": full_content},
    headers={
        "Authorization": f"Basic {auth_header}",
        "Content-Type": "application/json",
    },
    timeout=30
)
```

### Building the Block Comment

The critical function — properly JSON-escape the content, CSS, and JS into block comment JSON:

```python
def build_page_block(name, html, css="", js="", php_exec=False):
    """Build a wp:marketers-delight/page-block comment string."""
    attrs = {}

    if html:
        attrs["content"] = html
    if css:
        attrs["css"] = css
    if js:
        attrs["js"] = js
    if php_exec:
        attrs["phpExec"] = True

    attrs["metadata"] = {"name": name}

    # json.dumps handles all escaping (quotes, newlines, unicode)
    attrs_json = json.dumps(attrs, ensure_ascii=False)

    return f'<!-- wp:marketers-delight/page-block {attrs_json} /-->'
```

### JSON Escaping Rules

The block comment JSON uses standard JSON encoding. `json.dumps()` handles:
- `"` becomes `\"`
- Newlines become `\n`
- Tabs become `\t`
- `<` and `>` stay as-is (NOT HTML-escaped)
- `--` inside HTML comments becomes `\u002d\u002d` (WordPress requirement)
- `/` may become `\/` (both valid JSON)

**Critical**: The `--` sequence in HTML comments (like `<!-- comment -->`) inside content MUST be escaped to `\u002d\u002d` to avoid breaking the outer block comment boundary. Use:

```python
def escape_for_block_comment(html):
    """Escape HTML content for embedding in block comment JSON."""
    # Replace -- with unicode escapes inside the content
    # This prevents breaking the <!-- /-->  block comment wrapper
    return html.replace('-->', '\\u002d\\u002d>')
```

Or let `json.dumps` with `ensure_ascii=True` handle it (encodes all non-ASCII and special chars).

---

## Existing Page Block Examples (from site homepage)

The homepage uses 4 Page Blocks:

| # | Name | Content | CSS | JS | PHP |
|---|------|---------|-----|----|----|
| 1 | Hero | 12K chars, blueprint grid aesthetic | 21 chars (minimal, CSS in meta) | 614 chars (tab switching) | Yes |
| 2 | Services | 10.7K chars, terminal UI theme | 15.3K chars | None | No |
| 3 | Query (Featured Guides) | 14.7K chars, curated content grid | 21.8K chars | None | Yes |
| 4 | Tools | 8K chars, tool showcase grid | 4.4K chars | None | No |

### Pattern Observations
- Hero CSS is stored in the meta-box Page Blocks system (not in the GB block), so its `css` attribute is just `"/* Page Blocks CSS */"` placeholder
- Sections 2-4 have full CSS inline in the block `css` attribute
- Only the Hero has JS (for tab panel switching)
- PHP execution is used for dynamic dates (`date_i18n()`) and loops
- All sections use the utility-first spacing approach from `style.css`

---

## CSS Output Configuration

The page can be configured to output CSS/JS as inline or external files. This is controlled via the MD post meta `page_blocks.css_output` and `page_blocks.js_output` fields (set in the Page Blocks meta box in wp-admin).

- `"inline"` (default): CSS in `<style>` in head, JS in `<script>` in footer
- `"file"`: External minified files at `/wp-content/uploads/md-page-blocks/`

File paths:
- Meta-box blocks CSS: `page-blocks-{post_id}.css`
- Meta-box blocks JS: `page-blocks-{post_id}.js`
- Gutenberg blocks CSS: `page-block-gb-{post_id}.css`
- Gutenberg blocks JS: `page-block-gb-{post_id}.js`

Files are auto-regenerated on post save and deleted on post delete.

---

## REST API Endpoints

The dropin also provides dedicated REST endpoints:

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/wp-json/md/v1/page-blocks/{post_id}` | Get meta-box page blocks |
| POST | `/wp-json/md/v1/page-blocks/{post_id}` | Update meta-box page blocks |

These are for the **meta-box** Page Blocks system (separate from Gutenberg blocks). For Gutenberg Page Blocks, use the standard WordPress pages/posts REST API with `content` field containing the block markup.

---

## Workflow: Creating a New Page with Page Blocks

1. **Design sections** as standalone HTML/CSS/JS units
2. **Use the project's design system**: utility classes from `style.css`, CSS variables from `globals.css`, icons from Untitled UI
3. **Build each section** as a `build_page_block()` call
4. **Assemble** all sections with `"\n\n".join(sections)`
5. **Push** via REST API to the target page
6. **Verify** the live page renders correctly

### Section Checklist
- [ ] HTML uses semantic elements (`<section>`, `<header>`, `<nav>`)
- [ ] Spacing uses utility classes (`block-double-tb`, `mb-single`, etc.)
- [ ] CSS uses CSS variables, not hardcoded values
- [ ] CSS is scoped to section class (no global selectors)
- [ ] Dark mode works via `color-mix()` with theme variables
- [ ] Responsive breakpoints match the project system (640/768/992/1366)
- [ ] Accessibility: `aria-labelledby`, `aria-hidden="true"` on decorative elements
- [ ] JS wrapped in IIFE with early-return guard
- [ ] `content-visibility: auto` on below-fold sections for performance

---

## Important Notes

- **No document shell**: Never include `<html>`, `<head>`, `<body>` in content
- **No `<style>` or `<script>` tags**: CSS goes in `css` attribute, JS goes in `js` attribute
- **PHP requires admin**: `phpExec` only works for users with `manage_options` capability
- **Shortcodes work**: `do_shortcode()` is always called on content
- **Minification is automatic**: HTML, CSS, and JS are minified on render
- **Block comment integrity**: Content must not contain unescaped `-->` as it breaks the block comment wrapper
