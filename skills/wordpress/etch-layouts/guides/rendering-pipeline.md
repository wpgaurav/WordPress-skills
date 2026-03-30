# Etch Rendering Pipeline

How Etch blocks transform from JSON to final HTML on the WordPress frontend.

---

## High-Level Flow

```
Block JSON (stored in post_content as Gutenberg comments)
  → WordPress parse_blocks()
  → WP_Block render callbacks (registered by BlocksRegistry)
  → DynamicContextProvider resolves {expressions}
  → StylesRegister collects CSS
  → Final HTML + <style id="etch-page-styles">
```

---

## Rendering Per Block Type

### etch/element → `<tag attributes>inner blocks</tag>`

1. Extract `tag`, `attributes`, `styles` from attrs
2. Get context sources from `DynamicContextProvider::get_sources_for_wp_block()`
3. Resolve dynamic expressions in attribute values (e.g., `class="{this.type}"`)
4. Register styles via `StylesRegister::register_block_styles()`
5. Process shortcodes in resolved attribute values
6. Escape attributes with `esc_attr()`
7. Render inner blocks recursively
8. Output: `<tag attr1="val1" attr2="val2">...inner content...</tag>`

**Tag validation**: Must match `/^[a-z][a-z0-9\-]*$/` (supports custom elements).

**URL attribute sanitization**: `href`, `src`, `poster`, `action` are sanitized against `{url.parameter` injection patterns.

### etch/text → raw text

1. Extract `content` from attrs
2. Get context sources
3. Resolve dynamic expressions/templates in content
4. Sanitize HTML with `htmlspecialchars()` (preserving shortcodes via placeholder mechanism)
5. Process shortcodes
6. Output: raw text string (no wrapper element)

### etch/component → rendered pattern content

1. Load pattern blocks from `wp_block` post (by `ref` ID) via `CachedPattern`
2. Get parent context sources
3. Extract slot contents from component's inner blocks
4. Resolve component instance attributes against parent scope
5. **Clear the dynamic context stack** (scope isolation)
6. Resolve component property definitions + instance attributes → `props`
7. Push `props` and `slots` metadata onto context stack
8. Push slot context for lazy placeholder rendering
9. Render pattern blocks (each block sees `{props.x}` in context)
10. Pop all component context
11. Restore parent context entries
12. Output: rendered pattern HTML

**Scope isolation**: Component has its own `props` context. Parent loop/component context is cleared during rendering but restored after.

### etch/loop → repeated inner blocks

1. Resolve loop items from `target` expression or `loopId` preset
2. For each item:
   - Push `DynamicContentEntry('loop', itemId, item)` onto context stack
   - Optionally push index entry
   - Render all inner blocks (they see `{item.x}` or `{post.x}` etc.)
   - Pop context entries
3. Output: concatenated HTML of all iterations

**Item resolution pipelines**:
- `loopId` → `LoopHandlerManager::get_loop_preset_data()` → optional target modifiers
- `target` → expression resolution (JSON array, expression path, or preset name)

### etch/condition → inner blocks or nothing

1. Evaluate condition tree against context sources
2. If true: render inner blocks
3. If false: return empty string

**Condition tree**: Recursive structure with `operator`, `leftHand`, `rightHand`.

**Truthiness**: PHP `empty()` is falsy, string `"false"` (case-insensitive) is falsy.

---

## Dynamic Expression System

### Expression Formats

| Format | Example | Resolution Method |
|--------|---------|-------------------|
| Standalone | `{this.title}` | `DynamicContentProcessor::apply()` |
| Inline template | `"Hello {this.name}!"` | `DynamicContentProcessor::replace_templates()` |
| With modifiers | `{this.posts\|limit(5)\|map("name")}` | Chain applied left-to-right |
| Literal | `"text"`, `123`, `true` | No processing |

### Context Stack (DynamicContextProvider)

Stack of `DynamicContentEntry` objects, searched in reverse order (most recent first):

| Type | Key | Data | When |
|------|-----|------|------|
| `global` | `this` | Current post object | Always |
| `global` | `site` | Site name, URL, description | Always |
| `global` | `user` | Current user (if logged in) | Always |
| `global` | `url` | Current URL parts | Always |
| `global` | `options` | ACF option pages | Always |
| `global` | `archive` | Archive type, title, count | On archive pages |
| `global` | `term` | Term ID, name, slug | On taxonomy pages |
| `global` | `taxonomy` | Taxonomy name, label | On taxonomy pages |
| `component` | `props` | Resolved component properties | Inside component |
| `component-slots` | `slots` | Slot availability metadata | Inside component |
| `loop` | `item` (or custom) | Current loop item | Inside loop |
| `loop-index` | `index` (or custom) | Current loop index (0-based) | Inside loop with indexId |

**Resolution priority**: Loop > Component > Global (last pushed = first checked)

---

## Style System

### Collection and Emission

1. Each `etch/element` block calls `StylesRegister::register_block_styles()` during render
2. Style IDs from `attrs.styles` are looked up in the stored styles option (`etch_styles`)
3. If `class` attribute contains dynamic expressions, resolved class names are matched against registered styles
4. All collected styles accumulate in `StylesRegister::$page_styles` (static array)
5. At `wp_head` priority 99: single `<style id="etch-page-styles">` tag emitted with all CSS
6. Styles cleared after output

### Style Types in Database

Stored in WordPress option `etch_styles`:

```php
[
    'style-id' => [
        'type' => 'class',           // 'class' (.selector), 'id' (#selector), or 'element' (tag)
        'selector' => '.my-class',
        'css' => 'font-size: var(--fs-m);\ncolor: var(--text-primary);',
        'readonly' => false,
        'collection' => 'default'
    ]
]
```

Every element defines its own style entry. CSS uses `to-rem()` for pixel values and design system variables.

### Mandatory Styles

Always loaded regardless of block references:
- Styles with `:root` selector (CSS custom properties)
- Complex selectors (if `enable_complex_selector_loading_fix` setting enabled)

### CSS Output

```html
<style id="etch-page-styles">
.my-section { padding: var(--space-2xl) 0; background: var(--bg-base); }
.my-section__inner { width: 100%; max-width: var(--max-width); margin: 0 auto; }
.my-section__heading { font-size: clamp(to-rem(28px), 4vw, to-rem(40px)); }
</style>
```

Each element's style is emitted independently. The `css` field uses SCSS-like syntax with `to-rem()` for pixel values and GT Design System CSS variables. Nested CSS gets compiled to flat selectors.

---

## ContentWrapper

`ContentWrapper` removes the outer `<div>` wrapper that WordPress adds around `core/post-content`. This prevents Etch sections from having an extra wrapping div. Applied via `render_block_core/post-content` filter.

---

## Complete Render Example

**Input JSON:**
```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "Hero" },
    "tag": "section",
    "attributes": { "class": "hero" },
    "styles": ["hero-sect"]
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "metadata": { "name": "Container" },
        "tag": "div",
        "attributes": { "class": "hero__inner" },
        "styles": ["hero-inner"]
      },
      "innerBlocks": [
        {
          "blockName": "etch/element",
          "attrs": {
            "metadata": { "name": "Title" },
            "tag": "h1",
            "attributes": { "class": "hero__title" },
            "styles": ["hero-title"]
          },
          "innerBlocks": [
            { "blockName": "etch/text", "attrs": { "metadata": { "name": "Text" }, "content": "Welcome to {site.name}" } }
          ]
        },
        {
          "blockName": "etch/element",
          "attrs": {
            "metadata": { "name": "CTA" },
            "tag": "a",
            "attributes": { "class": "hero__cta", "href": "/get-started/" },
            "styles": ["hero-cta"]
          },
          "innerBlocks": [
            { "blockName": "etch/text", "attrs": { "metadata": { "name": "Text" }, "content": "Get Started" } }
          ]
        }
      ]
    }
  ]
}
```

**Output HTML:**
```html
<section class="hero">
  <div class="hero__inner">
    <h1 class="hero__title">Welcome to My Site</h1>
    <a class="hero__cta" href="/get-started/">Get Started</a>
  </div>
</section>
```

**Output CSS (in `<head>`):**
```html
<style id="etch-page-styles">
.hero { padding: var(--space-2xl) 0; background: var(--bg-base); }
.hero__inner { width: 100%; max-width: var(--max-width); margin: 0 auto; padding: 0 var(--space-m); }
.hero__title { font-size: clamp(to-rem(28px), 4vw, to-rem(40px)); font-weight: var(--fw-bold); }
.hero__cta { display: inline-flex; padding: var(--space-s) var(--space-l); background: var(--accent); }
</style>
```

Every element has its own class and style definition. Styles use `to-rem()` for pixel values and GT Design System CSS variables.

The key insight: **Etch blocks are a thin abstraction over semantic HTML.** Each `etch/element` renders directly to its `tag` with resolved attributes. `etch/text` is just text. The power comes from the context stack enabling dynamic data binding without prop drilling.
