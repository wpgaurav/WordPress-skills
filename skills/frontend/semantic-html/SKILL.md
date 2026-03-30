---
name: semantic-html
description: Build semantic, accessible, framework-driven frontend interfaces in Builderius. Use when building pages, sections, layouts, components, or any visual design task in the Builderius builder. Covers landmark planning, heading hierarchy, proper tag selection, list patterns, forms, tables, and Collection loops.
---

# Builderius Semantic HTML

Write meaningful HTML through Builderius modules that serves all users and respects the web platform.

## When to Use This Skill

- Creating new sections or page layouts in the Builderius builder
- Reviewing existing module trees for semantic correctness
- Deciding which `tag` value to set on an HtmlElement module
- Structuring documents with proper heading hierarchy
- Building forms with SmartForm and proper labelling
- Creating data loops with Collection/Template modules
- Adding ARIA attributes to improve accessibility

## Before You Start

1. Call `builderius_builder_get_css_framework` to discover available classes and variables
2. Read `builderius://design-guidelines` for full methodology, CSS patterns, and data patterns
3. Read `builderius://modules-reference` for available module types

Framework classes → entity CSS → module CSS (cascade order).

## Builderius Module-to-HTML Mapping

Every HtmlElement module renders as the HTML tag defined in its `tag` setting. Choose the tag for semantic meaning, not visual appearance.

| Module Type | Renders As | Key Settings |
|-------------|-----------|--------------|
| HtmlElement (tag=section) | `<section>` | `tag`, `tagClass`, `htmlAttribute`, `content` |
| HtmlElement (tag=article) | `<article>` | Same as above |
| HtmlElement (tag=nav) | `<nav>` | Same — always add `aria-label` |
| HtmlElement (tag=header) | `<header>` | Same |
| HtmlElement (tag=footer) | `<footer>` | Same |
| HtmlElement (tag=main) | `<main>` | Same — only one per page |
| HtmlElement (tag=aside) | `<aside>` | Same |
| HtmlElement (tag=h1–h6) | `<h1>`–`<h6>` | `content` for heading text |
| HtmlElement (tag=img) | `<img>` | `mediaUrl` for src, void — no children |
| HtmlElement (tag=a) | `<a>` | `href` for link destination, `content` for text |
| HtmlElement (tag=button) | `<button>` | `content` for button text |
| Collection | `<div has="collection">` | `data-b-context` via htmlAttribute |
| Template | `<template>` | Loop wrapper — use `{{field}}` syntax inside |
| SmartForm | `<builderius-smart-form>` | `data-method`, `data-action` via htmlAttribute |
| HtmlCode | raw HTML injection | `contentHtml` — for SVG icons, embeds |
| SvgCode | raw SVG injection | `contentSvg` — for inline SVGs |
| Component | transparent wrapper | `componentName` — renders component content |

### Void Tags — Cannot Have Children

These tags are self-closing. Never nest child modules inside them:

`img`, `input`, `br`, `hr`, `textarea`, `embed`, `source`, `track`, `wbr`, `col`, `area`, `base`, `link`, `meta`, `param`

## Core Principles

### 1. Landmarks First

Before building individual components, plan the full page structure. This allows you to:

- Identify key landmarks for assistive technology users
- Plan heading hierarchy across the entire document
- Avoid overusing landmarks (which diminishes their usefulness)

**Standard Builderius page template structure:**

```
root
  HtmlElement tag=a          → Skip navigation link (class: skip-navigation)
  Component                  → Site Header (contains <header> and <nav>)
  HtmlElement tag=main       → Main content (id="content")
    HtmlElement tag=section  → Section 1 (aria-labelledby=heading-id)
    HtmlElement tag=section  → Section 2
    ...
  Component                  → Site Footer (contains <footer>)
```

**Landmark element guide:**

| Tag | Use When | Builderius Notes |
|-----|----------|-----------------|
| `main` | Primary page content | Only one per template. Add `id="content"` via `add_html_attribute`. |
| `header` | Page or section intro | Use for section intro areas, not just the site header. |
| `footer` | Page or section closing | Contact info, copyright, related links. |
| `nav` | Navigation sections | Must have `aria-label`. Never include "navigation" in the label. |
| `section` | Thematic grouping | Only becomes a landmark when labelled via `aria-labelledby`. |
| `article` | Self-contained content | Blog posts, movie cards, comments, product cards. |
| `aside` | Tangentially related | Sidebars, pull quotes, advertising. |
| `search` | Search functionality | Contains the search form, not the results. |

### 2. Native Over ARIA

If a native HTML tag provides the semantics you need, use it. Do not add ARIA to a generic `<div>` when a proper element exists.

**Red flags in a Builderius module tree:**
- Multiple HtmlElement modules with `tag=div` that should be `section`, `article`, `header`, `nav`, or `footer`
- `role` attributes on elements that already have native roles (e.g., `role="button"` on a `<button>`)
- High ARIA attribute count on non-complex components

**Decision tree:**

```
Need a section wrapper?
  → Does it have a heading? → tag=section + aria-labelledby
  → No heading? → tag=div (section without label = div semantically)

Need a card/post container?
  → Would it make sense standalone? → tag=article
  → Just grouping? → tag=div

Need a clickable element?
  → Navigates to URL? → tag=a with href
  → Performs action? → tag=button
  → NEVER tag=div with onclick behavior
```

### 3. Separation of Visual and Semantic Hierarchy

CSS classes control appearance. HTML tags control meaning. In Builderius:

- Set the **tag** based on document structure and meaning
- Set **tagClass** (via `add_module_class`) for visual styling
- Use framework CSS variables for consistent visual treatment
- Create entity-scoped CSS classes for section-specific layout

**Example:** A heading that needs to look small but is semantically `h2`:

```
Module: HtmlElement
  tag: h2                    → semantic level (correct for document outline)
  tagClass: [font-size-1]   → visual size (framework class for smaller text)
  content: Section Title
```

### 4. Content Realism

Design content is idealized. Real content is messy. When building modules:

- Account for long titles that wrap to multiple lines
- Handle missing optional fields (e.g., no featured image, empty excerpt)
- Support dynamic content from Collections that varies in length
- Test with real data via `get_dynamic_data` before finalizing layout

## Headings

### Heading Hierarchy Rules

1. **One `h1` per template** — typically the page/archive title
2. **Never skip levels** — `h1 → h3` is invalid; use `h1 → h2 → h3`
3. **Every `<section>` should start with a heading** that matches its `aria-labelledby`
4. **In Collection loops**, headings inside the Template inherit the context of their parent section

**Common Builderius heading structure:**

```
main
  section (aria-labelledby="movies-heading")
    h2#movies-heading "Latest Movies"         → section heading
    Collection (loop)
      Template
        article
          h3 "{{post_title}}"                 → item heading (one level below section)
  section (aria-labelledby="team-heading")
    h2#team-heading "Our Team"                → next section, same level
    ul
      li
        h3 "Person Name"                      → item heading
```

### Headings in Components

Builderius components are reusable. A component that contains a heading should:

1. **Use a configurable heading tag** — The component property can control which `h` level renders
2. **Document the expected context** — State what heading level the component assumes
3. **Default to a safe level** — `h3` is a common default for card-level components

### Visual Heading Without Semantic Heading

Sometimes text should look like a heading but not be one semantically. In Builderius:

```
Module: HtmlElement
  tag: p                     → NOT a heading semantically
  tagClass: [movies-title]   → CSS class provides heading-like appearance
  content: "Sale ends tomorrow!"
```

Use this pattern for eyebrow labels, promotional text, and decorative typography that don't introduce content sections.

## Lists

### When to Use Lists

Use lists when **knowing the count of items helps the user**:

- Navigation menus → `<ul>` (how many options?)
- Search results → `<ul>` (how many matches?)
- Steps in a process → `<ol>` (what order?)
- Glossary/metadata → `<dl>` (term-description pairs)

### Builderius List Patterns

**Static list:**
```
HtmlElement tag=ul (tagClass: [team-list], htmlAttribute: [role=list])
  HtmlElement tag=li (tagClass: [team-person])
    ...
  HtmlElement tag=li
    ...
```

**Dynamic list via Collection:**
```
Collection tag=ul (tagClass: [movies-grid], data-b-context="[[movies.posts_query.posts]]")
  Template
    HtmlElement tag=li
      HtmlElement tag=article
        ...
```

**Note:** When CSS `list-style: none` is applied, add `role="list"` via `add_html_attribute` to preserve list semantics in Safari/VoiceOver.

### Definition Lists

Use `<dl>` for metadata, key-value pairs, and glossaries:

```
HtmlElement tag=dl
  HtmlElement tag=dt — content: "Director"
  HtmlElement tag=dd — content: "Steven Spielberg"
  HtmlElement tag=dt — content: "Year"
  HtmlElement tag=dd — content: "1993"
```

## Interactive Elements

### Buttons vs Links

| Interaction | Use | Builderius Tag |
|-------------|-----|---------------|
| Navigate to a URL | Link | `tag=a` with `href` |
| Perform an action (submit, toggle, delete) | Button | `tag=button` |
| Navigate to a URL that also has a JS action | Link | `tag=a` with `href` (progressive enhancement) |
| Card that links to a detail page | Link wrapping content | `tag=a` wrapping the card, or `tag=article` with a link inside |

**Never** use `tag=div` with a click handler for actions. Use `tag=button` or `tag=a`.

### The Details/Summary Pattern

For progressive disclosure (FAQ, expandable sections):

```
HtmlElement tag=details
  HtmlElement tag=summary — content: "How do I cancel my subscription?"
  HtmlElement tag=p — content: "You can cancel anytime from your account settings..."
```

## Forms

### SmartForm Module

For forms in Builderius, use the SmartForm module:

```
SmartForm (data-method="post", data-action="/contact", aria-label="Contact form")
  HtmlElement tag=div (tagClass: [field-group])
    HtmlElement tag=label — content: "Email", htmlAttribute: [for=email-input]
    HtmlElement tag=input — htmlAttribute: [type=email, id=email-input, name=email, required, aria-required=true]
  HtmlElement tag=button — content: "Submit"
```

### Label Rules

1. **Always use a `<label>` element.** No exceptions.
2. **Never rely on placeholder text as a label.** Placeholders disappear on input.
3. **Never use `aria-label` when a proper `<label>` element works.**
4. **Visually hidden labels are acceptable** when design requires it — use a CSS class that hides visually but remains accessible.

### Error Messages

```
HtmlElement tag=label — content: "Email", htmlAttribute: [for=email]
HtmlElement tag=input — htmlAttribute: [
  type=email,
  id=email,
  aria-invalid=true,
  aria-describedby=email-error
]
HtmlElement tag=p — content: "Enter a valid email address", htmlAttribute: [id=email-error, role=alert]
```

### Fieldset/Legend for Grouping

Use for thematic groups of fields:

```
HtmlElement tag=fieldset
  HtmlElement tag=legend — content: "Shipping Address"
  (form fields...)
```

## Tables

### When to Use Tables

Use a table when data has **meaningful relationships in both dimensions** — each row has the same columns, and data within each column is of the same type.

**Do NOT use tables for:**
- Simple lists (one dimension) → use `<ul>`
- Key-value pairs → use `<dl>`
- Form layouts → use proper form elements
- Visual grids of cards → use CSS grid with `<ul>` or `<div>`

### Table Semantic Baseline

```
HtmlElement tag=table
  HtmlElement tag=caption — content: "Quarterly Sales Report"
  HtmlElement tag=thead
    HtmlElement tag=tr
      HtmlElement tag=th — content: "Product", htmlAttribute: [scope=col]
      HtmlElement tag=th — content: "Q1", htmlAttribute: [scope=col]
  HtmlElement tag=tbody
    HtmlElement tag=tr
      HtmlElement tag=th — content: "Widget A", htmlAttribute: [scope=row]
      HtmlElement tag=td — content: "$10,000"
```

Always include: `<caption>`, `<thead>/<tbody>`, and `<th>` with `scope` attribute.

## Collection Loops

### Standard Loop Pattern

```
Collection (data-b-context="[[movies.posts_query.posts]]", tagClass: [movies-grid])
  Template
    HtmlElement tag=article (tagClass: [movie-card])
      HtmlElement tag=img — htmlAttribute: [src={{{featured_image.file_url}}}, alt={{post_title}}]
      HtmlElement tag=h3
        HtmlElement tag=a — href: {{{permalink}}}, content: {{post_title}}
      HtmlElement tag=p — content: {{post_excerpt}}
```

### Variable Syntax

| Syntax | Scope | Escaping |
|--------|-------|----------|
| `[[var]]` | Template-level data variable | HTML-escaped |
| `[[[var]]]` | Template-level data variable | Unescaped (for URLs, HTML) |
| `{{field}}` | Loop-local field (inside Collection/Template) | HTML-escaped |
| `{{{field}}}` | Loop-local field | Unescaped (for URLs, HTML, image sources) |

**Rules:**
- Use `{{{...}}}` (unescaped) for URLs in `href` and `src` attributes
- Use `{{...}}` (escaped) for visible text content
- Template-level `[[...]]` is accessible everywhere; loop-local `{{...}}` only inside a Template

### Nested Loops (SubCollection)

For nested arrays (e.g., categories within a post):

```
Collection (data-b-context="[[posts]]")
  Template
    HtmlElement tag=article
      HtmlElement tag=h3 — content: {{title}}
      SubCollection (data-source={{categories}})
        Template
          HtmlElement tag=span — content: {{name}}
```

## HtmlCode and SvgCode

Use these for raw code injection when Builderius modules are insufficient:

- **HtmlCode**: For complex HTML that can't be built with modules (e.g., icon SVGs inside links)
- **SvgCode**: For inline SVGs

**Critical:** These are leaf modules — no children, no `htmlAttribute` setting. All content goes in `contentHtml` or `contentSvg`.

**When using HtmlCode for icons inside links:**
- Add `aria-hidden="true"` to decorative SVGs within the `contentHtml`
- Add `aria-label` to the parent link/button module to provide an accessible name
- Include a visually hidden text span if the icon conveys meaning

## Module Review Checklist

### Positive Signals

- [ ] Landmark elements used for page structure (main, header, footer, nav, section, article)
- [ ] Logical heading hierarchy (h1 → h2 → h3, no skips)
- [ ] Sections have `aria-labelledby` pointing to their heading's `id`
- [ ] Images have meaningful `alt` text (not just the filename)
- [ ] Links have descriptive text (not "click here" or "read more" alone)
- [ ] Lists use `<ul>/<ol>` with `<li>` (not divs)
- [ ] Forms have proper `<label>` elements
- [ ] Collection loops use semantic wrappers (article, li)
- [ ] Framework CSS classes used before custom CSS
- [ ] CSS variables used for all visual tokens

### Warning Signs

- [ ] High div count where semantic elements should be used
- [ ] Heading levels chosen for visual size rather than structure
- [ ] Images without `alt` attributes
- [ ] Links with no accessible text (icon-only without aria-label)
- [ ] Forms using placeholder text as labels
- [ ] `role` attributes on elements that already have native semantics
- [ ] Per-module `css` setting used as primary styling method
- [ ] Hardcoded color/spacing values instead of CSS variables

## References

- [HTML Living Standard: Sections](https://html.spec.whatwg.org/dev/sections.html)
- [MDN: ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA)
- [Builderius Modules Reference](builderius://modules-reference)
- See `references/heading-patterns.md` for component heading strategies
