---
name: svg-graphics
description: Create professional SVG graphics including data visualizations (pie charts, bar charts, line graphs, donut charts), flat illustrations (people, icons, objects, devices), dashboard mockups, marketing graphics, and infographics. Use when user requests charts, diagrams, illustrations, infographics, dashboards, marketing visuals, UI mockups, or any vector graphic. Outputs clean, scalable SVG code optimized for web use.
---

# SVG Graphics Creation

Create professional vector graphics directly in SVG code. Output clean, well-structured SVG that renders beautifully at any scale.

## Quick Reference

Select the appropriate pattern based on request type:

| Request Type | Reference File | Key Elements |
|-------------|----------------|--------------|
| Pie/donut charts | [data-viz.md](references/data-viz.md) | Arcs, segments, legends |
| Bar/column charts | [data-viz.md](references/data-viz.md) | Rectangles, axes, labels |
| Line/area charts | [data-viz.md](references/data-viz.md) | Paths, points, gradients |
| People illustrations | [illustrations.md](references/illustrations.md) | Simplified human forms |
| Icons and objects | [illustrations.md](references/illustrations.md) | Geometric shapes, paths |
| Dashboard mockups | [dashboards.md](references/dashboards.md) | Cards, metrics, mini-charts |
| Marketing graphics | [marketing.md](references/marketing.md) | Bold typography, gradients |
| Infographics | [infographics.md](references/infographics.md) | Combined elements, flow |
| Desktop/app UI mockups | [app-ui-mockups.md](references/app-ui-mockups.md) | Window chrome, sidebars, code diffs |
| SaaS product mockups | [product-ui-mockups.md](references/product-ui-mockups.md) | Floating panels, shadows, badges |
| Hand-drawn sketches | [sketch-explainers.md](references/sketch-explainers.md) | Wobbly lines, blue/red ink, notebook |
| Monoline icon systems | [monoline-icons.md](references/monoline-icons.md) | Uniform stroke, no fill, Apple style |
| Blog featured images | [featured-images.md](references/featured-images.md) | 2400x1260, FA icons, depth layers |

## Core SVG Structure

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 600">
  <defs>
    <!-- Gradients, patterns, filters -->
  </defs>
  <g id="background"><!-- Background elements --></g>
  <g id="content"><!-- Main content --></g>
  <g id="labels"><!-- Text labels --></g>
</svg>
```

## Color Palette System

**Default: Site Theme** (from `globals.css`). Use this unless the user specifies otherwise:

```
Primary:    #C0392B (red — brand color, CTAs, emphasis)
Secondary:  #2D3748 (dark blue-gray — headings, dark backgrounds)
Tertiary:   #16A085 (teal — success, positive indicators)
Action:     #2563EB (blue — links, interactive elements)
Accent:     #F59E0B (amber — warnings, highlights, badges)
Text:       #212121 (near-black — body text, labels)
Background: #FFFFFC (off-white — card/surface backgrounds)
Border:     #DDDDDD (light gray — borders, dividers)
```

Light tints (for backgrounds/fills): mix theme colors with white at 10-20% opacity.
Dark shades (for contrast): mix with `#2D3748` at 25-50%.

For additional palettes, see [colors.md](references/colors.md).
Limit to 2-3 colors per graphic unless design requires more.

## Typography

**Heading font** (titles, section headers):
```svg
<text font-family="'Really Sans Large', system-ui, sans-serif"
      font-size="28" font-weight="700" fill="#212121">Title</text>
```

**Body font** (labels, captions, body text):
```svg
<text font-family="'Really Sans Small', system-ui, sans-serif"
      font-size="14" fill="#212121">Label</text>
```

**Size hierarchy**: Titles 24-32px, subtitles 16-20px, labels 12-14px, captions 10-12px

**Font weight**: Use `font-weight` attribute (100-900). Both font families support variable weights.

**Background preference**: Default to light backgrounds (`#FFFFFC`, `#FFFFFE`, or light gradients). Only use dark backgrounds when explicitly requested.

## Icons — FontAwesome

When SVGs need icons (UI mockups, infographics, marketing graphics, dashboards), use FontAwesome.

### Local Installation (Preferred)

FontAwesome Pro is installed locally:

```
~/Icons/svgs/
├── solid/       (primary, filled style)
├── regular/     (outline style, lighter)
├── light/       (thinner outline style)
├── thin/        (thinnest outline style)
├── duotone/     (two-tone layered style)
├── sharp-solid/ (sharp corners, filled)
├── sharp-regular/ (sharp corners, outline)
├── sharp-light/ (sharp corners, light)
└── brands/      (WordPress, YouTube, GitHub, etc.)
```

**How to use:**
1. Read the `.svg` file to get the `<path d="...">` and `viewBox`
2. Embed inline using `<g>` with transform for positioning/scaling

```svg
<g transform="translate(100, 200) scale(0.08)">
  <path d="M0 64C0 28.7 28.7 0 64 0L352..." fill="#2D3748"/>
</g>
```

**Scaling math:** FontAwesome icons use large viewBoxes (typically `0 0 512 512` or `0 0 640 512`).
Formula: `scale = target_size / icon_viewbox_width`

| Target Size | Scale (512 vBox) | Scale (640 vBox) |
|-------------|-----------------|-----------------|
| 24px | 0.047 | 0.038 |
| 32px | 0.063 | 0.05 |
| 48px | 0.094 | 0.075 |
| 64px | 0.125 | 0.1 |
| 96px | 0.188 | 0.15 |

### GitHub Fallback

If local FA icons aren't available or you need a specific icon not in the local set, fetch from the FontAwesome GitHub repo:

```
https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/solid/{icon-name}.svg
https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/regular/{icon-name}.svg
https://raw.githubusercontent.com/FortAwesome/Font-Awesome/6.x/svgs/brands/{icon-name}.svg
```

Use WebFetch to grab the SVG content, then extract the `<path>` data and embed inline.

### Common Icons by Topic

| Topic | Solid Icons |
|-------|------------|
| Money / Income | `dollar-sign`, `money-bill`, `coins`, `piggy-bank`, `wallet`, `chart-line` |
| WordPress | `brands/wordpress`, `brands/wordpress-simple` |
| SEO | `magnifying-glass`, `chart-simple`, `arrow-trend-up` |
| Email | `envelope`, `paper-plane`, `at`, `inbox` |
| Tools | `screwdriver-wrench`, `gear`, `gears`, `toolbox`, `wand-magic-sparkles` |
| Speed | `bolt`, `gauge-high`, `rocket`, `stopwatch` |
| Security | `shield-halved`, `lock`, `key`, `user-shield` |
| Code / Dev | `code`, `terminal`, `bug`, `laptop-code`, `file-code` |
| AI | `robot`, `microchip`, `brain`, `wand-magic-sparkles` |
| Analytics | `chart-bar`, `chart-pie`, `chart-line`, `chart-area` |
| Design | `palette`, `paintbrush`, `swatchbook`, `pen-ruler` |
| Shopping | `cart-shopping`, `bag-shopping`, `tags`, `receipt` |
| Social | `brands/twitter`, `brands/youtube`, `brands/instagram`, `brands/linkedin` |

## Essential Techniques

### Rounded Rectangles
```svg
<rect x="10" y="10" width="100" height="50" rx="8" ry="8" fill="#2563eb"/>
```

### Arcs for Pie Charts
Calculate arc endpoints using: `x = cx + r * cos(angle)`, `y = cy + r * sin(angle)`
```svg
<path d="M cx cy L x1 y1 A r r 0 largeArc 1 x2 y2 Z" fill="#color"/>
```

### Smooth Curves
```svg
<path d="M 0 100 Q 50 50 100 100 T 200 100" stroke="#2563eb" fill="none"/>
```

### Drop Shadows
```svg
<defs>
  <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
    <feDropShadow dx="0" dy="4" stdDeviation="8" flood-opacity="0.1"/>
  </filter>
</defs>
<rect filter="url(#shadow)" .../>
```

## Mobile-Friendly SVG Rules

All SVGs must render well on mobile screens (375px width and up):

1. **Always use `viewBox`** — never set fixed `width`/`height` in pixels. Let the SVG scale.
2. **Minimum text size**: 12px equivalent at the viewBox scale. Anything smaller becomes unreadable on mobile.
3. **Touch-friendly spacing**: Keep interactive/important elements at least 44px apart (at rendered size).
4. **Test at 375px wide**: Mentally verify labels and key details remain legible when the SVG is scaled to mobile width.
5. **Prefer horizontal layouts** for banner/hero SVGs. Tall vertical compositions get tiny on mobile.
6. **Responsive embed**: When referencing SVGs in HTML, use `width="100%" height="auto"` or CSS `max-width: 100%`.
7. **Avoid tiny details** that disappear at small sizes — simplify strokes and small icons for mobile clarity.

## Output Guidelines

1. **Always include** `xmlns="http://www.w3.org/2000/svg"` and a `viewBox`
2. **Group related elements** using `<g>` with descriptive `id` attributes
3. **Use `<defs>`** for reusable elements, gradients, and filters
4. **Round numeric values** to 2 decimal places maximum
5. **Include readable whitespace** and indentation
6. **Add comments** for complex path data

## Execution Steps

1. Identify graphic type and read the appropriate reference file
2. Plan layout: dimensions, spacing, element positions
3. Define colors and gradients/filters in `<defs>`
4. Build structural elements (backgrounds, containers)
5. Add data elements (bars, slices, lines, illustrations)
6. Apply labels and text
7. Review spacing and alignment
8. Output as `.svg` file

For detailed patterns and examples, consult the reference files linked above.
