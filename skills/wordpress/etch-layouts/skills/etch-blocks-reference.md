# Etch Blocks Reference Skill

Complete reference for all 11 custom Etch blocks with their attributes, rendering behavior, and usage patterns.

For the **paste-ready envelope format** (v2.1 clipboard schema), see `etch-paste-format.md`.

## Block Overview

| Block Name | Class | Purpose |
|------------|-------|---------|
| `etch/element` | `ElementBlock` | Any HTML element with dynamic attributes |
| `etch/text` | `TextBlock` | Text content with dynamic expressions |
| `etch/loop` | `LoopBlock` | Iterate over collections |
| `etch/component` | `ComponentBlock` | Reusable patterns with props/slots |
| `etch/condition` | `ConditionBlock` | Conditional rendering |
| `etch/dynamic-element` | `DynamicElementBlock` | Dynamic tag name resolution |
| `etch/dynamic-image` | `DynamicImageBlock` | Image with media library integration |
| `etch/svg` | `SvgBlock` | SVG rendering from URL source |
| `etch/raw-html` | `RawHtmlBlock` | Raw HTML/shortcode output |
| `etch/slot-content` | `SlotContentBlock` | Named content for component slots |
| `etch/slot-placeholder` | `SlotPlaceholderBlock` | Slot insertion point in components |

All blocks use Block API v3, disable `html`, `className`, and `customClassName` supports.

The Etch builder uses a **Svelte-inspired template syntax** for authoring. Standard HTML elements appear as-is, components use PascalCase tags (`<SectionIntro />`), slots use `{#slot name}...{/slot}`, loops use `{#loop}...{/loop}`, and conditions use `{#if}...{/if}`. This template compiles to/from block JSON.

---

## etch/element

The fundamental building block. Renders any HTML element with dynamic attribute resolution.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `tag` | string | `"div"` | HTML tag name. **REQUIRED.** Missing `tag` crashes the builder with `TypeError: Cannot read properties of undefined (reading 'toLowerCase')`. |
| `attributes` | object | `{}` | Key-value pairs of HTML attributes |
| `styles` | array | `[]` | Style IDs referencing entries in the paste envelope's `styles` object |

### Rendering Flow

1. Parse `ElementAttributes` from block data
2. Register any scripts (`ScriptRegister`)
3. Get dynamic context sources from `DynamicContextProvider`
4. Resolve dynamic expressions in each attribute value
5. Register styles (original + resolved)
6. Process shortcodes in resolved attribute values
7. Strip `data-etch-note` attribute (editor-only annotation)
8. Build attribute string with `esc_attr()`
9. Render `<tag attrs>inner_blocks</tag>`

### Supports

- `innerBlocks: true` — Can contain child blocks
- `skip_inner_blocks: true` — Manually renders children

### Example

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "section",
    "attributes": {
      "class": "hero-section",
      "id": "main-hero",
      "data-section": "hero",
      "aria-label": "{this.title}"
    },
    "styles": ["e-abc123"]
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

### Valid Tags

Any valid HTML tag: `div`, `section`, `article`, `header`, `footer`, `nav`, `main`, `aside`, `ul`, `ol`, `li`, `a`, `img`, `button`, `form`, `input`, `label`, `span`, `p`, `h1`-`h6`, `figure`, `figcaption`, `table`, `tr`, `td`, `th`, `thead`, `tbody`, `dl`, `dt`, `dd`, `details`, `summary`, etc.

### Special Attributes

| Attribute | Purpose | Frontend |
|-----------|---------|----------|
| `data-etch-element` | Identifies element role in builder tree (e.g., `"section"`, `"container"`) | Rendered |
| `data-etch-note` | Editor-only annotation for developers | **Stripped** |

### Template Syntax

In the builder's HTML panel, elements appear as standard HTML:

```html
<section data-etch-element="section" class="hero-catalina">
  <div data-etch-element="container" class="hero__container">
    <!-- Child elements and components -->
  </div>
</section>
```

### Scoped CSS

Each section has its own CSS in the builder's CSS panel, scoped to the section's class:

```css
.hero-catalina {
  color-scheme: light;
  min-block-size: 100vh;
  background: var(--black, #000);
  display: flex;
  flex-direction: column;
  a {
    color: var(--text-light, #eee);
    &:hover { color: var(--white, #fff); }
  }
}
```

---

## etch/text

Plain text content with dynamic expression resolution. Outputs text directly without a wrapper element.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `content` | string | `""` | Text content, supports `{expression}` syntax |

### Rendering Flow

1. Parse `TextAttributes`
2. Get dynamic context sources
3. Replace template expressions using `DynamicContentProcessor::replace_templates()`
4. Sanitize content (escape HTML but preserve shortcodes)
5. Process shortcodes
6. Return text string (no wrapper element)

### Sanitization

The text block has smart sanitization:
- Escapes HTML special characters via `htmlspecialchars()`
- Preserves WordPress shortcodes using placeholder replacement
- Fast-path for content without `[` character (no shortcodes to preserve)

### Example

```json
{
  "blockName": "etch/text",
  "attrs": {
    "content": "Published on {this.date.dateFormat(\"F j, Y\")} by {this.author.name}"
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

---

## etch/loop

Iterates over collections, rendering inner blocks for each item. Supports two resolution pipelines.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `target` | string | `""` | Expression path to resolve items OR modifier chain |
| `itemId` | string | `""` | Context key for current item (default: `"item"`) |
| `indexId` | string | `""` | Context key for current index |
| `loopId` | string | `null` | Reference to a loop preset |
| `loopParams` | object | `null` | Parameters for the loop preset |

### Two Resolution Pipelines

**1. loopId Pipeline** — Direct loop preset reference:
```json
{
  "loopId": "posts",
  "loopParams": { "$count": 6, "$type": "\"post\"" },
  "target": "slice(0, 3)"
}
```
- `loopId` references a preset defined in `etch_loops` option
- `loopParams` are resolved against current context (dynamic values allowed)
- `target` can contain modifiers applied to the resolved data

**2. target Pipeline** — Expression-based resolution:
```json
{
  "target": "item.children",
  "itemId": "child"
}
```
- Target string is parsed as an expression path
- Supports JSON arrays/objects directly: `"target": "[1, 2, 3]"`
- Traverses context sources, applies modifiers

### Loop Context Stack

For each iteration, the loop pushes entries to `DynamicContextProvider`:
- `loop` type entry with key = `itemId` and value = current item
- `loop-index` type entry with key = `indexId` and value = current index (if indexId set)

Entries are popped after each iteration.

### Built-in Loop Types (via LoopHandlerManager)

| Handler | Key | Description |
|---------|-----|-------------|
| `WpQueryLoopHandler` | `wp-query` | WordPress `WP_Query` |
| `WpMainQueryLoopHandler` | `main-query` | Current archive/search main query |
| `JsonLoopHandler` | `json` | Static JSON data |
| `WpTermsLoopHandler` | `wp-terms` | Taxonomy terms |
| `WpUsersLoopHandler` | `wp-users` | WordPress users |

### Loop Parameters

Parameters are prefixed with `$` and string values must be double-quoted:

| Parameter | Type | Description |
|-----------|------|-------------|
| `$count` | number | Number of items (-1 for all) |
| `$type` | string | Post type (e.g., `"\"post\""`) |
| `$orderby` | string | Order by field |
| `$order` | string | ASC or DESC |
| `$offset` | number | Skip N items |
| `$meta_key` | string | Meta key for queries |
| `$meta_value` | string | Meta value for queries |
| `$taxonomy` | string | Taxonomy name (for terms) |
| `$include` | string | Comma-separated IDs |
| `$exclude` | string | Comma-separated IDs |

### Example: Posts Grid

```json
{
  "blockName": "etch/loop",
  "attrs": {
    "loopId": "posts",
    "loopParams": {
      "$count": 6,
      "$type": "\"post\"",
      "$orderby": "\"date\"",
      "$order": "\"DESC\""
    },
    "itemId": "post",
    "indexId": "idx"
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "article",
        "attributes": { "class": "post-card" }
      },
      "innerBlocks": [
        {
          "blockName": "etch/text",
          "attrs": { "content": "{post.title}" },
          "innerBlocks": [], "innerHTML": "", "innerContent": []
        }
      ],
      "innerHTML": "", "innerContent": []
    }
  ],
  "innerHTML": "", "innerContent": []
}
```

### Example: Nested Loop (Children)

```json
{
  "blockName": "etch/loop",
  "attrs": {
    "target": "item.children",
    "itemId": "child",
    "indexId": "childIdx"
  },
  "innerBlocks": []
}
```

---

## etch/component

References and renders a reusable pattern (stored as `wp_block` post type) with prop passing and slot support.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `ref` | number | `null` | Post ID of the `wp_block` pattern |
| `attributes` | object | `{}` | Props passed to the component |

### Rendering Flow

1. Get parent context sources (for resolving props)
2. Fetch pattern blocks from `CachedPattern` cache
3. Extract slot contents from component instance's inner blocks
4. Capture current dynamic entries for slot rendering
5. Resolve component attribute values against parent context
6. **Clear** dynamic context stack (isolate component scope)
7. Push component `props` entry with resolved property values
8. Push `slots` metadata entry
9. Push slot context to `ComponentSlotContextProvider`
10. Render pattern blocks
11. Pop slot context, restore parent dynamic entries
12. Process shortcodes on rendered output

### Component Properties

Properties are defined on the pattern post via `etch_component_properties` meta. The `ComponentPropertyResolver` resolves instance attributes against property definitions, applying defaults.

### Props Access

Inside the component, props are accessed via `{props.propertyName}`:

```json
{
  "blockName": "etch/component",
  "attrs": {
    "ref": 123,
    "attributes": {
      "title": "{post.title}",
      "image": "{post.featuredImage.url}",
      "showBadge": true
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/slot-content",
      "attrs": { "name": "footer" },
      "innerBlocks": [
        {
          "blockName": "etch/text",
          "attrs": { "content": "Custom footer content" },
          "innerBlocks": [], "innerHTML": "", "innerContent": []
        }
      ],
      "innerHTML": "", "innerContent": []
    }
  ]
}
```

---

## etch/condition

Conditionally renders inner blocks based on evaluated condition.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `condition` | object | `null` | Structured condition object |
| `conditionString` | string | `""` | Legacy string condition |

### Condition Object Format

```json
{
  "operator": "===",
  "leftHand": "this.meta.featured",
  "rightHand": "yes"
}
```

### Supported Operators

| Operator | Description |
|----------|-------------|
| `==` | Loose equality |
| `===` | Strict equality |
| `!=` | Loose inequality |
| `!==` | Strict inequality |
| `>` | Greater than |
| `<` | Less than |
| `>=` | Greater or equal |
| `<=` | Less or equal |
| `&&` | Logical AND |
| `\|\|` | Logical OR |
| `isTruthy` | Value is truthy |
| `isFalsy` | Value is falsy |

### Nested Conditions

Operands can be nested condition objects for complex logic:

```json
{
  "operator": "&&",
  "leftHand": {
    "operator": "isTruthy",
    "leftHand": "this.meta.show_badge"
  },
  "rightHand": {
    "operator": "===",
    "leftHand": "this.status",
    "rightHand": "publish"
  }
}
```

### Truthiness Rules

- Empty values (`""`, `0`, `null`, `[]`) → falsy
- String `"false"` → explicitly falsy
- Everything else → follows PHP truthiness

---

## etch/dynamic-element

Similar to `etch/element` but resolves the tag name dynamically from attributes.

### Differences from etch/element

- Tag can come from resolved `attributes.tag` (dynamic)
- Falls back to `attrs.tag` if no dynamic tag found
- Tag name is validated via `ElementAttributes::is_valid_tag_format()`
- Invalid tags default to `div`

### Example

```json
{
  "blockName": "etch/dynamic-element",
  "attrs": {
    "tag": "div",
    "attributes": {
      "tag": "{props.headingLevel}",
      "class": "dynamic-heading"
    }
  }
}
```

---

## etch/dynamic-image

Specialized image block with WordPress media library integration, srcset generation, and responsive image handling.

### Attributes

Same as `etch/element` (`tag`, `attributes`, `styles`) but `tag` defaults to `"img"`.

### Special Attribute Properties

These are extracted from `attributes` and not rendered as HTML attributes:

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `mediaId` | string | `null` | WordPress attachment ID |
| `useSrcSet` | string | `"true"` | Generate srcset attribute |
| `maximumSize` | string | `"full"` | Maximum image size to use |

### Rendering Behavior

**Without mediaId:**
- Renders `<img>` with provided attributes
- Adds default placeholder `src` if none provided: `https://placehold.co/1920x1080`

**With mediaId:**
- Fetches attachment metadata from WordPress
- Generates `srcset` from all available sizes up to `maximumSize`
- Generates `sizes` attribute based on maximum width
- Sets `src` to the `maximumSize` image URL
- Auto-adds `alt` from media library if user hasn't set one
- Auto-adds `width` and `height` dimensions

### Example

```json
{
  "blockName": "etch/dynamic-image",
  "attrs": {
    "tag": "img",
    "attributes": {
      "mediaId": "{post.featuredImage.id}",
      "class": "post-thumbnail",
      "loading": "lazy",
      "maximumSize": "large"
    }
  }
}
```

---

## etch/svg

Renders SVG elements by fetching SVG content from a URL source and merging user-defined attributes.

### Special Attribute Properties

| Property | Type | Description |
|----------|------|-------------|
| `src` | string | URL of the SVG file to fetch |
| `stripColors` | string | Remove fill/stroke colors (`"true"` to enable) |

### Rendering Flow

1. Resolve dynamic expressions in attributes
2. Fetch SVG content from `src` URL via `SvgLoader::fetch_svg_cached()`
3. Optionally strip colors from SVG
4. Merge user attributes into the `<svg>` tag
5. Return prepared SVG markup

### Example

```json
{
  "blockName": "etch/svg",
  "attrs": {
    "tag": "svg",
    "attributes": {
      "src": "https://example.com/icon.svg",
      "class": "icon icon--social",
      "width": "24",
      "height": "24",
      "stripColors": "true"
    }
  }
}
```

---

## etch/raw-html

Renders raw HTML content. Supports dynamic expressions, shortcodes, embedded Gutenberg blocks, and optional unsafe mode.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `content` | string | `""` | HTML content to render |
| `unsafe` | string | `""` | Enable unsafe mode (skips sanitization) |

### Rendering Behavior

1. Resolve dynamic expressions in `content` and `unsafe`
2. Process shortcodes
3. If content contains Gutenberg blocks → parse and render them
4. If `unsafe` is truthy AND `allow_raw_html_unsafe_usage` setting enabled → return raw HTML
5. Otherwise → sanitize with `wp_kses()` (post-level allowed HTML + data-* + style)

### Example

```json
{
  "blockName": "etch/raw-html",
  "attrs": {
    "content": "<svg viewBox=\"0 0 24 24\"><path d=\"M12 2L2 7l10 5 10-5-10-5z\"/></svg>"
  }
}
```

---

## etch/slot-content

Used within component instances to provide named content for slot placeholders.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | `""` | Slot name to fill |

### Behavior

Simply renders its inner blocks. The actual slot routing is handled by `ComponentBlock` during component rendering — it extracts `etch/slot-content` blocks from the component instance's inner blocks and maps them by name.

---

## etch/slot-placeholder

Used in component definitions to mark insertion points for slot content.

### Attributes

| Attribute | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | string | `""` | Slot name to match |

### Rendering Flow

1. Look up slot content from `ComponentSlotContextProvider::current_slots()`
2. Check recursion guard (prevents infinite loops)
3. Save current dynamic context
4. Restore **parent** dynamic context (slots render in caller's scope, not component's)
5. Push slot marker entry
6. Render matched slot blocks
7. Restore component dynamic context

### Key Detail: Context Isolation

Slot content renders with the **parent's** dynamic context, not the component's. This prevents props leakage and ensures the slot content can access the same data scope as where the component was instantiated.

---

## Common Block Patterns

### Text in a Heading

Always wrap `etch/text` inside an `etch/element`:

```json
{
  "blockName": "etch/element",
  "attrs": { "tag": "h2", "attributes": { "class": "title" } },
  "innerBlocks": [
    {
      "blockName": "etch/text",
      "attrs": { "content": "{this.title}" },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ],
  "innerHTML": "", "innerContent": []
}
```

### Link with Dynamic URL

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "a",
    "attributes": {
      "href": "{post.permalink}",
      "class": "read-more"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/text",
      "attrs": { "content": "Read More" },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ],
  "innerHTML": "", "innerContent": []
}
```

### Image with Fallback

```json
{
  "blockName": "etch/dynamic-image",
  "attrs": {
    "tag": "img",
    "attributes": {
      "mediaId": "{post.featuredImage.id}",
      "alt": "{post.title}",
      "class": "thumbnail",
      "loading": "lazy"
    }
  },
  "innerBlocks": [], "innerHTML": "", "innerContent": []
}
```

## Output Requirements

1. All `etch/text` blocks must have `innerHTML: ""` and `innerContent: []`
2. All parent blocks with N children must have `innerHTML`/`innerContent` with newline separators and `null` placeholders (see `etch-paste-format.md` for the `buildContent(n)` function)
3. `blockName` must match one of the 11 registered types
4. `attrs` must match the expected schema for that block type
5. Every `etch/element` block MUST have `attrs.tag` — omitting it crashes the builder
6. Dynamic expressions use `{context.path}` syntax
7. Loop params with string values require escaped quotes: `"\"value\""`
8. For paste-ready output, wrap in v2.1 envelope (see `etch-paste-format.md`)
