# Etch JSON Authoring Skill

Create Etch block JSON from scratch for building pages, templates, and components in the Etch page builder.

## Core Concepts

Etch is a WordPress page builder that uses JSON to define block structures. Blocks can be:
- **Static**: Fixed HTML structure
- **Dynamic**: Use expressions like `{this.title}` to pull data
- **Looped**: Repeat content for collections (posts, terms, users)
- **Conditional**: Show/hide based on conditions

## Template Authoring Syntax

The Etch builder provides a **Svelte-inspired template syntax** as the primary authoring interface. This template language compiles to/from the underlying block JSON. Understanding both formats is essential.

### Syntax Overview

| Template Syntax | JSON Block | Description |
|----------------|------------|-------------|
| `<section class="hero">` | `etch/element` with `tag: "section"` | Standard HTML element |
| `<SectionIntro />` | `etch/component` with `ref: N` | Component reference |
| `{#slot nav} ... {/slot}` | `etch/slot-content` with `name: "nav"` | Named slot content |
| `Text content` | `etch/text` with `content: "..."` | Plain text |
| `{#loop posts} ... {/loop}` | `etch/loop` with `loopId: "posts"` | Loop iteration |
| `{#if condition} ... {/if}` | `etch/condition` | Conditional rendering |

### HTML Elements with data-etch-element

In the template syntax, structural HTML elements use the `data-etch-element` attribute to identify their role in the builder's tree panel:

```html
<section data-etch-element="section" class="hero-catalina">
  <div data-etch-element="container" class="hero__container">
    <!-- Content -->
  </div>
</section>
```

Common `data-etch-element` values: `section`, `container`, `wrapper`

### Developer Notes (data-etch-note)

The `data-etch-note` attribute provides editor-only annotations that are stripped from frontend output:

```html
<ol data-etch-element="container" data-etch-note="Border styles are set on the list" class="process__list">
```

### Component Syntax

Components (PascalCase tags) map to `etch/component` blocks. Props use two formats:

```html
<!-- String props: quoted values -->
<SectionIntro style="Center" sectionHeading="Our Process" headingLevel="h1" />

<!-- Boolean/expression props: curly braces -->
<SectionIntro showPrimaryCta={true} showLede={false} />

<!-- Self-closing (no children) -->
<FeatureCardYankee talkingPointPosition="25" />

<!-- With slot children -->
<PricingCardBravo>
  {#slot features}
    <PricingCardBravoListItem />
    <PricingCardBravoListItem />
  {/slot}
</PricingCardBravo>
```

#### Component → JSON Mapping

```html
<SectionIntro style="Center" showPrimaryCta={true} sectionHeading="Hello" />
```

Maps to:

```json
{
  "blockName": "etch/component",
  "attrs": {
    "ref": 456,
    "attributes": {
      "style": "Center",
      "showPrimaryCta": true,
      "sectionHeading": "Hello"
    }
  }
}
```

### Slot Syntax

Named slots distribute content into specific areas of a component:

```html
<HeaderAlpha>
  {#slot nav}
    <FlexNav>
      {#slot topLevel}
        <FlexNavItem itemLabel="Home" itemLink="/" />
        <FlexNavDropdown dropdownTag="ul">
          {#slot menuContent}
            <FlexNavItem itemLabel="Dropdown Item" itemLink="#" />
          {/slot}
        </FlexNavDropdown>
      {/slot}
    </FlexNav>
  {/slot}
</HeaderAlpha>
```

Maps to:

```json
{
  "blockName": "etch/component",
  "attrs": { "ref": 100 },
  "innerBlocks": [
    {
      "blockName": "etch/slot-content",
      "attrs": { "name": "nav" },
      "innerBlocks": [
        {
          "blockName": "etch/component",
          "attrs": { "ref": 200 },
          "innerBlocks": [
            {
              "blockName": "etch/slot-content",
              "attrs": { "name": "topLevel" },
              "innerBlocks": [ ... ]
            }
          ]
        }
      ]
    }
  ]
}
```

### Mixed Elements + Components

Sections commonly mix standard HTML elements with component references:

```html
<section data-etch-element="section" class="feature-section-yankee">
  <div data-etch-element="container" class="feature-section-yankee__section-wrapper">
    <SectionIntro style="Center" showLede={true} showPrimaryCta={false} />
    <div class="feature-section-yankee__badge-wrapper">
      <RatingBadgeAlpha />
      <RatingBadgeAlpha />
    </div>
  </div>
  <ul data-etch-element="container" class="feature-section-yankee__feature-list">
    <li class="feature-section-yankee__list-item">
      <FeatureCardYankee />
    </li>
    <li class="feature-section-yankee__list-item">
      <FeatureCardYankee talkingPointPosition="25" talkingPointText="My awesome talking point" />
    </li>
  </ul>
</section>
```

### CSS Panel

Each section has scoped CSS in the builder's CSS panel, using the section's class as root:

```css
.hero-catalina {
  color-scheme: light;
  min-block-size: 100vh;
  background: var(--black, #000);
  color: var(--text-light, #eee);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  h1, h2, h3 {
    /* Nested selectors */
  }
  a {
    color: var(--text-light, #eee);
    &:hover {
      color: var(--white, #fff);
    }
  }
}
```

### Component Properties Panel

When a component is selected, the right sidebar shows typed property fields:
- **String fields**: Text inputs (Heading, Label, URL)
- **Boolean fields**: Toggles (Show Lede, Include Skip Link)
- **Select fields**: Dropdowns (Style: Center/Left/Right, Position: Static/Fixed)
- **Number fields**: Numeric inputs (Price, Position)

These map to the component's `etch_component_properties` post meta definitions.

---

## Block References

### etch/element

The fundamental building block for any HTML element.

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "div",
    "attributes": {
      "class": "container",
      "id": "main",
      "data-section": "hero",
      "aria-label": "Main content"
    }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

**Common Tags:** `div`, `section`, `article`, `header`, `footer`, `nav`, `main`, `aside`, `ul`, `ol`, `li`, `a`, `img`, `button`, `form`, `input`, `label`, `span`, `p`, `h1`-`h6`, `figure`, `figcaption`

### etch/text

For text content with optional dynamic expressions.

```json
{
  "blockName": "etch/text",
  "attrs": {
    "content": "Hello World"
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

**Dynamic Content Examples:**
- `{this.title}` - Post title
- `{this.excerpt}` - Post excerpt
- `{site.name}` - Site name
- `{user.displayName}` - Current user
- `{item.title}` - Loop item (inside loop)
- `Posted on {this.date.dateFormat("F j, Y")}` - With modifier

### etch/loop

Iterate over collections of data.

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
    // Content repeated for each item
  ],
  "innerHTML": "",
  "innerContent": []
}
```

**Built-in Loop Presets:**
- `posts` - WP posts query
- `mainQuery` - Archive main query
- `nav` - Navigation items
- `simple_json` - Static JSON data
- `terms` - Taxonomy terms query
- `users` - WordPress users query

**Inline JSON Array (no preset needed):**
```json
{
  "blockName": "etch/loop",
  "attrs": {
    "target": "[\"Home\", \"About\", \"Contact\"]",
    "itemId": "label"
  }
}
```

**Loop Parameters (prefix with $):**
- `$count` - Number of items (-1 for all)
- `$type` - Post type (wrap string in quotes: `"\"post\""`)
- `$orderby` - Order by field
- `$order` - ASC or DESC
- `$offset` - Skip items
- `$meta_key`, `$meta_value` - Meta queries

**Inside loops, access data with itemId:**
- `{post.title}` (when itemId is "post")
- `{post.permalink}`
- `{post.featuredImage.url}`
- `{idx}` - Current index (0-based)

### etch/condition

Conditionally render content.

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "conditionString": "this.meta.featured === 'yes'"
  },
  "innerBlocks": [
    // Content shown when condition is true
  ],
  "innerHTML": "",
  "innerContent": []
}
```

**Condition Examples:**
- `this.meta.featured === 'yes'`
- `user.isLoggedIn`
- `item.hasChildren`
- `idx === 0` (first item in loop)
- `post.meta.show_badge`

### etch/component

Reference a reusable component/pattern.

```json
{
  "blockName": "etch/component",
  "attrs": {
    "ref": 123,
    "attributes": {
      "title": "{post.title}",
      "image": "{post.featuredImage.url}",
      "link": "{post.permalink}",
      "showBadge": true
    }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

### etch/raw-html

For SVG, iframes, or complex HTML.

```json
{
  "blockName": "etch/raw-html",
  "attrs": {
    "content": "<svg viewBox=\"0 0 24 24\">...</svg>"
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

### etch/dynamic-element

Like `etch/element` but the tag name can be dynamically resolved from attributes.

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

The `tag` inside `attributes` is resolved dynamically and removed from the HTML output. Falls back to `attrs.tag` if no dynamic tag found. Invalid tags default to `div`.

### etch/dynamic-image

Specialized image block with WordPress media library integration, automatic srcset generation, and responsive image handling.

```json
{
  "blockName": "etch/dynamic-image",
  "attrs": {
    "tag": "img",
    "attributes": {
      "mediaId": "{post.featuredImage.id}",
      "class": "post-thumbnail",
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

**Special Properties (extracted, not rendered as HTML attrs):**
- `mediaId` - WordPress attachment ID (required for media library features)
- `useSrcSet` - Generate srcset attribute (default: `"true"`)
- `maximumSize` - Max image size to use: `"thumbnail"`, `"medium"`, `"large"`, `"full"` (default: `"full"`)

Without `mediaId`, renders a plain `<img>` with a placeholder src. With `mediaId`, generates full srcset, sizes, width, height, and alt from the media library.

### etch/svg (with src)

Fetches and renders SVG content from a URL.

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

**Special Properties:**
- `src` - URL of the SVG file to fetch (required)
- `stripColors` - Remove fill/stroke colors to allow CSS coloring (`"true"` to enable)

### etch/slot-placeholder & etch/slot-content

For component slots (named content areas).

```json
{
  "blockName": "etch/slot-placeholder",
  "attrs": { "name": "footer" },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

## Dynamic Expression System

### Context Types

| Context | Access | Description |
|---------|--------|-------------|
| `this` | `{this.title}` | Current post/page data |
| `site` | `{site.name}` | Site-wide data |
| `user` | `{user.displayName}` | Current user |
| `url` | `{url.path}` | URL parameters |
| `props` | `{props.heading}` | Component properties |
| `item` | `{item.title}` | Loop item (custom via itemId) |
| `options` | `{options.field}` | ACF options |

### Available Modifiers

**String Modifiers:**
- `toUpperCase()` / `toLowerCase()`
- `trim()` / `ltrim()` / `rtrim()`
- `truncateChars(100, "...")` / `truncateWords(20, "...")`
- `concat("suffix")`
- `split(",")` / `join(", ")`
- `toSlug()`
- `stripTags()`
- `urlEncode()` / `urlDecode()`
- `toString()`

**Number Modifiers:**
- `numberFormat(2, ".", ",")` - Format number
- `toInt()` - Convert to integer
- `ceil()` / `floor()` / `round(2)`

**Date Modifiers:**
- `dateFormat("F j, Y")` - Format date

**Array Modifiers:**
- `at(0)` - Get item at index
- `slice(0, 5)` - Get subset
- `length()` - Get count
- `reverse()`
- `pluck("title")` - Extract property from objects
- `indexOf("value")`

**Comparison Modifiers (return true/false or custom values):**
- `includes("search", trueVal, falseVal)`
- `startsWith("prefix", trueVal, falseVal)`
- `endsWith("suffix", trueVal, falseVal)`
- `equal(value, trueVal, falseVal)`
- `less(10, trueVal, falseVal)` / `lessOrEqual()`
- `greater(5, trueVal, falseVal)` / `greaterOrEqual()`

**Type Conversion:**
- `toBool()` - Convert to boolean

**Example Expressions:**
```
{this.title.toUpperCase()}
{this.date.dateFormat("M j, Y")}
{this.excerpt.truncateWords(20, "...")}
{post.categories.pluck("name").join(", ")}
{item.price.numberFormat(2)}
{this.meta.count.greater(0, "visible", "hidden")}
```

## Common Patterns

### Blog Post Card

```json
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
        "tag": "a",
        "attributes": {
          "href": "{post.permalink}",
          "class": "post-card__image-link"
        }
      },
      "innerBlocks": [
        {
          "blockName": "etch/element",
          "attrs": {
            "tag": "img",
            "attributes": {
              "src": "{post.featuredImage.url}",
              "alt": "{post.title}"
            }
          },
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
        "tag": "div",
        "attributes": { "class": "post-card__content" }
      },
      "innerBlocks": [
        {
          "blockName": "etch/element",
          "attrs": { "tag": "h3", "attributes": {} },
          "innerBlocks": [
            {
              "blockName": "etch/element",
              "attrs": {
                "tag": "a",
                "attributes": { "href": "{post.permalink}" }
              },
              "innerBlocks": [
                {
                  "blockName": "etch/text",
                  "attrs": { "content": "{post.title}" },
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
          "attrs": { "tag": "p", "attributes": { "class": "post-card__excerpt" } },
          "innerBlocks": [
            {
              "blockName": "etch/text",
              "attrs": { "content": "{post.excerpt.truncateWords(20, \"...\")}" },
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

### Posts Grid with Loop

```json
[
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "section",
      "attributes": { "class": "posts-grid" }
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
            "attrs": { "tag": "h2", "attributes": { "class": "section-title" } },
            "innerBlocks": [
              {
                "blockName": "etch/text",
                "attrs": { "content": "Latest Posts" },
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
              "tag": "div",
              "attributes": { "class": "posts-grid__items" }
            },
            "innerBlocks": [
              {
                "blockName": "etch/loop",
                "attrs": {
                  "loopId": "posts",
                  "loopParams": {
                    "$count": 6,
                    "$type": "\"post\""
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
                        "blockName": "etch/element",
                        "attrs": {
                          "tag": "img",
                          "attributes": {
                            "src": "{post.featuredImage.url}",
                            "alt": "{post.title}"
                          }
                        },
                        "innerBlocks": [],
                        "innerHTML": "",
                        "innerContent": []
                      },
                      {
                        "blockName": "etch/element",
                        "attrs": { "tag": "h3", "attributes": {} },
                        "innerBlocks": [
                          {
                            "blockName": "etch/text",
                            "attrs": { "content": "{post.title}" },
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

### Navigation with Dropdown

```json
{
  "blockName": "etch/element",
  "attrs": {
    "tag": "nav",
    "attributes": { "class": "main-nav" }
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "ul",
        "attributes": { "class": "nav-menu" }
      },
      "innerBlocks": [
        {
          "blockName": "etch/loop",
          "attrs": {
            "loopId": "nav",
            "itemId": "item",
            "indexId": "idx"
          },
          "innerBlocks": [
            {
              "blockName": "etch/element",
              "attrs": {
                "tag": "li",
                "attributes": { "class": "nav-item" }
              },
              "innerBlocks": [
                {
                  "blockName": "etch/element",
                  "attrs": {
                    "tag": "a",
                    "attributes": {
                      "href": "{item.url}",
                      "class": "{item.class}"
                    }
                  },
                  "innerBlocks": [
                    {
                      "blockName": "etch/text",
                      "attrs": { "content": "{item.label}" },
                      "innerBlocks": [],
                      "innerHTML": "",
                      "innerContent": []
                    }
                  ],
                  "innerHTML": "",
                  "innerContent": []
                },
                {
                  "blockName": "etch/condition",
                  "attrs": {
                    "conditionString": "item.children"
                  },
                  "innerBlocks": [
                    {
                      "blockName": "etch/element",
                      "attrs": {
                        "tag": "ul",
                        "attributes": { "class": "nav-dropdown" }
                      },
                      "innerBlocks": [
                        {
                          "blockName": "etch/loop",
                          "attrs": {
                            "target": "item.children",
                            "itemId": "child",
                            "indexId": "childIdx"
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
                                    "attributes": { "href": "{child.url}" }
                                  },
                                  "innerBlocks": [
                                    {
                                      "blockName": "etch/text",
                                      "attrs": { "content": "{child.label}" },
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

### Conditional Featured Badge

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "conditionString": "post.meta.is_featured === 'yes'"
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "span",
        "attributes": { "class": "badge badge--featured" }
      },
      "innerBlocks": [
        {
          "blockName": "etch/text",
          "attrs": { "content": "Featured" },
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
```

### Hero Section

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
          "attributes": { "class": "hero__container" }
        },
        "innerBlocks": [
          {
            "blockName": "etch/element",
            "attrs": {
              "tag": "div",
              "attributes": { "class": "hero__content" }
            },
            "innerBlocks": [
              {
                "blockName": "etch/element",
                "attrs": { "tag": "h1", "attributes": { "class": "hero__title" } },
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
                "attrs": { "tag": "p", "attributes": { "class": "hero__description" } },
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
                  "attributes": {
                    "href": "{this.meta.cta_link}",
                    "class": "btn btn--primary"
                  }
                },
                "innerBlocks": [
                  {
                    "blockName": "etch/text",
                    "attrs": { "content": "{this.meta.cta_text}" },
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
    ],
    "innerHTML": "",
    "innerContent": []
  }
]
```

## Best Practices

1. **Always wrap output in array brackets** - Even single blocks
2. **Use semantic HTML tags** - `section`, `article`, `nav`, `header`, `footer`
3. **Keep class names consistent** - Use BEM or similar methodology
4. **Use dynamic expressions** - Don't hardcode content that should be dynamic
5. **Use loops for repeating content** - Don't duplicate block structures
6. **Use conditions for optional content** - Hide/show based on data
7. **Keep nesting reasonable** - Don't nest deeper than necessary

## Output Requirements

1. Output ONLY valid JSON
2. JSON must be an array (even for single blocks)
3. All strings must be properly escaped
4. All blocks must have `innerHTML` and `innerContent` as empty strings/arrays
5. Dynamic expressions use curly braces: `{context.path}`
6. Loop parameters prefixed with `$` and string values double-quoted
