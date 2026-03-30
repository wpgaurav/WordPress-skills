---
name: etch-layouts
description: Create responsive layouts using Etch page builder patterns and components.
---

# Etch Layouts Skill

Use this skill when creating layouts, sections, or components for Etch (the WordPress visual builder).

**For detailed reference, read `etch-skills/generating-layouts.md` in the project root.**

## Output Structure

Create layouts in `gt-design-system/layouts/{component-name}/`:

```
layouts/{component-name}/
├── {component-name}-etch.json    # For pasting into Etch (JSON format)
├── {component-name}-preview.html # Browser preview (compiled CSS inline)
└── {component-name}.js           # JavaScript (if interactive)
```

## Paste Format for Etch (v2.1)

**Etch only accepts JSON format for pasting.** The structure is:

```json
{
  "type": "block",
  "gutenbergBlock": {
    "blockName": "etch/element",
    "attrs": {
      "metadata": { "name": "My Section" },
      "tag": "section",
      "attributes": { "class": "my-section" },
      "styles": ["styleId123"]
    },
    "innerBlocks": [],
    "innerHTML": "",
    "innerContent": []
  },
  "version": 2.1,
  "styles": {
    "styleId123": {
      "type": "class",
      "selector": ".my-section",
      "collection": "default",
      "css": "padding: var(--space-2xl) 0;\nbackground: var(--bg-base);\n\n@media (max-width: to-rem(768px)) {\n    padding: var(--space-xl) 0;\n}",
      "readonly": false
    }
  }
}
```

### JSON Structure

| Field | Description |
|-------|-------------|
| `type` | Always `"block"` |
| `gutenbergBlock` | Block tree with `blockName`, `attrs`, `innerBlocks`, `innerHTML`, `innerContent` |
| `version` | Always `2.1` |
| `timestamp` | ISO 8601 timestamp |
| `styles` | Object mapping style IDs to style definitions |

### Block Types

| Block | Purpose |
|-------|---------|
| `etch/element` | HTML element with `tag`, `attributes`, `styles`, `metadata` |
| `etch/text` | Text content with `content` and `metadata` attributes |
| `etch/loop` | Iterator with `target`, `itemId`, `loopParams` |
| `etch/condition` | Conditional rendering with `condition` |
| `etch/component` | Reusable pattern reference with `ref` |

### Every Block MUST Have

All 5 fields: `blockName`, `attrs`, `innerBlocks`, `innerHTML`, `innerContent`

### Every Element MUST Have

- `metadata.name` — builder tree label
- `class` attribute — for CSS targeting
- `styles` array — with own style ID(s) linking to `styles` map

### innerHTML/innerContent Rules

| Case | innerHTML | innerContent |
|------|-----------|--------------|
| text block | `""` | `[]` |
| void element (img, br, hr) | `"\n\n"` | `["\n", "\n"]` |
| 0 children (non-void) | `""` | `[]` |
| 1 child | `"\n\n"` | `["\n", null, "\n"]` |
| 2 children | `"\n\n\n\n"` | `["\n", null, "\n\n", null, "\n"]` |
| N children | formula | `["\n", null, "\n\n", ..., null, "\n"]` |

### Style Definition

```json
{
  "type": "class",
  "selector": ".class-name",
  "collection": "default",
  "css": "/* SCSS-like syntax with to-rem() and design system variables */",
  "readonly": false
}
```

Style types: `"class"` (`.selector`), `"id"` (`#selector`), `"element"` (tag selector)

## Critical Rules

1. **No `data-etch-element`** — that attribute is from the legacy conversion script only
2. **No built-in styles** — no `etch-section-style` or `etch-container-style`
3. **Every element gets its own style** — per-element styling, not monolithic section CSS
4. **`to-rem()` for ALL pixel values** — never raw px
5. **Design system variables** — never hardcoded colors, spacing, or sizes
6. **BEM naming** — `section__element--modifier` pattern

## SCSS Rules

Styles use SCSS-like syntax:

1. `to-rem()` for all pixel values: `border: to-rem(1px) solid var(--border-default);`
2. `&` for pseudo-classes: `&:hover { color: var(--accent); }`
3. Nested media queries: `@media (max-width: to-rem(768px)) { ... }`
4. Child selectors from parent: `&:hover .card__title { color: var(--accent); }`
5. `clamp()` with `to-rem()`: `font-size: clamp(to-rem(28px), 4vw, to-rem(40px));`

## CSS Variables (GT Design System)

### Colors
- `--bg-base`, `--bg-subtle`, `--bg-elevated`, `--bg-sunken`, `--bg-overlay-heavy`
- `--text-primary`, `--text-secondary`, `--text-muted`, `--text-inverse`
- `--accent`, `--accent-hover`
- `--border-light`, `--border-default`, `--border-medium`

### Typography
- `--font-sans`, `--font-mono`
- `--fs-xs` to `--fs-4xl`
- `--fw-normal` to `--fw-black`
- `--lh-tight`, `--lh-snug`, `--lh-normal`, `--lh-relaxed`

### Spacing
- `--space-3xs` to `--space-3xl`

### Layout
- `--max-width`, `--content-width`
- `--header-height`, `--header-height-mobile`

### Effects
- `--radius-xs` to `--radius-full`
- `--shadow-xs` to `--shadow-xl`
- `--duration-fast`, `--duration-normal`
- `--ease-out`, `--ease-in-out`

### Z-Index
- `--z-header`, `--z-modal`, `--z-tooltip`

## Dynamic Expressions

Use `{context.path}` syntax in attributes and text content:

- `{site.url}` - Site URL
- `{site.name}` - Site name
- `{this.title}` - Current post title
- `{this.id}` - Current post ID
- `{user.displayName}` - Current user name
- `{props.myProp}` - Component prop
- `{post.title}` - Loop item field (when itemId is "post")
- `{post.permalink.relative}` - Post permalink
- `{post.featuredImage.url}` - Featured image URL
- `{post.date.dateFormat("M j, Y")}` - Formatted date
- `{post.excerpt | stripTags | truncate:100}` - Filtered excerpt

## Workflow

1. Read `etch-skills/generating-layouts.md` for full reference
2. Build JSON structure with blocks and styles (SCSS syntax in `css` fields)
3. Ensure every element has `class`, `metadata.name`, and `styles` with own ID(s)
4. Save as `-etch.json` for pasting into Etch
5. Create `-preview.html` with compiled CSS for browser testing
6. Create `.js` if interactive
