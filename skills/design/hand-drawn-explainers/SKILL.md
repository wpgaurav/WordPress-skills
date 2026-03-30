---
name: hand-drawn-explainers
description: Create hand-drawn explainer graphics in SVG that look like notebook sketches with blue and red ink on ruled paper. Use for product launches, technical explainers, dev tools, AI workflows, SaaS landing pages, educational diagrams, pitch decks, and social media. Output intentionally imperfect, human-feeling sketches that prioritize clarity over polish.
---

# Hand-Drawn Explainer Graphics

Create SVG graphics that look hand-sketched on notebook paper. Think whiteboard meets notebook meets startup sketch.

**Key principle**: If it looks too clean, it failed.

## When to Use

- Product launch explainers
- Developer tool overviews
- AI/SaaS workflow diagrams
- Educational diagrams
- Pitch deck visuals
- Blog featured images
- Social media explainers
- Internal documentation
- Newsletter headers

Best for explaining **systems, processes, or ideas**, not emotions or branding.

## Quick Reference

| Pattern | Use Case | Key Elements |
|---------|----------|--------------|
| Explainer | Product/concept overview | Central object + radiating callouts |
| Workflow | Process/sequence | Left-to-right flow, task bubbles, parallel paths |
| Feature Breakdown | Feature highlights | Main box + callouts with checkmarks |
| Comparison | Before/after, options | Side-by-side boxes with annotations |
| Architecture | System diagrams | Boxes, arrows, icons representing components |

---

## Image Generation Prompt Template

Use this optimized prompt when generating with image_gen tools:

```
Hand-drawn explainer diagram on a white notebook paper background with faint ruled lines.

Blue and red ink sketch style.
Imperfect, human-drawn lines.
Casual doodles.
No vector art.
No realism.

A hand-sketched title at the top with a red underline.

In the center, a simple hand-drawn screen labeled "[MAIN CONCEPT]".

Around it, multiple hand-drawn boxes and speech bubbles connected with curved arrows.
Some arrows show parallel paths.
Some boxes are circled in red.
Include simple stick figures and minimal icons like gears or robots where relevant.

Text appears handwritten, slightly uneven, and casual.
The drawing feels like it was made quickly during a brainstorming session.

No gradients.
No shadows.
No modern UI elements.
No clean typography.
```

### Prompt Variables

Replace `[MAIN CONCEPT]` with:
- Product name or feature
- Process being explained
- System component

### Additional Prompt Modifiers

**For workflow diagrams, add:**
```
Show a left-to-right flow with numbered steps.
Each step is a hand-drawn box connected by curved arrows.
Some paths branch and merge.
```

**For feature breakdowns, add:**
```
Central product box with feature callouts radiating outward.
Each feature has a red checkmark.
Small icons represent each feature.
```

**For comparisons, add:**
```
Two columns: "Before" on left, "After" on right.
Red X marks on problems, green checkmarks on solutions.
Arrows show transformation.
```

**For architecture diagrams, add:**
```
Multiple boxes representing system components.
Labeled with handwritten text.
Arrows show data flow direction.
Include simple icons: database cylinders, cloud shapes, server boxes.
```

---

## Core Visual Rules

### Canvas
- White or off-white paper background (#fefefe or #f8f6f0)
- Faint ruled notebook lines (horizontal, every 25-30px)
- Optional: subtle paper texture, coffee stains, creases, fold marks
- Red margin line on left side (optional)
- Never gradients or solid modern backgrounds

### Color Palette (Strict)

| Color | Hex | Usage |
|-------|-----|-------|
| Blue ink | #2563eb | Primary drawings, boxes, arrows, text |
| Red ink | #dc2626 | Emphasis circles, underlines, checkmarks, X marks |
| Black ink | #1e293b | Only if absolutely necessary for contrast |
| Paper white | #fefefe | Background |
| Paper cream | #f8f6f0 | Alternative background |
| Ruled lines | #e5e7eb | Faint horizontal lines |

**Hard rules:**
- No fills (outlines only)
- No shadows
- No gradients
- No opacity/transparency effects
- No glow effects

### Line Quality

| Attribute | Correct | Wrong |
|-----------|---------|-------|
| Straightness | Slight wobble, curves | Perfectly straight |
| Thickness | Varies 1.5-3px naturally | Uniform thickness |
| Endings | Slightly imprecise | Clean endpoints |
| Corners | Rounded, overshooting | Sharp 90-degree |
| Continuity | May have gaps | Perfectly connected |

### Typography

- **Font**: Handwritten-style only
  - Primary: `'Comic Sans MS', 'Marker Felt', cursive`
  - Fallback: `'Segoe Print', 'Bradley Hand', cursive`
- **Case**: Uppercase for labels, mixed case for notes
- **Alignment**: Slightly off, never perfectly centered
- **Rotation**: Tilt text -3 to +3 degrees
- **Spacing**: Inconsistent letter spacing
- **Size hierarchy**:
  - Title: 24-32px
  - Labels: 14-18px
  - Notes: 10-14px

---

## SVG Structure Template

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 600">
  <defs>
    <!-- Paper texture filter -->
    <filter id="paper-texture">
      <feTurbulence type="fractalNoise" baseFrequency="0.04" numOctaves="5" result="noise"/>
      <feColorMatrix type="saturate" values="0"/>
      <feBlend in="SourceGraphic" in2="noise" mode="multiply"/>
    </filter>

    <!-- Hand-drawn wobble effect -->
    <filter id="sketch-wobble">
      <feTurbulence type="turbulence" baseFrequency="0.02" numOctaves="3" result="noise"/>
      <feDisplacementMap in="SourceGraphic" in2="noise" scale="2" xChannelSelector="R" yChannelSelector="G"/>
    </filter>

    <!-- Ink bleed effect -->
    <filter id="ink-bleed">
      <feMorphology operator="dilate" radius="0.3"/>
      <feGaussianBlur stdDeviation="0.2"/>
    </filter>
  </defs>

  <!-- Paper background -->
  <rect width="100%" height="100%" fill="#fefefe"/>

  <!-- Paper texture overlay (optional) -->
  <rect width="100%" height="100%" fill="#f8f6f0" opacity="0.3" filter="url(#paper-texture)"/>

  <!-- Red margin line (optional) -->
  <line x1="60" y1="0" x2="60" y2="600" stroke="#f5d5d5" stroke-width="1"/>

  <!-- Ruled lines -->
  <g id="ruled-lines" stroke="#e5e7eb" stroke-width="0.5" opacity="0.6">
    <line x1="0" y1="30" x2="800" y2="30"/>
    <line x1="0" y1="60" x2="800" y2="60"/>
    <line x1="0" y1="90" x2="800" y2="90"/>
    <line x1="0" y1="120" x2="800" y2="120"/>
    <line x1="0" y1="150" x2="800" y2="150"/>
    <line x1="0" y1="180" x2="800" y2="180"/>
    <line x1="0" y1="210" x2="800" y2="210"/>
    <line x1="0" y1="240" x2="800" y2="240"/>
    <line x1="0" y1="270" x2="800" y2="270"/>
    <line x1="0" y1="300" x2="800" y2="300"/>
    <line x1="0" y1="330" x2="800" y2="330"/>
    <line x1="0" y1="360" x2="800" y2="360"/>
    <line x1="0" y1="390" x2="800" y2="390"/>
    <line x1="0" y1="420" x2="800" y2="420"/>
    <line x1="0" y1="450" x2="800" y2="450"/>
    <line x1="0" y1="480" x2="800" y2="480"/>
    <line x1="0" y1="510" x2="800" y2="510"/>
    <line x1="0" y1="540" x2="800" y2="540"/>
    <line x1="0" y1="570" x2="800" y2="570"/>
  </g>

  <!-- Main sketch content -->
  <g id="sketch-content" filter="url(#sketch-wobble)">
    <!-- Title -->
    <g id="title">
      <!-- Title text and underline -->
    </g>

    <!-- Central element -->
    <g id="central-object">
      <!-- Main concept box/screen -->
    </g>

    <!-- Callouts and annotations -->
    <g id="callouts">
      <!-- Surrounding boxes, bubbles, notes -->
    </g>

    <!-- Connecting arrows -->
    <g id="arrows">
      <!-- Curved arrows between elements -->
    </g>

    <!-- Icons and figures -->
    <g id="icons">
      <!-- Stick figures, gears, simple icons -->
    </g>

    <!-- Emphasis marks -->
    <g id="emphasis">
      <!-- Red circles, checkmarks, underlines -->
    </g>
  </g>

  <!-- Labels (outside filter for readability) -->
  <g id="labels">
    <!-- Handwritten text labels -->
  </g>
</svg>
```

---

## Drawing Techniques Library

### Wobbly Lines

```svg
<!-- Horizontal wobbly line -->
<path d="M 100 100 Q 130 97 160 102 Q 190 99 220 101 Q 250 98 280 100"
      stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>

<!-- Vertical wobbly line -->
<path d="M 100 100 Q 98 130 102 160 Q 99 190 101 220"
      stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>

<!-- Diagonal wobbly line -->
<path d="M 100 100 Q 120 115 140 135 Q 165 158 190 180"
      stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
```

### Sketchy Rectangles

```svg
<!-- Basic sketchy box -->
<path d="M 50 50
         Q 55 48 100 51 Q 145 49 150 52
         Q 152 55 151 85 Q 153 115 148 120
         Q 145 122 100 119 Q 55 121 52 118
         Q 48 115 49 85 Q 47 55 50 50"
      stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>

<!-- Rounded sketchy box -->
<path d="M 60 50
         Q 50 50 50 60
         Q 48 100 50 140
         Q 50 150 60 150
         Q 100 152 140 150
         Q 150 150 150 140
         Q 152 100 150 60
         Q 150 50 140 50
         Q 100 48 60 50"
      stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>

<!-- Double-line sketchy box (overdrawn effect) -->
<g>
  <path d="M 50 50 Q 100 48 150 51 Q 152 100 149 150 Q 100 152 51 149 Q 48 100 50 50"
        stroke="#2563eb" stroke-width="2" fill="none" opacity="0.7"/>
  <path d="M 52 52 Q 100 50 148 53 Q 150 100 147 148 Q 100 150 53 147 Q 50 100 52 52"
        stroke="#2563eb" stroke-width="2" fill="none"/>
</g>
```

### Speech Bubbles

```svg
<!-- Thought bubble -->
<g>
  <ellipse cx="200" cy="100" rx="80" ry="50" stroke="#2563eb" stroke-width="2" fill="none"/>
  <circle cx="140" cy="150" r="8" stroke="#2563eb" stroke-width="2" fill="none"/>
  <circle cx="120" cy="170" r="5" stroke="#2563eb" stroke-width="2" fill="none"/>
  <circle cx="105" cy="185" r="3" stroke="#2563eb" stroke-width="2" fill="none"/>
</g>

<!-- Speech bubble with pointer -->
<g>
  <path d="M 120 50 Q 100 50 100 70 Q 98 100 100 130 Q 100 150 120 150
           Q 180 152 240 150 Q 260 150 260 130 Q 262 100 260 70 Q 260 50 240 50
           Q 180 48 120 50"
        stroke="#2563eb" stroke-width="2" fill="none"/>
  <path d="M 130 150 Q 125 170 100 180 Q 140 175 145 150"
        stroke="#2563eb" stroke-width="2" fill="none"/>
</g>
```

### Arrows

```svg
<!-- Simple curved arrow -->
<g>
  <path d="M 100 100 Q 150 70 200 100" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 188 92 L 200 100 L 190 110" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
</g>

<!-- Wavy arrow (longer distance) -->
<g>
  <path d="M 100 100 Q 150 80 200 95 Q 250 110 300 100" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 288 92 L 300 100 L 290 110" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
</g>

<!-- Downward arrow -->
<g>
  <path d="M 100 100 Q 95 150 100 200" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 92 188 L 100 200 L 108 188" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>
</g>

<!-- Bidirectional arrow -->
<g>
  <path d="M 120 100 Q 175 90 230 100" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 130 92 L 120 100 L 130 108" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 220 92 L 230 100 L 220 108" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
</g>

<!-- Branching arrows (parallel paths) -->
<g>
  <path d="M 100 150 Q 130 150 150 120" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 100 150 Q 130 150 150 180" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 142 112 L 150 120 L 140 125" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
  <path d="M 142 188 L 150 180 L 140 175" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round"/>
</g>
```

### Red Emphasis Marks

```svg
<!-- Emphasis circle around element -->
<ellipse cx="200" cy="100" rx="60" ry="35"
         stroke="#dc2626" stroke-width="2.5" fill="none"
         transform="rotate(-5 200 100)"/>

<!-- Double emphasis circle (overdrawn) -->
<g>
  <ellipse cx="200" cy="100" rx="58" ry="33" stroke="#dc2626" stroke-width="2" fill="none" opacity="0.5" transform="rotate(-3 200 100)"/>
  <ellipse cx="200" cy="100" rx="62" ry="37" stroke="#dc2626" stroke-width="2" fill="none" transform="rotate(-7 200 100)"/>
</g>

<!-- Underline -->
<path d="M 100 120 Q 150 123 200 119 Q 250 122 300 120"
      stroke="#dc2626" stroke-width="2.5" fill="none" stroke-linecap="round"/>

<!-- Wavy underline -->
<path d="M 100 120 Q 120 115 140 120 Q 160 125 180 120 Q 200 115 220 120 Q 240 125 260 120"
      stroke="#dc2626" stroke-width="2" fill="none" stroke-linecap="round"/>

<!-- Checkmark -->
<path d="M 90 100 L 100 112 L 125 85"
      stroke="#dc2626" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round"/>

<!-- X mark -->
<g stroke="#dc2626" stroke-width="3" stroke-linecap="round">
  <path d="M 90 90 L 115 115"/>
  <path d="M 115 90 L 90 115"/>
</g>

<!-- Star/asterisk -->
<g stroke="#dc2626" stroke-width="2" stroke-linecap="round" transform="translate(100, 100)">
  <path d="M 0 -12 L 0 12"/>
  <path d="M -10 -6 L 10 6"/>
  <path d="M -10 6 L 10 -6"/>
</g>

<!-- Exclamation mark -->
<g fill="#dc2626">
  <ellipse cx="100" cy="80" rx="4" ry="15"/>
  <circle cx="100" cy="105" r="4"/>
</g>
```

### Stick Figures

```svg
<!-- Basic stick figure -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round">
  <!-- Head -->
  <circle cx="0" cy="-35" r="12"/>
  <!-- Body -->
  <path d="M 0 -23 Q 2 0 0 25"/>
  <!-- Arms -->
  <path d="M -20 -5 Q 0 5 20 -5"/>
  <!-- Legs -->
  <path d="M 0 25 Q -5 40 -15 55"/>
  <path d="M 0 25 Q 5 40 15 55"/>
</g>

<!-- Stick figure waving -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round">
  <circle cx="0" cy="-35" r="12"/>
  <path d="M 0 -23 Q 2 0 0 25"/>
  <path d="M -20 -5 Q -10 -15 -5 -25"/> <!-- Raised arm -->
  <path d="M 0 -10 Q 10 0 20 5"/> <!-- Normal arm -->
  <path d="M 0 25 Q -5 40 -15 55"/>
  <path d="M 0 25 Q 5 40 15 55"/>
</g>

<!-- Stick figure with expression (happy) -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round">
  <circle cx="0" cy="-35" r="12"/>
  <!-- Eyes -->
  <circle cx="-4" cy="-38" r="1.5" fill="#2563eb"/>
  <circle cx="4" cy="-38" r="1.5" fill="#2563eb"/>
  <!-- Smile -->
  <path d="M -5 -32 Q 0 -28 5 -32"/>
  <path d="M 0 -23 Q 2 0 0 25"/>
  <path d="M -20 -5 Q 0 5 20 -5"/>
  <path d="M 0 25 Q -5 40 -15 55"/>
  <path d="M 0 25 Q 5 40 15 55"/>
</g>
```

### Simple Icons

```svg
<!-- Computer/Screen -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round">
  <path d="M -30 -25 Q -28 -27 0 -26 Q 28 -27 30 -25 Q 32 0 30 20 Q 28 22 0 21 Q -28 22 -30 20 Q -32 0 -30 -25"/>
  <path d="M -10 22 L -15 35 L 15 35 L 10 22"/>
  <path d="M -20 35 Q 0 37 20 35"/>
</g>

<!-- Gear/Cog -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none">
  <circle cx="0" cy="0" r="8"/>
  <path d="M 0 -15 L 0 -12 M 0 12 L 0 15"/>
  <path d="M -15 0 L -12 0 M 12 0 L 15 0"/>
  <path d="M -10 -10 L -8 -8 M 8 8 L 10 10"/>
  <path d="M 10 -10 L 8 -8 M -8 8 L -10 10"/>
</g>

<!-- Robot head -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round">
  <path d="M -20 -15 Q -22 0 -20 15 Q 0 17 20 15 Q 22 0 20 -15 Q 0 -17 -20 -15"/>
  <circle cx="-8" cy="-3" r="5"/>
  <circle cx="8" cy="-3" r="5"/>
  <path d="M -8 8 L 8 8"/>
  <path d="M 0 -15 L 0 -25"/>
  <circle cx="0" cy="-28" r="3"/>
</g>

<!-- Cloud -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none">
  <path d="M -25 10 Q -35 10 -35 0 Q -35 -10 -25 -12 Q -25 -25 -10 -25 Q 5 -30 15 -20 Q 30 -25 35 -10 Q 45 -5 40 5 Q 45 15 30 15 Q 15 20 0 15 Q -15 18 -25 10"/>
</g>

<!-- Database cylinder -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none">
  <ellipse cx="0" cy="-20" rx="25" ry="8"/>
  <path d="M -25 -20 L -25 20"/>
  <path d="M 25 -20 L 25 20"/>
  <ellipse cx="0" cy="20" rx="25" ry="8"/>
</g>

<!-- Lightning bolt -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none" stroke-linejoin="round">
  <path d="M 5 -20 L -10 0 L 0 0 L -5 20 L 15 -5 L 5 -5 Z"/>
</g>

<!-- Heart -->
<g transform="translate(100, 100)" stroke="#dc2626" stroke-width="2" fill="none">
  <path d="M 0 8 Q -15 -5 -15 -12 Q -15 -20 -8 -20 Q 0 -20 0 -12 Q 0 -20 8 -20 Q 15 -20 15 -12 Q 15 -5 0 8"/>
</g>

<!-- Lightbulb (idea) -->
<g transform="translate(100, 100)" stroke="#2563eb" stroke-width="2" fill="none" stroke-linecap="round">
  <path d="M -10 5 Q -18 -5 -15 -18 Q -10 -30 0 -30 Q 10 -30 15 -18 Q 18 -5 10 5"/>
  <path d="M -8 5 L -8 12 Q 0 15 8 12 L 8 5"/>
  <path d="M -5 15 L 5 15"/>
  <path d="M -3 18 L 3 18"/>
</g>
```

### Handwritten Text

```svg
<!-- Title text -->
<text x="400" y="50"
      font-family="'Comic Sans MS', 'Marker Felt', cursive"
      font-size="28" fill="#2563eb"
      text-anchor="middle"
      transform="rotate(-1 400 50)">
  HOW IT WORKS
</text>

<!-- Label text -->
<text x="200" y="150"
      font-family="'Comic Sans MS', 'Marker Felt', cursive"
      font-size="16" fill="#2563eb"
      transform="rotate(2 200 150)">
  API CALLS
</text>

<!-- Small annotation -->
<text x="300" y="250"
      font-family="'Comic Sans MS', 'Marker Felt', cursive"
      font-size="12" fill="#2563eb"
      transform="rotate(-2 300 250)">
  (this part is optional)
</text>

<!-- Numbered step -->
<g transform="translate(100, 100)">
  <circle cx="0" cy="0" r="15" stroke="#2563eb" stroke-width="2" fill="none"/>
  <text x="0" y="5"
        font-family="'Comic Sans MS', 'Marker Felt', cursive"
        font-size="16" fill="#2563eb"
        text-anchor="middle">1</text>
</g>
```

---

## Layout Patterns

### Explainer (Central Concept)

```
              [TITLE with red underline]
                        |
                        v
     [callout] <--- [  CENTRAL   ] ---> [callout]
         ^          [  OBJECT    ]          |
         |               |                  v
    [detail]             v             [detail]
                    [callout]
```

**Implementation notes:**
- Central object is largest (150-200px wide)
- Callouts are smaller (80-120px wide)
- Use curved arrows, not straight
- Arrows should have slight wobble
- Space callouts evenly but imperfectly

### Workflow (Sequential)

```
[Step 1] ----> [Step 2] ----> [Step 3] ----> [Step 4]
    |              |              |              |
    v              v              v              v
 (note)        (note)         (note)         (note)
```

**With branching:**
```
                    /--> [Option A] --\
[Start] ----> [Decision]              [Merge] ----> [End]
                    \--> [Option B] --/
```

**Implementation notes:**
- Maintain roughly horizontal flow
- Steps can be slightly offset vertically
- Notes below are smaller, in parentheses style
- Arrows between steps should curve slightly

### Feature Breakdown

```
    +---------------------------+
    |                           |
    |      PRODUCT NAME         |
    |                           |
    +---------------------------+
       /        |         \
      v         v          v
 [*] Feat1  [*] Feat2  [*] Feat3
      |         |          |
    desc      desc       desc
```

**Implementation notes:**
- Central box is prominent
- Features radiate outward with curved lines
- Each feature has checkmark or star
- Short descriptions below each feature

### Comparison (Before/After)

```
     BEFORE                    AFTER
  +-----------+            +-----------+
  |           |            |           |
  | [X] prob1 |  ------->  | [*] fix1  |
  | [X] prob2 |            | [*] fix2  |
  | [X] prob3 |            | [*] fix3  |
  |           |            |           |
  +-----------+            +-----------+
```

### Architecture Diagram

```
   [User]
      |
      v
  +-------+       +----------+
  |  API  | <---> | Database |
  +-------+       +----------+
      |
      v
  +-------+
  | Cache |
  +-------+
```

---

## Complete Example: Product Explainer

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 500">
  <defs>
    <filter id="sketch">
      <feTurbulence type="turbulence" baseFrequency="0.02" numOctaves="3" result="noise"/>
      <feDisplacementMap in="SourceGraphic" in2="noise" scale="1.5" xChannelSelector="R" yChannelSelector="G"/>
    </filter>
  </defs>

  <!-- Paper background -->
  <rect width="100%" height="100%" fill="#fefefe"/>

  <!-- Ruled lines -->
  <g stroke="#e5e7eb" stroke-width="0.5" opacity="0.5">
    <line x1="0" y1="30" x2="800" y2="30"/>
    <line x1="0" y1="60" x2="800" y2="60"/>
    <line x1="0" y1="90" x2="800" y2="90"/>
    <line x1="0" y1="120" x2="800" y2="120"/>
    <line x1="0" y1="150" x2="800" y2="150"/>
    <line x1="0" y1="180" x2="800" y2="180"/>
    <line x1="0" y1="210" x2="800" y2="210"/>
    <line x1="0" y1="240" x2="800" y2="240"/>
    <line x1="0" y1="270" x2="800" y2="270"/>
    <line x1="0" y1="300" x2="800" y2="300"/>
    <line x1="0" y1="330" x2="800" y2="330"/>
    <line x1="0" y1="360" x2="800" y2="360"/>
    <line x1="0" y1="390" x2="800" y2="390"/>
    <line x1="0" y1="420" x2="800" y2="420"/>
    <line x1="0" y1="450" x2="800" y2="450"/>
    <line x1="0" y1="480" x2="800" y2="480"/>
  </g>

  <!-- Sketch content -->
  <g filter="url(#sketch)">
    <!-- Title -->
    <text x="400" y="50" font-family="'Comic Sans MS', cursive" font-size="28" fill="#2563eb" text-anchor="middle" transform="rotate(-1 400 50)">HOW OUR API WORKS</text>
    <path d="M 250 58 Q 325 62 400 59 Q 475 56 550 60" stroke="#dc2626" stroke-width="2.5" fill="none"/>

    <!-- Central screen -->
    <g transform="translate(400, 220)">
      <path d="M -80 -60 Q -78 -62 0 -61 Q 78 -62 80 -60 Q 82 0 80 55 Q 78 57 0 56 Q -78 57 -80 55 Q -82 0 -80 -60" stroke="#2563eb" stroke-width="2" fill="none"/>
      <path d="M -50 58 L -60 80 L 60 80 L 50 58" stroke="#2563eb" stroke-width="2" fill="none"/>
      <text x="0" y="5" font-family="'Comic Sans MS', cursive" font-size="18" fill="#2563eb" text-anchor="middle">YOUR APP</text>
    </g>

    <!-- Left callout: Request -->
    <g transform="translate(150, 180)">
      <path d="M -50 -30 Q -48 -32 0 -31 Q 48 -32 50 -30 Q 52 0 50 25 Q 48 27 0 26 Q -48 27 -50 25 Q -52 0 -50 -30" stroke="#2563eb" stroke-width="2" fill="none"/>
      <text x="0" y="2" font-family="'Comic Sans MS', cursive" font-size="14" fill="#2563eb" text-anchor="middle">REQUEST</text>
    </g>
    <!-- Arrow to center -->
    <path d="M 205 180 Q 250 175 290 190" stroke="#2563eb" stroke-width="2" fill="none"/>
    <path d="M 280 183 L 290 190 L 278 195" stroke="#2563eb" stroke-width="2" fill="none"/>

    <!-- Right callout: Response -->
    <g transform="translate(650, 180)">
      <path d="M -50 -30 Q -48 -32 0 -31 Q 48 -32 50 -30 Q 52 0 50 25 Q 48 27 0 26 Q -48 27 -50 25 Q -52 0 -50 -30" stroke="#2563eb" stroke-width="2" fill="none"/>
      <text x="0" y="2" font-family="'Comic Sans MS', cursive" font-size="14" fill="#2563eb" text-anchor="middle">RESPONSE</text>
    </g>
    <!-- Arrow from center -->
    <path d="M 510 190 Q 550 175 595 180" stroke="#2563eb" stroke-width="2" fill="none"/>
    <path d="M 585 173 L 595 180 L 583 185" stroke="#2563eb" stroke-width="2" fill="none"/>

    <!-- Bottom callout: Database -->
    <g transform="translate(400, 380)">
      <ellipse cx="0" cy="-20" rx="40" ry="12" stroke="#2563eb" stroke-width="2" fill="none"/>
      <path d="M -40 -20 L -40 15" stroke="#2563eb" stroke-width="2"/>
      <path d="M 40 -20 L 40 15" stroke="#2563eb" stroke-width="2"/>
      <ellipse cx="0" cy="15" rx="40" ry="12" stroke="#2563eb" stroke-width="2" fill="none"/>
      <text x="0" y="50" font-family="'Comic Sans MS', cursive" font-size="14" fill="#2563eb" text-anchor="middle">DATABASE</text>
    </g>
    <!-- Arrow to database -->
    <path d="M 400 285 Q 395 310 400 335" stroke="#2563eb" stroke-width="2" fill="none"/>
    <path d="M 393 325 L 400 335 L 407 325" stroke="#2563eb" stroke-width="2" fill="none"/>

    <!-- Red emphasis on central element -->
    <ellipse cx="400" cy="220" rx="100" ry="80" stroke="#dc2626" stroke-width="2" fill="none" transform="rotate(-3 400 220)"/>

    <!-- Stick figure user -->
    <g transform="translate(80, 220)" stroke="#2563eb" stroke-width="2" fill="none">
      <circle cx="0" cy="-30" r="10"/>
      <path d="M 0 -20 L 0 15"/>
      <path d="M -15 -5 Q 0 5 15 -5"/>
      <path d="M 0 15 L -10 40"/>
      <path d="M 0 15 L 10 40"/>
    </g>
    <text x="80" y="280" font-family="'Comic Sans MS', cursive" font-size="12" fill="#2563eb" text-anchor="middle">USER</text>

    <!-- Checkmarks for features -->
    <g transform="translate(550, 350)">
      <path d="M -5 0 L 0 8 L 15 -10" stroke="#dc2626" stroke-width="2.5" fill="none"/>
      <text x="25" y="2" font-family="'Comic Sans MS', cursive" font-size="12" fill="#2563eb">Fast!</text>
    </g>
    <g transform="translate(550, 380)">
      <path d="M -5 0 L 0 8 L 15 -10" stroke="#dc2626" stroke-width="2.5" fill="none"/>
      <text x="25" y="2" font-family="'Comic Sans MS', cursive" font-size="12" fill="#2563eb">Secure</text>
    </g>
    <g transform="translate(550, 410)">
      <path d="M -5 0 L 0 8 L 15 -10" stroke="#dc2626" stroke-width="2.5" fill="none"/>
      <text x="25" y="2" font-family="'Comic Sans MS', cursive" font-size="12" fill="#2563eb">Simple</text>
    </g>
  </g>
</svg>
```

---

## Mobile-Friendly SVG Rules

All SVGs must render well on mobile (375px width and up):

1. **Always use `viewBox`** — never fixed `width`/`height`. Let SVGs scale responsively.
2. **Minimum text size**: 14px equivalent at viewBox scale. Handwritten text needs to be larger than clean text to remain legible.
3. **Test at 375px wide**: Verify title and key labels remain readable when scaled to mobile width.
4. **Keep compositions simple**: 5-7 main elements max. Complex sketches with many small annotations become unreadable on mobile.
5. **Responsive embed**: Use `width="100%" height="auto"` or CSS `max-width: 100%` in HTML.

## Quality Checklist

Before finalizing:

- [ ] Background looks like notebook paper with ruled lines
- [ ] Uses only blue ink (#2563eb) and red ink (#dc2626)
- [ ] All lines have natural wobble (not perfectly straight)
- [ ] Text is handwritten style with slight rotation
- [ ] Arrows are curved, not straight
- [ ] Shapes are imperfect (not geometric)
- [ ] Red is used only for emphasis (circles, checkmarks, underlines)
- [ ] Could plausibly be drawn by a human
- [ ] Communicates the idea clearly
- [ ] Feels like a 5-minute brainstorm sketch

**Automatic rejection if:**
- Looks like polished vector art
- Has gradients, shadows, or glow effects
- Uses modern UI elements
- Typography is clean and professional
- Lines are perfectly straight
- Colors outside the blue/red palette

---

## Negative Prompt (Must Be Applied)

When using image generation tools, always include these negative constraints:

```
Do NOT generate:
- Flat vector illustrations
- Corporate or SaaS illustration styles
- Clean geometric shapes
- Perfect symmetry
- Modern UI mockups
- Sans-serif digital fonts
- Gradients, shadows, or lighting effects
- Photorealistic people
- High-detail characters
- 3D renders
- Stock illustration aesthetics

If the image looks polished, glossy, or "designed," it is wrong.
```

**Why this matters:** Image generation models default to polished, professional output. Without explicit negative prompting, they will produce clean vector art instead of the intentionally imperfect notebook sketch style this skill requires.

---

## Execution Steps

1. **Understand the concept** - What needs to be explained?
2. **Choose layout pattern** - Explainer, workflow, feature breakdown, comparison?
3. **Identify key elements** - What boxes, arrows, icons are needed?
4. **Create paper background** - White with ruled lines
5. **Draw title** - Handwritten, red underline
6. **Build central element** - Main concept box/screen
7. **Add surrounding callouts** - Related concepts, features
8. **Connect with arrows** - Curved, wobbly arrows showing relationships
9. **Add icons** - Stick figures, gears, simple symbols
10. **Apply red emphasis** - Circle important elements, add checkmarks
11. **Add labels** - Handwritten text with slight rotation
12. **Apply sketch filter** - Extra wobble for authenticity
13. **Final review** - Does it look human-drawn?
