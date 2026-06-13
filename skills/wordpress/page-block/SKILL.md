---
name: page-block
description: Build and push section-based pages using the Marketers Delight Page Block (`marketers-delight/page-block`) Gutenberg block with HTML, CSS, and optional JS in block attributes. Use when creating or updating WordPress pages that use Page Blocks and when generating or pushing Page Block content through the REST API.
---

# Page Block Skill

Build and push section-based pages using the Marketers Delight **Page Block** system (v7.0.0). Page Blocks are reusable HTML/CSS/JS/PHP sections stored in a custom database table (`wp_md_page_blocks`), embeddable via Gutenberg block picker, shortcode, or positioned on hooks site-wide.

---

## What Is a Page Block?

A Page Block is a **reusable content unit** stored in `wp_md_page_blocks` with its own HTML, CSS, JS, and display conditions. It can be used in three ways:

1. **Gutenberg block** — picked from the library in the Block Editor via `marketers-delight/page-block`
2. **Shortcode** — `[page_block id="123"]` or `[page_block slug="hero-section"]`
3. **Positioned** — hooked to a theme action (e.g., `md_hook_before_header`) and conditionally displayed site-wide

### Database Schema

| Column | Type | Default | Purpose |
|--------|------|---------|---------|
| `id` | bigint | AUTO_INCREMENT | Primary key |
| `title` | varchar(255) | `''` | Display name |
| `slug` | varchar(200) | `''` | Unique identifier |
| `status` | varchar(20) | `'publish'` | publish/draft/trash |
| `content` | longtext | — | HTML (or HTML + PHP) |
| `css` | longtext | — | Block CSS |
| `js` | longtext | — | Block JavaScript |
| `js_location` | varchar(10) | `'footer'` | footer or inline |
| `output` | varchar(10) | `'inline'` | inline or file |
| `php_exec` | tinyint(1) | `0` | Execute PHP in content |
| `format` | tinyint(1) | `0` | Apply wpautop() |
| `position` | varchar(100) | `''` | Theme hook name (empty = no auto-placement) |
| `priority` | int(11) | `10` | Hook priority |
| `conditions` | longtext | `NULL` | JSON display conditions |
| `author` | bigint(20) | `0` | Creator user ID |
| `created_at` | datetime | CURRENT_TIMESTAMP | Creation time |
| `updated_at` | datetime | CURRENT_TIMESTAMP | Last update time |

### Gutenberg Block Reference Format

When embedded via the Block Editor, the block comment references by ID:

```
<!-- wp:marketers-delight/page-block {"blockId":1} /-->

<!-- wp:marketers-delight/page-block {"blockId":50} /-->
```

Key details:
- **Self-closing block**: ends with `/-->` (no inner blocks)
- `blockId` references `wp_md_page_blocks.id`
- All content/CSS/JS lives in the database, not in the block comment
- The block has `save: function() { return null; }` — all rendering is server-side

### Inline Page Block Format

For pages where content/CSS/JS should live directly in the post content (not in the database), use the **inline-page-block** block type:

```
<!-- wp:marketers-delight/inline-page-block {"content":"<section>...</section>","css":".class{css:value;}","js":"function (){}"} /-->
```

Key details:
- **Block name**: `marketers-delight/inline-page-block` (NOT `page-block`)
- **Self-closing block**: ends with `/-->` (no inner blocks)
- All content/CSS/JS is JSON-encoded in the block comment attributes
- `content`: HTML string (JSON-escaped)
- `css`: CSS string (JSON-escaped)
- `js`: JavaScript string (JSON-escaped, optional)
- No `blockId` — everything is inline in the post content
- Ideal for programmatic/templated pages (e.g., local SEO city pages) where each page needs unique content
- Can be mixed with database-backed `page-block` references on the same page

**When to use inline vs database:**
- **Database (`page-block` with `blockId`)**: Shared sections reused across many pages (edit once, update everywhere)
- **Inline (`inline-page-block`)**: Unique per-page content, programmatic generation, templated pages

### Python Pattern for Inline Page Blocks

```python
import json

def inline_page_block(content, css, js=""):
    """Build an inline-page-block comment"""
    obj = {"content": content, "css": css}
    if js:
        obj["js"] = js
    return '<!-- wp:marketers-delight/inline-page-block ' + json.dumps(obj, ensure_ascii=False) + ' /-->'

# Build a page with multiple inline blocks
blocks = [
    inline_page_block('<section class="hero">...</section>', '.hero { background: #000; }', '(function(){})();'),
    inline_page_block('<section class="services">...</section>', '.services { padding: 4rem 0; }'),
]
page_content = "\n\n".join(blocks)
```

New blocks should use the database `blockId` reference format for shared content, and `inline-page-block` for per-page unique content.

---

## How It Renders

### CSS Delivery
1. On `template_redirect`, positioned blocks are queried and their CSS collected
2. During `the_content`, Gutenberg page blocks render and add their CSS
3. All CSS is combined and output in `<head>` as `<style id="md-page-blocks-css">`
4. File output mode: generates `/wp-content/uploads/md-page-blocks/page-blocks-v{version}.css`

### HTML Rendering
1. If `php_exec` is true **AND** `MD_ALLOW_PHP_SNIPPETS` is defined truthy in `wp-config.php` **AND** the stored `php_checksum` matches `md5($content)` at render time, PHP is executed via temp file include. Otherwise `<?php … ?>` blocks are stripped (HTML between tags is preserved, which is misleading — see "PHP execution is double-gated" below).
2. Shortcodes are processed via `do_shortcode()`
3. If `format` is true, `wpautop()` is applied
4. HTML is minified (whitespace collapsed, comments stripped, `<pre>`/`<code>`/`<script>`/`<style>` preserved)

### JS Delivery
1. Inline JS collected and output in `wp_footer` as `<script id="md-page-blocks-js">`
2. JS with `js_location = 'inline'` outputs immediately after the block's HTML
3. File output mode: generates external minified JS file

### Positioned Blocks
Blocks with a `position` set are automatically hooked to that theme action:
1. On `template_redirect`, all positioned blocks are queried
2. Display conditions are evaluated (post types, post IDs, page types)
3. Matching blocks register on their position hook at the specified priority
4. CSS is collected early for `<head>` output

---

## REST API

Full CRUD at `/wp-json/md/v1/page-blocks`. Requires authentication.

| Method | Endpoint | Permission | Purpose |
|--------|----------|------------|---------|
| GET | `/page-blocks` | `edit_posts` | List blocks (paginated, filterable) |
| POST | `/page-blocks` | `manage_options` | Create block |
| GET | `/page-blocks/{id}` | `edit_posts` | Get single block |
| PUT/PATCH | `/page-blocks/{id}` | `manage_options` | Update block |
| DELETE | `/page-blocks/{id}` | `manage_options` | Trash (or `?force=true` to delete) |
| GET | `/page-blocks/{id}/render` | `edit_posts` | Render block HTML preview |

### Query Parameters (GET /page-blocks)

| Param | Type | Default | Options |
|-------|------|---------|---------|
| `status` | string | `'publish'` | publish, draft, trash, `''` (all) |
| `search` | string | `''` | Search title and slug |
| `position` | string | `''` | Filter by position hook |
| `orderby` | string | `'updated_at'` | id, title, slug, updated_at, created_at |
| `order` | string | `'DESC'` | ASC, DESC |
| `per_page` | int | `20` | 1–100 |
| `page` | int | `1` | Page number |

### Create/Update Fields

| Field | Type | Description |
|-------|------|-------------|
| `title` | string | Display name |
| `slug` | string | Unique slug (auto-generated from title if omitted) |
| `status` | string | publish, draft, trash |
| `content` | string | HTML content |
| `css` | string | CSS code |
| `js` | string | JavaScript code |
| `js_location` | string | `'footer'` or `'inline'` |
| `output` | string | `'inline'` or `'file'` |
| `php_exec` | boolean | Execute PHP in content |
| `format` | boolean | Apply wpautop() formatting |
| `position` | string | Theme hook name (empty = shortcode/block only) |
| `priority` | integer | Hook priority (default 10) |
| `conditions` | object/null | Display conditions JSON |

### Python Pattern for Managing Page Blocks

```python
import base64
import requests

WP_URL = "https://yoursite.com"
USERNAME = "your-username"
APP_PASSWORD = "..."  # from .env

credentials = f"{USERNAME}:{APP_PASSWORD}"
auth_header = base64.b64encode(credentials.encode()).decode()
headers = {
    "Authorization": f"Basic {auth_header}",
    "Content-Type": "application/json",
}

# Create a new page block
response = requests.post(
    f"{WP_URL}/wp-json/md/v1/page-blocks",
    json={
        "title": "Hero Section",
        "content": '<section class="hero block-double-tb"><div class="inner">...</div></section>',
        "css": ".hero { background: var(--color-bg); }",
        "js": "(function() { /* interactions */ })();",
        "status": "publish",
    },
    headers=headers,
    timeout=30,
)
block = response.json()
block_id = block["id"]  # Use this in Gutenberg: {"blockId": block_id}

# Update an existing page block
requests.put(
    f"{WP_URL}/wp-json/md/v1/page-blocks/{block_id}",
    json={"css": ".hero { background: linear-gradient(...); }"},
    headers=headers,
)

# Create a positioned block (shows site-wide)
requests.post(
    f"{WP_URL}/wp-json/md/v1/page-blocks",
    json={
        "title": "Announcement Bar",
        "content": '<div class="announce block-half-tb"><div class="inner">...</div></div>',
        "css": ".announce { background: var(--color-primary); color: #fff; }",
        "position": "md_hook_before_header",
        "priority": 5,
        "conditions": {
            "page_types": ["front_page", "blog"],
        },
        "status": "publish",
    },
    headers=headers,
)

# List all page blocks
blocks = requests.get(
    f"{WP_URL}/wp-json/md/v1/page-blocks",
    params={"per_page": 50},
    headers=headers,
).json()
```

### Embedding in a WordPress Page

After creating page blocks via the REST API, reference them in page content:

```python
# Push page content with page block references
page_content = "\n\n".join([
    '<!-- wp:marketers-delight/page-block {"blockId":1} /-->',
    '<!-- wp:marketers-delight/page-block {"blockId":2} /-->',
    '<!-- wp:marketers-delight/page-block {"blockId":50} /-->',
])

requests.post(
    f"{WP_URL}/wp-json/wp/v2/pages/{PAGE_ID}",
    json={"content": page_content},
    headers=headers,
)
```

---

## Display Conditions (Positioned Blocks)

Conditions are stored as JSON. All conditions must pass (AND logic).

```json
{
    "post_types": ["post", "page"],
    "post_ids": [7172, 1234],
    "page_types": ["front_page", "blog", "singular", "archive", "search", "404"]
}
```

- Empty conditions = show everywhere
- `post_types` — only show on these post types
- `post_ids` — only show on these specific posts/pages
- `page_types` — only show on these WordPress conditionals

---

## Available Position Hooks

| Hook | Location |
|------|----------|
| `md_hook_before_html` | Very top of page |
| `md_hook_before_header` | Before header |
| `md_hook_header_top` | Header top |
| `md_hook_header_bottom` | Header bottom |
| `md_hook_after_header` | After header |
| `md_hook_before_content_box` | Before content box |
| `md_hook_content_box_top` | Content box top |
| `md_hook_content_box_bottom` | Content box bottom |
| `md_hook_before_content` | Before main content |
| `md_hook_content_top` | Content top (inside) |
| `md_hook_before_the_content` | Before the content |
| `md_hook_content` | After post content |
| `md_hook_content_bottom` | Content bottom (inside) |
| `md_hook_after_content` | After main content |
| `md_hook_before_sidebar` | Before sidebar |
| `md_hook_after_sidebar` | After sidebar |
| `md_hook_before_footer` | Before footer |
| `md_hook_footer_top` | Footer top |
| `md_hook_footer_bottom` | Footer bottom |
| `md_hook_after_footer` | After footer |
| `md_hook_before_footer_copy` | Before footer copyright |
| `md_hook_after_footer_copy` | After footer copyright |

---

## Section Architecture

Each Page Block represents one visual section. The recommended structure:

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

#### Font Families (CSS is OK)

| Variable | Value | Usage |
|----------|-------|-------|
| `var(--font-head)` | GTReallySans | Headings, titles, badges, buttons, stat numbers |
| `var(--font-body)` | InterVar/Inter | Body text (default, rarely needs explicit declaration) |
| `var(--font-serif)` | TiemposText | Subtitles, quotes, editorial accents |
| `var(--font-mono)` | SF Mono | Code blocks, technical labels |

### CSS Conventions
- Define section-scoped CSS variables at the section class level
- Use `color-mix()` for theme-aware colors that work in light/dark mode
- Use existing CSS variables from `globals.css` (`--color-primary`, `--color-text`, etc.)
- **No `@import` in CSS** — the theme already loads globals
- **No `<link>` or `<script>` in HTML** — CSS goes in the `css` field, JS in `js` field
- Prefix component classes with `gt-` (e.g., `gt-book-hero__title`, `gt-services__card`)
- Prefer CSS-only animations over JS-driven scroll animations
- Include `@media (prefers-reduced-motion: reduce)` to disable animations
- Dark mode overrides via `[data-theme="dark"]` selector

### JS Conventions (Minimize JS)
- Prefer CSS-only solutions: `@keyframes` for entrance animations, `:hover`/`:focus-visible` for interactions
- Only use JS when CSS cannot achieve the effect
- When JS is needed: wrap in IIFE, early-return if section not found, respect `prefers-reduced-motion`
- Use event delegation on section wrapper

---

## Admin Bar Integration

The **MD Tools** admin bar menu provides quick access:
- **Compile All / CSS / JS** — recompile theme assets
- **+ New Page Block** — direct link to create a new page block
- **Active Blocks (n)** — shows all page blocks rendering on the current page (both positioned and Gutenberg-embedded), each linking to its edit screen

---

## Workflow: Creating Page Blocks

### Via Admin UI
1. Go to **MD Settings → Page Blocks → Add New**
2. Enter title, HTML content, CSS, and JS
3. Optionally set position hook and display conditions for site-wide placement
4. Save as publish or draft

### Via REST API
1. `POST /wp-json/md/v1/page-blocks` with content/css/js fields
2. Use the returned `id` in Gutenberg: `<!-- wp:marketers-delight/page-block {"blockId":ID} /-->`
3. Or set `position` for automatic hook-based placement

### Via Shortcode
```
[page_block id="123"]
[page_block slug="hero-section"]
```

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
- **No `<style>` or `<script>` tags**: CSS goes in `css` field, JS goes in `js` field
- **PHP execution is double-gated** (since dropin v2.0+): `php_exec=1` alone is **not enough**. The runtime checks `md_page_blocks_execute_php()` which requires:
  1. `define('MD_ALLOW_PHP_SNIPPETS', true)` in `wp-config.php` — site-level opt-in constant. Without it, PHP tags are silently stripped at render time.
  2. The stored `php_checksum` (md5 of content at save time) must match the current content's md5. If they diverge — e.g., the content was mutated directly in the DB, or a save raced the checksum write — the runtime falls back to stripping `<?php … ?>` tags.
  - Inline Gutenberg blocks (`marketers-delight/inline-page-block`) **cannot** run PHP — there's no save-time checksum to verify. Only database-stored page blocks (`{"blockId":N}` references) can execute PHP.
  - **Failure symptom**: HTML between PHP tags renders once (control flow gone, plain HTML kept), all `<?php echo … ?>` outputs are empty, loops appear to iterate exactly once. If you see this, check (a) the constant in `wp-config.php`, (b) re-save the block via REST/admin to refresh `php_checksum`.
  - Sites can override the gate via the `md_page_blocks_can_execute_php` filter (receives `$gate_default, $content, $checksum`) for stricter or looser policies.
- **Shortcodes work**: `do_shortcode()` is always called on content — prefer shortcodes over `php_exec` when the dynamic logic already exists as a shortcode, since they don't depend on the `MD_ALLOW_PHP_SNIPPETS` gate.
- **Minification is automatic**: HTML, CSS, and JS are minified on render
- **Slugs are unique**: auto-generated from title if not provided, with `-2`, `-3` suffixes for duplicates
- **Soft delete**: DELETE without `?force=true` trashes; with `force=true` permanently deletes
- **Asset versioning**: every insert/update/delete bumps an internal version counter for cache busting
