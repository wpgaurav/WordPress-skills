# Etch Paste Format (v2.1 Clipboard Schema)

How to create JSON that can be pasted directly into the Etch builder via Cmd+V.

## CRITICAL: This Format Is Different From Block JSON

The builder's **clipboard paste** format is NOT a flat array of blocks. It is a **versioned envelope** wrapping a single Gutenberg block tree plus style/loop/component registrations. Getting this wrong produces either "Paste failed: Unsupported legacy content structure" or `TypeError: Cannot read properties of undefined (reading 'toLowerCase')`.

## Version Dispatch

The paste handler reads `version` from the parsed JSON:

| Version | Handler | Notes |
|---------|---------|-------|
| `2.1` | `pTt` (modern) | Current format. Styles use `selector`+`collection` lookup. |
| `2` | `pTt` (modern) | Same handler. `rem()` auto-converted to `to-rem()`. |
| `1` | `eTt` (legacy) | Expects `type: "block"` or `type: "component"` at root. |
| Other | Rejected | Toast: "created with a newer version of Etch" |
| Missing | Defaults to `1` | Falls through to legacy handler. |

**Always use `version: 2.1`.**

## Envelope Schema

```json
{
  "type": "block",
  "gutenbergBlock": { ... },
  "version": 2.1,
  "timestamp": "2026-02-22T05:30:00.000Z",
  "styles": { ... },
  "loops": { ... },
  "components": { ... }
}
```

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `type` | `"block"` | Must be `"block"` for section/element paste. Use `"component"` for component paste (different schema). |
| `gutenbergBlock` | object | The root block in Gutenberg block format (see below). |
| `version` | `2.1` | Paste format version. |
| `timestamp` | string | ISO 8601 timestamp. |
| `styles` | object | Map of style ID → style definition. Keys are referenced in block `attrs.styles` arrays. |

### Optional Fields

| Field | Type | Description |
|-------|------|-------------|
| `loops` | object | Map of loop ID → loop preset definition (for `etch/loop` blocks with `loopId`). |
| `components` | object | Map of component definitions (for `etch/component` blocks). |

## gutenbergBlock Format

The `gutenbergBlock` is a recursive block tree. Every block MUST have these five fields:

```json
{
  "blockName": "etch/element",
  "attrs": { ... },
  "innerBlocks": [ ... ],
  "innerHTML": "...",
  "innerContent": [ ... ]
}
```

### innerHTML and innerContent Rules

These fields control how the Gutenberg parser reconstructs block content. They are REQUIRED even though Etch blocks don't use them for rendering.

**For `etch/text` blocks:**
```json
"innerHTML": "",
"innerContent": []
```

**For blocks WITH children (N inner blocks):**
```json
"innerHTML": "\n\n\n\n",
"innerContent": ["\n", null, "\n\n", null, "\n"]
```

The pattern for `innerContent` with N children:
- Start with `"\n"`
- For each child: `null` (placeholder), then `"\n\n"` (or `"\n"` after the last child)
- End with `"\n"` after the last null

Shortcut formula for N children:
```javascript
function buildContent(n) {
    if (n === 0) return { innerHTML: '', innerContent: [] };
    const parts = ['\n'];
    for (let i = 0; i < n; i++) {
        parts.push(null);
        parts.push(i < n - 1 ? '\n\n' : '\n');
    }
    return {
        innerHTML: parts.filter(p => p !== null).join(''),
        innerContent: parts,
    };
}
```

**For blocks WITHOUT children (leaf elements like `<img>`):**
```json
"innerHTML": "",
"innerContent": []
```

### Block attrs Schema

#### etch/element

```json
{
  "metadata": { "name": "Section" },
  "tag": "section",
  "attributes": {
    "data-etch-element": "section",
    "class": "hero-section",
    "id": "main-hero"
  },
  "styles": ["etch-section-style", "abc1234"]
}
```

| Field | Required | Description |
|-------|----------|-------------|
| `tag` | **YES** | HTML tag name. Missing `tag` causes `TypeError: Cannot read properties of undefined (reading 'toLowerCase')`. |
| `attributes` | No | HTML attributes as key-value object. |
| `styles` | No | Array of style IDs referencing entries in the envelope's `styles` object. |
| `metadata.name` | No | Display label in the builder's tree panel. |

#### etch/text

```json
{
  "metadata": { "name": "Text" },
  "content": "Hello, world!"
}
```

| Field | Required | Description |
|-------|----------|-------------|
| `content` | YES | Text content. Supports `{expression}` syntax for dynamic data. |
| `metadata.name` | No | Display label. Typically `"Text"`. |

**etch/text blocks must NOT have `tag` or `styles` fields.**

#### etch/loop, etch/component, etch/condition, etc.

Same attrs schema as documented in `etch-blocks-reference.md`. The paste format wraps them identically.

## styles Object

Maps style IDs (strings) to style definitions. These IDs are referenced in block `attrs.styles` arrays.

```json
{
  "styles": {
    "etch-section-style": {
      "type": "element",
      "selector": ":where([data-etch-element=\"section\"])",
      "collection": "default",
      "css": "inline-size: 100%;\n  display: flex;\n  flex-direction: column;\n  align-items: center;",
      "readonly": true
    },
    "etch-container-style": {
      "type": "element",
      "selector": ":where([data-etch-element=\"container\"])",
      "collection": "default",
      "css": "inline-size: 100%;\n  display: flex;\n  flex-direction: column;\n  max-inline-size: var(--content-width, 1366px);\n  align-self: center; margin-inline: auto;",
      "readonly": true
    },
    "djvgb07": {
      "type": "class",
      "selector": ".hero-section",
      "collection": "default",
      "css": "min-block-size: 100vh;\nbackground: #0a0a23;\ncolor: #f0f0f0;\n\n.hero__heading {\n  font-size: clamp(2.5rem, 6vw, 4.5rem);\n  font-weight: 800;\n}",
      "readonly": false
    }
  }
}
```

### Style Definition Fields

| Field | Type | Description |
|-------|------|-------------|
| `type` | string | `"element"` for attribute-based selectors, `"class"` for class-based. |
| `selector` | string | CSS selector. Used by the builder to look up or create the style. |
| `collection` | string | Style collection. Use `"default"`. |
| `css` | string | CSS declarations. For class styles, this is the **body** of the rule (without the selector wrapper). Supports nested CSS syntax. |
| `readonly` | boolean | `true` for built-in styles that shouldn't be edited. |

### How Style Import Works (from source)

```javascript
// For each style in the paste data:
const existingStyle = StyleManager.getStyle(selector, collection);
if (existingStyle) {
    existingStyle.css = newCss;      // Update CSS
    mapping[oldId] = existingStyle.id; // Map old ID to existing
} else {
    const newStyle = StyleManager.createStyle(selector, css, collection);
    mapping[oldId] = newStyle;         // Map old ID to new
}
```

The builder de-duplicates by `(selector, collection)`. If a style with the same selector already exists, it updates the CSS and remaps the ID. This means:
- `etch-section-style` and `etch-container-style` will map to the builder's existing built-in styles.
- Custom class styles (e.g., `.hero-section`) will be created fresh or updated if they already exist.

### CSS Nesting in Style Bodies

Style CSS uses **native CSS nesting** syntax:

```css
min-block-size: 100vh;
background: #0a0a23;

.hero__heading {
  font-size: clamp(2.5rem, 6vw, 4.5rem);
}

&:hover {
  opacity: 0.9;
}

@media (max-width: 768px) {
  padding: 2rem 1rem;
}
```

The root declarations belong to the selector. Nested rules use standard CSS nesting (`&` for pseudo-classes, direct child selectors, or `@media` blocks).

## Built-in Style IDs

These are the default element styles that the builder pre-registers. Always include them for section/container elements:

| ID | Selector | Purpose |
|----|----------|---------|
| `etch-section-style` | `:where([data-etch-element="section"])` | Base section layout (full-width, flex column, center-aligned) |
| `etch-container-style` | `:where([data-etch-element="container"])` | Base container layout (full-width, flex column, max-width, centered) |

## Section Structure Pattern

Every pasteable section should follow this hierarchy:

```
etch/element (tag: "section", data-etch-element: "section")
  └── etch/element (tag: "div", data-etch-element: "container")
       ├── etch/element (tag: "h1")
       │    └── etch/text (content: "...")
       ├── etch/element (tag: "p")
       │    └── etch/text (content: "...")
       └── etch/element (tag: "div", class: "actions")
            ├── etch/element (tag: "a", href: "...")
            │    └── etch/text (content: "Button")
            └── ...
```

### Minimal Working Section

```json
{
  "type": "block",
  "gutenbergBlock": {
    "blockName": "etch/element",
    "attrs": {
      "metadata": { "name": "My Section" },
      "tag": "section",
      "attributes": { "data-etch-element": "section" },
      "styles": ["etch-section-style"]
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "metadata": { "name": "Container" },
          "tag": "div",
          "attributes": { "data-etch-element": "container" },
          "styles": ["etch-container-style"]
        },
        "innerBlocks": [
          {
            "blockName": "etch/text",
            "attrs": {
              "metadata": { "name": "Text" },
              "content": "Hello from Etch!"
            },
            "innerBlocks": [],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "\n\n",
        "innerContent": ["\n", null, "\n"]
      }
    ],
    "innerHTML": "\n\n",
    "innerContent": ["\n", null, "\n"]
  },
  "version": 2.1,
  "timestamp": "2026-02-22T05:30:00.000Z",
  "styles": {
    "etch-section-style": {
      "type": "element",
      "selector": ":where([data-etch-element=\"section\"])",
      "collection": "default",
      "css": "inline-size: 100%;\n  display: flex;\n  flex-direction: column;\n  align-items: center;",
      "readonly": true
    },
    "etch-container-style": {
      "type": "element",
      "selector": ":where([data-etch-element=\"container\"])",
      "collection": "default",
      "css": "inline-size: 100%;\n  display: flex;\n  flex-direction: column;\n  max-inline-size: var(--content-width, 1366px);\n  align-self: center; margin-inline: auto;",
      "readonly": true
    }
  }
}
```

## Complete Example: Hero Section with Custom Styles

```json
{
  "type": "block",
  "gutenbergBlock": {
    "blockName": "etch/element",
    "attrs": {
      "metadata": { "name": "SaaS Hero" },
      "tag": "section",
      "attributes": {
        "data-etch-element": "section",
        "class": "saas-hero",
        "id": "hero"
      },
      "styles": ["etch-section-style", "s1a2b3c"]
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "metadata": { "name": "Container" },
          "tag": "div",
          "attributes": {
            "data-etch-element": "container",
            "class": "saas-hero__container"
          },
          "styles": ["etch-container-style"]
        },
        "innerBlocks": [
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "h1",
              "attributes": { "class": "saas-hero__heading" },
              "styles": []
            },
            "innerBlocks": [
              {
                "blockName": "etch/text",
                "attrs": {
                  "metadata": { "name": "Text" },
                  "content": "Ship faster with the modern dev platform"
                },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "\n\n",
            "innerContent": ["\n", null, "\n"]
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "p",
              "attributes": { "class": "saas-hero__lede" },
              "styles": []
            },
            "innerBlocks": [
              {
                "blockName": "etch/text",
                "attrs": {
                  "metadata": { "name": "Text" },
                  "content": "Deploy, scale, and manage your applications."
                },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "\n\n",
            "innerContent": ["\n", null, "\n"]
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "a",
              "attributes": {
                "class": "saas-hero__btn",
                "href": "#pricing"
              },
              "styles": []
            },
            "innerBlocks": [
              {
                "blockName": "etch/text",
                "attrs": {
                  "metadata": { "name": "Text" },
                  "content": "Start Free Trial"
                },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "\n\n",
            "innerContent": ["\n", null, "\n"]
          }
        ],
        "innerHTML": "\n\n\n\n\n\n",
        "innerContent": ["\n", null, "\n\n", null, "\n\n", null, "\n"]
      }
    ],
    "innerHTML": "\n\n",
    "innerContent": ["\n", null, "\n"]
  },
  "version": 2.1,
  "timestamp": "2026-02-22T05:30:00.000Z",
  "styles": {
    "etch-section-style": {
      "type": "element",
      "selector": ":where([data-etch-element=\"section\"])",
      "collection": "default",
      "css": "inline-size: 100%;\n  display: flex;\n  flex-direction: column;\n  align-items: center;",
      "readonly": true
    },
    "etch-container-style": {
      "type": "element",
      "selector": ":where([data-etch-element=\"container\"])",
      "collection": "default",
      "css": "inline-size: 100%;\n  display: flex;\n  flex-direction: column;\n  max-inline-size: var(--content-width, 1366px);\n  align-self: center; margin-inline: auto;",
      "readonly": true
    },
    "s1a2b3c": {
      "type": "class",
      "selector": ".saas-hero",
      "collection": "default",
      "css": "min-block-size: 100vh;\nbackground: linear-gradient(135deg, #0a0a23 0%, #1a1a4e 100%);\ncolor: #f0f0f0;\npadding: 6rem 2rem;\n\n.saas-hero__heading {\n  font-size: clamp(2.5rem, 6vw, 4.5rem);\n  font-weight: 800;\n  line-height: 1.1;\n  max-inline-size: 20ch;\n}\n\n.saas-hero__lede {\n  font-size: 1.25rem;\n  opacity: 0.8;\n  max-inline-size: 50ch;\n  margin-block-start: 1.5rem;\n}\n\n.saas-hero__btn {\n  display: inline-flex;\n  padding: 1rem 2.5rem;\n  background: #6366f1;\n  color: #fff;\n  border-radius: 0.5rem;\n  font-weight: 600;\n  text-decoration: none;\n  margin-block-start: 2rem;\n  &:hover {\n    background: #4f46e5;\n  }\n}",
      "readonly": false
    }
  }
}
```

## Pasting via Browser Console (Programmatic)

Since the paste handler reads from `navigator.clipboard`, you can inject JSON programmatically:

```javascript
const block = { /* v2.1 envelope */ };
await navigator.clipboard.writeText(JSON.stringify(block));
// Then Cmd+V in the builder with a block selected in the tree panel
```

Or use the builder's internal API directly (requires the builder to be loaded):

```javascript
// Access internal paste function via the builder's store
const block = { /* v2.1 envelope */ };
await navigator.clipboard.writeText(JSON.stringify(block));
// Focus the tree panel, then Cmd+V
```

## Pasting via REST API

The blocks can be pushed directly to a post's blocks via the Etch API:

```javascript
// In browser console with builder loaded (for auth):
const blocks = [/* array of gutenberg blocks (NOT envelopes) */];
const postId = 20;
await wp.apiFetch({
  path: `/etch-api/post/${postId}/blocks`,
  method: 'POST',
  data: blocks
});
```

**Note:** The REST API accepts raw block arrays, NOT the paste envelope format. `curl` with basic auth returns 401 — the API requires the builder's `X-WP-Nonce` header from an active session.

## Common Errors and Fixes

| Error | Cause | Fix |
|-------|-------|-----|
| `Paste failed: Unsupported legacy content structure` | `version` missing (defaults to 1) or `type` not `"block"` | Add `"version": 2.1` and `"type": "block"` |
| `TypeError: Cannot read properties of undefined (reading 'toLowerCase')` | `etch/element` block missing `attrs.tag` | Ensure every `etch/element` has `"tag": "div"` (or appropriate tag) in its `attrs` |
| `Error parsing HTML: No block could be created` | JSON pasted into the HTML panel instead of the tree panel | Paste with Cmd+V while the tree panel is focused, not the code editor |
| Paste silently ignored | Cursor is inside an editable text field or code editor | Click a block in the tree panel first, then Cmd+V |
| Styles not applied | Style IDs in block don't match keys in `styles` object | Ensure `attrs.styles` array entries match keys in the envelope's `styles` map |

## Conversion Script

A Node.js script at `layouts/convert-to-etch.mjs` converts flat block arrays + companion CSS files into paste-ready v2.1 JSON:

```bash
node layouts/convert-to-etch.mjs layouts/saas-product.json layouts/saas-product.css
```

Output goes to `layouts/etch/` directory:
- Individual section files: `layouts/etch/saas-product--saas-hero.json`
- Combined file: `layouts/etch/saas-product.json`

## Layout File Organization

```
layouts/
├── saas-product.json          # Source: flat block array (NOT paste-ready)
├── saas-product.css           # Companion CSS for parsing
├── agency-portfolio.json
├── agency-portfolio.css
├── magazine-blog.json
├── magazine-blog.css
├── convert-to-etch.mjs        # Conversion script
└── etch/                      # Output: paste-ready v2.1 envelopes
    ├── saas-product--saas-hero.json
    ├── saas-product--saas-stats.json
    ├── saas-product.json       # Combined (array of envelopes)
    ├── agency-portfolio--agency-hero.json
    └── ...
```

## Source Code References

The paste logic lives in `etch/apps/dist/builder/builder.js` (minified). Key functions:

| Minified Name | Purpose |
|---------------|---------|
| `pTt` | v2/2.1 paste handler — processes styles, loops, components, then inserts block |
| `eTt` | v1 legacy paste handler |
| `iTt` | Style import — maps paste style IDs to builder style IDs |
| `sTt` | Loop import — maps paste loop IDs to builder loop IDs |
| `oTt` | Component import — maps paste component IDs to builder component IDs |
| `rz` | Convert Gutenberg block JSON to internal builder block model |
| `J0e` | Custom blocks conversion (etch/* blocks → internal models) |
| `iae` | Apply style/loop/component ID remapping to a block tree |

The copy shortcut (`Cmd+C`) serializes a selected block into the same v2.1 envelope format, so copying an existing section and inspecting the clipboard content is the best way to verify format expectations.
