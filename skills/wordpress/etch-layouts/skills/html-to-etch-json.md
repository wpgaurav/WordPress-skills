# HTML to Etch JSON Conversion Skill

Convert HTML markup to Etch block JSON format for pasting into the Etch page builder.

## Output Formats

Etch supports three formats:

1. **Paste-Ready JSON (v2.1 Envelope)** — For Cmd+V pasting into the builder. See `etch-paste-format.md` for full schema.
2. **Block JSON** — Array of block objects (the `gutenbergBlock` tree inside the envelope)
3. **Template Syntax** — Svelte-inspired HTML for the builder's HTML panel

This skill covers conversion to **Block JSON** format. To make the output pasteable, wrap it in the v2.1 envelope (see `etch-paste-format.md`).

All output must be valid JSON.

## Block Structure

Every Etch block follows this structure:

```json
{
  "blockName": "etch/element",
  "attrs": { ... },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

### Required Fields

| Field | Type | Description |
|-------|------|-------------|
| `blockName` | string | Block type (e.g., `etch/element`, `etch/text`) |
| `attrs` | object | Block-specific attributes |
| `innerBlocks` | array | Child blocks |
| `innerHTML` | string | Newlines for blocks with children; empty for leaf/text blocks |
| `innerContent` | array | Alternating newline strings and `null` placeholders for children; empty for leaf/text blocks |

### innerHTML / innerContent Pattern

For blocks **with N children**, use newline separators with `null` child placeholders:
```json
"innerHTML": "\n\n\n\n",
"innerContent": ["\n", null, "\n\n", null, "\n"]
```

For **text blocks** and **leaf elements** (no children):
```json
"innerHTML": "",
"innerContent": []
```

See `etch-paste-format.md` for the `buildContent(n)` helper function.

## Block Types and Their Attributes

### etch/element

For any HTML element (div, section, article, header, nav, ul, li, a, img, etc.):

**CRITICAL:** The `tag` field is REQUIRED. Missing `tag` causes `TypeError: Cannot read properties of undefined (reading 'toLowerCase')` in the builder.

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "div",
    "attributes": {
      "class": "my-class",
      "id": "my-id",
      "data-custom": "value",
      "href": "/link",
      "src": "image.jpg",
      "alt": "Image alt"
    },
    "styles": [],
    "metadata": { "name": "Element" }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

**Tag Mapping:**
- `<div>`, `<section>`, `<article>`, `<header>`, `<footer>`, `<nav>`, `<main>`, `<aside>` → `"tag": "[element]"`
- `<a href="...">` → `"tag": "a"` with `"href"` in attributes
- `<img>` → `"tag": "img"` with `src`, `alt` in attributes
- `<ul>`, `<ol>`, `<li>` → corresponding tags
- `<button>` → `"tag": "button"`
- `<form>`, `<input>`, `<label>` → corresponding tags

### etch/text

For text content:

```json
{
  "blockName": "etch/text",
  "attrs": {
    "content": "Your text content here"
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

**Use etch/text for:**
- Plain text inside elements
- Headings content (wrap in etch/element with tag h1-h6)
- Paragraph content (wrap in etch/element with tag p)
- Span content
- Any inline text

### etch/raw-html

For complex HTML that cannot be easily converted:

```json
{
  "blockName": "etch/raw-html",
  "attrs": {
    "content": "<svg>...</svg>"
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

**Use for:** SVG code, iframes, embedded scripts, complex inline styles

### etch/dynamic-image

For `<img>` elements that should use WordPress media library features (srcset, responsive sizing):

```json
{
  "blockName": "etch/dynamic-image",
  "attrs": {
    "tag": "img",
    "attributes": {
      "mediaId": "{post.featuredImage.id}",
      "class": "responsive-image",
      "loading": "lazy",
      "maximumSize": "large",
      "alt": "{post.title}"
    }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

**Use instead of etch/element with tag "img" when:**
- Image comes from WordPress media library (has an attachment ID)
- You want automatic srcset/sizes generation
- You want responsive image handling

**Special attributes (not rendered as HTML):** `mediaId`, `useSrcSet`, `maximumSize`

### etch/svg

For SVG elements loaded from external URLs:

```json
{
  "blockName": "etch/svg",
  "attrs": {
    "tag": "svg",
    "attributes": {
      "src": "https://example.com/icon.svg",
      "class": "icon",
      "width": "24",
      "height": "24",
      "stripColors": "true"
    }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

**Use instead of etch/raw-html when:**
- SVG is loaded from a URL (not inline)
- You want to merge custom attributes onto the SVG
- You want color stripping for CSS-controlled colors

**Special attributes:** `src` (SVG URL), `stripColors` (remove fill/stroke)

### etch/dynamic-element

For elements where the HTML tag needs to be resolved dynamically:

```json
{
  "blockName": "etch/dynamic-element",
  "attrs": {
    "tag": "div",
    "attributes": {
      "tag": "{props.headingLevel}",
      "class": "dynamic-heading"
    }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

**Use instead of etch/element when:**
- The HTML tag name comes from dynamic data (e.g., h1-h6 based on props)
- Tag name needs to be determined at render time

## Conversion Rules

### 1. Structure Mapping

```html
<section class="hero">
  <div class="container">
    <h1>Welcome</h1>
    <p>Description text</p>
  </div>
</section>
```

Converts to:

```json
[
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "section",
      "attributes": { "class": "hero" }
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "div",
          "attributes": { "class": "container" }
        },
        "innerBlocks": [
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "h1",
              "attributes": {}
            },
            "innerBlocks": [
              {
                "blockName": "etch/text",
                "attrs": { "content": "Welcome" },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          },
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "p",
              "attributes": {}
            },
            "innerBlocks": [
              {
                "blockName": "etch/text",
                "attrs": { "content": "Description text" },
                "innerBlocks": [],
                "innerHTML": "",
                "innerContent": []
              }
            ],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "",
        "innerContent": []
      }
    ],
    "innerHTML": "",
    "innerContent": []
  }
]
```

### 2. Attribute Handling

- All HTML attributes go in `attrs.attributes` object
- Class names: `"class": "class1 class2"`
- IDs: `"id": "my-id"`
- Data attributes: `"data-*": "value"`
- ARIA attributes: `"aria-*": "value"`
- Link href: `"href": "/path"`
- Image src/alt: `"src": "url"`, `"alt": "text"`

### 3. Text Content Rules

- Pure text inside an element becomes `etch/text` block
- Multiple text nodes separated by elements: each becomes separate `etch/text`
- Whitespace-only text: skip or trim

### 4. Self-Closing Elements

For `<img>`, `<input>`, `<br>`, `<hr>`:

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "img",
    "attributes": {
      "src": "image.jpg",
      "alt": "Description"
    }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

### 5. Links

```html
<a href="/about" class="nav-link">About Us</a>
```

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "a",
    "attributes": {
      "href": "/about",
      "class": "nav-link"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/text",
      "attrs": { "content": "About Us" },
      "innerBlocks": [],
      "innerHTML": "",
      "innerContent": []
    }
  ],
  "innerHTML": "",
  "innerContent": []
}
```

### 6. Lists

```html
<ul class="menu">
  <li><a href="/">Home</a></li>
  <li><a href="/about">About</a></li>
</ul>
```

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "ul",
    "attributes": { "class": "menu" }
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": { "tag": "li", "attributes": {} },
      "innerBlocks": [
        {
          "blockName": "etch/element",
          "attrs": {
            "tag": "a",
            "attributes": { "href": "/" }
          },
          "innerBlocks": [
            {
              "blockName": "etch/text",
              "attrs": { "content": "Home" },
              "innerBlocks": [],
              "innerHTML": "",
              "innerContent": []
            }
          ],
          "innerHTML": "",
          "innerContent": []
        }
      ],
      "innerHTML": "",
      "innerContent": []
    },
    {
      "blockName": "etch/element",
      "attrs": { "tag": "li", "attributes": {} },
      "innerBlocks": [
        {
          "blockName": "etch/element",
          "attrs": {
            "tag": "a",
            "attributes": { "href": "/about" }
          },
          "innerBlocks": [
            {
              "blockName": "etch/text",
              "attrs": { "content": "About" },
              "innerBlocks": [],
              "innerHTML": "",
              "innerContent": []
            }
          ],
          "innerHTML": "",
          "innerContent": []
        }
      ],
      "innerHTML": "",
      "innerContent": []
    }
  ],
  "innerHTML": "",
  "innerContent": []
}
```

## Dynamic Data Placeholders

When converting HTML with placeholder text, use Etch's dynamic expression syntax:

| Placeholder Pattern | Etch Expression |
|---------------------|-----------------|
| `{{title}}` or `{title}` | `{this.title}` |
| `{{post.title}}` | `{this.title}` |
| `{{excerpt}}` | `{this.excerpt}` |
| `{{featured_image}}` | `{this.featuredImage.url}` |
| `{{author}}` | `{this.author.name}` |
| `{{date}}` | `{this.date}` |
| `{{permalink}}` | `{this.permalink}` |
| `{{site_name}}` | `{site.name}` |
| Custom field `{{meta.field}}` | `{this.meta.field}` |

### Example with Dynamic Data

```html
<article class="post-card">
  <img src="{{featured_image}}" alt="{{title}}">
  <h2>{{title}}</h2>
  <p>{{excerpt}}</p>
  <a href="{{permalink}}">Read More</a>
</article>
```

```json
[
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "article",
      "attributes": { "class": "post-card" }
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "img",
          "attributes": {
            "src": "{this.featuredImage.url}",
            "alt": "{this.title}"
          }
        },
        "innerBlocks": [],
        "innerHTML": "",
        "innerContent": []
      },
      {
        "blockName": "etch/element",
        "attrs": { "tag": "h2", "attributes": {} },
        "innerBlocks": [
          {
            "blockName": "etch/text",
            "attrs": { "content": "{this.title}" },
            "innerBlocks": [],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "",
        "innerContent": []
      },
      {
        "blockName": "etch/element",
        "attrs": { "tag": "p", "attributes": {} },
        "innerBlocks": [
          {
            "blockName": "etch/text",
            "attrs": { "content": "{this.excerpt}" },
            "innerBlocks": [],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "",
        "innerContent": []
      },
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "a",
          "attributes": { "href": "{this.permalink}" }
        },
        "innerBlocks": [
          {
            "blockName": "etch/text",
            "attrs": { "content": "Read More" },
            "innerBlocks": [],
            "innerHTML": "",
            "innerContent": []
          }
        ],
        "innerHTML": "",
        "innerContent": []
      }
    ],
    "innerHTML": "",
    "innerContent": []
  }
]
```

## Output Requirements

1. Output ONLY valid JSON - no markdown code blocks, no explanations
2. JSON must be an array (even for single blocks)
3. All strings must be properly escaped
4. Maintain proper nesting hierarchy
5. `etch/text` blocks: `innerBlocks: []`, `innerHTML: ""`, `innerContent: []`
6. Parent blocks with N children: use the `buildContent(N)` pattern for `innerHTML`/`innerContent`
7. Every `etch/element` MUST have `attrs.tag` — omitting it crashes the builder
8. Add `metadata.name` for sections (`"Section"`), containers (`"Container"`), and text blocks (`"Text"`)
9. Sections should use `data-etch-element: "section"` and `styles: ["etch-section-style"]`
10. Containers should use `data-etch-element: "container"` and `styles: ["etch-container-style"]`

## Making Output Paste-Ready

The block array from this conversion is NOT directly pasteable. To paste into the builder:

1. Wrap each top-level block in the v2.1 envelope (see `etch-paste-format.md`)
2. Add style definitions to the `styles` object
3. Copy the envelope JSON to clipboard
4. Focus the tree panel in the builder, then Cmd+V

Or use the conversion script:
```bash
node layouts/convert-to-etch.mjs my-layout.json my-layout.css
```
