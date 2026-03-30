---
name: monoline-icons
description: Create Apple-style monoline icon illustrations in SVG. Single-color outline icons with uniform stroke weight, rounded caps/joins, and clean geometry. Use for tech product marketing, feature showcases, device ecosystems, service overviews, blog graphics, and documentation illustrations. Output crisp, professional iconography that looks like Apple developer documentation or WWDC slide art.
---

# Monoline Icon Illustrations

Create SVG graphics with clean, single-weight outline icons in the Apple marketing style. Think WWDC keynote slides, Apple developer documentation, SF Symbols, and product ecosystem diagrams.

**Key principle**: One color, one stroke weight, zero fills. If it has a gradient or a drop shadow, it failed.

## When to Use

- Tech product ecosystem showcases
- Device/platform feature overviews
- Service icon collections
- Blog featured images (tech topics)
- Documentation hero graphics
- Landing page illustrations
- Product comparison visuals
- API/SDK capability diagrams
- Newsletter header graphics
- Pitch deck technology slides

Best for showing **technology, devices, services, or capabilities** as clean iconographic compositions.

## Quick Reference

| Pattern | Use Case | Key Elements |
|---------|----------|--------------|
| Ecosystem Scatter | Device/product family | Mixed-size icons scattered organically |
| Icon Grid | Feature list, capabilities | Uniform icons in aligned grid |
| Hero + Satellites | Central product + features | One large icon, smaller ones orbiting |
| Horizontal Strip | Banner, header graphic | Icons in a horizontal flow |
| Vertical Stack | Sidebar, tall format | Icons stacked with consistent spacing |

---

## Core Visual Rules

### Canvas

- **White or near-white background** (`#ffffff` or `#fafbfc`)
- No background patterns, textures, or gradients
- Clean, open space around icons
- Common sizes: `800x400` (banner), `800x600` (standard), `1200x630` (OG image), `2400x1260` (featured image)
- Always use `viewBox`, never fixed `width`/`height`

### The Monoline Rules (Non-Negotiable)

| Rule | Correct | Wrong |
|------|---------|-------|
| Stroke weight | Uniform everywhere | Varying thickness |
| Stroke color | Single color | Multiple colors or gradients |
| Fill | `none` on all shapes | Filled shapes |
| Line caps | `round` | `butt` or `square` |
| Line joins | `round` | `miter` or `bevel` |
| Corners | Rounded (`rx`/`ry` on rects) | Sharp 90-degree corners |
| Geometry | Clean, precise curves | Wobbly or hand-drawn |
| Complexity | Minimal detail | Over-detailed |

**Exception for fills**: Small accent marks (dots, filled circles for indicators) may use fill sparingly. Recognized brand logos (Apple logo, etc.) may also use fill. Everything else is outline only.

### Color Palette

**Default: Single Blue**

| Element | Hex | Usage |
|---------|-----|-------|
| Icon stroke | `#0066FF` | All icon strokes (Apple's classic link blue) |
| Background | `#FFFFFF` | Canvas background |

**Alternative single-color palettes** (pick ONE per graphic):

| Name | Hex | Best For |
|------|-----|----------|
| Apple Blue | `#0066FF` | Default, tech, ecosystem |
| Indigo | `#5856D6` | Developer tools, APIs |
| Teal | `#30B0C7` | Health, wellness, data |
| Green | `#34C759` | Sustainability, growth |
| Orange | `#FF9500` | Creativity, media |
| Red | `#FF3B30` | Security, alerts |
| Purple | `#AF52DE` | AI, machine learning |
| Graphite | `#48484A` | Professional, enterprise |

**Hard rule**: Never use more than one stroke color in the same graphic. The monoline aesthetic depends on uniformity.

### Stroke Weight

The stroke weight must be **consistent across all icons in the composition**, regardless of icon size. This is the defining characteristic of the style.

| Canvas Width | Recommended Stroke | Use Case |
|-------------|-------------------|----------|
| 200-400px | 2-3px | Small icons, inline |
| 400-800px | 3-5px | Standard illustrations |
| 800-1200px | 5-8px | Blog graphics, OG images |
| 1200-2400px | 8-14px | Featured images, hero |

**Formula**: `stroke-width = canvas_width / 120` (approximate starting point, adjust by eye)

### Corner Radius

All rounded rectangles use consistent corner radii. Scale proportionally with icon size.

| Element Size | Corner Radius | Ratio |
|-------------|---------------|-------|
| Small (30-60px) | 4-6px | ~10% of width |
| Medium (60-120px) | 8-14px | ~12% of width |
| Large (120-250px) | 16-28px | ~12% of width |
| XL (250px+) | 28-40px | ~12% of width |

Device screens (phones, tablets, laptops) use slightly larger radii to match real hardware proportions.

### Typography

Monoline icon illustrations should have **no text**. The icons tell the story.

If labels are absolutely required (rare):
- Font: `-apple-system, BlinkMacSystemFont, 'SF Pro Display', 'Helvetica Neue', sans-serif`
- Same color as icon stroke
- Lightweight (font-weight 300-400)
- Small relative to icons (never dominant)
- Placed below or beside icons, never inside

---

## SVG Structure Template

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 400">
  <!-- Global stroke settings -->
  <g fill="none" stroke="#0066FF" stroke-width="5"
     stroke-linecap="round" stroke-linejoin="round">

    <!-- Icon 1: positioned and scaled -->
    <g transform="translate(100, 200)">
      <!-- Icon paths here -->
    </g>

    <!-- Icon 2 -->
    <g transform="translate(400, 180)">
      <!-- Icon paths here -->
    </g>

    <!-- Icon 3 (different scale) -->
    <g transform="translate(650, 220) scale(0.7)">
      <!-- Icon paths here -->
    </g>

  </g>
</svg>
```

**Key structural rules:**
1. Set `fill="none"`, `stroke`, `stroke-width`, `stroke-linecap="round"`, `stroke-linejoin="round"` on the outermost `<g>` wrapper
2. Individual icons inherit these properties
3. Use `transform="translate(x, y)"` for positioning
4. Use `transform="scale(s)"` for sizing (maintain uniform stroke by applying scale to the group)
5. Icons are self-contained `<g>` groups that can be repositioned independently

**Important**: When scaling icons with `transform="scale()"`, the stroke width also scales. To maintain uniform stroke weight across different-sized icons, use `vector-effect="non-scaling-stroke"` on paths, OR draw icons at a canonical size and adjust the stroke-width inversely.

### Maintaining Uniform Stroke at Different Scales

**Method 1: Non-scaling stroke (preferred)**

```svg
<g transform="translate(100, 100) scale(0.5)">
  <rect x="-40" y="-60" width="80" height="120" rx="10"
        vector-effect="non-scaling-stroke"/>
</g>
```

**Method 2: Inverse stroke adjustment**

```svg
<!-- Base stroke is 5px. Icon at 0.5x scale needs 10px stroke to appear as 5px -->
<g transform="translate(100, 100) scale(0.5)" stroke-width="10">
  <rect x="-40" y="-60" width="80" height="120" rx="10"/>
</g>
```

**Method 3: Draw at final size (simplest)**

Draw each icon at its final pixel size, no scaling transforms. This avoids stroke inconsistency entirely.

---

## Icon Construction Library

All icons below are drawn at a canonical 100x100 unit size centered at origin (0,0). Scale and translate as needed.

### Devices

#### Smartphone (iPhone-style)

```svg
<!-- Smartphone: 60x100 units, centered at 0,0 -->
<g>
  <!-- Body -->
  <rect x="-30" y="-50" width="60" height="100" rx="10"/>
  <!-- Screen notch / Dynamic Island -->
  <rect x="-10" y="-44" width="20" height="6" rx="3"/>
  <!-- Face ID scanning lines (optional detail) -->
  <rect x="-12" y="-15" width="24" height="24" rx="3"/>
  <circle cx="-5" cy="-3" r="2"/>
  <circle cx="5" cy="-3" r="2"/>
  <path d="M -6 4 Q 0 10 6 4"/>
</g>
```

#### Laptop (MacBook-style)

```svg
<!-- Laptop: 140x100 units, centered at 0,0 -->
<g>
  <!-- Screen -->
  <rect x="-60" y="-50" width="120" height="80" rx="6"/>
  <!-- Notch -->
  <rect x="-10" y="-50" width="20" height="6" rx="3"/>
  <!-- Base/keyboard -->
  <path d="M -70 30 L -60 30 L -60 30 Q -60 30 -60 30 L 60 30 L 70 30
           Q 72 30 72 32 L 72 35 Q 72 38 70 38 L -70 38 Q -72 38 -72 35
           L -72 32 Q -72 30 -70 30 Z"/>
  <!-- Logo (Apple-style, optional, filled exception) -->
  <!-- Use a simple leaf shape if brand logo not appropriate -->
</g>
```

#### Tablet (iPad-style)

```svg
<!-- Tablet: 80x100 units, centered at 0,0 -->
<g>
  <!-- Body -->
  <rect x="-40" y="-50" width="80" height="100" rx="8"/>
  <!-- Camera dot -->
  <circle cx="0" cy="-44" r="3"/>
</g>
```

#### Smartwatch (Apple Watch-style)

```svg
<!-- Watch: 40x50 units, centered at 0,0 -->
<g>
  <!-- Band top -->
  <path d="M -12 -30 L -12 -25 Q -12 -20 -8 -20"/>
  <path d="M 12 -30 L 12 -25 Q 12 -20 8 -20"/>
  <!-- Case -->
  <rect x="-18" y="-22" width="36" height="44" rx="10"/>
  <!-- Crown/button -->
  <rect x="18" y="-8" width="4" height="10" rx="2"/>
  <!-- Band bottom -->
  <path d="M -12 22 Q -12 25 -12 28 L -12 30"/>
  <path d="M 12 22 Q 12 25 12 28 L 12 30"/>
</g>
```

### Service/Feature Icons

#### Chat/Messages (Overlapping Bubbles)

```svg
<!-- Messages: 50x45 units -->
<g>
  <!-- Back bubble -->
  <path d="M -5 -20 Q -5 -22 5 -22 L 20 -22 Q 25 -22 25 -17
           L 25 -2 Q 25 3 20 3 L 18 3 L 22 10 L 12 3
           L 5 3 Q -5 3 -5 -2 Z"/>
  <!-- Front bubble -->
  <path d="M -25 -10 Q -25 -15 -20 -15 L 5 -15 Q 10 -15 10 -10
           L 10 5 Q 10 10 5 10 L -10 10 L -18 18 L -14 10
           L -20 10 Q -25 10 -25 5 Z"/>
</g>
```

#### Fingerprint (Touch ID)

```svg
<!-- Fingerprint: 50x60 units -->
<g>
  <!-- Concentric arcs suggesting a fingerprint -->
  <path d="M -5 25 Q -20 15 -20 0 Q -20 -20 0 -25" fill="none"/>
  <path d="M 5 25 Q 20 15 20 0 Q 20 -15 10 -22" fill="none"/>
  <path d="M -2 20 Q -12 12 -12 0 Q -12 -12 0 -16" fill="none"/>
  <path d="M 2 20 Q 12 12 12 0 Q 12 -10 5 -15" fill="none"/>
  <path d="M 0 15 Q -5 8 -5 0 Q -5 -5 0 -8" fill="none"/>
  <path d="M 0 15 Q 5 8 5 0 Q 5 -5 0 -8" fill="none"/>
  <line x1="0" y1="-8" x2="0" y2="8"/>
</g>
```

#### Cloud with Checkmark (iCloud)

```svg
<!-- Cloud + checkmark: 60x45 units -->
<g>
  <!-- Cloud shape -->
  <path d="M -20 15 L 20 15 Q 30 15 30 5 Q 30 -5 20 -8
           Q 22 -20 10 -22 Q 0 -25 -8 -18
           Q -12 -22 -20 -18 Q -28 -14 -25 -5
           Q -32 0 -30 8 Q -30 15 -20 15 Z" fill="none"/>
  <!-- Checkmark inside -->
  <path d="M -8 2 L -2 8 L 10 -5"/>
</g>
```

#### Gear/Settings

```svg
<!-- Gear: 50x50 units -->
<g>
  <!-- Outer gear teeth (simplified, 8 teeth) -->
  <path d="M -5 -24 L -3 -20 L 3 -20 L 5 -24
           L 10 -22 L 14 -18 L 18 -14 L 22 -10
           L 24 -5 L 20 -3 L 20 3 L 24 5
           L 22 10 L 18 14 L 14 18 L 10 22
           L 5 24 L 3 20 L -3 20 L -5 24
           L -10 22 L -14 18 L -18 14 L -22 10
           L -24 5 L -20 3 L -20 -3 L -24 -5
           L -22 -10 L -18 -14 L -14 -18 L -10 -22 Z"/>
  <!-- Center circle -->
  <circle cx="0" cy="0" r="8"/>
</g>
```

#### Power/Standby

```svg
<!-- Power button: 40x45 units -->
<g>
  <!-- Arc (open at top) -->
  <path d="M -8 -12 A 18 18 0 1 0 8 -12" fill="none"/>
  <!-- Vertical line -->
  <line x1="0" y1="-20" x2="0" y2="-5"/>
</g>
```

#### Camera

```svg
<!-- Camera: 55x40 units -->
<g>
  <!-- Body -->
  <rect x="-25" y="-12" width="50" height="30" rx="5"/>
  <!-- Lens -->
  <circle cx="0" cy="3" r="10"/>
  <circle cx="0" cy="3" r="5"/>
  <!-- Flash/viewfinder -->
  <rect x="-18" y="-18" width="14" height="8" rx="2"/>
</g>
```

#### Battery

```svg
<!-- Battery: 40x22 units -->
<g>
  <!-- Body -->
  <rect x="-18" y="-10" width="36" height="20" rx="3"/>
  <!-- Terminal -->
  <rect x="18" y="-5" width="4" height="10" rx="2"/>
</g>
```

#### 3D Box (ARKit/Spatial)

```svg
<!-- 3D cube: 45x50 units -->
<g>
  <!-- Front face -->
  <path d="M -20 5 L 0 15 L 20 5 L 20 -15 L 0 -25 L -20 -15 Z"/>
  <!-- Top edge -->
  <path d="M -20 -15 L 0 -5 L 20 -15"/>
  <!-- Middle vertical -->
  <line x1="0" y1="-5" x2="0" y2="15"/>
</g>
```

#### Lock/Security

```svg
<!-- Lock: 36x50 units -->
<g>
  <!-- Shackle -->
  <path d="M -10 -10 L -10 -22 Q -10 -30 0 -30 Q 10 -30 10 -22 L 10 -10"/>
  <!-- Body -->
  <rect x="-15" y="-12" width="30" height="25" rx="4"/>
  <!-- Keyhole -->
  <circle cx="0" cy="-3" r="4"/>
  <line x1="0" y1="1" x2="0" y2="8"/>
</g>
```

#### Shield

```svg
<!-- Shield: 40x50 units -->
<g>
  <path d="M 0 -25 L 20 -15 L 20 5 Q 20 20 0 25 Q -20 20 -20 5
           L -20 -15 Z"/>
</g>
```

#### Wi-Fi Signal

```svg
<!-- Wi-Fi: 50x40 units -->
<g>
  <!-- Arcs from top to bottom (largest to smallest) -->
  <path d="M -22 -8 Q 0 -30 22 -8" fill="none"/>
  <path d="M -15 0 Q 0 -18 15 0" fill="none"/>
  <path d="M -8 8 Q 0 -4 8 8" fill="none"/>
  <!-- Dot at base -->
  <circle cx="0" cy="15" r="3" fill="currentColor" stroke="none"/>
</g>
```

#### Document/File

```svg
<!-- Document: 36x46 units -->
<g>
  <!-- Page with folded corner -->
  <path d="M -15 -23 L 8 -23 L 18 -13 L 18 23 Q 18 23 18 23
           L -15 23 Q -18 23 -18 20 L -18 -20 Q -18 -23 -15 -23 Z"/>
  <!-- Corner fold -->
  <path d="M 8 -23 L 8 -13 L 18 -13"/>
  <!-- Text lines -->
  <line x1="-10" y1="-5" x2="10" y2="-5"/>
  <line x1="-10" y1="3" x2="10" y2="3"/>
  <line x1="-10" y1="11" x2="5" y2="11"/>
</g>
```

#### Globe/Web

```svg
<!-- Globe: 44x44 units -->
<g>
  <!-- Outer circle -->
  <circle cx="0" cy="0" r="22"/>
  <!-- Horizontal line -->
  <line x1="-22" y1="0" x2="22" y2="0"/>
  <!-- Vertical ellipse (meridian) -->
  <ellipse cx="0" cy="0" rx="10" ry="22"/>
  <!-- Latitude lines -->
  <path d="M -20 -10 Q 0 -14 20 -10" fill="none"/>
  <path d="M -20 10 Q 0 14 20 10" fill="none"/>
</g>
```

#### Mail/Envelope

```svg
<!-- Envelope: 50x35 units -->
<g>
  <!-- Body -->
  <rect x="-25" y="-15" width="50" height="35" rx="3"/>
  <!-- Flap -->
  <path d="M -25 -15 L 0 5 L 25 -15"/>
</g>
```

#### Bell/Notification

```svg
<!-- Bell: 36x46 units -->
<g>
  <!-- Bell body -->
  <path d="M -15 8 L -15 -5 Q -15 -22 0 -22 Q 15 -22 15 -5 L 15 8 Z"/>
  <!-- Brim -->
  <line x1="-20" y1="8" x2="20" y2="8"/>
  <!-- Clapper -->
  <path d="M -5 8 Q -5 15 0 15 Q 5 15 5 8"/>
  <!-- Handle -->
  <line x1="0" y1="-22" x2="0" y2="-26"/>
</g>
```

#### Download Arrow

```svg
<!-- Download: 36x46 units -->
<g>
  <!-- Arrow pointing down -->
  <line x1="0" y1="-20" x2="0" y2="10"/>
  <path d="M -10 2 L 0 12 L 10 2"/>
  <!-- Tray -->
  <path d="M -15 10 L -15 18 L 15 18 L 15 10"/>
</g>
```

#### Pencil/Edit

```svg
<!-- Pencil: 46x46 units, rotated 45deg -->
<g transform="rotate(-45)">
  <!-- Body -->
  <rect x="-5" y="-22" width="10" height="35" rx="2"/>
  <!-- Tip -->
  <path d="M -5 13 L 0 20 L 5 13"/>
  <!-- Eraser band -->
  <line x1="-5" y1="-16" x2="5" y2="-16"/>
</g>
```

---

## Composition Patterns

### Ecosystem Scatter

The reference image style. Icons of varying sizes scattered organically across the canvas. Larger icons (devices) anchor the composition; smaller icons (services/features) fill gaps.

```
      [messages]
 [gear]     [iPhone]    [MacBook]     [fingerprint]     [iPad]    [cloud]
[box]                       [watch]   [power]                  [camera] [battery]
```

**Rules:**
- 8-14 icons total
- 2-3 large device icons (40-60% of canvas height)
- 4-6 medium service icons (20-35% of canvas height)
- 2-4 small accent icons (10-20% of canvas height)
- Vary vertical position (not aligned on a baseline)
- No icon overlaps (minimum gap = 1x stroke-width)
- Visual weight distributed roughly evenly across horizontal span
- Largest icon(s) near center or slightly left of center

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 500">
  <g fill="none" stroke="#0066FF" stroke-width="6"
     stroke-linecap="round" stroke-linejoin="round">

    <!-- Large: MacBook at center -->
    <g transform="translate(500, 260) scale(1.8)">
      <!-- laptop paths -->
    </g>

    <!-- Large: iPhone left of center -->
    <g transform="translate(180, 250) scale(1.4)">
      <!-- smartphone paths -->
    </g>

    <!-- Large: iPad right -->
    <g transform="translate(920, 240) scale(1.5)">
      <!-- tablet paths -->
    </g>

    <!-- Medium: Messages top-left -->
    <g transform="translate(250, 80) scale(1.0)">
      <!-- messages paths -->
    </g>

    <!-- Medium: Fingerprint top-right -->
    <g transform="translate(720, 70) scale(1.0)">
      <!-- fingerprint paths -->
    </g>

    <!-- Small: Watch bottom-center -->
    <g transform="translate(650, 380) scale(0.8)">
      <!-- watch paths -->
    </g>

    <!-- Small: Gear far-left -->
    <g transform="translate(50, 180) scale(0.7)">
      <!-- gear paths -->
    </g>

    <!-- Small: Cloud far-right -->
    <g transform="translate(1100, 150) scale(0.8)">
      <!-- cloud paths -->
    </g>

    <!-- Small: Camera bottom-right -->
    <g transform="translate(1020, 370) scale(0.6)">
      <!-- camera paths -->
    </g>

    <!-- Small: Battery far bottom-right -->
    <g transform="translate(1140, 380) scale(0.5)">
      <!-- battery paths -->
    </g>

    <!-- Small: 3D box far bottom-left -->
    <g transform="translate(60, 380) scale(0.6)">
      <!-- box paths -->
    </g>

    <!-- Small: Power center -->
    <g transform="translate(680, 330) scale(0.5)">
      <!-- power paths -->
    </g>
  </g>
</svg>
```

### Icon Grid

Uniform-sized icons in a clean grid. Best for feature lists, capability overviews.

```
  [icon1]  [icon2]  [icon3]  [icon4]
  [icon5]  [icon6]  [icon7]  [icon8]
```

**Rules:**
- All icons same visual size (scale to fit uniform bounding box)
- Equal spacing between grid cells
- Optional: icon label text below each icon
- 3-4 columns, 2-3 rows typical
- Centered on canvas

### Hero + Satellites

One large central icon with smaller icons radiating around it.

```
            [small1]
    [small2]        [small3]
        [  HERO ICON  ]
    [small4]        [small5]
            [small6]
```

**Rules:**
- Hero icon is 3-4x the size of satellites
- Satellites arranged in a rough circle/orbit
- Even angular spacing (not perfectly uniform, organic)
- Optional: thin connecting lines from satellites to hero (same stroke color, thinner weight)

---

## Drawing Principles

### Simplification

Reduce real objects to their most recognizable outline. A MacBook is a rectangle with a thin base. A camera is a rounded rectangle with a circle.

| Object | Essential Features | Skip |
|--------|-------------------|------|
| Phone | Rounded rect + notch | Buttons, ports, speaker grills |
| Laptop | Screen rect + wedge base + notch | Keys, trackpad, hinge detail |
| Watch | Squircle + crown + bands | Complications, sensors |
| Camera | Body rect + lens circles | Flash detail, mode dial |
| Lock | Shackle + body + keyhole | Screws, brand marks |
| Gear | Toothed circle + center hole | Individual tooth precision |

### Curve Quality

Use quadratic (`Q`) and cubic (`C`) Bezier curves for organic shapes. Arcs (`A`) for circular sections. Never approximate curves with many short line segments.

```svg
<!-- Good: smooth Bezier -->
<path d="M -20 10 Q -30 -5 -20 -15 Q -10 -25 5 -20"/>

<!-- Bad: jagged line approximation -->
<path d="M -20 10 L -22 8 L -24 5 L -25 2 L -24 -2 L -22 -5..."/>
```

### Negative Space

Icons communicate through the space they leave, not just the lines they draw. Keep interiors open. A lock's keyhole is more recognizable than the lock body itself.

### Consistent Visual Weight

Even though all strokes are the same pixel width, different shapes have different visual weight. A large filled-looking area (many close parallel lines) appears heavier than a single outline. Balance by:

- Keeping icon interiors mostly empty
- Using fewer internal details on larger icons
- Matching the density of detail across icons in the same composition

---

## Topic-Specific Icon Selections

| Article Topic | Recommended Icons |
|--------------|------------------|
| Apple ecosystem | MacBook, iPhone, iPad, Watch, AirPods, iCloud, Messages |
| WordPress | Document, Gear, Globe, Pencil, Lock, Code brackets |
| Web hosting | Server rack, Cloud, Globe, Shield, Gauge, Database |
| Email marketing | Envelope, Bell, Chart, Users, Pencil, Megaphone |
| SEO | Magnifying glass, Chart, Globe, Document, Link, Gauge |
| Security | Lock, Shield, Fingerprint, Key, Eye, Alert triangle |
| E-commerce | Cart, Credit card, Package/box, Star, Truck, Receipt |
| Social media | Speech bubbles, Heart, Share arrow, Camera, Bell, Users |
| AI/ML | Brain, Chip/processor, Robot, Sparkle, Network nodes |
| Productivity | Clock, Calendar, Checkbox, Folder, Pencil, Chart |
| Photography | Camera, Image frame, Aperture, Flash, Gallery grid |
| Development | Code brackets, Terminal, Bug, Git branch, Rocket |
| Finance | Dollar sign, Chart, Calculator, Wallet, Pie chart |
| Education | Book, Graduation cap, Lightbulb, Pencil, Globe |
| Cloud services | Cloud, Upload/download, Sync arrows, Server, Lock |

---

## Complete Example: Tech Ecosystem

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 450">
  <g fill="none" stroke="#0066FF" stroke-width="5"
     stroke-linecap="round" stroke-linejoin="round">

    <!-- === LARGE ICONS === -->

    <!-- MacBook (center, largest) -->
    <g transform="translate(480, 240)">
      <!-- Screen -->
      <rect x="-100" y="-80" width="200" height="130" rx="8"/>
      <!-- Notch -->
      <rect x="-14" y="-80" width="28" height="8" rx="4"/>
      <!-- Base -->
      <path d="M -110 50 L -100 50 L 100 50 L 110 50
               Q 114 50 114 54 L 114 58 Q 114 62 110 62
               L -110 62 Q -114 62 -114 58 L -114 54
               Q -114 50 -110 50 Z"/>
    </g>

    <!-- iPhone (left) -->
    <g transform="translate(160, 235)">
      <rect x="-32" y="-55" width="64" height="110" rx="12"/>
      <!-- Dynamic Island -->
      <rect x="-10" y="-48" width="20" height="6" rx="3"/>
      <!-- Face ID symbol -->
      <rect x="-12" y="-12" width="24" height="24" rx="4"/>
      <path d="M -6 -2 Q 0 6 6 -2"/>
      <circle cx="-4" cy="-6" r="1.5"/>
      <circle cx="4" cy="-6" r="1.5"/>
    </g>

    <!-- iPad (right) -->
    <g transform="translate(830, 230)">
      <rect x="-50" y="-65" width="100" height="130" rx="10"/>
      <!-- Scribble lines inside (representing Apple Pencil content) -->
      <path d="M -25 -20 Q -5 -35 15 -15 Q 30 0 10 10" fill="none"/>
      <path d="M -20 5 Q 0 -10 20 5 Q 35 15 15 25" fill="none"/>
    </g>

    <!-- === MEDIUM ICONS === -->

    <!-- Messages (top-left) -->
    <g transform="translate(270, 60)">
      <!-- Back bubble -->
      <path d="M 5 -22 Q 5 -28 12 -28 L 32 -28 Q 38 -28 38 -22
               L 38 -4 Q 38 2 32 2 L 28 2 L 34 12 L 20 2
               L 12 2 Q 5 2 5 -4 Z"/>
      <!-- Front bubble -->
      <path d="M -20 -16 Q -20 -22 -14 -22 L 14 -22 Q 20 -22 20 -16
               L 20 2 Q 20 8 14 8 L -2 8 L -12 18 L -8 8
               L -14 8 Q -20 8 -20 2 Z"/>
    </g>

    <!-- Fingerprint (top-center-right) -->
    <g transform="translate(660, 55)">
      <path d="M -6 28 Q -22 18 -22 0 Q -22 -22 0 -28" fill="none"/>
      <path d="M 6 28 Q 22 18 22 0 Q 22 -16 12 -24" fill="none"/>
      <path d="M -3 22 Q -14 14 -14 0 Q -14 -14 0 -18" fill="none"/>
      <path d="M 3 22 Q 14 14 14 0 Q 14 -12 6 -17" fill="none"/>
      <path d="M 0 16 Q -6 10 -6 0 Q -6 -6 0 -10" fill="none"/>
      <path d="M 0 16 Q 6 10 6 0 Q 6 -6 0 -10" fill="none"/>
    </g>

    <!-- Cloud + checkmark (far right) -->
    <g transform="translate(950, 120)">
      <path d="M -22 16 L 22 16 Q 32 16 32 6 Q 32 -4 22 -8
               Q 24 -20 12 -24 Q 2 -28 -8 -20
               Q -14 -24 -22 -20 Q -30 -16 -28 -6
               Q -34 0 -32 8 Q -32 16 -22 16 Z" fill="none"/>
      <path d="M -8 2 L -2 9 L 12 -5"/>
    </g>

    <!-- === SMALL ICONS === -->

    <!-- Gear (far left) -->
    <g transform="translate(45, 150) scale(0.8)">
      <circle cx="0" cy="0" r="18"/>
      <circle cx="0" cy="0" r="8"/>
      <!-- Simplified teeth as short lines radiating out -->
      <line x1="0" y1="-18" x2="0" y2="-25"/>
      <line x1="0" y1="18" x2="0" y2="25"/>
      <line x1="-18" y1="0" x2="-25" y2="0"/>
      <line x1="18" y1="0" x2="25" y2="0"/>
      <line x1="-13" y1="-13" x2="-18" y2="-18"/>
      <line x1="13" y1="-13" x2="18" y2="-18"/>
      <line x1="-13" y1="13" x2="-18" y2="18"/>
      <line x1="13" y1="13" x2="18" y2="18"/>
    </g>

    <!-- 3D Box (bottom-left) -->
    <g transform="translate(50, 380) scale(0.7)">
      <path d="M -22 6 L 0 18 L 22 6 L 22 -16 L 0 -28 L -22 -16 Z"/>
      <path d="M -22 -16 L 0 -4 L 22 -16"/>
      <line x1="0" y1="-4" x2="0" y2="18"/>
    </g>

    <!-- Watch (bottom-center) -->
    <g transform="translate(620, 365) scale(0.9)">
      <rect x="-16" y="-20" width="32" height="40" rx="8"/>
      <!-- Crown -->
      <rect x="16" y="-5" width="5" height="10" rx="2"/>
      <!-- Band hints -->
      <line x1="-10" y1="-20" x2="-10" y2="-28"/>
      <line x1="10" y1="-20" x2="10" y2="-28"/>
      <line x1="-10" y1="20" x2="-10" y2="28"/>
      <line x1="10" y1="20" x2="10" y2="28"/>
    </g>

    <!-- Power icon (center-bottom) -->
    <g transform="translate(580, 330) scale(0.6)">
      <path d="M -10 -14 A 20 20 0 1 0 10 -14" fill="none"/>
      <line x1="0" y1="-22" x2="0" y2="-5"/>
    </g>

    <!-- Camera (bottom-right) -->
    <g transform="translate(900, 370) scale(0.7)">
      <rect x="-28" y="-14" width="56" height="34" rx="6"/>
      <circle cx="0" cy="3" r="11"/>
      <circle cx="0" cy="3" r="5"/>
      <rect x="-20" y="-22" width="16" height="10" rx="3"/>
    </g>

    <!-- Battery (far bottom-right) -->
    <g transform="translate(960, 390) scale(0.5)">
      <rect x="-22" y="-12" width="44" height="24" rx="4"/>
      <rect x="22" y="-6" width="5" height="12" rx="2"/>
    </g>

  </g>
</svg>
```

---

## Adapting for Different Contexts

### Blog Featured Image (2400x1260)

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2400 1260">
  <g fill="none" stroke="#0066FF" stroke-width="12"
     stroke-linecap="round" stroke-linejoin="round">
    <!-- Scale all icons up proportionally -->
    <!-- Keep 120px safe margin from edges -->
  </g>
</svg>
```

Convert to PNG: `rsvg-convert -f png -w 2400 -h 1260 -o "output.png" "input.svg"`

### OG Image (1200x630)

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 630">
  <g fill="none" stroke="#0066FF" stroke-width="6"
     stroke-linecap="round" stroke-linejoin="round">
    <!-- 60px safe margin -->
  </g>
</svg>
```

### Small Inline Graphic (400x200)

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200">
  <g fill="none" stroke="#0066FF" stroke-width="3"
     stroke-linecap="round" stroke-linejoin="round">
    <!-- Fewer icons (3-5), simpler compositions -->
  </g>
</svg>
```

---

## Theme Color Integration

**Default stroke color inherits from site theme:**

| Context | Stroke Color | Hex |
|---------|-------------|-----|
| Default (links/actions) | Action blue | `#2563EB` |
| Brand emphasis | Primary red | `#C0392B` |
| Success/growth | Teal | `#16A085` |
| Neutral/professional | Dark gray | `#2D3748` |

Use one color per graphic. `#2563EB` is the default unless the article mood suggests otherwise.

## Mobile-Friendly SVG Rules

All SVGs must render well on mobile (375px width and up):

1. **Always use `viewBox`** — never fixed `width`/`height`. Let SVGs scale responsively.
2. **Minimum icon size**: Icons must remain recognizable at 24px rendered size on mobile.
3. **Test at 375px wide**: Verify all icons are distinguishable at mobile width.
4. **Reduce icon count for small formats**: Use 5-8 icons for mobile-targeted graphics vs 8-14 for desktop.
5. **Responsive embed**: Use `width="100%" height="auto"` or CSS `max-width: 100%` in HTML.

## Quality Checklist

Before finalizing:

- [ ] Single stroke color throughout (no second colors)
- [ ] Uniform stroke-width on every path/shape
- [ ] `stroke-linecap="round"` and `stroke-linejoin="round"` set globally
- [ ] `fill="none"` on all shapes (except allowed fill exceptions)
- [ ] No gradients, shadows, or opacity effects
- [ ] All rounded rectangles use `rx`/`ry` (no sharp corners)
- [ ] Icons are recognizable at half size
- [ ] Composition has visual balance (not front-heavy or top-heavy)
- [ ] Adequate spacing between icons (no crowding)
- [ ] Background is clean white (no patterns or textures)
- [ ] SVG uses `viewBox` (no fixed pixel dimensions)
- [ ] File is self-contained (no external references)
- [ ] rsvg-convert produces clean output at target resolution

**Automatic rejection if:**
- Multiple stroke colors used
- Any filled shapes (except brand logos or indicator dots)
- Stroke width varies between icons
- Sharp/square line caps or joins
- Gradients or shadows present
- Icons are too detailed (over-rendered)
- Looks like a filled icon set (FontAwesome, Material) rather than monoline

---

## What NOT to Do

| Bad Practice | Why It Fails |
|-------------|-------------|
| Filled icons | Breaks the monoline aesthetic entirely |
| Multiple colors | Distracts; monoline = mono-color |
| Varying stroke widths | Creates visual hierarchy where there should be uniformity |
| Sharp corners | Feels harsh; rounded corners are essential |
| Drop shadows | Not part of this style at all |
| Gradients on strokes | Destroys the flat, clean look |
| Too many icons (15+) | Gets cluttered and unreadable |
| All same size | Loses visual interest; vary sizes |
| Text-heavy labels | Icons should speak for themselves |
| Complex internal detail | Simplify relentlessly |
| Butt/square line caps | Creates visual gaps at path endpoints |
| Overlapping icons | Each icon needs clear breathing room |

---

## Execution Steps

1. **Determine the topic** - What concept or ecosystem needs illustration?
2. **Select 8-12 icons** from the library (or create new ones following the construction principles)
3. **Choose composition pattern** - Scatter, grid, hero+satellites, strip, or stack
4. **Set canvas size** - Based on output target (featured image, OG, inline)
5. **Calculate stroke weight** - `canvas_width / 120` as starting point
6. **Place large anchor icons first** - Devices or primary concept icons
7. **Fill with medium icons** - Service/feature icons around anchors
8. **Add small accent icons** - In remaining gaps
9. **Check spacing** - No overlaps, even visual distribution
10. **Verify monoline rules** - One color, one stroke width, round caps/joins, no fills
11. **Test at half size** - Icons still recognizable?
12. **Export** - Save as SVG, convert to PNG if needed

---

## Extending the Icon Library

When you need an icon not in the library, follow these construction principles:

1. **Start with the object's silhouette** - What is the single most recognizable outline?
2. **Draw in a 100x100 unit space** centered at (0,0)
3. **Use 3-7 path elements** maximum per icon
4. **Round all corners** - Use `rx`/`ry` on rects, Bezier curves on paths
5. **Leave interiors mostly empty** - One or two internal details max
6. **Test stroke-only rendering** - Does it read without any fill?
7. **Simplify until it almost fails** - Then add back one detail

The best monoline icons use the minimum number of strokes to be instantly recognizable.
