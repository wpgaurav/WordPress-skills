# Etch Layout Quick Reference

Cheatsheet for generating Etch v2.1 paste-ready JSON.

---

## Minimal Section Template

```json
{
  "type": "block",
  "gutenbergBlock": {
    "blockName": "etch/element",
    "attrs": {
      "metadata": { "name": "SECTION_LABEL" },
      "tag": "section",
      "attributes": { "class": "SECTION_CLASS" },
      "styles": ["SECTION_STYLE_ID"]
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "metadata": { "name": "Container" },
          "tag": "div",
          "attributes": { "class": "SECTION_CLASS__inner" },
          "styles": ["CONTAINER_STYLE_ID"]
        },
        "innerBlocks": [ /* CONTENT HERE */ ],
        "innerHTML": "COMPUTE_FROM_CHILDREN",
        "innerContent": "COMPUTE_FROM_CHILDREN"
      }
    ],
    "innerHTML": "\n\n",
    "innerContent": ["\n", null, "\n"]
  },
  "version": 2.1,
  "timestamp": "CURRENT_ISO_TIMESTAMP",
  "styles": {
    "SECTION_STYLE_ID": {
      "type": "class",
      "selector": ".SECTION_CLASS",
      "collection": "default",
      "css": "padding: var(--space-2xl) 0;\nbackground: var(--bg-base);\n\n@media (max-width: to-rem(768px)) {\n    padding: var(--space-xl) 0;\n}",
      "readonly": false
    },
    "CONTAINER_STYLE_ID": {
      "type": "class",
      "selector": ".SECTION_CLASS__inner",
      "collection": "default",
      "css": "width: 100%;\nmax-width: var(--max-width);\nmargin: 0 auto;\npadding: 0 var(--space-m);\n\n@media (max-width: to-rem(768px)) {\n    padding: 0 var(--space-s);\n}",
      "readonly": false
    }
  }
}
```

---

## Common Block Patterns

### Heading with Text

```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "Title" },
    "tag": "h2",
    "attributes": { "class": "sec__title" },
    "styles": ["sec-title"]
  },
  "innerBlocks": [
    {
      "blockName": "etch/text",
      "attrs": { "metadata": { "name": "Text" }, "content": "My Heading" },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

### Paragraph

```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "Description" },
    "tag": "p",
    "attributes": { "class": "sec__desc" },
    "styles": ["sec-desc"]
  },
  "innerBlocks": [
    {
      "blockName": "etch/text",
      "attrs": { "metadata": { "name": "Text" }, "content": "Paragraph text here." },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

### Link / Button

```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "CTA Button" },
    "tag": "a",
    "attributes": { "class": "sec__btn", "href": "/get-started/" },
    "styles": ["sec-btn"]
  },
  "innerBlocks": [
    {
      "blockName": "etch/text",
      "attrs": { "metadata": { "name": "Text" }, "content": "Get Started" },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

### Image (void element)

```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "Image" },
    "tag": "img",
    "attributes": { "class": "sec__img", "src": "/path/to/image.jpg", "alt": "Description", "width": "600", "height": "400" },
    "styles": ["sec-img"]
  },
  "innerBlocks": [],
  "innerHTML": "\n\n",
  "innerContent": ["\n", "\n"]
}
```

### Figure with Image

```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "Figure" },
    "tag": "figure",
    "attributes": { "class": "sec__figure" },
    "styles": ["sec-figure"]
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "metadata": { "name": "Image" },
        "tag": "img",
        "attributes": { "src": "{post.featuredImage.url}", "alt": "{post.featuredImage.alt}", "width": "600", "height": "250" },
        "styles": ["sec-figure-img"]
      },
      "innerBlocks": [],
      "innerHTML": "\n\n",
      "innerContent": ["\n", "\n"]
    }
  ],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

### Wrapper Div (N children)

```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "Grid" },
    "tag": "div",
    "attributes": { "class": "sec__grid" },
    "styles": ["sec-grid"]
  },
  "innerBlocks": [ /* child1, child2, child3 */ ],
  "innerHTML": "\n\n\n\n\n\n",
  "innerContent": ["\n", null, "\n\n", null, "\n\n", null, "\n"]
}
```

### Badge / Label

```json
{
  "blockName": "etch/element",
  "attrs": {
    "metadata": { "name": "Label" },
    "tag": "span",
    "attributes": { "class": "sec__label" },
    "styles": ["sec-label"]
  },
  "innerBlocks": [
    {
      "blockName": "etch/text",
      "attrs": { "metadata": { "name": "Text" }, "content": "New Release" },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

### Loop (recent posts)

```json
{
  "blockName": "etch/loop",
  "attrs": {
    "target": "recent-posts",
    "itemId": "post",
    "loopParams": { "$count": 6 }
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "metadata": { "name": "Card" },
        "tag": "article",
        "attributes": { "class": "card" },
        "styles": ["card-style"]
      },
      "innerBlocks": [ /* card content referencing {post.title}, {post.permalink.relative}, etc. */ ],
      "innerHTML": "COMPUTE_FROM_CHILDREN",
      "innerContent": "COMPUTE_FROM_CHILDREN"
    }
  ],
  "innerHTML": "\n\n",
  "innerContent": ["\n", null, "\n"]
}
```

---

## innerHTML/innerContent Lookup Table

| N children | innerHTML | innerContent |
|------------|-----------|--------------|
| text block | `""` | `[]` |
| void (img) | `"\n\n"` | `["\n", "\n"]` |
| 0 (non-void) | `""` | `[]` |
| 1 | `"\n\n"` | `["\n", null, "\n"]` |
| 2 | `"\n\n\n\n"` | `["\n", null, "\n\n", null, "\n"]` |
| 3 | `"\n\n\n\n\n\n"` | `["\n", null, "\n\n", null, "\n\n", null, "\n"]` |
| 4 | `"\n\n\n\n\n\n\n\n"` | `["\n", null, "\n\n", null, "\n\n", null, "\n\n", null, "\n"]` |
| 5 | 10 newlines | `["\n", null, "\n\n", null, "\n\n", null, "\n\n", null, "\n\n", null, "\n"]` |

**Pattern**: Start `"\n"`, then for each child: `null`, then `"\n\n"` (or `"\n"` for last child).

---

## CSS Pattern Examples

### Section Background with Padding

```scss
padding: var(--space-2xl) 0;
background: var(--bg-subtle);

@media (max-width: to-rem(768px)) {
    padding: var(--space-xl) 0;
}
```

### Container (max-width + centered)

```scss
width: 100%;
max-width: var(--max-width);
margin: 0 auto;
padding: 0 var(--space-m);

@media (max-width: to-rem(768px)) {
    padding: 0 var(--space-s);
}
```

### Card with Hover

```scss
display: flex;
flex-direction: column;
background: var(--bg-elevated);
border: to-rem(1px) solid var(--border-default);
border-radius: var(--radius-m);
overflow: hidden;
text-decoration: none;
transition: all var(--duration-normal) var(--ease-out);

&:hover {
    transform: translateY(to-rem(-6px));
    box-shadow: var(--shadow-l);
    border-color: var(--accent);
}

&:hover .card__title {
    color: var(--accent);
}
```

### Responsive Grid

```scss
display: grid;
grid-template-columns: repeat(3, 1fr);
gap: var(--space-s);

@media (max-width: to-rem(992px)) {
    grid-template-columns: repeat(2, 1fr);
}

@media (max-width: to-rem(600px)) {
    grid-template-columns: 1fr;
}
```

### Label / Badge

```scss
display: inline-flex;
align-items: center;
gap: var(--space-xs);
font-size: var(--fs-xs);
font-weight: var(--fw-bold);
letter-spacing: 0.1em;
text-transform: uppercase;
color: var(--accent);
margin-bottom: var(--space-xs);

&::before {
    content: "";
    width: to-rem(6px);
    height: to-rem(6px);
    background: var(--accent);
    border-radius: 50%;
}
```

### Primary Button

```scss
display: inline-flex;
align-items: center;
justify-content: center;
gap: var(--space-2xs);
padding: var(--space-s) var(--space-l);
font-size: var(--fs-base);
font-weight: var(--fw-semibold);
color: var(--text-inverse);
background: var(--accent);
border: none;
border-radius: var(--radius-m);
text-decoration: none;
transition: transform var(--duration-fast) var(--ease-out),
            box-shadow var(--duration-fast) var(--ease-out),
            background var(--duration-fast) var(--ease-out);

&:hover {
    background: var(--accent-hover);
    transform: translateY(to-rem(-2px));
    box-shadow: var(--shadow-m);
}

@media (max-width: to-rem(480px)) {
    width: 100%;
}
```

### Heading (responsive clamp)

```scss
font-size: clamp(to-rem(28px), 4vw, to-rem(40px));
font-weight: var(--fw-black);
letter-spacing: -0.03em;
line-height: var(--lh-tight);
color: var(--text-primary);
margin: 0 0 var(--space-xs) 0;
```

### Sticky Sidebar

```scss
position: sticky;
top: calc(to-rem(64px) + var(--space-s));

@media (max-width: to-rem(1024px)) {
    position: static;
}
```

---

## Naming Conventions

- **Section class**: short lowercase BEM block (e.g., `hero`, `faq`, `pricing`, `features`)
- **BEM children**: `section__element` (e.g., `hero__title`, `hero__btn`)
- **BEM modifiers**: `section__element--modifier` (e.g., `hero__btn--primary`)
- **Container**: `section__inner` or `section__container`
- **Style IDs**: random 7-char alphanumeric or descriptive kebab-case (e.g., `hero-btn`)
- **Metadata names**: Human-readable labels (e.g., `"Title"`, `"Container"`, `"Primary CTA"`)
- **Every element**: MUST have `class`, `metadata.name`, and `styles` with own ID(s)
