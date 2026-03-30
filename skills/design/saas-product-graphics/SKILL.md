---
name: saas-product-graphics
description: Create polished SaaS product UI showcase graphics in SVG. Floating panels, soft shadows, modern gradients, clean typography. Use for landing pages, feature showcases, product marketing, app store screenshots, and hero sections. Output professional, modern visuals that look like Figma/Sketch exports.
---

# SaaS Product Graphics

Create SVG graphics that showcase product UI with floating panels, soft shadows, and modern SaaS aesthetics. Think Notion, Linear, Figma marketing pages.

**Key principle**: Clean, professional, intentionally designed. Every shadow, gradient, and spacing choice is deliberate.

## When to Use

- Product landing page heroes
- Feature showcase sections
- App store screenshots
- Product Hunt graphics
- Blog featured images (product-focused)
- Social media product announcements
- Investor deck visuals
- Documentation hero images
- Changelog graphics
- Onboarding illustrations

Best for showing **product UI, features, or workflows** in marketing context.

## Quick Reference

| Pattern | Use Case | Key Elements |
|---------|----------|--------------|
| Floating Panels | Feature showcase | Multiple overlapping UI panels at angles |
| App Screenshot | Hero section | Single prominent UI with subtle background |
| Feature Grid | Multiple features | Grid of UI snippets with labels |
| Workflow | Process visualization | Connected UI states with arrows |
| Before/After | Transformation | Side-by-side UI comparison |
| Dashboard | Data/analytics | Charts, metrics, data visualization |

---

## Core Visual Rules

### Canvas

- Light gradient background (subtle warm or cool tones)
- Optional: faint dot grid or line grid pattern
- Optional: abstract geometric shapes (circles, blobs) in background
- Clean, spacious composition
- Typical sizes: 1200x630 (OG), 1920x1080 (hero), 800x600 (feature)

### Color Palette

**Default: Site Theme.** Use these unless the user specifies otherwise:

| Element | Colors | Notes |
|---------|--------|-------|
| Background | `#FFFFFC` to `#f0f4f8` | Off-white to light neutral gradient |
| Background accent | `#e8f4fd`, `#fef3e8` | Subtle colored regions |
| Panel background | `#ffffff` | Pure white for UI panels |
| Panel border | `#DDDDDD`, `#d1d5db` | Subtle borders |
| Primary accent | `#C0392B` | Brand red — CTAs, emphasis |
| Secondary accent | `#2563EB` | Blue — links, interactive elements |
| Tertiary accent | `#16A085` | Teal — success, positive |
| Text dark | `#212121`, `#2D3748` | Headings, primary text |
| Text muted | `#6b7280`, `#9ca3af` | Secondary text, labels |
| Shadow | `rgba(0,0,0,0.08)` to `rgba(0,0,0,0.15)` | Soft, diffuse shadows |
| Selection | `#2563EB` with `0.1` opacity fill | Blue dashed border |

### Shadow System

```css
/* Floating panel shadow - soft and diffuse */
box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1),
            0 2px 4px -2px rgba(0, 0, 0, 0.1);

/* Elevated panel shadow - more prominent */
box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1),
            0 4px 6px -4px rgba(0, 0, 0, 0.1);

/* Card hover shadow */
box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1),
            0 8px 10px -6px rgba(0, 0, 0, 0.1);
```

### Typography

- **Font**: InterVariable/Inter — matches site theme
  - Primary: `'InterVariable', 'Inter', sans-serif`
  - Monospace: `'SF Mono', 'Fira Code', monospace`
- **Weights**: 400 (regular), 500 (medium), 600 (semibold). InterVariable supports variable weights.
- **Sizes**:
  - Panel title: 14-16px
  - Body text: 12-14px
  - Labels: 10-12px
  - Small: 9-10px

### Border Radius

| Element | Radius |
|---------|--------|
| Large panels | 12-16px |
| Cards | 8-12px |
| Buttons | 6-8px |
| Inputs | 4-6px |
| Tags/badges | 4px or full (pill) |

---

## SVG Structure Template

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 630">
  <defs>
    <!-- Gradients -->
    <linearGradient id="bg-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#fafbfc"/>
      <stop offset="100%" stop-color="#f0f4f8"/>
    </linearGradient>

    <linearGradient id="accent-gradient" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#3b82f6"/>
      <stop offset="100%" stop-color="#8b5cf6"/>
    </linearGradient>

    <!-- Panel shadow filter -->
    <filter id="panel-shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="4" stdDeviation="8" flood-color="#000" flood-opacity="0.1"/>
      <feDropShadow dx="0" dy="2" stdDeviation="4" flood-color="#000" flood-opacity="0.06"/>
    </filter>

    <!-- Elevated shadow filter -->
    <filter id="elevated-shadow" x="-30%" y="-30%" width="160%" height="160%">
      <feDropShadow dx="0" dy="10" stdDeviation="15" flood-color="#000" flood-opacity="0.1"/>
      <feDropShadow dx="0" dy="4" stdDeviation="6" flood-color="#000" flood-opacity="0.08"/>
    </filter>

    <!-- Dot grid pattern -->
    <pattern id="dot-grid" width="20" height="20" patternUnits="userSpaceOnUse">
      <circle cx="10" cy="10" r="1" fill="#d1d5db" opacity="0.5"/>
    </pattern>

    <!-- Selection pattern (dashed) -->
    <pattern id="selection-dash" width="8" height="8" patternUnits="userSpaceOnUse">
      <rect width="4" height="8" fill="#3b82f6"/>
    </pattern>
  </defs>

  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#bg-gradient)"/>

  <!-- Optional: dot grid overlay -->
  <rect width="100%" height="100%" fill="url(#dot-grid)" opacity="0.3"/>

  <!-- Optional: background accent shapes -->
  <g id="bg-accents" opacity="0.5">
    <circle cx="100" cy="100" r="200" fill="#e8f4fd"/>
    <circle cx="1100" cy="500" r="150" fill="#fef3e8"/>
  </g>

  <!-- Main content area -->
  <g id="panels">
    <!-- Primary panel -->
    <g id="panel-main" filter="url(#elevated-shadow)">
      <rect x="300" y="100" width="600" height="400" rx="12" fill="#fff"/>
      <!-- Panel content here -->
    </g>

    <!-- Secondary floating panel -->
    <g id="panel-secondary" filter="url(#panel-shadow)">
      <rect x="150" y="200" width="200" height="250" rx="10" fill="#fff"/>
      <!-- Panel content here -->
    </g>

    <!-- Tertiary floating panel -->
    <g id="panel-tertiary" filter="url(#panel-shadow)">
      <rect x="850" y="150" width="180" height="200" rx="10" fill="#fff"/>
      <!-- Panel content here -->
    </g>
  </g>

  <!-- Selection indicator (dashed box) -->
  <rect x="400" y="250" width="300" height="120" rx="8"
        fill="rgba(59, 130, 246, 0.05)"
        stroke="#3b82f6" stroke-width="2" stroke-dasharray="6 4"/>
</svg>
```

---

## Component Library

### Panel / Card

```svg
<!-- Basic panel with shadow -->
<g filter="url(#panel-shadow)">
  <rect x="100" y="100" width="300" height="200" rx="12" fill="#fff"/>
  <!-- Optional border -->
  <rect x="100" y="100" width="300" height="200" rx="12" fill="none" stroke="#e5e7eb" stroke-width="1"/>
</g>

<!-- Panel with header -->
<g filter="url(#panel-shadow)">
  <rect x="100" y="100" width="300" height="200" rx="12" fill="#fff"/>
  <!-- Header bar -->
  <rect x="100" y="100" width="300" height="40" rx="12" fill="#f9fafb"/>
  <rect x="100" y="128" width="300" height="12" fill="#f9fafb"/>
  <!-- Header text -->
  <text x="120" y="126" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="600" fill="#374151">Panel Title</text>
  <!-- Window controls -->
  <circle cx="130" cy="120" r="5" fill="#ef4444"/>
  <circle cx="148" cy="120" r="5" fill="#f59e0b"/>
  <circle cx="166" cy="120" r="5" fill="#22c55e"/>
</g>
```

### Buttons

```svg
<!-- Primary button -->
<g>
  <rect x="100" y="100" width="120" height="36" rx="6" fill="#3b82f6"/>
  <text x="160" y="123" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#fff" text-anchor="middle">Button</text>
</g>

<!-- Secondary button -->
<g>
  <rect x="100" y="100" width="120" height="36" rx="6" fill="#fff" stroke="#d1d5db" stroke-width="1"/>
  <text x="160" y="123" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#374151" text-anchor="middle">Button</text>
</g>

<!-- Ghost button -->
<g>
  <rect x="100" y="100" width="120" height="36" rx="6" fill="transparent"/>
  <text x="160" y="123" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#6b7280" text-anchor="middle">Button</text>
</g>

<!-- Gradient button -->
<g>
  <rect x="100" y="100" width="120" height="36" rx="6" fill="url(#accent-gradient)"/>
  <text x="160" y="123" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#fff" text-anchor="middle">Button</text>
</g>
```

### Input Fields

```svg
<!-- Text input -->
<g>
  <rect x="100" y="100" width="200" height="36" rx="6" fill="#fff" stroke="#d1d5db" stroke-width="1"/>
  <text x="112" y="123" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#9ca3af">Placeholder text...</text>
</g>

<!-- Focused input -->
<g>
  <rect x="100" y="100" width="200" height="36" rx="6" fill="#fff" stroke="#3b82f6" stroke-width="2"/>
  <text x="112" y="123" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#1e293b">User input</text>
</g>

<!-- Input with icon -->
<g>
  <rect x="100" y="100" width="200" height="36" rx="6" fill="#fff" stroke="#d1d5db" stroke-width="1"/>
  <!-- Search icon placeholder -->
  <circle cx="120" cy="118" r="7" fill="none" stroke="#9ca3af" stroke-width="1.5"/>
  <line x1="125" y1="123" x2="130" y2="128" stroke="#9ca3af" stroke-width="1.5"/>
  <text x="140" y="123" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#9ca3af">Search...</text>
</g>
```

### List Items

```svg
<!-- Simple list item -->
<g>
  <rect x="100" y="100" width="250" height="44" rx="6" fill="#fff"/>
  <circle cx="124" cy="122" r="12" fill="#e5e7eb"/>
  <text x="148" y="118" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1e293b">List Item Title</text>
  <text x="148" y="134" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#6b7280">Description text</text>
</g>

<!-- List item with icon -->
<g>
  <rect x="100" y="100" width="250" height="44" rx="6" fill="#fff"/>
  <rect x="112" cy="110" width="24" height="24" rx="4" fill="#e8f4fd"/>
  <!-- Icon placeholder -->
  <text x="124" y="127" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#3b82f6" text-anchor="middle">A</text>
  <text x="148" y="126" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1e293b">Text</text>
</g>

<!-- Selected list item -->
<g>
  <rect x="100" y="100" width="250" height="44" rx="6" fill="#eff6ff"/>
  <rect x="100" y="100" width="3" height="44" fill="#3b82f6"/>
  <text x="120" y="126" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1e293b">Selected Item</text>
</g>
```

### Dropdown Menu

```svg
<g filter="url(#panel-shadow)">
  <rect x="100" y="100" width="180" height="160" rx="8" fill="#fff"/>

  <!-- Menu items -->
  <g>
    <rect x="108" y="108" width="164" height="32" rx="4" fill="#f3f4f6"/>
    <text x="120" y="129" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#1e293b">Option 1</text>
  </g>
  <g>
    <text x="120" y="161" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Option 2</text>
  </g>
  <g>
    <text x="120" y="193" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Option 3</text>
  </g>
  <g>
    <text x="120" y="225" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Option 4</text>
  </g>
</g>
```

### Tags / Badges

```svg
<!-- Solid badge -->
<g>
  <rect x="100" y="100" width="60" height="22" rx="4" fill="#dbeafe"/>
  <text x="130" y="115" font-family="InterVariable, Inter, sans-serif" font-size="11" font-weight="500" fill="#1d4ed8" text-anchor="middle">Badge</text>
</g>

<!-- Pill badge -->
<g>
  <rect x="100" y="100" width="60" height="22" rx="11" fill="#f3f4f6"/>
  <text x="130" y="115" font-family="InterVariable, Inter, sans-serif" font-size="11" font-weight="500" fill="#374151" text-anchor="middle">Label</text>
</g>

<!-- Status badge (success) -->
<g>
  <rect x="100" y="100" width="70" height="22" rx="11" fill="#dcfce7"/>
  <circle cx="115" cy="111" r="4" fill="#22c55e"/>
  <text x="140" y="115" font-family="InterVariable, Inter, sans-serif" font-size="11" font-weight="500" fill="#166534" text-anchor="middle">Active</text>
</g>
```

### Icons (Simplified)

```svg
<!-- Menu icon (hamburger) -->
<g stroke="#6b7280" stroke-width="2" stroke-linecap="round">
  <line x1="100" y1="108" x2="120" y2="108"/>
  <line x1="100" y1="115" x2="120" y2="115"/>
  <line x1="100" y1="122" x2="120" y2="122"/>
</g>

<!-- Checkbox (unchecked) -->
<rect x="100" y="100" width="18" height="18" rx="4" fill="#fff" stroke="#d1d5db" stroke-width="1.5"/>

<!-- Checkbox (checked) -->
<g>
  <rect x="100" y="100" width="18" height="18" rx="4" fill="#3b82f6"/>
  <path d="M105 109 L108 112 L114 106" stroke="#fff" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
</g>

<!-- Radio (unselected) -->
<circle cx="109" cy="109" r="8" fill="#fff" stroke="#d1d5db" stroke-width="1.5"/>

<!-- Radio (selected) -->
<g>
  <circle cx="109" cy="109" r="8" fill="#fff" stroke="#3b82f6" stroke-width="1.5"/>
  <circle cx="109" cy="109" r="4" fill="#3b82f6"/>
</g>

<!-- Toggle (off) -->
<g>
  <rect x="100" y="104" width="36" height="20" rx="10" fill="#e5e7eb"/>
  <circle cx="114" cy="114" r="7" fill="#fff" filter="url(#panel-shadow)"/>
</g>

<!-- Toggle (on) -->
<g>
  <rect x="100" y="104" width="36" height="20" rx="10" fill="#3b82f6"/>
  <circle cx="122" cy="114" r="7" fill="#fff" filter="url(#panel-shadow)"/>
</g>

<!-- Close (X) -->
<g stroke="#6b7280" stroke-width="2" stroke-linecap="round">
  <line x1="100" y1="100" x2="116" y2="116"/>
  <line x1="116" y1="100" x2="100" y2="116"/>
</g>

<!-- Plus -->
<g stroke="#6b7280" stroke-width="2" stroke-linecap="round">
  <line x1="100" y1="108" x2="116" y2="108"/>
  <line x1="108" y1="100" x2="108" y2="116"/>
</g>

<!-- Arrow right -->
<path d="M100 108 L110 108 M106 104 L110 108 L106 112" stroke="#6b7280" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>

<!-- Chevron down -->
<path d="M100 106 L108 114 L116 106" stroke="#6b7280" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
```

### Charts (Simplified)

```svg
<!-- Bar chart -->
<g>
  <rect x="110" y="160" width="30" height="60" rx="4" fill="#3b82f6"/>
  <rect x="150" y="140" width="30" height="80" rx="4" fill="#3b82f6"/>
  <rect x="190" y="100" width="30" height="120" rx="4" fill="#3b82f6"/>
  <rect x="230" y="130" width="30" height="90" rx="4" fill="#3b82f6"/>
</g>

<!-- Line chart -->
<g>
  <polyline points="100,180 140,150 180,160 220,120 260,100"
            fill="none" stroke="#3b82f6" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  <!-- Area fill -->
  <path d="M100,180 L140,150 L180,160 L220,120 L260,100 L260,200 L100,200 Z"
        fill="url(#accent-gradient)" opacity="0.1"/>
  <!-- Data points -->
  <circle cx="100" cy="180" r="4" fill="#3b82f6"/>
  <circle cx="140" cy="150" r="4" fill="#3b82f6"/>
  <circle cx="180" cy="160" r="4" fill="#3b82f6"/>
  <circle cx="220" cy="120" r="4" fill="#3b82f6"/>
  <circle cx="260" cy="100" r="4" fill="#3b82f6"/>
</g>

<!-- Donut chart -->
<g transform="translate(150, 150)">
  <circle cx="0" cy="0" r="50" fill="none" stroke="#e5e7eb" stroke-width="15"/>
  <circle cx="0" cy="0" r="50" fill="none" stroke="#3b82f6" stroke-width="15"
          stroke-dasharray="188 314" stroke-dashoffset="0" transform="rotate(-90)"/>
  <text x="0" y="5" font-family="InterVariable, Inter, sans-serif" font-size="18" font-weight="600" fill="#1e293b" text-anchor="middle">60%</text>
</g>
```

### Selection Indicator

```svg
<!-- Dashed selection box -->
<rect x="100" y="100" width="200" height="100" rx="8"
      fill="rgba(59, 130, 246, 0.05)"
      stroke="#3b82f6" stroke-width="2" stroke-dasharray="8 4"/>

<!-- With resize handles -->
<g>
  <rect x="100" y="100" width="200" height="100" rx="8"
        fill="rgba(59, 130, 246, 0.05)"
        stroke="#3b82f6" stroke-width="2" stroke-dasharray="8 4"/>
  <!-- Corner handles -->
  <circle cx="100" cy="100" r="4" fill="#fff" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="300" cy="100" r="4" fill="#fff" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="100" cy="200" r="4" fill="#fff" stroke="#3b82f6" stroke-width="2"/>
  <circle cx="300" cy="200" r="4" fill="#fff" stroke="#3b82f6" stroke-width="2"/>
</g>

<!-- Cursor pointer -->
<g transform="translate(250, 150)">
  <path d="M0 0 L0 20 L5 16 L9 24 L12 23 L8 15 L14 15 Z" fill="#1e293b"/>
</g>
```

---

## Layout Patterns

### Floating Panels (Hero Style)

```
    +---------------------------+
    |  Main Product UI Panel    |
    |                           |
    +---------------------------+
            /           \
   +-------+             +-------+
   | Menu  |             | Side  |
   | Panel |             | Panel |
   +-------+             +-------+
```

- Main panel is largest, centered, elevated shadow
- Secondary panels overlap edges, smaller shadows
- Panels at slight angles (1-3 degrees rotation)
- Space for breathing room between elements

### App Screenshot (Clean)

```
+------------------------------------------+
|  Browser chrome / app frame              |
+------------------------------------------+
|                                          |
|           Product UI Content             |
|                                          |
|                                          |
+------------------------------------------+
```

- Optional browser chrome (URL bar, buttons)
- Full-width panel with elevated shadow
- Content fills the frame
- Subtle background gradient behind

### Feature Grid

```
+--------+  +--------+  +--------+
| Feat 1 |  | Feat 2 |  | Feat 3 |
+--------+  +--------+  +--------+

+--------+  +--------+  +--------+
| Feat 4 |  | Feat 5 |  | Feat 6 |
+--------+  +--------+  +--------+
```

- Equal-sized panels in grid
- Consistent spacing (24-32px gaps)
- Each panel shows a UI snippet
- Optional labels below each panel

### Workflow Visualization

```
+--------+        +--------+        +--------+
| Step 1 | -----> | Step 2 | -----> | Step 3 |
+--------+        +--------+        +--------+
```

- Panels connected with arrows or lines
- Gradient or colored connector lines
- Sequential left-to-right or top-to-bottom
- Progress indicators optional

---

## Complete Example: Form Builder Showcase

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 700">
  <defs>
    <!-- Background gradient -->
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#fafbfc"/>
      <stop offset="100%" stop-color="#f0f4f8"/>
    </linearGradient>

    <!-- Blue accent gradient -->
    <linearGradient id="blue-accent" x1="0%" y1="0%" x2="100%" y2="0%">
      <stop offset="0%" stop-color="#3b82f6"/>
      <stop offset="100%" stop-color="#60a5fa"/>
    </linearGradient>

    <!-- Panel shadow -->
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="4" stdDeviation="12" flood-color="#000" flood-opacity="0.08"/>
      <feDropShadow dx="0" dy="2" stdDeviation="4" flood-color="#000" flood-opacity="0.04"/>
    </filter>

    <!-- Elevated shadow -->
    <filter id="shadow-lg" x="-30%" y="-30%" width="160%" height="160%">
      <feDropShadow dx="0" dy="12" stdDeviation="24" flood-color="#000" flood-opacity="0.1"/>
      <feDropShadow dx="0" dy="4" stdDeviation="8" flood-color="#000" flood-opacity="0.06"/>
    </filter>

    <!-- Dot pattern -->
    <pattern id="dots" width="24" height="24" patternUnits="userSpaceOnUse">
      <circle cx="12" cy="12" r="1" fill="#cbd5e1" opacity="0.4"/>
    </pattern>
  </defs>

  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#bg)"/>
  <rect width="100%" height="100%" fill="url(#dots)"/>

  <!-- Background accent blobs -->
  <ellipse cx="150" cy="200" rx="200" ry="150" fill="#dbeafe" opacity="0.3"/>
  <ellipse cx="1050" cy="500" rx="180" ry="140" fill="#fef3c7" opacity="0.3"/>

  <!-- Left sidebar panel - Template categories -->
  <g filter="url(#shadow)" transform="translate(80, 150)">
    <rect width="220" height="380" rx="12" fill="#fff"/>

    <!-- Header -->
    <text x="20" y="35" font-family="InterVariable, Inter, sans-serif" font-size="14" font-weight="600" fill="#1e293b">Create new form</text>

    <!-- Template options -->
    <g transform="translate(16, 55)">
      <!-- Blank Form -->
      <g>
        <rect width="188" height="48" rx="8" fill="#f0fdf4"/>
        <rect x="12" y="12" width="24" height="24" rx="6" fill="#22c55e"/>
        <text x="27" y="28" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#fff" text-anchor="middle">+</text>
        <text x="48" y="24" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1e293b">Blank Form</text>
        <text x="48" y="40" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#6b7280">Create a new view from scratch</text>
      </g>

      <!-- Survey template -->
      <g transform="translate(0, 60)">
        <rect width="188" height="48" rx="8" fill="#fff"/>
        <rect x="12" y="12" width="24" height="24" rx="6" fill="#3b82f6"/>
        <text x="48" y="28" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1e293b">Survey and Polls</text>
        <text x="48" y="40" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#6b7280">11 templates | 6 available</text>
        <path d="M170 24 L176 30 L170 36" stroke="#9ca3af" stroke-width="2" fill="none" stroke-linecap="round"/>
      </g>

      <!-- Users info template -->
      <g transform="translate(0, 115)">
        <rect width="188" height="48" rx="8" fill="#fff"/>
        <rect x="12" y="12" width="24" height="24" rx="6" fill="#8b5cf6"/>
        <text x="48" y="28" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1e293b">Users info</text>
        <text x="48" y="40" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#6b7280">11 templates | 4 available</text>
        <path d="M170 24 L176 30 L170 36" stroke="#9ca3af" stroke-width="2" fill="none" stroke-linecap="round"/>
      </g>

      <!-- Listings template -->
      <g transform="translate(0, 170)">
        <rect width="188" height="48" rx="8" fill="#fff"/>
        <rect x="12" y="12" width="24" height="24" rx="6" fill="#06b6d4"/>
        <text x="48" y="28" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1e293b">Listings</text>
        <text x="48" y="40" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#6b7280">11 templates</text>
        <path d="M170 24 L176 30 L170 36" stroke="#9ca3af" stroke-width="2" fill="none" stroke-linecap="round"/>
      </g>

      <!-- Calculators -->
      <g transform="translate(0, 225)">
        <rect width="188" height="48" rx="8" fill="#fff"/>
        <rect x="12" y="12" width="24" height="24" rx="6" fill="#f59e0b"/>
        <text x="48" y="28" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1e293b">Calculators</text>
        <text x="48" y="40" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#6b7280">11 templates</text>
        <path d="M170 24 L176 30 L170 36" stroke="#9ca3af" stroke-width="2" fill="none" stroke-linecap="round"/>
      </g>
    </g>
  </g>

  <!-- Center field picker dropdown -->
  <g filter="url(#shadow)" transform="translate(320, 120)">
    <rect width="180" height="300" rx="10" fill="#fff"/>

    <!-- Field types -->
    <g transform="translate(12, 12)">
      <g>
        <text x="24" y="16" font-family="InterVariable, Inter, sans-serif" font-size="14" font-weight="500" fill="#1e293b">A</text>
        <text x="44" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Text</text>
      </g>
      <g transform="translate(0, 32)">
        <rect x="16" y="0" width="14" height="14" rx="3" fill="none" stroke="#6b7280" stroke-width="1.5"/>
        <text x="44" y="12" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Checkbox</text>
      </g>
      <g transform="translate(0, 64)">
        <rect x="16" y="0" width="14" height="14" rx="3" fill="none" stroke="#6b7280" stroke-width="1.5"/>
        <path d="M22 4 L22 10 M26 7 L22 10 L18 7" stroke="#6b7280" stroke-width="1.5" fill="none"/>
        <text x="44" y="12" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Dropdown</text>
      </g>
      <g transform="translate(0, 96)">
        <text x="24" y="12" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#6b7280">@</text>
        <text x="44" y="12" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Email</text>
      </g>
      <g transform="translate(0, 128)">
        <circle cx="23" cy="7" r="7" fill="none" stroke="#6b7280" stroke-width="1.5"/>
        <path d="M23 4 L23 7 L26 7" stroke="#6b7280" stroke-width="1.5" fill="none"/>
        <text x="44" y="12" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Time</text>
      </g>
      <g transform="translate(0, 160)">
        <rect x="16" y="0" width="14" height="14" rx="3" fill="none" stroke="#6b7280" stroke-width="1.5"/>
        <circle cx="23" cy="7" r="3" fill="#6b7280"/>
        <text x="44" y="12" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Toggle</text>
      </g>
    </g>
  </g>

  <!-- Secondary dropdown (right side of center) -->
  <g filter="url(#shadow)" transform="translate(520, 120)">
    <rect width="160" height="200" rx="10" fill="#fff"/>

    <g transform="translate(12, 12)">
      <text x="16" y="14" font-family="InterVariable, Inter, sans-serif" font-size="14" font-weight="500" fill="#374151">A</text>
      <text x="40" y="14" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Paragraph</text>

      <g transform="translate(0, 32)">
        <circle cx="24" cy="7" r="6" fill="none" stroke="#6b7280" stroke-width="1.5"/>
        <circle cx="24" cy="7" r="2" fill="#6b7280"/>
        <text x="40" y="12" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Radio Buttons</text>
      </g>
    </g>
  </g>

  <!-- Main form preview panel -->
  <g filter="url(#shadow-lg)" transform="translate(700, 100)">
    <rect width="420" height="480" rx="12" fill="#fff"/>

    <!-- Form fields preview -->
    <g transform="translate(30, 30)">
      <!-- Field placeholder bars -->
      <rect width="180" height="12" rx="3" fill="#e5e7eb"/>
      <rect y="24" width="360" height="36" rx="6" fill="#f3f4f6"/>

      <rect y="80" width="140" height="12" rx="3" fill="#e5e7eb"/>
      <rect y="104" width="360" height="36" rx="6" fill="#f3f4f6"/>
    </g>

    <!-- Selection box with dashed border -->
    <g transform="translate(20, 200)">
      <rect width="380" height="100" rx="8"
            fill="rgba(59, 130, 246, 0.04)"
            stroke="#3b82f6" stroke-width="2" stroke-dasharray="8 4"/>

      <!-- Form inside selection -->
      <rect x="16" y="16" width="200" height="28" rx="4" fill="url(#blue-accent)"/>
      <rect x="16" y="56" width="200" height="28" rx="4" fill="url(#blue-accent)" opacity="0.6"/>

      <!-- Cursor icon -->
      <g transform="translate(340, 60)">
        <path d="M0 0 L0 18 L5 14 L8 22 L11 21 L8 13 L13 13 Z" fill="#374151"/>
      </g>
    </g>

    <!-- More placeholder content below -->
    <g transform="translate(30, 330)">
      <rect width="160" height="10" rx="3" fill="#e5e7eb"/>
      <g transform="translate(0, 24)">
        <circle cx="8" cy="8" r="8" fill="#f3f4f6" stroke="#d1d5db" stroke-width="1"/>
        <rect x="28" width="100" height="8" rx="2" fill="#e5e7eb"/>
      </g>
      <g transform="translate(0, 48)">
        <circle cx="8" cy="8" r="8" fill="#f3f4f6" stroke="#d1d5db" stroke-width="1"/>
        <rect x="28" width="80" height="8" rx="2" fill="#e5e7eb"/>
      </g>
      <g transform="translate(0, 72)">
        <circle cx="8" cy="8" r="8" fill="#3b82f6"/>
        <circle cx="8" cy="8" r="3" fill="#fff"/>
        <rect x="28" width="120" height="8" rx="2" fill="#93c5fd"/>
      </g>
      <g transform="translate(0, 96)">
        <circle cx="8" cy="8" r="8" fill="#f3f4f6" stroke="#d1d5db" stroke-width="1"/>
        <rect x="28" width="90" height="8" rx="2" fill="#e5e7eb"/>
      </g>
    </g>
  </g>

  <!-- Floating badge - Real estate category -->
  <g filter="url(#shadow)" transform="translate(100, 90)">
    <rect width="120" height="36" rx="8" fill="#fff"/>
    <rect x="10" y="8" width="20" height="20" rx="4" fill="#3b82f6"/>
    <text x="20" y="22" font-family="InterVariable, Inter, sans-serif" font-size="10" fill="#fff" text-anchor="middle">🏠</text>
    <text x="42" y="18" font-family="InterVariable, Inter, sans-serif" font-size="11" font-weight="500" fill="#1e293b">Real estate</text>
    <text x="42" y="30" font-family="InterVariable, Inter, sans-serif" font-size="9" fill="#6b7280">11 templates</text>
  </g>

  <!-- Payments floating badge -->
  <g filter="url(#shadow)" transform="translate(340, 430)">
    <rect width="100" height="36" rx="8" fill="#fff"/>
    <rect x="10" y="8" width="20" height="20" rx="4" fill="#ec4899"/>
    <text x="42" y="22" font-family="InterVariable, Inter, sans-serif" font-size="11" font-weight="500" fill="#1e293b">Payments</text>
    <text x="42" y="32" font-family="InterVariable, Inter, sans-serif" font-size="9" fill="#6b7280">11 templates</text>
  </g>
</svg>
```

---

## Quality Checklist

Before finalizing:

- [ ] Background has subtle gradient (not flat white)
- [ ] All panels have appropriate shadow filters
- [ ] Typography uses consistent font family and weights
- [ ] Border radius is consistent across similar elements
- [ ] Colors follow the defined palette
- [ ] Sufficient whitespace and breathing room
- [ ] Visual hierarchy is clear (size, shadow, position)
- [ ] Interactive elements look clickable
- [ ] Selection indicators use brand blue with dashed borders
- [ ] Overall composition is balanced

**Automatic rejection if:**
- Panels have no shadows (looks flat)
- Inconsistent border radius
- Text is not readable (too small, wrong color)
- Cramped layout with no whitespace
- Clashing colors outside the palette
- Looks like a wireframe instead of polished UI

---

## Mobile-Friendly SVG Rules

All SVGs must render well on mobile (375px width and up):

1. **Always use `viewBox`** — never fixed `width`/`height`. Let SVGs scale responsively.
2. **Minimum text size**: 12px equivalent at viewBox scale. Smaller text becomes unreadable on mobile.
3. **Test at 375px wide**: Verify panel labels and key text remain legible at mobile width.
4. **Prefer horizontal layouts** for OG/hero images. Tall compositions shrink too much on mobile.
5. **Responsive embed**: Use `width="100%" height="auto"` or CSS `max-width: 100%` in HTML.
6. **Simplify for small screens**: Reduce number of floating panels if the composition gets crowded at mobile widths.

## Execution Steps

1. **Define the message** - What product feature/workflow to showcase?
2. **Choose layout pattern** - Floating panels, screenshot, grid, workflow?
3. **Set canvas size** - 1200x630 for OG, 1920x1080 for hero, etc.
4. **Create background** - Gradient + optional dot grid + accent blobs
5. **Build primary panel** - Main UI content with elevated shadow
6. **Add secondary panels** - Supporting UI elements, smaller shadows
7. **Create UI components** - Buttons, inputs, lists using component library
8. **Add selection indicators** - Dashed boxes, cursors if showing interaction
9. **Apply typography** - Headers, labels, body text
10. **Add floating badges** - Category labels, feature tags if needed
11. **Final composition** - Ensure balance, whitespace, visual flow
12. **Export** - SVG for web, PNG for social media
