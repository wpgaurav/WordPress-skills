---
name: just-html
description: Build self-contained, drop-in HTML components (hero, pricing, features, testimonials, footer, etc.) that work inside any existing page without conflicts. Outputs a single code block with scoped CSS, semantic HTML, and minimal JS.
user_invocable: true
---

# Self-Contained HTML Component Builder

Build drop-in HTML sections that work inside any existing page without conflicts. One code block. No dependencies. No collisions.

## When to Use This Skill

- Building a standalone section (hero, pricing, features, testimonials, CTA, footer, etc.)
- Creating HTML for paste into WordPress Custom HTML blocks, Bricks code elements, GenerateBlocks containers, or raw PHP templates
- When the component must not interfere with existing page styles or scripts

## Step 1: Gather Requirements

Before writing any code, ask the user these questions (skip any already answered):

1. **What component?** — e.g., hero, pricing table, feature grid, testimonial carousel, FAQ accordion, footer
2. **Namespace prefix** — 2-4 letter prefix for all classes and CSS variables (e.g., `gh`, `gl`, `ai`). Default: first two letters of brand/project name
3. **Brand tokens** — Ask for CSS variables or hex values for: primary color, secondary color, text color, background color, border color, shadow. If not provided, use sensible defaults and note them
4. **Content** — Headings, body text, CTAs, card content, pricing tiers, testimonial quotes, etc. Ask for specifics based on the component type
5. **Design reference** — Any URL, screenshot, or description of the desired look. If none, build a clean modern default
6. **Special behavior** — Toggles, counters, text cycling, scroll animations, tabs? Default: static with hover states only

Once requirements are clear, proceed to build.

## Build Rules

### Structure
- Output a single code block containing: `<style>`, `<section>`, and `<script>` (if needed) in that order
- No `<!DOCTYPE>`, `<html>`, `<head>`, `<body>`, or `<meta>` tags
- No font imports or declarations (the host page handles fonts)
- No CSS resets beyond the component scope
- The `<section>` must have a unique class name: `[prefix]-[component]` (e.g., `brand-hero`, `brand-pricing`)

### CSS Scoping
- Define ALL design tokens as CSS custom properties on the section's root class, not on `:root`
- Prefix every custom property with a short namespace: `--[xx]-` (e.g., `--gh-primary`, `--gh-text`)
- Prefix every class name with the same short namespace: `[xx]-` (e.g., `gh-inner`, `gh-title`)
- Use `color-mix()` for derived colors (soft backgrounds, hovers, light borders) instead of hardcoded hex values
- Scope the universal box-sizing reset to the component: `.component *, .component *::before, .component *::after { box-sizing: border-box; }`
- Never use bare element selectors (h1, p, a, span). Always use prefixed classes
- All keyframe names must be prefixed to avoid collisions (e.g., `ghFadeUp` not `fadeUp`)

### HTML
- Use `<a>` tags for CTAs and navigation links, not `<button>` with onclick
- Use semantic HTML (section, nav, header) where appropriate
- Inline SVG for icons (no icon font dependencies)
- No external image URLs unless the user provides them. Use CSS, SVG, or Unicode for visual elements

### JavaScript
- Wrap everything in an IIFE: `(function(){ ... })();`
- No global variables or functions
- Use `document.querySelector` scoped to component classes
- Keep it minimal: counters, text cycling, scroll triggers. No frameworks
- Omit the `<script>` block entirely if the component is purely static

### Responsive
- Include breakpoints at 1100px, 768px, and 480px
- Progressively hide less important elements on smaller screens (don't just shrink everything)
- Stack layouts vertically on tablet and below
- Buttons go full-width on mobile

### What NOT to Include
- No Google Fonts or font-face declarations
- No normalize.css or reset.css
- No external JS libraries
- No localStorage or sessionStorage
- No fetch calls or API requests
- No comments explaining what CSS properties do (only section separators are fine)

## Override Pattern

Because tokens are CSS custom properties on the section class, the user can override from their theme stylesheet without touching the component:

```css
.brand-hero {
  --gh-primary: #2563EB;
}
```

## Output Format

Return the complete component as a single fenced code block (```html). No file splitting. No build steps. Copy-paste ready.
