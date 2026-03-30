# Bricks Builder Layouts Skill

Create ready-to-paste sections and importable templates for Bricks Builder.

## Styling Priority

When styling elements, follow this order of preference:

1. **Core Framework Classes** (`core-framework.css`) - Use existing utility classes first
2. **Inline Settings** - Use element `settings` for element-specific styling
3. **Custom CSS** - Only for complex/unique styles not covered by framework

The Core Framework provides a comprehensive utility-first CSS library. Always prefer these classes over creating new global classes or inline styles.

## Two Layout Formats

Bricks uses two distinct JSON formats:

### 1. Sections (Copy/Paste Format)

For pasting directly into the builder via clipboard. Used for hero sections, feature blocks, CTAs, etc.

```json
{
  "content": [...elements...],
  "source": "bricksCopiedElements",
  "sourceUrl": "https://example.com",
  "version": "2.0.1",
  "globalClasses": [...class definitions...],
  "globalElements": []
}
```

### 2. Templates (Site-Wide Assignment)

Full templates with metadata for importing via Bricks Templates system.

```json
{
  "id": 1195,
  "name": "header-new",
  "title": "Header New",
  "date": "2025-07-24 14:09:56",
  "date_formatted": "July 24, 2025",
  "author": {
    "name": "Author Name",
    "avatar": "https://...",
    "url": "https://..."
  },
  "permalink": "https://example.com/template/header-new/",
  "thumbnail": null,
  "bundles": [],
  "tags": [],
  "type": "header",
  "header": [...elements...],
  "templateType": "header",
  "global_classes": [...class definitions...],
  "globalVariables": [...variables...],
  "globalVariablesCategories": [...]
}
```

---

## Section Structure (Copy/Paste)

### Required Keys

| Key | Type | Description |
|-----|------|-------------|
| `content` | array | Root array of all elements |
| `source` | string | Must be `"bricksCopiedElements"` |
| `sourceUrl` | string | Origin URL for reference |
| `version` | string | Bricks version (e.g., `"2.0.1"`) |
| `globalClasses` | array | CSS class definitions used |
| `globalElements` | array | Global elements (usually empty) |

### Element Structure

Each element in `content` array:

```json
{
  "id": "enrntt",
  "name": "section",
  "parent": 0,
  "children": ["azdlaa"],
  "settings": {
    "_cssGlobalClasses": ["classId1", "classId2"]
  },
  "label": "Hero"
}
```

| Property | Description |
|----------|-------------|
| `id` | Unique 6-character alphanumeric ID |
| `name` | Element type (section, container, block, heading, etc.) |
| `parent` | Parent element ID or `0` for root |
| `children` | Array of child element IDs |
| `settings` | Element-specific settings |
| `label` | Display name in structure panel |
| `themeStyles` | Optional array of theme style references |

---

## Element Types Reference

### Layout Elements

| Name | Purpose | Key Settings |
|------|---------|--------------|
| `section` | Full-width section wrapper | `tag`, `_padding` |
| `container` | Content container with max-width | `_width`, `_widthMax`, `_direction` |
| `block` | Flexbox div element | `tag`, `_display`, `_direction`, `_flexWrap` |
| `div` | Basic div element | `tag` |

### Content Elements

| Name | Purpose | Key Settings |
|------|---------|--------------|
| `heading` | H1-H6 heading | `text`, `tag` |
| `text-basic` | Paragraph text | `text`, `tag` |
| `text` | Rich text with HTML | `text` (HTML content) |
| `button` | Button element | `text`, `style`, `link`, `icon`, `iconPosition` |
| `image` | Image element | `image`, `_aspectRatio`, `_objectFit` |
| `logo` | Site logo | `logo`, `logoWidth`, `logoHeight` |
| `icon` | SVG icon | `icon`, `iconSize` |

### Navigation Elements

| Name | Purpose | Key Settings |
|------|---------|--------------|
| `nav-nested` | Nested navigation menu | `mobileMenu` |
| `dropdown` | Dropdown menu item | `text`, `toggleOn`, `megaMenu` |
| `text-link` | Navigation link | `text`, `link` |
| `toggle` | Mobile menu toggle | `icon`, `animation`, `toggleSelector` |

### Interactive Elements

| Name | Purpose | Key Settings |
|------|---------|--------------|
| `slider-nested` | Carousel/slider | `perPage`, `gap`, `autoplay`, `pagination` |
| `accordion` | Collapsible content | `titleTypography`, `contentTypography` |
| `icon-box` | Icon with text | `icon`, `iconSize`, `typographyHeading`, `typographyBody` |
| `form` | Contact form | Field and submit button settings |
| `list` | Styled list | `separatorDisable`, `itemMargin` |

### Utility Elements

| Name | Purpose | Key Settings |
|------|---------|--------------|
| `code` | Custom CSS/JS | `cssCode`, `javascriptCode`, `executeCode` |

---

## Element Settings by Type

### Heading

```json
{
  "text": "Welcome to Our Site",
  "tag": "h1",
  "_cssGlobalClasses": ["heading-1"],
  "_typography": {
    "font-family": "Inter",
    "font-size": "var(--text-3xl)",
    "font-weight": "700",
    "color": {"raw": "var(--color-secondary)"},
    "text-align": "center"
  }
}
```

### Text (Rich Text)

```json
{
  "text": "<p>Paragraph with <strong>bold</strong> and <em>italic</em> text.</p>",
  "_cssGlobalClasses": ["body-text"],
  "_typography": {
    "font-size": "var(--text-sm)",
    "color": {"raw": "var(--color-tertiary)"}
  }
}
```

### Button

```json
{
  "text": "Get Started",
  "style": "primary",
  "link": {"type": "external", "url": "#"},
  "icon": {"library": "fontawesomeSolid", "icon": "fas fa-arrow-right"},
  "iconPosition": "right",
  "_cssGlobalClasses": ["btn", "btn--primary"]
}
```

Button styles: `primary`, `secondary`, `info`, `success`, `warning`, `danger`, `light`, `dark`

### Image

```json
{
  "image": {
    "url": "https://example.com/image.jpg",
    "external": true,
    "filename": "image.jpg"
  },
  "_aspectRatio": "16 / 9",
  "_objectFit": "cover",
  "_objectPosition": "50%",
  "_border": {
    "radius": {"top": "var(--radius-m)", "right": "var(--radius-m)", "bottom": "var(--radius-m)", "left": "var(--radius-m)"}
  }
}
```

For internal images (from media library):
```json
{
  "image": {
    "id": 123,
    "filename": "image.jpg",
    "size": "large",
    "full": "https://example.com/wp-content/uploads/image.jpg",
    "url": "https://example.com/wp-content/uploads/image-1024x768.jpg"
  }
}
```

### Logo

```json
{
  "logo": {
    "url": "https://example.com/logo.svg",
    "external": true,
    "filename": "logo.svg"
  },
  "logoWidth": "clamp(16.0rem, 14.7763rem + 3.8241vw, 20.0rem)",
  "logoHeight": "auto"
}
```

### Nav Nested (Navigation Menu)

```json
{
  "mobileMenu": "tablet_portrait",
  "_cssGlobalClasses": ["main-nav"]
}
```

Values for `mobileMenu`: `always`, `never`, `laptop`, `tablet_landscape`, `tablet_portrait`, `mobile_landscape`, `mobile_portrait`

### Dropdown (Menu Item)

```json
{
  "text": "Services",
  "toggleOn": "both",
  "megaMenu": true,
  "megaMenuSelector": ".header__container",
  "link": {"type": "external", "url": "#"},
  "_cssGlobalClasses": ["dropdown-menu"]
}
```

Values for `toggleOn`: `hover`, `click`, `both`

### Toggle (Mobile Menu Button)

```json
{
  "icon": {
    "library": "svg",
    "svg": {
      "id": 2530,
      "filename": "bars.svg",
      "url": "https://example.com/bars.svg"
    }
  },
  "animation": "spin",
  "toggleSelector": ".mobile-menu",
  "ariaLabel": "Open Menu",
  "iconSize": "30",
  "barColor:tablet_portrait": {"raw": "var(--color-secondary)"}
}
```

### Slider Nested (Carousel)

```json
{
  "perPage": "3",
  "perPage:tablet_portrait": "2",
  "perPage:mobile_portrait": "1",
  "gap": "2rem",
  "autoplay": true,
  "interval": "5000",
  "pauseOnHover": true,
  "pagination": true,
  "paginationBottom": "-40",
  "arrows": true,
  "height": "none",
  "_cssCustom": ".slider-class .splide__list { transition-timing-function: linear !important; }"
}
```

### Icon Box

```json
{
  "icon": {"library": "fontawesomeSolid", "icon": "fas fa-rocket"},
  "iconSize": "3rem",
  "gap": "var(--spacing-xs)",
  "typographyHeading": {
    "color": {"raw": "var(--color-secondary)"},
    "font-size": "var(--text-md)"
  },
  "typographyBody": {
    "font-family": "Inter",
    "color": {"raw": "var(--color-tertiary)"},
    "font-size": "var(--text-sm)"
  },
  "_cssCustom": ".icon-box h3 { margin-bottom: var(--spacing-3xs); }"
}
```

### Accordion

```json
{
  "titleTypography": {
    "font-size": "var(--text-md)",
    "color": {"raw": "var(--color-secondary)"}
  },
  "contentTypography": {
    "font-size": "var(--text-sm)",
    "color": {"raw": "var(--color-tertiary)"}
  },
  "titleMargin": {"bottom": "var(--spacing-xs)"},
  "contentMargin": {"bottom": "var(--spacing-md)"},
  "titleBorder": {
    "width": {"bottom": "1"},
    "style": "solid",
    "color": {"raw": "var(--color-tertiary)"}
  },
  "_cssCustom": ".accordion .brxe-icon { transition: transform 0.3s ease; }\n.accordion .brx-open .brxe-icon { transform: rotate(90deg); }"
}
```

### Form (Newsletter Style)

```json
{
  "submitButtonWidth": "35",
  "submitButtonTypography": {
    "color": {"raw": "var(--color-light)"},
    "font-size": "var(--text-xs)"
  },
  "submitButtonBackgroundColor": {"raw": "var(--color-primary)"},
  "submitButtonBorder": {
    "width": {"top": "2", "right": "2", "bottom": "2", "left": "2"},
    "style": "solid",
    "color": {"raw": "var(--color-primary)"}
  },
  "fieldTypography": {
    "color": {"raw": "var(--color-secondary)"},
    "font-size": "var(--text-xs)"
  },
  "fieldBorder": {
    "width": {"top": "1", "right": "0", "bottom": "1", "left": "1"},
    "style": "solid",
    "color": {"raw": "var(--color-light)"}
  },
  "fieldPadding": {"top": "0.5rem", "bottom": "0.5rem", "left": "1.2rem", "right": "1.2rem"},
  "fieldMargin": {"bottom": "0"}
}
```

### List (Footer Links)

```json
{
  "separatorDisable": true,
  "itemMargin": {"bottom": "1.5rem"},
  "itemJustifyContent": "flex-start",
  "_typography": {
    "font-family": "Inter",
    "color": {"raw": "var(--color-tertiary)"},
    "font-size": "var(--text-sm)"
  }
}
```

### Code Element

```json
{
  "executeCode": true,
  "cssCode": ".my-section { background: linear-gradient(...); }",
  "javascriptCode": "(function() { console.log('Loaded'); })();",
  "signature": "hash-for-security",
  "user_id": 1,
  "time": 1720582839
}
```

---

## Common Layout Settings

### Flexbox Container

```json
{
  "_display": "flex",
  "_direction": "row",
  "_direction:tablet_portrait": "column",
  "_justifyContent": "space-between",
  "_alignItems": "center",
  "_flexWrap": "wrap",
  "_columnGap": "var(--spacing-md)",
  "_rowGap": "var(--spacing-md)"
}
```

### Grid Container

```json
{
  "_display": "grid",
  "_gridTemplateColumns": "repeat(3, minmax(0, 1fr))",
  "_gridTemplateColumns:tablet_portrait": "repeat(2, minmax(0, 1fr))",
  "_gridTemplateColumns:mobile_portrait": "repeat(1, minmax(0, 1fr))",
  "_gridGap": "var(--spacing-md)",
  "_alignItemsGrid": "stretch"
}
```

### Width & Sizing

```json
{
  "_width": "100%",
  "_width:tablet_portrait": "50%",
  "_widthMax": "1200",
  "_widthMin": "300",
  "_height": "auto",
  "_heightMin": "400",
  "_aspectRatio": "16 / 9"
}
```

### Spacing

```json
{
  "_padding": {"top": "var(--spacing-lg)", "right": "var(--spacing-md)", "bottom": "var(--spacing-lg)", "left": "var(--spacing-md)"},
  "_margin": {"top": "0", "bottom": "var(--spacing-xl)"}
}
```

### Typography

```json
{
  "_typography": {
    "font-family": "Inter",
    "font-size": "var(--text-md)",
    "font-weight": "600",
    "line-height": "1.5",
    "letter-spacing": "0.02em",
    "text-transform": "uppercase",
    "text-align": "center",
    "color": {"raw": "var(--color-secondary)"}
  }
}
```

### Background

```json
{
  "_background": {
    "color": {"raw": "var(--color-primary)"},
    "videoUrl": "https://example.com/video.mp4"
  },
  "_gradient": {
    "applyTo": "background",
    "colors": [
      {"id": "c1", "color": {"raw": "transparent"}, "stop": "0"},
      {"id": "c2", "color": {"raw": "var(--color-dark-70)"}, "stop": "100"}
    ]
  }
}
```

### Borders & Radius

```json
{
  "_border": {
    "width": {"top": "1", "right": "1", "bottom": "1", "left": "1"},
    "style": "solid",
    "color": {"raw": "var(--border-primary)"},
    "radius": {"top": "var(--radius-m)", "right": "var(--radius-m)", "bottom": "var(--radius-m)", "left": "var(--radius-m)"}
  }
}
```

### Position & Overlay

```json
{
  "_position": "relative",
  "_zIndex": "1",
  "_overflow": "hidden",
  "_isolation": "isolate"
}
```

For absolute positioned overlays:
```json
{
  "_position": "absolute",
  "_top": "0",
  "_right": "0",
  "_bottom": "0",
  "_left": "0",
  "_zIndex": "-1"
}
```

### Shadows

```json
{
  "_boxShadow": {
    "values": {"blur": "20", "offsetY": "8", "offsetX": "0", "spread": "0"},
    "color": {"raw": "var(--shadow-primary)"}
  }
}
```

### Custom CSS

```json
{
  "_cssCustom": ".my-element { transition: all 0.3s ease; }\n.my-element:hover { transform: translateY(-5px); }"
}
```

---

## Global Classes Definition

### Basic Class

```json
{
  "id": "btn-primary",
  "name": "btn-primary",
  "settings": {
    "_typography": {"color": {"raw": "var(--color-light)"}},
    "_background": {"color": {"raw": "var(--color-primary)"}},
    "_padding": {"top": "1rem", "right": "2rem", "bottom": "1rem", "left": "2rem"},
    "_border": {"radius": {"top": "var(--radius-s)", "right": "var(--radius-s)", "bottom": "var(--radius-s)", "left": "var(--radius-s)"}}
  }
}
```

### Class with Category

```json
{
  "id": "heading-1",
  "name": "heading-1",
  "settings": {
    "_typography": {"font-family": "Inter", "font-size": "var(--text-3xl)"}
  },
  "category": "typography",
  "_categoryData": {"id": "typography", "name": "Typography"},
  "modified": 1733551470,
  "user_id": 1
}
```

### Class with Custom CSS

```json
{
  "id": "card-hover",
  "name": "card-hover",
  "settings": {
    "_cssCustom": ".card-hover { transition: transform 0.3s ease, box-shadow 0.3s ease; }\n.card-hover:hover { transform: translateY(-10px); box-shadow: var(--shadow-xl); }"
  }
}
```

---

## Responsive Settings

Append breakpoint suffix to any setting:

```json
{
  "_direction": "row",
  "_direction:tablet_portrait": "column",
  "_direction:mobile_portrait": "column",
  "_display": "flex",
  "_display:mobile_portrait": "none",
  "_width": "50%",
  "_width:tablet_portrait": "100%",
  "_gridTemplateColumns": "repeat(3, minmax(0, 1fr))",
  "_gridTemplateColumns:tablet_portrait": "repeat(2, minmax(0, 1fr))",
  "_gridTemplateColumns:mobile_portrait": "repeat(1, minmax(0, 1fr))"
}
```

### Breakpoints

| Breakpoint | Suffix | Max Width |
|------------|--------|-----------|
| Desktop | (none) | - |
| Laptop | `:laptop` | 1366px |
| Tablet Landscape | `:tablet_landscape` | 1024px |
| Tablet Portrait | `:tablet_portrait` | 991px |
| Mobile Landscape | `:mobile_landscape` | 767px |
| Mobile Portrait | `:mobile_portrait` | 478px |
| Small Mobile | `:small_mobile` | 320px |

---

## Template Structure (Site-Wide)

### Required Keys

| Key | Type | Description |
|-----|------|-------------|
| `id` | int | Unique template ID |
| `name` | string | Template slug |
| `title` | string | Display title |
| `date` | string | Creation date (Y-m-d H:i:s) |
| `type` | string | Template type |
| `templateType` | string | Same as type |
| `header` or `content` | array | Elements (key based on type) |

### Template Types

| Type | Content Key | Purpose |
|------|-------------|---------|
| `header` | `header` | Site header |
| `footer` | `footer` | Site footer |
| `content` | `content` | Page content |
| `section` | `content` | Reusable section |
| `archive` | `content` | Archive pages |
| `search` | `content` | Search results |
| `error` | `content` | 404 page |
| `popup` | `content` | Popup/modal |

### Author Object

```json
{
  "name": "Author Name",
  "avatar": "https://secure.gravatar.com/avatar/...",
  "url": "https://example.com"
}
```

### Global Variables

```json
{
  "id": "primary",
  "name": "primary",
  "value": "#2364a9",
  "category": "corefrm"
}
```

### Variable Categories

```json
{
  "id": "corefrm",
  "name": "Core Framework"
}
```

---

## Complete Layout Examples

### Hero Section with CTA

```json
{
  "content": [
    {
      "id": "sec001",
      "name": "section",
      "parent": 0,
      "children": ["con001"],
      "settings": {"_cssGlobalClasses": ["pad-top-bottom-lg"]},
      "label": "Hero"
    },
    {
      "id": "con001",
      "name": "container",
      "parent": "sec001",
      "children": ["col001", "col002"],
      "settings": {
        "_direction": "row",
        "_direction:tablet_portrait": "column",
        "_alignItems": "center",
        "_cssGlobalClasses": ["gap-md"]
      }
    },
    {
      "id": "col001",
      "name": "block",
      "parent": "con001",
      "children": ["hdg001", "txt001", "btns01"],
      "settings": {"_cssGlobalClasses": ["gap-xs"]},
      "label": "Content Column"
    },
    {
      "id": "hdg001",
      "name": "heading",
      "parent": "col001",
      "children": [],
      "settings": {
        "text": "Speak directly to the visitor's challenge",
        "tag": "h1",
        "_cssGlobalClasses": ["heading-1", "text-secondary"]
      }
    },
    {
      "id": "txt001",
      "name": "text",
      "parent": "col001",
      "children": [],
      "settings": {
        "text": "<p>Clearly explain how your product or service solves the problem—keep it simple and direct.</p>",
        "_cssGlobalClasses": ["text-p", "text-tertiary"]
      }
    },
    {
      "id": "btns01",
      "name": "block",
      "parent": "col001",
      "children": ["btn001", "btn002"],
      "settings": {
        "_direction": "row",
        "_cssGlobalClasses": ["gap-xs", "margin-top-xs"]
      },
      "label": "Buttons"
    },
    {
      "id": "btn001",
      "name": "button",
      "parent": "btns01",
      "children": [],
      "settings": {
        "text": "Get Started",
        "_cssGlobalClasses": ["btn", "btn--primary"]
      }
    },
    {
      "id": "btn002",
      "name": "button",
      "parent": "btns01",
      "children": [],
      "settings": {
        "text": "Learn More",
        "_cssGlobalClasses": ["btn", "btn--outline"]
      }
    },
    {
      "id": "col002",
      "name": "block",
      "parent": "con001",
      "children": ["img001"],
      "settings": {},
      "label": "Image Column"
    },
    {
      "id": "img001",
      "name": "image",
      "parent": "col002",
      "children": [],
      "settings": {
        "image": {"url": "https://example.com/hero.jpg", "external": true},
        "_cssGlobalClasses": ["object-cover", "full-width"]
      }
    }
  ],
  "source": "bricksCopiedElements",
  "sourceUrl": "https://example.com",
  "version": "2.0.1",
  "globalClasses": [
    {"id": "pad-top-bottom-lg", "name": "pad-top-bottom-lg", "settings": {"_padding": {"bottom": "var(--spacing-lg)", "top": "var(--spacing-lg)"}}},
    {"id": "gap-md", "name": "gap-md", "settings": {"_columnGap": "var(--spacing-md)", "_rowGap": "var(--spacing-md)"}},
    {"id": "gap-xs", "name": "gap-xs", "settings": {"_columnGap": "var(--spacing-xs)", "_rowGap": "var(--spacing-xs)"}},
    {"id": "heading-1", "name": "heading-1", "settings": {"_typography": {"font-family": "Inter", "font-size": "var(--text-3xl)"}}},
    {"id": "text-secondary", "name": "text-secondary", "settings": {"_typography": {"color": {"raw": "var(--color-secondary)"}}}},
    {"id": "text-p", "name": "text-p", "settings": {"_typography": {"font-size": "var(--text-sm)", "font-family": "Inter"}}},
    {"id": "text-tertiary", "name": "text-tertiary", "settings": {"_typography": {"color": {"raw": "var(--color-tertiary)"}}}},
    {"id": "margin-top-xs", "name": "margin-top-xs", "settings": {"_margin": {"top": "var(--spacing-xs)"}}},
    {"id": "btn", "name": "btn", "settings": {"_padding": {"top": "1rem", "right": "2rem", "bottom": "1rem", "left": "2rem"}}},
    {"id": "btn--primary", "name": "btn--primary", "settings": {"_background": {"color": {"raw": "var(--color-primary)"}}, "_typography": {"color": {"raw": "var(--color-light)"}}}},
    {"id": "btn--outline", "name": "btn--outline", "settings": {"_border": {"color": {"raw": "var(--color-primary)"}}, "_typography": {"color": {"raw": "var(--color-primary)"}}}},
    {"id": "object-cover", "name": "object-cover", "settings": {"_objectFit": "cover"}},
    {"id": "full-width", "name": "full-width", "settings": {"_width": "100%"}}
  ],
  "globalElements": []
}
```

### Features Grid (3 Columns)

```json
{
  "content": [
    {
      "id": "sec001",
      "name": "section",
      "parent": 0,
      "children": ["con001"],
      "settings": {"_cssGlobalClasses": ["pad-top-bottom-lg"]},
      "label": "Features"
    },
    {
      "id": "con001",
      "name": "container",
      "parent": "sec001",
      "children": ["hdr001", "grid01"],
      "settings": {"_cssGlobalClasses": ["gap-md", "container-width-md"]}
    },
    {
      "id": "hdr001",
      "name": "block",
      "parent": "con001",
      "children": ["tag001", "hdg001"],
      "settings": {"_cssGlobalClasses": ["text-center", "gap-xs"]},
      "label": "Section Header"
    },
    {
      "id": "tag001",
      "name": "heading",
      "parent": "hdr001",
      "children": [],
      "settings": {"text": "Features", "tag": "h6", "_cssGlobalClasses": ["heading-6", "text-font-600"]}
    },
    {
      "id": "hdg001",
      "name": "heading",
      "parent": "hdr001",
      "children": [],
      "settings": {"text": "Everything you need", "tag": "h2", "_cssGlobalClasses": ["heading-2"]}
    },
    {
      "id": "grid01",
      "name": "block",
      "parent": "con001",
      "children": ["feat01", "feat02", "feat03"],
      "settings": {"_cssGlobalClasses": ["grid-3col", "grid-gap-md"]},
      "label": "Features Grid"
    },
    {
      "id": "feat01",
      "name": "icon-box",
      "parent": "grid01",
      "children": [],
      "settings": {
        "icon": {"library": "fontawesomeSolid", "icon": "fas fa-rocket"},
        "_cssGlobalClasses": ["icon-box"]
      }
    },
    {
      "id": "feat02",
      "name": "icon-box",
      "parent": "grid01",
      "children": [],
      "settings": {
        "icon": {"library": "fontawesomeSolid", "icon": "fas fa-shield-alt"},
        "_cssGlobalClasses": ["icon-box"]
      }
    },
    {
      "id": "feat03",
      "name": "icon-box",
      "parent": "grid01",
      "children": [],
      "settings": {
        "icon": {"library": "fontawesomeSolid", "icon": "fas fa-chart-line"},
        "_cssGlobalClasses": ["icon-box"]
      }
    }
  ],
  "source": "bricksCopiedElements",
  "sourceUrl": "https://example.com",
  "version": "2.0.1",
  "globalClasses": [
    {"id": "pad-top-bottom-lg", "name": "pad-top-bottom-lg", "settings": {"_padding": {"bottom": "var(--spacing-lg)", "top": "var(--spacing-lg)"}}},
    {"id": "gap-md", "name": "gap-md", "settings": {"_columnGap": "var(--spacing-md)", "_rowGap": "var(--spacing-md)"}},
    {"id": "gap-xs", "name": "gap-xs", "settings": {"_columnGap": "var(--spacing-xs)", "_rowGap": "var(--spacing-xs)"}},
    {"id": "container-width-md", "name": "container-width-md", "settings": {"_width": "90%", "_widthMax": "900"}},
    {"id": "text-center", "name": "text-center", "settings": {"_typography": {"text-align": "center"}}},
    {"id": "heading-2", "name": "heading-2", "settings": {"_typography": {"font-family": "Inter", "font-size": "var(--text-2xl)"}}},
    {"id": "heading-6", "name": "heading-6", "settings": {"_typography": {"font-size": "var(--text-xs)", "font-family": "Inter", "text-transform": "uppercase"}}},
    {"id": "text-font-600", "name": "text-font-600", "settings": {"_typography": {"font-weight": "600"}}},
    {"id": "grid-3col", "name": "grid-3col", "settings": {"_gridTemplateColumns": "repeat(3, minmax(0, 1fr))", "_display": "grid", "_gridTemplateColumns:tablet_portrait": "repeat(2, minmax(0, 1fr))", "_gridTemplateColumns:mobile_portrait": "repeat(1, minmax(0, 1fr))"}},
    {"id": "grid-gap-md", "name": "grid-gap-md", "settings": {"_gridGap": "var(--spacing-md)"}},
    {"id": "icon-box", "name": "icon-box", "settings": {"typographyBody": {"font-family": "Inter", "color": {"raw": "var(--color-tertiary)"}, "font-size": "var(--text-sm)"}, "typographyHeading": {"color": {"raw": "var(--color-secondary)"}, "font-size": "var(--text-md)"}, "gap": "var(--spacing-xs)", "iconSize": "3rem"}}
  ],
  "globalElements": []
}
```

---

## Core Framework Classes Reference

The `core-framework.css` provides utility classes. Use these via `_cssGlobalClasses` setting.

### Components

| Class | Purpose |
|-------|---------|
| `.btn` | Button base style |
| `.btn.small` / `.btn.large` | Button sizes |
| `.btn.secondary` / `.btn.tertiary` / `.btn.ghost` / `.btn.slight` | Button variants |
| `.card` / `.card.secondary` / `.card.primary` | Card component |
| `.badge` / `.badge.secondary` | Badge/tag component |
| `.link` / `.link.secondary` / `.link.tertiary` | Link styles |
| `.input` | Form input styling |
| `.select` | Form select styling |
| `.icon` / `.icon.small` / `.icon.large` | Icon container |
| `.avatar` / `.avatar.small` / `.avatar.large` | Avatar image |
| `.divider` / `.divider.vertical` | Divider line |
| `.checkbox` / `.radio` | Form checkbox/radio |
| `.expand-click` | Expand click area to parent |

### Layout & Flexbox

| Class | Purpose |
|-------|---------|
| `.flex-row` / `.flex-column` | Flex direction |
| `.flex-wrap` / `.flex-nowrap` | Flex wrap |
| `.flex-1` / `.flex-2` / `.flex-3` | Flex grow |
| `.row` | Flex row with wrap |
| `.column` | Flex column |
| `.items-center` / `.items-left` / `.items-right` | Align items horizontally |
| `.items-top` / `.items-middle` / `.items-bottom` | Align items vertically |
| `.content-center` / `.content-left` / `.content-right` | Justify content horizontally |
| `.content-top` / `.content-middle` / `.content-bottom` | Justify content vertically |
| `.self-center` / `.self-stretch` | Align self |
| `.space-between` / `.space-around` | Justify content |

### Grid

| Class | Purpose |
|-------|---------|
| `.columns-2` to `.columns-8` | Grid columns |
| `.columns-min-5` to `.columns-min-70` | Auto-fit grid with min width |
| `.col-span-2` to `.col-span-8` | Column span |
| `.col-start-1` to `.col-start-8` | Column start |
| `.row-span-2` to `.row-span-8` | Row span |
| `.row-start-1` to `.row-start-8` | Row start |

### Spacing (Gap)

| Class | Purpose |
|-------|---------|
| `.gap-4xs` to `.gap-4xl` | Gap (4xs, 3xs, 2xs, xs, s, m, l, xl, 2xl, 3xl, 4xl) |

### Padding

| Class | Purpose |
|-------|---------|
| `.padding-4xs` to `.padding-4xl` | All sides padding |
| `.padding-top-xs` to `.padding-top-4xl` | Top padding |
| `.padding-bottom-xs` to `.padding-bottom-4xl` | Bottom padding |
| `.padding-left-xs` to `.padding-left-4xl` | Left padding |
| `.padding-right-xs` to `.padding-right-4xl` | Right padding |
| `.padding-horizontal-xs` to `.padding-horizontal-4xl` | Left + Right padding |
| `.padding-vertical-xs` to `.padding-vertical-4xl` | Top + Bottom padding |

### Margin

| Class | Purpose |
|-------|---------|
| `.margin-4xs` to `.margin-4xl` | All sides margin |
| `.margin-top-xs` to `.margin-top-4xl` | Top margin |
| `.margin-bottom-xs` to `.margin-bottom-4xl` | Bottom margin |
| `.margin-left-xs` to `.margin-left-4xl` | Left margin |
| `.margin-right-xs` to `.margin-right-4xl` | Right margin |
| `.margin-horizontal-xs` to `.margin-horizontal-4xl` | Left + Right margin |
| `.margin-vertical-xs` to `.margin-vertical-4xl` | Top + Bottom margin |

### Width & Height

| Class | Purpose |
|-------|---------|
| `.full-width` / `.full-height` | 100% width/height |
| `.auto-width` / `.auto-height` | Auto width/height |
| `.screen-width` / `.screen-height` | 100vw/100vh |
| `.width-10` to `.width-90` | Percentage width (10%, 20%, etc.) |
| `.max-width-10` to `.max-width-140` | Max width in rem |
| `.max-site-width` | Max site container width |

### Aspect Ratio

| Class | Purpose |
|-------|---------|
| `.aspect-1` | 1:1 square |
| `.aspect-16-9` / `.aspect-9-16` | 16:9 and 9:16 |
| `.aspect-4-3` / `.aspect-3-4` | 4:3 and 3:4 |
| `.aspect-3-2` / `.aspect-2-3` | 3:2 and 2:3 |

### Background Colors

| Class | Purpose |
|-------|---------|
| `.bg-primary` / `.bg-primary-5` to `.bg-primary-90` | Primary with opacity |
| `.bg-primary-l-1` to `.bg-primary-l-4` | Primary light variants |
| `.bg-primary-d-1` to `.bg-primary-d-4` | Primary dark variants |
| `.bg-secondary`, `.bg-tertiary` | Same pattern as primary |
| `.bg-light` / `.bg-dark` | Light/dark backgrounds |
| `.bg-light-5` to `.bg-light-90` | Light with opacity |
| `.bg-dark-5` to `.bg-dark-90` | Dark with opacity |
| `.bg-body` / `.bg-surface` | Body/surface backgrounds |
| `.bg-success` / `.bg-error` | Status colors |

### Text Colors

| Class | Purpose |
|-------|---------|
| `.text-primary` / `.text-secondary` / `.text-tertiary` | Brand text colors |
| `.text-primary-l-1` to `.text-primary-l-4` | Light variants |
| `.text-primary-d-1` to `.text-primary-d-4` | Dark variants |
| `.text-light` / `.text-dark` | Light/dark text |
| `.text-body` / `.text-title` | Body/title text |
| `.text-success` / `.text-error` | Status text colors |

### Text Size

| Class | Purpose |
|-------|---------|
| `.text-xs` / `.text-s` / `.text-m` / `.text-l` / `.text-xl` | Font sizes |
| `.text-2xl` / `.text-3xl` / `.text-4xl` | Large font sizes |

### Text Alignment

| Class | Purpose |
|-------|---------|
| `.text-left` / `.text-center` / `.text-right` | Text alignment |

### Text Style

| Class | Purpose |
|-------|---------|
| `.bold` | Font weight bold |
| `.font-100` to `.font-900` | Font weights |
| `.italic` | Italic text |
| `.uppercase` / `.lowercase` | Text transform |
| `.underline` | Text decoration |
| `.white-space-nowrap` | No text wrap |
| `.line-height-xs` to `.line-height-xl` | Line heights |

### Border Colors

| Class | Purpose |
|-------|---------|
| `.border-primary` / `.border-secondary` / `.border-tertiary` | Border colors |
| `.border-light` / `.border-dark` | Light/dark borders |
| `.border-success` / `.border-error` | Status borders |
| `.border` | Default border |
| `.border-top` / `.border-bottom` / `.border-left` / `.border-right` | Single-side borders |

### Border Radius

| Class | Purpose |
|-------|---------|
| `.radius-xs` / `.radius-s` / `.radius-m` / `.radius-l` / `.radius-xl` | Border radius |
| `.radius-full` | Full circle/pill |

### Shadows

| Class | Purpose |
|-------|---------|
| `.shadow-xs` / `.shadow-s` / `.shadow-m` / `.shadow-l` / `.shadow-xl` | Box shadows |

### Position

| Class | Purpose |
|-------|---------|
| `.relative` / `.absolute` / `.fixed` / `.sticky` | Position type |
| `.top-0` / `.right-0` / `.bottom-0` / `.left-0` | Position values |
| `.inset-0` | All sides 0 |
| `.z--1` / `.z-0` / `.z-1` / `.z-10` / `.z-100` / `.z-1000` / `.z-10000` | Z-index |

### Display & Visibility

| Class | Purpose |
|-------|---------|
| `.display-none` / `.hidden` | Hide element |
| `.visible` | Show element |
| `.opacity-0` to `.opacity-100` | Opacity (increments of 10) |

### Object Fit

| Class | Purpose |
|-------|---------|
| `.fit-cover` / `.fit-contain` / `.fit-fill` | Object-fit for images |

### Overflow

| Class | Purpose |
|-------|---------|
| `.overflow-hidden` / `.overflow-auto` | Overflow |
| `.overflow-x-hidden` / `.overflow-x-auto` | Horizontal overflow |
| `.overflow-y-hidden` / `.overflow-y-auto` | Vertical overflow |

### Effects

| Class | Purpose |
|-------|---------|
| `.bg-blur-xs` to `.bg-blur-xl` | Backdrop blur |
| `.grayscale` | Grayscale filter |
| `.rotate-90` / `.rotate-180` | Rotation |
| `.transition-global` | Standard transition |

### Cursor

| Class | Purpose |
|-------|---------|
| `.pointer` | Pointer cursor |
| `.cursor-auto` | Auto cursor |
| `.not-allowed` | Not-allowed cursor |
| `.no-pointer-events` | Disable pointer events |

### Lists

| Class | Purpose |
|-------|---------|
| `.list-none` | Remove list styling |

### Usage Example

```json
{
  "id": "sec001",
  "name": "section",
  "parent": 0,
  "children": ["con001"],
  "settings": {
    "_cssGlobalClasses": ["padding-vertical-xl", "bg-surface"]
  }
}
```

```json
{
  "id": "hdg001",
  "name": "heading",
  "parent": "con001",
  "children": [],
  "settings": {
    "text": "Welcome",
    "tag": "h1",
    "_cssGlobalClasses": ["text-3xl", "text-primary", "text-center", "margin-bottom-m"]
  }
}
```

```json
{
  "id": "btn001",
  "name": "button",
  "parent": "con001",
  "children": [],
  "settings": {
    "text": "Get Started",
    "_cssGlobalClasses": ["btn", "shadow-m"]
  }
}
```

---

## ID Generation

Element IDs must be 6-character alphanumeric strings:

```javascript
function generateId() {
  return Math.random().toString(36).substring(2, 8);
}
```

Or use patterns:
- Semantic: `sec001`, `hdr001`, `btn001`, `img001`
- Random: `jdhuyf`, `hxbbms`, `towhmc`

---

## CSS Variables Reference (from core-framework.css)

### Spacing (`--space-*`)

```
--space-4xs  --space-3xs  --space-2xs  --space-xs  --space-s
--space-m    --space-l    --space-xl   --space-2xl --space-3xl  --space-4xl
```

All spacing values use fluid `clamp()` for responsive scaling.

### Typography (`--text-*`)

```
--text-xs  --text-s  --text-m  --text-l  --text-xl
--text-2xl --text-3xl --text-4xl
```

### Colors

**Brand Colors:**
```
--primary    --secondary    --tertiary
```

**Opacity Variants (5-90%):**
```
--primary-5 ... --primary-90
--secondary-5 ... --secondary-90
--tertiary-5 ... --tertiary-90
```

**Shade Variants:**
```
--primary-d-1 to --primary-d-4   (darker)
--primary-l-1 to --primary-l-4   (lighter)
```

**Neutral Colors:**
```
--base        --light       --dark
--bg-body     --bg-surface
--text-body   --text-title
```

**Status Colors:**
```
--success  --error
--success-5 to --success-90
--error-5 to --error-90
```

### Grid Columns (`--columns-*`)

```
--columns-1 to --columns-12
```

### Border Radius (`--radius-*`)

```
--radius-xs  --radius-s  --radius-m  --radius-l  --radius-xl  --radius-full
```

### Shadows (`--shadow-*`)

```
--shadow-xs  --shadow-s  --shadow-m  --shadow-l  --shadow-xl
```

Shadows use `--shadow-primary` for color.

---

## How to Use Layouts

### Copy/Paste Sections

1. Copy JSON content to clipboard
2. In Bricks Builder, right-click in structure panel
3. Select "Paste" or use Ctrl/Cmd+V
4. Elements and classes are pasted together

### Import Templates

1. Go to Bricks > Templates in WordPress admin
2. Click Import
3. Upload JSON file or paste content
4. Template appears in template list
5. Assign to pages via template conditions

---

## Interactions & Animations

Bricks uses `_interactions` for animations and dynamic behaviors. The deprecated `_animation` property (pre-v1.6) should not be used.

### Interaction Structure

```json
{
  "_interactions": [
    {
      "id": "anim01",
      "trigger": "enterView",
      "action": "startAnimation",
      "animationType": "fadeInUp",
      "animationDuration": "0.8s",
      "animationDelay": "0.2s",
      "runOnce": true
    }
  ]
}
```

### Interaction Properties

| Property | Type | Description |
|----------|------|-------------|
| `id` | string | Unique identifier (6 chars) |
| `trigger` | string | Event that triggers the action |
| `action` | string | Action to perform |
| `animationType` | string | Animation style (for startAnimation) |
| `animationDuration` | string | Duration (e.g., "0.8s", "1s") |
| `animationDelay` | string | Delay before starting (e.g., "0", "0.2s") |
| `runOnce` | boolean | Run animation only once |
| `target` | string | Target element (for show/hide) |
| `templateId` | string | Target template ID (for popups) |

### Triggers

| Trigger | Description |
|---------|-------------|
| `enterView` | Element enters viewport (scroll) |
| `click` | User clicks element |
| `mouseover` | Mouse hovers over element |
| `contentLoaded` | Page content fully loaded |

### Actions

| Action | Description | Used With |
|--------|-------------|-----------|
| `startAnimation` | Play CSS animation | animationType, animationDuration, animationDelay |
| `show` | Show hidden element | target, templateId |
| `hide` | Hide visible element | target, templateId |

### Animation Types

| Type | Description |
|------|-------------|
| `fadeIn` | Fade in (opacity 0 to 1) |
| `fadeInUp` | Fade in while moving up |
| `fadeInDown` | Fade in while moving down |
| `fadeInLeft` | Fade in while moving from left |
| `fadeInRight` | Fade in while moving from right |
| `pulse` | Pulsing/scaling effect |

### Staggered Animations

Create sequential reveal effects by incrementing `animationDelay`:

```json
{
  "id": "card01",
  "settings": {
    "_interactions": [
      {"id": "a1", "trigger": "enterView", "action": "startAnimation", "animationType": "fadeInUp", "animationDuration": "0.6s", "animationDelay": "0", "runOnce": true}
    ]
  }
},
{
  "id": "card02",
  "settings": {
    "_interactions": [
      {"id": "a2", "trigger": "enterView", "action": "startAnimation", "animationType": "fadeInUp", "animationDuration": "0.6s", "animationDelay": "0.1s", "runOnce": true}
    ]
  }
},
{
  "id": "card03",
  "settings": {
    "_interactions": [
      {"id": "a3", "trigger": "enterView", "action": "startAnimation", "animationType": "fadeInUp", "animationDuration": "0.6s", "animationDelay": "0.2s", "runOnce": true}
    ]
  }
}
```

### Hover Effects via Custom CSS

Use `_cssCustom` for hover states and transitions:

```json
{
  "id": "card01",
  "settings": {
    "_cssCustom": "#brxe-card01 { transition: transform 0.3s ease, box-shadow 0.3s ease; }\n#brxe-card01:hover { transform: translateY(-5px); box-shadow: var(--shadow-l); }"
  }
}
```

Common hover patterns:

**Card Lift Effect:**
```json
"_cssCustom": "#brxe-card01 { transition: all 0.3s ease; }\n#brxe-card01:hover { transform: translateY(-8px); box-shadow: var(--shadow-xl); }"
```

**Background Color Change:**
```json
"_cssCustom": "#brxe-card01 { transition: background 0.3s ease; }\n#brxe-card01:hover { background: var(--primary-10); }"
```

**Image Zoom:**
```json
"_cssCustom": "#brxe-imgwrap img { transition: transform 0.5s ease; }\n#brxe-imgwrap:hover img { transform: scale(1.05); }"
```

**Border Accent:**
```json
"_cssCustom": "#brxe-card01 { transition: border-color 0.3s ease; border-left: 3px solid transparent; }\n#brxe-card01:hover { border-left-color: var(--primary); }"
```

**Button Glow:**
```json
"_cssCustom": "#brxe-btn01 { transition: all 0.3s ease; }\n#brxe-btn01:hover { transform: translateY(-3px); box-shadow: 0 10px 30px rgba(0,0,0,0.2); }"
```

### Popup Interactions

Show/hide popups with click triggers:

```json
{
  "id": "closebtn",
  "settings": {
    "_interactions": [
      {
        "id": "close01",
        "trigger": "click",
        "action": "hide",
        "target": "popup",
        "templateId": "1323"
      }
    ]
  }
}
```

### Entrance Animation on Section

Animate entire section when scrolled into view:

```json
{
  "id": "sec001",
  "name": "section",
  "parent": 0,
  "children": ["con001"],
  "settings": {
    "_cssGlobalClasses": ["padding-vertical-xl"],
    "_interactions": [
      {"id": "secAnim", "trigger": "enterView", "action": "startAnimation", "animationType": "fadeIn", "animationDuration": "1s", "animationDelay": "0", "runOnce": true}
    ]
  }
}
```

### Complete Animated Card Example

```json
{
  "id": "card01",
  "name": "block",
  "parent": "grid01",
  "children": ["cardimg", "cardtxt"],
  "settings": {
    "_cssGlobalClasses": ["card", "padding-m", "radius-m"],
    "_interactions": [
      {"id": "cardAnim", "trigger": "enterView", "action": "startAnimation", "animationType": "fadeInUp", "animationDuration": "0.8s", "animationDelay": "0", "runOnce": true}
    ],
    "_cssCustom": "#brxe-card01 { transition: transform 0.3s ease, box-shadow 0.3s ease; }\n#brxe-card01:hover { transform: translateY(-8px); box-shadow: var(--shadow-xl); }"
  },
  "label": "Feature Card"
}
```

---

## Best Practices

1. **Use Core Framework First** - Always check `core-framework.css` for existing utility classes before creating new ones
2. **Styling Priority** - Core Framework classes → inline settings → custom CSS (in that order)
3. **Compose with Utilities** - Combine multiple utility classes instead of creating new component classes
4. **Responsive Design** - Always include tablet and mobile breakpoint settings for inline styles
5. **Semantic Labels** - Use descriptive labels for elements in structure panel
6. **Consistent ID Patterns** - Use semantic prefixes like `sec`, `con`, `hdg`, `btn`, `img`
7. **Minimize Custom CSS** - Only use code elements for complex animations/interactions not covered by framework
8. **Version Matching** - Match the `version` field to target Bricks version
9. **Custom Classes for Components** - Only create new global classes for repeated component patterns
10. **Animation Performance** - Use `runOnce: true` to prevent repeated animations on scroll
11. **Stagger Delays** - Increment delays by 0.1s for smooth sequential reveals
12. **Hover Transitions** - Always include `transition` property before defining hover states

---

## Examples in Repository

See `templates-2026-01-12/` folder:

| File | Type | Description |
|------|------|-------------|
| `hero.json` | Section | Hero section with grid, testimonials, CTA |
| `home.json` | Section | Complete homepage with navbar, hero, features, testimonials, FAQ, footer |
| `template-header-new-2026-01-12.json` | Template | Complete header with mega menu |
| `template-frontpage-2026-01-12.json` | Template | Homepage content template |
| `template-*-archive-*.json` | Template | Archive page templates |

### Key Patterns from Examples

**home.json demonstrates:**
- Navigation with `nav-nested`, `dropdown`, `toggle` elements
- Hero section with two-column layout
- Features grid with `icon-box` elements
- Logo slider with `slider-nested`
- Testimonials carousel
- FAQ with `accordion` element
- Newsletter form
- Footer with link lists
- Responsive breakpoints (`:tablet_portrait`, `:mobile_portrait`)
