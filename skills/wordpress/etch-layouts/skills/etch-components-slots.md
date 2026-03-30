# Etch Components & Slots Skill

Complete guide to creating, using, and understanding Etch components (reusable patterns) and the slot system.

## Components Overview

Etch components are reusable block patterns stored as `wp_block` posts. They support:
- **Props** — Typed properties passed from parent to component
- **Slots** — Named content areas that can be filled by the parent
- **Context isolation** — Components have their own scope, preventing data leakage

## Creating a Component

### 1. Define the Pattern (wp_block Post)

Components are `wp_block` posts with Etch blocks as content. The pattern blocks define the component's structure:

```json
[
  {
    "blockName": "etch/element",
    "attrs": {
      "tag": "article",
      "attributes": { "class": "card" }
    },
    "innerBlocks": [
      {
        "blockName": "etch/element",
        "attrs": {
          "tag": "img",
          "attributes": {
            "src": "{props.image}",
            "alt": "{props.title}"
          }
        },
        "innerBlocks": [], "innerHTML": "", "innerContent": []
      },
      {
        "blockName": "etch/element",
        "attrs": { "tag": "h3", "attributes": {} },
        "innerBlocks": [
          {
            "blockName": "etch/text",
            "attrs": { "content": "{props.title}" },
            "innerBlocks": [], "innerHTML": "", "innerContent": []
          }
        ],
        "innerHTML": "", "innerContent": []
      },
      {
        "blockName": "etch/slot-placeholder",
        "attrs": { "name": "footer" },
        "innerBlocks": [], "innerHTML": "", "innerContent": []
      }
    ],
    "innerHTML": "", "innerContent": []
  }
]
```

### 2. Define Properties

Component properties are stored as `etch_component_properties` post meta on the `wp_block` post. Properties have:

| Field | Type | Description |
|-------|------|-------------|
| `key` | string | Property name (accessed as `props.key`) |
| `type` | string | Property type (`string`, `number`, `boolean`, `object`, `array`) |
| `default` | mixed | Default value if not provided |
| `required` | boolean | Whether the property must be provided |

### 3. Component Post Meta

| Meta Key | Purpose |
|----------|---------|
| `etch_component_properties` | Array of property definitions |
| `etch_component_html_key` | Unique HTML identifier for the component |
| `etch_component_legacy_id` | Legacy component ID (for migration) |

## Using a Component

### Basic Usage

```json
{
  "blockName": "etch/component",
  "attrs": {
    "ref": 123,
    "attributes": {
      "title": "My Card Title",
      "image": "https://example.com/image.jpg"
    }
  },
  "innerBlocks": [],
  "innerHTML": "",
  "innerContent": []
}
```

### With Dynamic Props

Props can use dynamic expressions that resolve against the parent context:

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

### With Slot Content

```json
{
  "blockName": "etch/component",
  "attrs": {
    "ref": 123,
    "attributes": {
      "title": "{post.title}"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/slot-content",
      "attrs": { "name": "footer" },
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
              "attrs": { "content": "Read More" },
              "innerBlocks": [], "innerHTML": "", "innerContent": []
            }
          ],
          "innerHTML": "", "innerContent": []
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

## Slot System

### How Slots Work

1. **Component definition** contains `etch/slot-placeholder` blocks marking where content can be inserted
2. **Component instance** contains `etch/slot-content` blocks providing the content
3. During rendering, `ComponentBlock` extracts slot contents and pushes them to `ComponentSlotContextProvider`
4. When `SlotPlaceholderBlock` renders, it looks up matching slot content by name

### Slot Context

**Critical:** Slot content renders with the **parent's** dynamic context, not the component's. This means:

```
Parent scope: { post: { title: "My Post" } }
Component scope: { props: { title: "Card Title" } }

Slot content can access: {post.title}  ✅ (parent scope)
Slot content cannot access: {props.title}  ❌ (component scope)
```

This prevents props leakage and ensures slot content behaves as if it's still in the parent's context.

### Checking Slot Emptiness

Inside a component, you can check if a slot has content:

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "isFalsy",
      "leftHand": "slots.footer.empty"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/slot-placeholder",
      "attrs": { "name": "footer" },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ]
}
```

### Recursion Guard

The `SlotPlaceholderBlock` has a recursion guard that prevents a slot from rendering itself through nested slot content. Each slot render is tracked by a guard key combining the component object ID and slot name.

## Component Rendering Pipeline

```
1. ComponentBlock::render_block() called
2. Get parent context sources (for resolving props)
3. Fetch pattern blocks from CachedPattern
4. Extract slot contents from innerBlocks
5. Capture parent dynamic entries (for slot rendering)
6. Resolve component attributes against parent context
7. ─── CONTEXT BOUNDARY ───
8. Clear dynamic context stack
9. Resolve properties (merge instance attrs with definitions/defaults)
10. Push "component" entry with key="props"
11. Push "component-slots" entry with key="slots"
12. Push slot context to ComponentSlotContextProvider
13. Render pattern blocks
14. ─── RESTORE ───
15. Pop slot context
16. Restore parent dynamic entries
17. Process shortcodes on output
```

## CachedPattern

Component patterns are cached per-request by `CachedPattern`:

```php
CachedPattern::get_pattern_parsed_blocks($ref_id)  // Returns parsed blocks
CachedPattern::get_pattern_properties($ref_id)       // Returns property definitions
```

The cache prevents repeated database lookups when the same component is used multiple times on a page.

## Component in a Loop

Common pattern: component inside a loop for repeated items:

```json
{
  "blockName": "etch/loop",
  "attrs": {
    "loopId": "posts",
    "loopParams": { "$count": 6 },
    "itemId": "post"
  },
  "innerBlocks": [
    {
      "blockName": "etch/component",
      "attrs": {
        "ref": 123,
        "attributes": {
          "title": "{post.title}",
          "image": "{post.featuredImage.url}",
          "link": "{post.permalink}",
          "excerpt": "{post.excerpt}"
        }
      },
      "innerBlocks": [],
      "innerHTML": "",
      "innerContent": []
    }
  ],
  "innerHTML": "",
  "innerContent": []
}
```

## Template Authoring Syntax

In the Etch builder, components and slots are authored using a Svelte-inspired template syntax rather than raw JSON.

### Component Authoring

```html
<!-- Self-closing component with string and boolean props -->
<SectionIntro style="Center" showPrimaryCta={true} showLede={false}
  sectionHeading="Our Process" headingLevel="h1" />

<!-- Component with slot children -->
<PricingCardBravo>
  {#slot features}
    <PricingCardBravoListItem />
    <PricingCardBravoListItem />
  {/slot}
</PricingCardBravo>
```

### Nested Slots

```html
<HeaderAlpha>
  {#slot nav}
    <FlexNav>
      {#slot topLevel}
        <FlexNavItem itemLabel="Home" itemLink="/" />
        <FlexNavDropdown dropdownTag="ul">
          {#slot menuContent}
            <FlexNavItem itemLabel="Dropdown" itemLink="#" />
          {/slot}
        </FlexNavDropdown>
      {/slot}
    </FlexNav>
  {/slot}
</HeaderAlpha>
```

### Properties Panel (Right Sidebar)

When a component is selected, the right sidebar displays **typed property fields**:

| Field Type | UI | Example |
|------------|------|--------|
| String | Text input | Heading, Label, URL |
| Boolean | Toggle switch | Show Lede, Include Skip Link |
| Select | Dropdown | Style: Center/Left/Right |
| Number | Numeric input | Price, Position |

These fields correspond to `etch_component_properties` post meta on the `wp_block` pattern post. Values entered here become the `attributes` object in the `etch/component` block JSON.

### Mixed HTML + Components

Sections commonly mix standard elements with component references:

```html
<section data-etch-element="section" class="feature-section">
  <div data-etch-element="container" class="feature__wrapper">
    <SectionIntro style="Center" showLede={true} />
  </div>
  <ul class="feature__list">
    <li class="feature__item">
      <FeatureCard />
    </li>
  </ul>
</section>
```

The `data-etch-element` attribute identifies the element's role in the builder's tree panel. The `data-etch-note` attribute provides editor-only annotations stripped from frontend output.

## Best Practices

1. **Define clear property types** — Use typed properties with defaults to make components self-documenting
2. **Use slots for flexible areas** — Slots allow parent to customize specific areas without prop explosion
3. **Keep components focused** — Each component should do one thing well
4. **Use descriptive prop names** — `title`, `image`, `link` not `a`, `b`, `c`
5. **Check slot emptiness** — Wrap slot placeholders in conditions to handle empty slots gracefully
6. **Remember context isolation** — Components clear the parent context; use props to pass data in
7. **Cache awareness** — Components are cached per-request; identical refs share the parsed pattern
