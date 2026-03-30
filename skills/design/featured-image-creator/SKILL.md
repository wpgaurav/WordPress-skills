---
name: featured-image-creator
description: Create blog featured images as SVG (2400x1260px) using illustration libraries, FontAwesome icons, and open-source SVGs. No or negligible text. Convert to PNG via rsvg-convert. Use for yoursite.com and youragency.com blog post thumbnails, social sharing images, and WordPress featured images.
---

# Featured Image Creator

Create blog featured images as clean SVG graphics at 2400x1260px. Illustrations and icons tell the story, not text. Output is converted to PNG via `rsvg-convert` for WordPress.

## Specs

| Attribute | Value |
|-----------|-------|
| Dimensions | `viewBox="0 0 2400 1260"` |
| Aspect ratio | ~1.9:1 (close to 16:9) |
| Text | None or negligible (title overlay not needed) |
| Visuals | Illustration libraries (primary) + FontAwesome icons (accent) |
| Output | `.svg` file, converted to `.png` via rsvg-convert |
| Target PNG | 2400x1260px exact via `rsvg-convert -w 2400 -h 1260` |

## Conversion Command

```bash
for f in *.svg; do rsvg-convert -f png -w 2400 -h 1260 -o "${f%.svg}.png" "$f"; done
```

Single file:
```bash
rsvg-convert -f png -w 2400 -h 1260 -o "output.png" "input.svg"
```

---

## Illustration Library (Primary Visual Source)

### Location

```
~/Icons/graphics-inspirations/
```

### Available Collections

| Collection | Folder | SVGs | Best For |
|-----------|--------|------|----------|
| Freelance & Remote Work | `Freelance-Vector-Illustrations/SVG/Expanded/Titled/` | 361 | Freelancing, remote work, agency life |
| Software Developer | `Software-Developer-Illustrations/SVG/Expanded/Titled/` | 201 | Coding, debugging, dev workflows |
| Work & Office | `7c89bfb8-*-Work-Illustrations/SVG/Expanded/Titled/` | 201 | Planning, burnout, office scenarios |
| Job Professions | `Job-Illustrations-Art-Set/SVG/Expanded/Titled/` | 201 | Career roles, professional services |
| Ecommerce | `Ecommerce-Illustrations/SVG/Expanded/Titled/` | 201 | Shopping, pricing, products, billing |
| AI & Robotics | `971d5aad-*-Artificial-Intelligence-*/SVG/Expanded/Titled/` | 301 | AI, automation, robots, futuristic |
| Workaholics | `Workaholics-Characters-*/SVG/Expanded/Titled/` | 401 | Work stress, deadlines, hustle |
| Advertising | `Advertising Illustration/SVG/Expanded/` | 25 | Marketing, ads (numbered 1–25) |
| Colorful Life | `Colorful-Life-Collection/` (6 subcategories) | 1126 | Celebration, health, travel, education |
| IoT & Smart Devices | `IOT-Illustrations/SVG/Expanded/Titled/` | 201 | Smart tech, automation, devices |
| Lifestyle | `Lifestyle-Illustrations/SVG/Expanded/Titled/` | 361 | Daily activities, hobbies |
| Shopping & Grocery | `Shopping-Grocery-Illustrations/SVG/Expanded/Titled/` | 301 | Retail, delivery, shopping |
| Stress & Sleep | `Stress & Sleep Illustrations Design/SVG/Expanded/Titled/` | 301 | Mental health, wellness |
| Math & Education | `c0788535-*-Math-Illustrations/SVG/Expanded/Titled/` | 261 | Math, education, tutoring |
| Reeded Glass | `e6ceb468-*-reeded_glass/` | 20 | Glassmorphism UI elements |
| WordPress | `wpbeginner/` | 5 | WordPress-specific scenes |

### How to Use Illustrations

Illustrations are full SVG files with embedded `<style>` blocks using CSS classes (`.st0`, `.st1`, etc.) for colors. They have their own viewBoxes (commonly `0 0 156 156` or `0 0 600 600`).

**Embed using nested `<svg>` element** to preserve the illustration's style scope:

```svg
<!-- Read the illustration file, strip the XML declaration and outer <svg> opening/closing -->
<!-- Then embed as a nested SVG with positioning -->
<svg x="600" y="80" width="1200" height="1100" viewBox="0 0 156 156">
  <style type="text/css">
    .st0{fill:#F7CFC6;}
    .st1{fill:#73504E;}
    <!-- ... all style classes from the illustration -->
  </style>
  <!-- All illustration paths/groups here -->
</svg>
```

**Key embedding rules:**
1. Read the illustration SVG file completely
2. Extract everything BETWEEN `<svg ...>` and `</svg>` (the inner content including `<style>`)
3. Wrap in a new `<svg>` element with x/y/width/height for positioning on the 2400x1260 canvas
4. The nested SVG's viewBox should match the original illustration's viewBox
5. Size the illustration to occupy ~60-80% of canvas height (750-1000px height)
6. Center horizontally, position slightly above vertical center

**Illustration style notes:**
- All illustrations use flat design with vibrant, consistent color palettes
- Colors include blues (#006BFF, #3BA2FB), greens (#00C491, #02A05A), pinks (#EE5271), yellows (#FFD700), and skin tones (#F7CFC6, #FAB19D)
- Character-centric scenes with professional themes
- Well-suited as hero visuals without color modification

### Matching Illustrations to Topics

| Article Topic | Collection | Search Keywords |
|--------------|-----------|-----------------|
| Agency operations | Work-Illustrations | "Making Plan", "Employee Planning", "Organizing Files" |
| Project management | Software-Developer, Work | "Organizing Tasks", "Tracking Sales" |
| Proposals/contracts | Work-Illustrations | "Proofreading", "Discussion" |
| Developer rates | Job-Illustrations, Freelance | "Freelance Worker", "Freelancer" |
| Maintenance business | Software-Developer | "Debugging", "Server Configuration" |
| Pricing/billing | Ecommerce | "Sale Offer", "Bill Receipt", "Checkout" |
| Sales/pitching | Freelance, Advertising | "Brainstorming", "Video Call", "Presentation" |
| Productized services | Ecommerce | "Add to Cart", "Online Shopping", "Online Store" |
| AI services | AI-Illustrations | "AI Analyst", "AI Research", "Robot Assistant" |
| White-label | Software-Developer | "Frontend Developer", "Reviewing Code" |
| Partnerships | Work-Illustrations | "Work Buddy", "Online Chat" |
| Freelancer growth | Freelance | "Freelancer", "Remote Employment" |
| Plugin development | Software-Developer | "Coding Files", "Feature Branch", "Programming" |
| Product business | Ecommerce | "Online Order", "Online Sale" |
| SaaS ideas | Software-Developer, AI | "App Testing", "Storage Setting", "Virtual Assistant" |

---

## FontAwesome Icons (Local)

### Location

```
~/Downloads/fontawesome-pro-6.4.2-desktop/svgs/
```

### Categories

| Category | Path | Count | Use For |
|----------|------|-------|---------|
| Solid | `solid/` | 1,390 | Primary icons, filled style |
| Regular | `regular/` | 163 | Outline style, lighter feel |
| Brands | `brands/` | 492 | WordPress, YouTube, GitHub, etc. |

### How to Use FontAwesome Icons

1. **Read the SVG file** to get the path data
2. **Extract the `<path d="...">` and `viewBox`** from the file
3. **Embed inline** in your SVG using a `<g>` with transform for positioning and scaling

```svg
<!-- Example: embedding a FontAwesome icon -->
<g transform="translate(500, 400) scale(0.15)">
  <!-- Paste the path data from the .svg file -->
  <path d="M0 64C0 28.7 28.7 0 64 0L352..." fill="#2563eb"/>
</g>
```

### Scaling Math

FontAwesome icons use large viewBoxes (typically `0 0 512 512` or `0 0 640 512`). To get them to a target pixel size in the 2400x1260 canvas:

| Target Size | Scale Factor (512 viewBox) | Scale Factor (640 viewBox) |
|-------------|---------------------------|---------------------------|
| 40px | 0.078 | 0.0625 |
| 60px | 0.117 | 0.094 |
| 80px | 0.156 | 0.125 |
| 100px | 0.195 | 0.156 |
| 120px | 0.234 | 0.188 |
| 150px | 0.293 | 0.234 |
| 200px | 0.39 | 0.313 |
| 250px | 0.488 | 0.39 |
| 300px | 0.586 | 0.469 |

**Formula**: `scale = target_size / icon_viewbox_width`

### Common Icons by Topic

| Blog Topic | Solid Icons to Use |
|------------|-------------------|
| Blogging / Writing | `pen-to-square`, `blog`, `pencil`, `keyboard`, `newspaper` |
| Money / Income | `dollar-sign`, `money-bill`, `coins`, `piggy-bank`, `wallet`, `chart-line` |
| WordPress | `brands/wordpress`, `brands/wordpress-simple` |
| Hosting / Server | `server`, `database`, `hard-drive`, `cloud` |
| SEO | `magnifying-glass`, `chart-simple`, `ranking-star`, `arrow-trend-up` |
| Email | `envelope`, `paper-plane`, `at`, `inbox` |
| Social Media | `brands/twitter`, `brands/youtube`, `brands/instagram`, `brands/linkedin` |
| Education / Students | `graduation-cap`, `book`, `book-open`, `school`, `chalkboard-user` |
| Tools | `screwdriver-wrench`, `gear`, `gears`, `toolbox`, `wand-magic-sparkles` |
| Speed / Performance | `bolt`, `gauge-high`, `rocket`, `stopwatch` |
| Security | `shield-halved`, `lock`, `key`, `user-shield` |
| Shopping / Affiliate | `cart-shopping`, `bag-shopping`, `tags`, `receipt` |
| Design | `palette`, `paintbrush`, `swatchbook`, `pen-ruler` |
| Code / Dev | `code`, `terminal`, `bug`, `laptop-code`, `file-code` |
| AI / Automation | `robot`, `microchip`, `brain`, `wand-magic-sparkles` |
| Analytics | `chart-bar`, `chart-pie`, `chart-line`, `chart-area` |
| Communication | `comments`, `message`, `bullhorn`, `phone` |
| Media | `image`, `camera`, `video`, `photo-film` |
| Growth | `arrow-up`, `arrow-trend-up`, `seedling`, `leaf` |
| Invoicing / Finance | `file-invoice-dollar`, `receipt`, `credit-card`, `calculator`, `money-bill-wave` |
| Time / Productivity | `clock`, `stopwatch`, `hourglass-half`, `gauge-high`, `list-check` |

### Open-Source SVG Icons (Online)

When FontAwesome doesn't have what you need, use inline SVG paths from:

- **Heroicons** (MIT): Simple, clean outlines or solid fills
- **Lucide** (ISC): Fork of Feather Icons, consistent 24x24 grid
- **Simple Icons** (CC0): Brand/company logos
- **Tabler Icons** (MIT): 2px stroke, rounded caps

Embed the same way: extract `<path>` data, embed in `<g>` with transform.

---

## Visual Styles

Pick one style per image based on article type. Do not mix styles.

### Style 1: Floating Icons (Default)

Best for: Most blog articles, how-to guides, educational content.

Clean background gradient with 4-8 icons floating at different sizes, slight rotations, and varying opacities. The icons tell the story of the article topic.

**Background**: Subtle gradient (warm or cool), dot grid pattern for texture.
**Icons**: Mixed sizes (60px to 250px), scattered composition, slight rotations (-15 to +15 degrees), varying opacity (0.4 to 1.0 for depth).
**Accents**: Soft colored blobs behind icon clusters, decorative rings, thin connecting lines optional.

**Depth techniques (REQUIRED for standout quality):**
- Use 3 distinct depth layers: foreground (opacity 0.9-1.0, scale large), midground (0.6-0.8, scale medium), background (0.3-0.5, scale small)
- Background-layer icons should use a **blur filter** (`feGaussianBlur stdDeviation="3"`) to simulate depth of field
- Foreground icons should have a **drop shadow** for elevation
- Add 1-2 **decorative rings** (unfilled circles with thin stroke) behind the hero icon cluster for visual interest
- Place **accent dots** (3-6px circles at 0.1-0.2 opacity) scattered between icons

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2400 1260">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#f0f9ff"/>
      <stop offset="100%" stop-color="#e0f2fe"/>
    </linearGradient>
    <filter id="shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="6" stdDeviation="12" flood-opacity="0.1"/>
    </filter>
    <filter id="bgBlur">
      <feGaussianBlur stdDeviation="3"/>
    </filter>
    <pattern id="dots" width="30" height="30" patternUnits="userSpaceOnUse">
      <circle cx="15" cy="15" r="1.5" fill="#94a3b8" opacity="0.15"/>
    </pattern>
  </defs>

  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#bg)"/>
  <rect width="100%" height="100%" fill="url(#dots)"/>

  <!-- Accent blobs (soft, organic shapes) -->
  <ellipse cx="650" cy="450" rx="320" ry="260" fill="#dbeafe" opacity="0.35"/>
  <ellipse cx="1800" cy="800" rx="280" ry="220" fill="#c7d2fe" opacity="0.25"/>

  <!-- Decorative rings (behind hero icon) -->
  <circle cx="1100" cy="550" r="220" fill="none" stroke="#93c5fd" stroke-width="1.5" opacity="0.2"/>
  <circle cx="1100" cy="550" r="320" fill="none" stroke="#93c5fd" stroke-width="1" opacity="0.1"/>

  <!-- Accent dots scattered for texture -->
  <circle cx="380" cy="200" r="4" fill="#3b82f6" opacity="0.15"/>
  <circle cx="1900" cy="180" r="5" fill="#6366f1" opacity="0.12"/>
  <circle cx="2100" cy="900" r="6" fill="#3b82f6" opacity="0.1"/>
  <circle cx="300" cy="1000" r="4" fill="#8b5cf6" opacity="0.12"/>
  <circle cx="1500" cy="150" r="3" fill="#6366f1" opacity="0.15"/>

  <!-- BACKGROUND LAYER: small, blurred, low opacity -->
  <g filter="url(#bgBlur)">
    <g transform="translate(200, 180) scale(0.1) rotate(-8)" opacity="0.35">
      <path d="..." fill="#8b5cf6"/>
    </g>
    <g transform="translate(2050, 950) scale(0.1) rotate(10)" opacity="0.3">
      <path d="..." fill="#a78bfa"/>
    </g>
  </g>

  <!-- MIDGROUND LAYER: medium, partial opacity -->
  <g filter="url(#shadow)">
    <g transform="translate(500, 350) scale(0.22) rotate(8)" opacity="0.7">
      <path d="..." fill="#3b82f6"/>
    </g>
    <g transform="translate(1750, 350) scale(0.2) rotate(-10)" opacity="0.65">
      <path d="..." fill="#6366f1"/>
    </g>
    <g transform="translate(450, 750) scale(0.23) rotate(-10)" opacity="0.75">
      <path d="..." fill="#2563eb"/>
    </g>
  </g>

  <!-- FOREGROUND LAYER: hero, large, high opacity, strong shadow -->
  <g filter="url(#shadow)">
    <g transform="translate(1050, 500) scale(0.45) rotate(-5)" opacity="0.95">
      <path d="..." fill="#2563eb"/>
    </g>
    <g transform="translate(1850, 630) scale(0.2) rotate(6)" opacity="0.85">
      <path d="..." fill="#6366f1"/>
    </g>
  </g>
</svg>
```

**Composition rules for floating icons:**
- 1 large hero icon (180-250px) placed slightly off-center (rule of thirds)
- 2-3 midground icons (80-120px) distributed around
- 2-3 background icons (40-70px) filling gaps, lower opacity, slight blur
- Minimum 80px padding from canvas edges
- Vary rotation between -15 and +15 degrees
- Use 2-3 colors from the same palette, never rainbow
- Add decorative rings behind hero icon for visual depth
- Scatter 4-6 accent dots between icon clusters

### Style 2: Icon Cards on Grid

Best for: Tool comparisons, plugin roundups, structured content.

Icons sit inside white card containers arranged on a visible dot grid. Connected by dashed lines. Feels organized and structured like a diagram.

**Background**: Light neutral with visible dot grid.
**Icons**: Inside white rounded-rect cards (120x120px), consistent sizes (60-80px), arranged in a balanced grid-like pattern.
**Accents**: Thin dashed lines connecting cards, subtle drop shadows on cards, one card highlighted with colored border.

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2400 1260">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#fafbfc"/>
      <stop offset="100%" stop-color="#f1f5f9"/>
    </linearGradient>
    <filter id="card-shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="4" stdDeviation="12" flood-opacity="0.06"/>
    </filter>
    <filter id="hero-shadow" x="-20%" y="-20%" width="140%" height="140%">
      <feDropShadow dx="0" dy="8" stdDeviation="20" flood-opacity="0.12"/>
    </filter>
    <pattern id="grid" width="60" height="60" patternUnits="userSpaceOnUse">
      <circle cx="30" cy="30" r="1.5" fill="#cbd5e1" opacity="0.25"/>
    </pattern>
  </defs>

  <rect width="100%" height="100%" fill="url(#bg)"/>
  <rect width="100%" height="100%" fill="url(#grid)"/>

  <!-- Connecting lines between cards (dashed) -->
  <line x1="520" y1="400" x2="780" y2="400" stroke="#cbd5e1" stroke-width="2" stroke-dasharray="8 4"/>
  <line x1="920" y1="400" x2="1180" y2="400" stroke="#cbd5e1" stroke-width="2" stroke-dasharray="8 4"/>

  <!-- Regular cards -->
  <g filter="url(#card-shadow)" transform="translate(400, 340)">
    <rect x="-60" y="-60" width="120" height="120" rx="16" fill="#fff"/>
    <g transform="scale(0.15) translate(-256, -256)">
      <path d="..." fill="#64748b"/>
    </g>
  </g>

  <!-- Hero card (highlighted, slightly larger, colored border) -->
  <g filter="url(#hero-shadow)" transform="translate(800, 340)">
    <rect x="-72" y="-72" width="144" height="144" rx="20" fill="#fff" stroke="#3b82f6" stroke-width="3"/>
    <g transform="scale(0.18) translate(-256, -256)">
      <path d="..." fill="#2563eb"/>
    </g>
  </g>

  <!-- More regular cards... -->
</svg>
```

**Composition rules for icon cards:**
- 5-7 cards in a loose grid (NOT perfectly aligned, slight organic drift)
- One card is the "hero" card: 20% larger, colored border, stronger shadow
- Cards connected by dashed lines to show relationships
- Use the Slate Neutral palette for cards, accent color only on hero card
- Stagger rows slightly for visual interest (not a rigid grid)

### Style 3: Bold Gradient + Central Icon

Best for: Single-topic articles, reviews, opinion pieces, newsletter headers.

A rich gradient background with one large central icon (or a tight cluster of 2-3). Minimal, impactful, bold.

**Background**: Strong multi-point gradient, no grid.
**Icons**: 1 large icon (280-350px) centered, or 2-3 tightly grouped. White or near-white fill.
**Accents**: Glow effect behind central icon, concentric rings, subtle radial gradient, corner geometric shapes.

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2400 1260">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#1e3a5f"/>
      <stop offset="40%" stop-color="#1e40af"/>
      <stop offset="100%" stop-color="#3b82f6"/>
    </linearGradient>
    <radialGradient id="glow" cx="50%" cy="50%" r="35%">
      <stop offset="0%" stop-color="#fff" stop-opacity="0.12"/>
      <stop offset="100%" stop-color="#fff" stop-opacity="0"/>
    </radialGradient>
    <filter id="icon-glow" x="-50%" y="-50%" width="200%" height="200%">
      <feGaussianBlur in="SourceGraphic" stdDeviation="15" result="blur"/>
      <feBlend in="SourceGraphic" in2="blur" mode="normal"/>
    </filter>
  </defs>

  <rect width="100%" height="100%" fill="url(#bg)"/>
  <rect width="100%" height="100%" fill="url(#glow)"/>

  <!-- Concentric rings -->
  <circle cx="1200" cy="630" r="250" fill="none" stroke="#fff" stroke-width="1.5" opacity="0.08"/>
  <circle cx="1200" cy="630" r="350" fill="none" stroke="#fff" stroke-width="1" opacity="0.05"/>
  <circle cx="1200" cy="630" r="450" fill="none" stroke="#fff" stroke-width="0.5" opacity="0.03"/>

  <!-- Corner geometric accents -->
  <rect x="80" y="80" width="120" height="3" rx="1.5" fill="#fff" opacity="0.1"/>
  <rect x="80" y="80" width="3" height="120" rx="1.5" fill="#fff" opacity="0.1"/>
  <rect x="2200" y="1080" width="120" height="3" rx="1.5" fill="#fff" opacity="0.1"/>
  <rect x="2317" y="960" width="3" height="120" rx="1.5" fill="#fff" opacity="0.1"/>

  <!-- Central icon (large, white, with glow) -->
  <g transform="translate(1200, 630) scale(0.6)" filter="url(#icon-glow)">
    <g transform="translate(-256, -256)">
      <path d="..." fill="#fff"/>
    </g>
  </g>

  <!-- Small supporting icon (subtle) -->
  <g transform="translate(700, 400) scale(0.15)" opacity="0.2">
    <path d="..." fill="#93c5fd"/>
  </g>
</svg>
```

### Style 4: Glassmorphism Float (NEW)

Best for: SaaS reviews, modern web tools, premium content.

Icons float on frosted glass cards over a gradient background. Premium, modern feel. Each icon sits on a semi-transparent card with backdrop blur simulation.

**Background**: Rich gradient (dark or vibrant).
**Icons**: Inside glassmorphic containers (white at 0.08-0.12 opacity, white border at 0.15 opacity, rounded corners).
**Accents**: Gradient orbs behind glass cards, scattered light sparkles.

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2400 1260">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#0f172a"/>
      <stop offset="50%" stop-color="#1e293b"/>
      <stop offset="100%" stop-color="#0f172a"/>
    </linearGradient>
    <filter id="glow-orb">
      <feGaussianBlur stdDeviation="40"/>
    </filter>
    <filter id="card-shadow">
      <feDropShadow dx="0" dy="8" stdDeviation="16" flood-color="#000" flood-opacity="0.2"/>
    </filter>
  </defs>

  <rect width="100%" height="100%" fill="url(#bg)"/>

  <!-- Glowing orbs behind cards -->
  <circle cx="500" cy="400" r="200" fill="#3b82f6" opacity="0.15" filter="url(#glow-orb)"/>
  <circle cx="1900" cy="800" r="180" fill="#8b5cf6" opacity="0.12" filter="url(#glow-orb)"/>
  <circle cx="1200" cy="600" r="250" fill="#06b6d4" opacity="0.08" filter="url(#glow-orb)"/>

  <!-- Glass card with icon -->
  <g filter="url(#card-shadow)" transform="translate(1100, 500)">
    <!-- Glass background -->
    <rect x="-80" y="-80" width="160" height="160" rx="24"
          fill="#fff" fill-opacity="0.08"
          stroke="#fff" stroke-opacity="0.15" stroke-width="1"/>
    <!-- Icon inside -->
    <g transform="scale(0.18) translate(-256, -256)">
      <path d="..." fill="#e2e8f0"/>
    </g>
  </g>

  <!-- More glass cards at various positions... -->

  <!-- Light sparkles (tiny bright dots) -->
  <circle cx="800" cy="300" r="2" fill="#fff" opacity="0.4"/>
  <circle cx="1600" cy="200" r="1.5" fill="#fff" opacity="0.3"/>
  <circle cx="2000" cy="500" r="2" fill="#fff" opacity="0.35"/>
</svg>
```

**Composition rules for glassmorphism:**
- 4-6 glass cards of varying sizes (100px to 200px containers)
- One hero card is 40% larger than others
- Cards overlap slightly at edges for depth
- 2-3 colored orbs behind cards create the glow bleed effect
- Scatter 5-8 tiny sparkle dots (1.5-3px, white, 0.2-0.5 opacity)
- Use slate white icons (#e2e8f0) for consistency on dark backgrounds

### Style 5: Illustration Hero (PREFERRED)

Best for: Any article where a matching illustration exists. This is the highest-quality style.

A full illustration from the library serves as the hero visual, positioned on a gradient background with subtle accent elements. The illustration tells the story; FA icons are optional accents only.

**Background**: Soft gradient matching illustration mood + subtle dot grid.
**Hero**: Full illustration (60-80% canvas height), centered or rule-of-thirds positioned.
**Accents**: 2-3 soft blobs behind illustration, optional 1-2 small FA icons as floating accents at very low opacity, decorative rings.

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 2400 1260">
  <defs>
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#f0f9ff"/>
      <stop offset="100%" stop-color="#e0f2fe"/>
    </linearGradient>
    <filter id="shadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="0" dy="8" stdDeviation="20" flood-opacity="0.08"/>
    </filter>
    <pattern id="dots" width="40" height="40" patternUnits="userSpaceOnUse">
      <circle cx="20" cy="20" r="1" fill="#94a3b8" opacity="0.12"/>
    </pattern>
  </defs>

  <!-- Background -->
  <rect width="100%" height="100%" fill="url(#bg)"/>
  <rect width="100%" height="100%" fill="url(#dots)"/>

  <!-- Accent blobs (behind illustration) -->
  <ellipse cx="1200" cy="600" rx="500" ry="400" fill="#dbeafe" opacity="0.3"/>
  <ellipse cx="800" cy="700" rx="300" ry="250" fill="#c7d2fe" opacity="0.2"/>

  <!-- Decorative rings -->
  <circle cx="1200" cy="630" r="500" fill="none" stroke="#93c5fd" stroke-width="1" opacity="0.1"/>

  <!-- ILLUSTRATION (nested SVG preserves its own styles) -->
  <g filter="url(#shadow)">
    <svg x="600" y="80" width="1200" height="1100" viewBox="0 0 156 156">
      <style type="text/css">
        .st0{fill:#F7CFC6;}
        .st1{fill:#73504E;}
        <!-- ... illustration styles ... -->
      </style>
      <!-- ... illustration paths ... -->
    </svg>
  </g>

  <!-- Optional: 1-2 tiny FA icon accents (very subtle) -->
  <g transform="translate(300, 200) scale(0.12)" opacity="0.15">
    <path d="..." fill="#3b82f6"/>
  </g>

  <!-- Accent dots -->
  <circle cx="400" cy="300" r="4" fill="#3b82f6" opacity="0.12"/>
  <circle cx="2000" cy="900" r="5" fill="#6366f1" opacity="0.1"/>
</svg>
```

**Composition rules for illustration hero:**
- Illustration occupies 60-80% of canvas height (750-1000px)
- Center the illustration horizontally on the canvas
- Position illustration slightly above vertical center (y offset ~80-130px from top)
- Background gradient should complement the illustration's color palette
- Accent blobs should be BEHIND the illustration, large and soft
- FA icon accents are OPTIONAL and should be at 0.1-0.2 opacity max
- Keep accent dots and decorative elements subtle — the illustration is the star
- Apply a light drop shadow to the illustration group for elevation

**How to embed an illustration:**
1. Read the full illustration SVG file
2. Extract the `viewBox` value from the source SVG
3. Extract the inner content (everything between `<svg>` and `</svg>`, including `<style>` blocks)
4. Wrap in a new `<svg x="..." y="..." width="..." height="..." viewBox="...">` element
5. Place inside a `<g filter="url(#shadow)">` for elevation
6. Size: for a 156x156 viewBox illustration, use `width="1100" height="1100"` and center with `x="650" y="80"`
7. For 600x600 viewBox illustrations, use `width="1100" height="1100"` and center with `x="650" y="80"`

**Illustration viewBox sizing reference:**

| Source viewBox | Recommended width/height | x position (centered) | y position |
|---------------|-------------------------|----------------------|------------|
| 0 0 156 156 | 1100 x 1100 | 650 | 80 |
| 0 0 600 600 | 1100 x 1100 | 650 | 80 |
| 0 0 500 500 | 1100 x 1100 | 650 | 80 |

---

## Color Palettes

Pick one palette per image. Match to article mood.

### Cool Blue (Default for tech/WordPress)

| Element | Color | Hex |
|---------|-------|-----|
| Background start | Ice blue | `#f0f9ff` |
| Background end | Light blue | `#e0f2fe` |
| Primary icon | Blue | `#2563eb` |
| Secondary icon | Indigo | `#6366f1` |
| Tertiary icon | Violet | `#8b5cf6` |
| Accent blob | Blue wash | `#dbeafe` |
| Decorative ring | Light blue | `#93c5fd` |
| Grid dots | Slate | `#94a3b8` |

### Warm Amber (Money, business, affiliate)

| Element | Color | Hex |
|---------|-------|-----|
| Background start | Warm cream | `#fffbeb` |
| Background end | Amber tint | `#fef3c7` |
| Primary icon | Amber | `#d97706` |
| Secondary icon | Orange | `#ea580c` |
| Tertiary icon | Rose | `#e11d48` |
| Accent blob | Amber wash | `#fde68a` |
| Decorative ring | Peach | `#fdba74` |
| Grid dots | Stone | `#a8a29e` |

### Fresh Green (Growth, blogging, beginner guides)

| Element | Color | Hex |
|---------|-------|-----|
| Background start | Mint | `#f0fdf4` |
| Background end | Green tint | `#dcfce7` |
| Primary icon | Green | `#16a34a` |
| Secondary icon | Teal | `#0d9488` |
| Tertiary icon | Emerald | `#059669` |
| Accent blob | Green wash | `#bbf7d0` |
| Decorative ring | Light green | `#86efac` |
| Grid dots | Gray-green | `#86efac` |

### Deep Dark (Bold reviews, opinion pieces)

| Element | Color | Hex |
|---------|-------|-----|
| Background start | Dark navy | `#0f172a` |
| Background mid | Dark blue | `#1e293b` |
| Icon color | White | `#ffffff` |
| Secondary icon | Light slate | `#e2e8f0` |
| Accent orbs | Blue/violet/cyan at low opacity | `#3b82f6` / `#8b5cf6` / `#06b6d4` |
| Sparkles | White at 0.3-0.5 | `#ffffff` |
| Geometric accents | White at 0.05-0.1 | `#ffffff` |

### Slate Neutral (Comparisons, lists, roundups)

| Element | Color | Hex |
|---------|-------|-----|
| Background start | Near white | `#fafbfc` |
| Background end | Light slate | `#f1f5f9` |
| Primary icon | Slate | `#475569` |
| Secondary icon | Blue-gray | `#64748b` |
| Accent | Blue pop | `#3b82f6` |
| Card background | White | `#ffffff` |
| Card border (hero) | Blue | `#3b82f6` |

---

## Composition Rules

### Canvas Layout

```
+--80px padding--+------------------------------------------+--80px padding--+
|                 |                                          |                 |
|  80px           |         SAFE AREA (2240 x 1100)          |           80px  |
|  padding        |                                          |  padding        |
|                 |                                          |                 |
+--80px padding--+------------------------------------------+--80px padding--+
```

- Keep all icons within the safe area (80px inset from edges)
- Social sharing crops to ~1.91:1 (Facebook) or 2:1 (Twitter). Critical content should be centered
- WordPress thumbnails crop to various ratios. Center the visual weight

### Hierarchy (3-Layer Depth System)

Every image MUST use 3 depth layers for visual richness:

1. **Foreground** (closest to viewer)
   - The hero icon (largest, 180-300px)
   - 1-2 supporting icons at high opacity (0.85-1.0)
   - Drop shadow filter applied
   - Slight rotation for dynamism

2. **Midground** (middle distance)
   - 2-3 medium icons (80-120px)
   - Medium opacity (0.6-0.8)
   - Light shadow or no shadow
   - Moderate rotation

3. **Background** (furthest away)
   - 2-3 small icons (40-70px)
   - Low opacity (0.3-0.5)
   - Apply blur filter (`feGaussianBlur stdDeviation="2-4"`)
   - Creates atmospheric depth

### Decorative Elements (REQUIRED)

Every image must include at least 3 of these:

- **Accent blobs**: Soft ellipses (200-350px radius) at 0.2-0.4 opacity in palette-matching colors
- **Decorative rings**: 1-2 unfilled circles (200-350px radius) with thin stroke (1-2px) at 0.08-0.2 opacity centered behind hero icon
- **Accent dots**: 4-8 small circles (2-6px) scattered across canvas at 0.1-0.2 opacity
- **Dot grid pattern**: Light repeating dot pattern for texture
- **Corner accents**: Thin L-shaped lines in corners (Style 3 and 4 only)
- **Sparkles**: Tiny bright dots for glassmorphism style

### Spacing

- Minimum 80px between icon edges
- Hero icon should have 180px+ clear space around it (except for decorative rings)
- Supporting icons distribute evenly but not symmetrically
- Background icons can be partially clipped by safe area edges for depth

### What NOT to Do

- No text (article title goes in WordPress, not the image)
- No photographs or raster images embedded in SVG
- No more than 8 icons total (gets cluttered)
- No rainbow colors. Stick to one palette (2-3 hues)
- No perfect symmetry (feels lifeless)
- No tiny icons that disappear at thumbnail size
- No clip art aesthetic
- No decorative borders or frames
- No flat compositions without depth layers
- No icons all the same size (kills visual hierarchy)
- No icons all at the same opacity (kills depth)

---

## Execution Steps

1. **Read the article** (or article outline) to understand the core topic
2. **Pick a visual style**: Floating Icons (default), Icon Cards, Bold Gradient, or Glassmorphism Float
3. **Pick a color palette**: Match to article mood/category
4. **Select 5-8 icons** from FontAwesome that represent the topic
   - Read each `.svg` file from the local FontAwesome directory
   - Extract the `viewBox` and `<path d="...">` data
   - Note the viewBox dimensions for scaling math
5. **Build the SVG**:
   a. Set `viewBox="0 0 2400 1260"`
   b. Define gradients, filters (shadow, blur, glow), and patterns in `<defs>`
   c. Create background (gradient + pattern)
   d. Add accent shapes (blobs, rings, dots)
   e. Place BACKGROUND layer icons (small, blurred, low opacity)
   f. Place MIDGROUND layer icons (medium, moderate opacity)
   g. Place FOREGROUND layer icons (hero + supporting, high opacity, shadow)
   h. Add final decorative touches (sparkles, corner accents)
6. **Review**: Does it read well at 300px wide (thumbnail)? Is the topic obvious from icons alone? Is there clear visual depth?
7. **Save** as `.svg` file
8. **Convert**: `rsvg-convert -f png -w 2400 -h 1260 -o "output.png" "input.svg"`

---

## Matching Style to Article Type

**PREFERRED**: Always check the Illustration Library first. If a matching illustration exists, use **Style 5: Illustration Hero**. Fall back to icon-only styles when no good illustration match is available.

| Article Type | Preferred Style | Fallback Style | Recommended Palette |
|-------------|----------------|----------------|---------------------|
| How-to guide | Illustration Hero | Floating Icons | Cool Blue |
| Tutorial | Illustration Hero | Icon Cards on Grid | Cool Blue or Neutral |
| Money/affiliate | Illustration Hero | Floating Icons | Warm Amber |
| Beginner guide | Illustration Hero | Floating Icons | Fresh Green |
| WordPress tutorial | Illustration Hero | Floating Icons or Icon Cards | Cool Blue |
| Software review | Illustration Hero | Bold Gradient or Glassmorphism | Deep Dark |
| Product review | Illustration Hero | Glassmorphism Float | Deep Dark |
| Comparison/roundup | Illustration Hero | Icon Cards on Grid | Slate Neutral |
| Opinion/thought leadership | Illustration Hero | Bold Gradient | Deep Dark |
| Agency/business | Illustration Hero | Floating Icons | Cool Blue or Amber |
| Freelancing | Illustration Hero | Floating Icons | Warm Amber |
| AI/automation | Illustration Hero | Glassmorphism Float | Deep Dark |
| Newsletter header | Illustration Hero | Floating Icons | Any |
| Tool recommendation | Illustration Hero | Floating Icons | Warm Amber |
| Student/education | Illustration Hero | Floating Icons | Fresh Green |
| SaaS/web app | Illustration Hero | Glassmorphism Float | Deep Dark |
| Invoice/finance | Illustration Hero | Floating Icons | Warm Amber |
| Time/productivity | Illustration Hero | Floating Icons | Cool Blue |

---

## rsvg-convert Notes

- For exact 2400x1260 PNG: `rsvg-convert -f png -w 2400 -h 1260 -o "output.png" "input.svg"`
- For batch conversion: `for f in *.svg; do rsvg-convert -f png -w 2400 -h 1260 -o "${f%.svg}.png" "$f"; done`
- Install on macOS: `brew install librsvg`
- If only `-w` is specified, height scales proportionally from viewBox

---

## Mobile-Friendly Rules

Featured images display at various sizes across devices:

1. **viewBox is mandatory** — `viewBox="0 0 2400 1260"`, never fixed pixel dimensions.
2. **Center visual weight**: Social crops (1.91:1 Facebook, 2:1 Twitter) and WordPress thumbnails all crop from center. Keep the hero icon cluster centered.
3. **Test at 300px wide**: The image must be recognizable and the topic obvious at thumbnail size. This is the mobile card/feed width.
4. **Minimum icon rendered size**: The hero icon must remain identifiable at ~60px rendered width. Background icons can fade.
5. **No tiny decorative elements** that vanish at small sizes — accent dots under 4px at viewBox scale disappear on mobile.
6. **Responsive embed**: WordPress handles this, but for custom use: `width="100%" height="auto"`.

## Quality Checklist

- [ ] viewBox is `0 0 2400 1260`
- [ ] No text or negligible text (title NOT baked into image)
- [ ] Icons are from FontAwesome (local) or open-source (inline paths)
- [ ] No `<image>` tags or external references (fully self-contained SVG)
- [ ] 5-8 icons total, clear visual hierarchy
- [ ] One color palette used consistently (2-3 hues max)
- [ ] Icons stay within safe area (80px from edges)
- [ ] **3 depth layers present** (foreground, midground, background)
- [ ] Background layer icons have blur filter applied
- [ ] Foreground icons have drop shadow
- [ ] At least 3 decorative elements (blobs, rings, dots, sparkles)
- [ ] Reads well at thumbnail size (~300px wide)
- [ ] Topic is recognizable from icons alone
- [ ] Background has gradient (not flat white)
- [ ] rsvg-convert produces clean PNG without artifacts
- [ ] File size is reasonable (under 100KB for SVG)
