# Generating Etch Layouts from AI

Complete reference for producing paste-ready Etch v2.1 JSON that can be Cmd+V pasted directly into the Etch builder.

---

## Output Format: v2.1 Envelope

Every pasteable section is a single JSON object:

```json
{
  "type": "block",
  "gutenbergBlock": { /* block tree */ },
  "version": 2.1,
  "timestamp": "2026-02-25T06:09:49.791Z",
  "styles": { /* style ID → definition map */ }
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `type` | `"block"` | Yes | Always `"block"` for sections |
| `gutenbergBlock` | object | Yes | Fully-formed block tree with innerHTML/innerContent |
| `version` | `2.1` | Yes | Must be exactly `2.1` (routes to modern paste handler) |
| `timestamp` | ISO 8601 | Yes | `new Date().toISOString()` |
| `styles` | object | Yes | Map of style IDs to style definitions |

**Multiple sections**: Output an array of envelopes (`[{...}, {...}]`).

---

## Block Structure: The Five Required Fields

Every block in the tree MUST have exactly these five fields:

```json
{
  "blockName": "etch/element",
  "attrs": {},
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

### innerHTML / innerContent Rules

**Text blocks (`etch/text`) — always empty:**
```json
"innerHTML": "",
"innerContent": []
```

**Non-void elements with 0 children:**
```json
"innerHTML": "",
"innerContent": []
```

**Void elements (`img`, `br`, `hr`, `input`) with 0 innerBlocks:**
```json
"innerHTML": "\n\n",
"innerContent": ["\n", "\n"]
```

**Elements with N children** follow this formula:

| Children | innerHTML | innerContent |
|----------|-----------|--------------|
| 1 | `"\n\n"` | `["\n", null, "\n"]` |
| 2 | `"\n\n\n\n"` | `["\n", null, "\n\n", null, "\n"]` |
| 3 | `"\n\n\n\n\n\n"` | `["\n", null, "\n\n", null, "\n\n", null, "\n"]` |
| N | (N-1 `\n\n` + 2 `\n`) | `["\n", null, "\n\n", ..., null, "\n"]` |

Algorithm:
```
Start with ["\n"]
For each child i (0 to N-1):
  push null
  push (i < N-1) ? "\n\n" : "\n"
innerHTML = join all non-null parts
```

---

## Block Types and Attributes

### etch/element

The workhorse block. Wraps any HTML element.

```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "Card Title" },
    "tag": "h3",
    "attributes": {
      "class": "card__title"
    },
    "styles": ["a7b3c9d"]
  },
  "innerBlocks": [...],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `tag` | string | **Yes** | HTML tag. Missing = crash (`TypeError: toLowerCase of undefined`) |
| `attributes` | object | **Yes** | HTML attributes. **Always include `class`** |
| `styles` | array | **Yes** | Style IDs referencing top-level `styles` map |
| `metadata` | object | **Yes** | `{ "name": "..." }` label shown in builder tree |

**Mandatory element rules:**
- **Every element MUST have a `class` attribute** for CSS targeting
- **Every element MUST have a `metadata.name`** for builder tree readability
- **Every element MUST have its own style ID(s)** with matching entries in the top-level `styles` map
- URL attributes (`href`, `src`, `poster`, `action`) are sanitized at render time

**Renders to:**
```html
<h3 class="card__title">inner blocks</h3>
```

### etch/text

Pure text content. No wrapping element.

```json
{
  "blockName": "etch/text",
  "attrs": {
    "metadata": { "name": "Text" },
    "content": "Hello, world!"
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `content` | string | Yes | Text content. Supports `{expression}` syntax for dynamic data |
| `metadata` | object | Yes | Builder label. Typically `{ "name": "Text" }` |

**Rules:**
- Never has `tag` or `styles`
- Always `innerHTML: ""`, `innerContent: []`
- Always a leaf (no `innerBlocks`)

**Dynamic examples:**
```json
"content": "{this.title}"
"content": "{post.date.dateFormat(\"M j, Y\")}"
"content": "{post.excerpt | stripTags | truncate:120}"
"content": "{site.name}"
```

### etch/loop

Iterates over a data source, rendering inner blocks for each item.

```json
{
  "blockName": "etch/loop",
  "attrs": {
    "target": "recent-posts",
    "itemId": "post",
    "loopParams": {
      "$count": 6
    }
  },
  "innerBlocks": [ /* template blocks rendered per item */ ],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

| Field | Required | Notes |
|-------|----------|-------|
| `target` | Yes (if no loopId) | Preset name (e.g., `"recent-posts"`) or expression path |
| `itemId` | No | Context key for current item (default: `"item"`). Use `"post"` for post loops |
| `indexId` | No | Context key for current index (0-based) |
| `loopId` | No | References a saved loop preset |
| `loopParams` | No | Parameters. `{"$count": N}` limits results |

**Target values:**
- Preset name: `"recent-posts"` (NOT wrapped in `{}`)
- Expression: `"{this.related_posts}"` (wrapped in `{}` for dynamic resolution)
- JSON array: `[{"name":"Item 1"},{"name":"Item 2"}]`

**Inner block expressions** reference items via the `itemId`:
```json
"{post.title}"
"{post.permalink.relative}"
"{post.featuredImage.url}"
"{post.featuredImage.alt}"
"{post.date}"
"{post.date.dateFormat(\"M j, Y\")}"
"{post.excerpt | stripTags | truncate:100}"
```

### etch/condition

Conditional rendering.

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "===",
      "leftHand": "{this.status}",
      "rightHand": "\"published\""
    }
  },
  "innerBlocks": [ /* rendered only if condition is true */ ],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

Operators: `==`, `===`, `!=`, `!==`, `>`, `<`, `>=`, `<=`, `&&`, `||`, `isTruthy`, `isFalsy`

Conditions can nest (leftHand/rightHand can be condition objects).

### etch/component

References a reusable pattern (wp_block post).

```json
{
  "blockName": "etch/component",
  "attrs": {
    "ref": 26,
    "attributes": { "title": "My Title", "count": "5" }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

### Other Blocks

| Block | Purpose | Key attrs |
|-------|---------|-----------|
| `etch/svg` | SVG rendering | `content` (SVG markup) |
| `etch/raw-html` | Unprocessed HTML | `content` (raw HTML) |
| `etch/dynamic-element` | Dynamic tag resolution | `tag` (expression) |
| `etch/dynamic-image` | Dynamic images | Image source expression |
| `etch/slot-content` | Named slot content | `name` |
| `etch/slot-placeholder` | Slot insertion point | `name` |

---

## Styles Object

The top-level `styles` map provides CSS for the builder and frontend renderer. **Every element gets its own style entry** — no shared or built-in styles.

### Style Definition

```json
{
  "a7b3c9d": {
    "type": "class",
    "selector": ".card__title",
    "collection": "default",
    "css": "font-size: var(--fs-m);\nfont-weight: var(--fw-bold);\nline-height: var(--lh-snug);\ncolor: var(--text-primary);\nmargin: 0 0 var(--space-xs) 0;\ntransition: color var(--duration-fast) var(--ease-out);",
    "readonly": false
  }
}
```

| Field | Type | Values |
|-------|------|--------|
| `type` | string | `"class"` for `.classname`, `"id"` for `#id`, `"element"` for tag selectors |
| `selector` | string | CSS selector matching the type (`.my-class`, `#my-id`) |
| `collection` | string | Always `"default"` |
| `css` | string | SCSS-like syntax with `to-rem()` and design system variables |
| `readonly` | boolean | Always `false` for custom styles |

### Style Types

| Type | Selector Example | Use Case |
|------|-----------------|----------|
| `"class"` | `.blog-posts-home` | Primary styling (most common) |
| `"id"` | `#posts` | ID-based styling (for anchor targets, usually empty css) |
| `"element"` | `section` | Tag-level styles (rare) |

**Multiple styles per element**: When an element has both a class and an ID:
```json
"styles": ["classStyleId", "idStyleId"]
```

### CSS Syntax Rules

The `css` field uses **SCSS-like syntax**:

**1. `to-rem()` for ALL pixel values** — never raw px:
```scss
border: to-rem(1px) solid var(--border-default);
border-radius: var(--radius-m);
transform: translateY(to-rem(-6px));
width: to-rem(6px);
height: to-rem(6px);
top: calc(to-rem(64px) + var(--space-s));
```

**2. Design system CSS variables** — never hardcoded colors/sizes/spacing:
```scss
background: var(--bg-elevated);
color: var(--text-primary);
padding: var(--space-s);
font-size: var(--fs-m);
font-weight: var(--fw-bold);
gap: var(--space-xs);
border-radius: var(--radius-m);
box-shadow: var(--shadow-l);
transition: all var(--duration-normal) var(--ease-out);
```

**3. `&` for pseudo-classes and pseudo-elements:**
```scss
&:hover {
    transform: translateY(to-rem(-6px));
    box-shadow: var(--shadow-l);
    border-color: var(--accent);
}

&::before {
    content: "";
    width: to-rem(6px);
    height: to-rem(6px);
    background: var(--accent);
    border-radius: 50%;
}

&:last-child {
    border-bottom: none;
}
```

**4. Nested child selectors** (from parent context):
```scss
&:hover .card__title {
    color: var(--accent);
}

img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.4s ease;
}

a {
    color: var(--accent);
    text-decoration: underline;
    text-underline-offset: to-rem(3px);

    &:hover {
        text-decoration: none;
    }
}
```

**5. Nested media queries:**
```scss
@media (max-width: to-rem(768px)) {
    padding: 0 var(--space-s);
    grid-template-columns: 1fr;
}

@media (max-width: to-rem(1024px)) {
    grid-template-columns: 1fr;
}
```

**6. `clamp()` with `to-rem()`:**
```scss
font-size: clamp(to-rem(28px), 4vw, to-rem(40px));
```

### Design System CSS Variables

**Colors:**
| Variable | Purpose |
|----------|---------|
| `--bg-base` | Default page background |
| `--bg-subtle` | Slightly tinted background |
| `--bg-elevated` | Card/raised surface |
| `--bg-sunken` | Recessed background |
| `--bg-overlay-heavy` | Heavy backdrop overlay |
| `--text-primary` | Main text |
| `--text-secondary` | Supporting text |
| `--text-muted` | De-emphasized text |
| `--text-inverse` | Text on dark/accent backgrounds |
| `--accent` | Primary brand color |
| `--accent-hover` | Accent hover state |
| `--border-light` | Subtle border |
| `--border-default` | Standard border |
| `--border-medium` | Prominent border |

**Typography:**
| Variable | Purpose |
|----------|---------|
| `--font-sans`, `--font-mono` | Font families |
| `--fs-xs` to `--fs-4xl` | Font sizes (xs, s, base, m, l, xl, 2xl, 3xl, 4xl) |
| `--fw-normal` to `--fw-black` | Font weights (normal, medium, semibold, bold, black) |
| `--lh-tight`, `--lh-snug`, `--lh-normal`, `--lh-relaxed` | Line heights |
| `--ls-tight`, `--ls-wider` | Letter spacing |

**Spacing:** `--space-3xs` through `--space-3xl` (3xs, 2xs, xs, s, m, l, xl, 2xl, 3xl)

**Layout:** `--max-width`, `--content-width`, `--header-height`, `--header-height-mobile`

**Effects:**
| Variable | Purpose |
|----------|---------|
| `--radius-xs` to `--radius-full` | Border radii (xs, s, m, l, full) |
| `--shadow-xs` to `--shadow-xl` | Box shadows (xs, s, m, l, xl) |
| `--duration-fast`, `--duration-normal` | Transition durations |
| `--ease-out`, `--ease-in-out` | Easing functions |

**Z-Index:** `--z-header`, `--z-modal`, `--z-tooltip`

### Style ID Generation

Use a random 7-character alphanumeric string:
```javascript
const genId = () => Math.random().toString(36).slice(2, 9);
```

Or use descriptive kebab-case IDs (e.g., `faq-title`, `hero-btn`).

---

## Section Anatomy Pattern

Every section follows this structure:

```
section.section-name (styles: [sectionStyleId])
  └── div.section-name__inner (styles: [containerStyleId])
       ├── header.section-name__header (styles: [headerStyleId])
       │    ├── span.section-name__label (styles: [labelStyleId])
       │    │    └── etch/text
       │    ├── h2.section-name__title (styles: [titleStyleId])
       │    │    └── etch/text
       │    └── p.section-name__subtitle (styles: [subtitleStyleId])
       │         └── etch/text
       └── div.section-name__grid (styles: [gridStyleId])
            └── ... content blocks (each with own class + style)
```

The section is the full-width wrapper. The inner container constrains to `--max-width` and handles horizontal padding.

**Container style pattern:**
```scss
width: 100%;
max-width: var(--max-width);
margin: 0 auto;
padding: 0 var(--space-m);

@media (max-width: to-rem(768px)) {
    padding: 0 var(--space-s);
}
```

**Section style pattern:**
```scss
padding: var(--space-2xl) 0;
background: var(--bg-base);

@media (max-width: to-rem(768px)) {
    padding: var(--space-xl) 0;
}
```

---

## Complete Example: FAQ Section

```json
{
  "type": "block",
  "gutenbergBlock": {
    "blockName": "etch/element",
    "attrs": {
      "metadata": { "name": "FAQ Section" },
      "tag": "section",
      "attributes": {
        "class": "faq",
        "id": "faq"
      },
      "styles": ["faq-sect", "faq-id"]
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "metadata": { "name": "Container" },
          "tag": "div",
          "attributes": { "class": "faq__inner" },
          "styles": ["faq-inner"]
        },
        "innerBlocks": [
          {
            "blockName": "etch/element",
            "attrs": {
              "metadata": { "name": "Title" },
              "tag": "h2",
              "attributes": { "class": "faq__title" },
              "styles": ["faq-title"]
            },
            "innerBlocks": [
              {
                "blockName": "etch/text",
                "attrs": { "metadata": { "name": "Text" }, "content": "Frequently Asked Questions" },
                "innerBlocks": [], "innerHTML": "", "innerContent": []
              }
            ],
            "innerHTML": "\n\n",
            "innerContent": ["\n", null, "\n"]
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "metadata": { "name": "List" },
              "tag": "dl",
              "attributes": { "class": "faq__list" },
              "styles": ["faq-list"]
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": {
                  "metadata": { "name": "Question" },
                  "tag": "dt",
                  "attributes": { "class": "faq__question" },
                  "styles": ["faq-q"]
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/text",
                    "attrs": { "metadata": { "name": "Text" }, "content": "Is there a free tier?" },
                    "innerBlocks": [], "innerHTML": "", "innerContent": []
                  }
                ],
                "innerHTML": "\n\n",
                "innerContent": ["\n", null, "\n"]
              },
              {
                "blockName": "etch/element",
                "attrs": {
                  "metadata": { "name": "Answer" },
                  "tag": "dd",
                  "attributes": { "class": "faq__answer" },
                  "styles": ["faq-a"]
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/text",
                    "attrs": { "metadata": { "name": "Text" }, "content": "Yes, 10,000 tokens per month at no cost." },
                    "innerBlocks": [], "innerHTML": "", "innerContent": []
                  }
                ],
                "innerHTML": "\n\n",
                "innerContent": ["\n", null, "\n"]
              }
            ],
            "innerHTML": "\n\n\n\n",
            "innerContent": ["\n", null, "\n\n", null, "\n"]
          }
        ],
        "innerHTML": "\n\n\n\n",
        "innerContent": ["\n", null, "\n\n", null, "\n"]
      }
    ],
    "innerHTML": "\n\n",
    "innerContent": ["\n", null, "\n"]
  },
  "version": 2.1,
  "timestamp": "2026-02-25T00:00:00.000Z",
  "styles": {
    "faq-sect": {
      "type": "class",
      "selector": ".faq",
      "collection": "default",
      "css": "padding: var(--space-2xl) 0;\nbackground: var(--bg-base);\n\n@media (max-width: to-rem(768px)) {\n    padding: var(--space-xl) 0;\n}",
      "readonly": false
    },
    "faq-id": {
      "type": "id",
      "selector": "#faq",
      "collection": "default",
      "css": "",
      "readonly": false
    },
    "faq-inner": {
      "type": "class",
      "selector": ".faq__inner",
      "collection": "default",
      "css": "width: 100%;\nmax-width: var(--max-width);\nmargin: 0 auto;\npadding: 0 var(--space-m);\n\n@media (max-width: to-rem(768px)) {\n    padding: 0 var(--space-s);\n}",
      "readonly": false
    },
    "faq-title": {
      "type": "class",
      "selector": ".faq__title",
      "collection": "default",
      "css": "font-size: clamp(to-rem(28px), 4vw, to-rem(40px));\nfont-weight: var(--fw-bold);\ncolor: var(--text-primary);\ntext-align: center;\nmargin: 0 0 var(--space-l) 0;",
      "readonly": false
    },
    "faq-list": {
      "type": "class",
      "selector": ".faq__list",
      "collection": "default",
      "css": "display: flex;\nflex-direction: column;\nmax-width: to-rem(780px);\nmargin: 0 auto;",
      "readonly": false
    },
    "faq-q": {
      "type": "class",
      "selector": ".faq__question",
      "collection": "default",
      "css": "font-weight: var(--fw-semibold);\ncolor: var(--text-primary);\npadding: var(--space-s) 0;\nborder-top: to-rem(1px) solid var(--border-light);",
      "readonly": false
    },
    "faq-a": {
      "type": "class",
      "selector": ".faq__answer",
      "collection": "default",
      "css": "font-size: var(--fs-s);\nline-height: var(--lh-relaxed);\ncolor: var(--text-secondary);\npadding-bottom: var(--space-s);\nmargin: 0;",
      "readonly": false
    }
  }
}
```

---

## Gotchas and Hard Rules

1. **Missing `tag` crashes the builder** — Every `etch/element` MUST have `attrs.tag`
2. **Every element MUST have a `class`** — For CSS targeting and styling flexibility
3. **Every element MUST have `metadata.name`** — For builder tree readability
4. **Every element MUST have its own style ID(s)** — With corresponding entries in `styles`
5. **`etch/text` never has `tag` or `styles`** — Text blocks output raw text only
6. **innerHTML/innerContent are mandatory** — Every block needs both fields
7. **Style IDs must match** — IDs in `attrs.styles` must exist in top-level `styles`
8. **Version must be `2.1`** — Routes to modern paste handler
9. **CSS uses `to-rem()`** — NEVER raw pixel values. Write `to-rem(1px)` not `1px`
10. **CSS uses design system variables** — NEVER hardcoded colors, spacing, or sizes
11. **No `data-etch-element`** — That attribute is only from the legacy conversion script, NOT Etch-native
12. **No built-in styles** — No `etch-section-style` or `etch-container-style`. Every element defines its own styles
13. **Void elements** (`img`, `br`, `hr`, `input`) with 0 innerBlocks use `innerHTML: "\n\n"`, `innerContent: ["\n", "\n"]`
14. **BEM naming** — Section class as block, children as `block__element`, modifiers as `block__element--modifier`
15. **Style IDs** — Random 7-char alphanumeric or descriptive kebab-case

---

## Workflow: Always Generate Paste-Ready JSON (Option A)

Always generate the full v2.1 envelope JSON directly. User copies and Cmd+V pastes into Etch.

Output files to `gt-design-system/layouts/{section-name}/`:
- `{section-name}-etch.json` — Paste-ready JSON (v2.1 envelope)
- `{section-name}-preview.html` — Browser preview with compiled CSS inline

The source JSON + CSS conversion pipeline (`convert-to-etch.mjs`) exists for bulk legacy conversion but is NOT the preferred workflow.
