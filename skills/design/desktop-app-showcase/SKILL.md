---
name: desktop-app-showcase
description: Create desktop application showcase graphics in SVG featuring macOS-style window chrome, sidebars, multi-panel layouts, chat interfaces, and code diffs. Use for developer tools, AI assistants, IDE plugins, productivity apps, and desktop software marketing. Output polished app mockups with gradient backgrounds.
---

# Desktop App Showcase Graphics

Create SVG graphics that showcase desktop applications with macOS-style window frames, multi-panel layouts, and professional gradient backgrounds. Think Linear, Raycast, Warp, Cursor, or Claude desktop app marketing.

**Key principle**: Show the app in action with realistic content, not empty states.

## When to Use

- Developer tool landing pages
- AI assistant/copilot marketing
- IDE and code editor showcases
- Desktop app Product Hunt launches
- macOS/Windows app marketing
- CLI tool with GUI wrapper showcases
- Changelog and feature announcements
- Documentation hero images
- App store screenshots

Best for showing **desktop software with multiple panels, sidebars, and real content**.

## Quick Reference

| Pattern | Use Case | Key Elements |
|---------|----------|--------------|
| Three-Column | IDE/dev tools | Sidebar + main + detail panel |
| Two-Column | Chat apps, settings | Sidebar + main content |
| Single Panel | Focused app view | Full window with content |
| Split View | Before/after, diff | Two equal panels side by side |
| Floating Windows | Multi-window apps | Overlapping app windows |

---

## Core Visual Rules

### Canvas & Background

- **Gradient backgrounds** - Purple/blue, blue/teal, or brand colors
- Subtle noise texture optional
- Soft color transitions (not harsh)
- Common sizes: 2560x1600 (retina), 1920x1200, 1440x900

```svg
<!-- Purple/blue gradient (like the example) -->
<linearGradient id="bg-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
  <stop offset="0%" stop-color="#c4b5fd"/>
  <stop offset="30%" stop-color="#a5b4fc"/>
  <stop offset="70%" stop-color="#93c5fd"/>
  <stop offset="100%" stop-color="#a5f3fc"/>
</linearGradient>

<!-- Teal/green gradient -->
<linearGradient id="bg-teal" x1="0%" y1="0%" x2="100%" y2="100%">
  <stop offset="0%" stop-color="#99f6e4"/>
  <stop offset="100%" stop-color="#a5f3fc"/>
</linearGradient>

<!-- Dark/moody gradient -->
<linearGradient id="bg-dark" x1="0%" y1="0%" x2="100%" y2="100%">
  <stop offset="0%" stop-color="#1e1b4b"/>
  <stop offset="100%" stop-color="#0f172a"/>
</linearGradient>
```

### Window Chrome (macOS Style)

| Element | Specification |
|---------|---------------|
| Traffic lights | Red #ef4444, Yellow #eab308, Green #22c55e |
| Traffic light size | 12px diameter, 8px gap between |
| Traffic light position | 20px from left, centered vertically in title bar |
| Title bar height | 40-52px |
| Title bar color | #f9fafb (light) or #1f2937 (dark) |
| Window border radius | 10-12px |
| Window shadow | Large, soft, 20-40px blur |

### Color Palette

| Element | Light Mode | Dark Mode |
|---------|------------|-----------|
| Window bg | #ffffff | #1f2937, #111827 |
| Sidebar bg | #f9fafb, #f3f4f6 | #111827, #0f172a |
| Border | #e5e7eb | #374151 |
| Text primary | #111827 | #f9fafb |
| Text secondary | #6b7280 | #9ca3af |
| Text muted | #9ca3af | #6b7280 |
| Accent | #3b82f6 | #60a5fa |
| Success/add | #22c55e, #dcfce7 | #4ade80, #166534 |
| Error/remove | #ef4444, #fee2e2 | #f87171, #991b1b |

### Typography

- **Font**: InterVariable/Inter — matches your site theme
  - `'InterVariable', 'Inter', sans-serif`
- **Monospace**: `'SF Mono', 'Fira Code', 'JetBrains Mono', monospace`
- **Sizes**:
  - Window title: 13px
  - Section headers: 11-12px, uppercase, letter-spacing
  - Body text: 13-14px
  - Code: 12-13px
  - Small labels: 10-11px

---

## SVG Structure Template

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1400 900">
  <defs>
    <!-- Background gradient -->
    <linearGradient id="bg-gradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#c4b5fd"/>
      <stop offset="50%" stop-color="#a5b4fc"/>
      <stop offset="100%" stop-color="#93c5fd"/>
    </linearGradient>

    <!-- Window shadow -->
    <filter id="window-shadow" x="-10%" y="-10%" width="120%" height="120%">
      <feDropShadow dx="0" dy="10" stdDeviation="30" flood-color="#000" flood-opacity="0.25"/>
    </filter>

    <!-- Subtle inner shadow for depth -->
    <filter id="inner-shadow">
      <feOffset dx="0" dy="1"/>
      <feGaussianBlur stdDeviation="1"/>
      <feComposite operator="out" in="SourceGraphic"/>
      <feColorMatrix values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 0.1 0"/>
      <feBlend in="SourceGraphic"/>
    </filter>
  </defs>

  <!-- Gradient background -->
  <rect width="100%" height="100%" fill="url(#bg-gradient)"/>

  <!-- Main app window -->
  <g id="app-window" filter="url(#window-shadow)" transform="translate(50, 50)">
    <!-- Window frame -->
    <rect width="1300" height="800" rx="12" fill="#fff"/>

    <!-- Title bar -->
    <g id="title-bar">
      <rect width="1300" height="52" rx="12" fill="#f9fafb"/>
      <rect y="40" width="1300" height="12" fill="#f9fafb"/>

      <!-- Traffic lights -->
      <circle cx="24" cy="26" r="6" fill="#ef4444"/>
      <circle cx="44" cy="26" r="6" fill="#eab308"/>
      <circle cx="64" cy="26" r="6" fill="#22c55e"/>

      <!-- Window title (optional) -->
      <text x="650" y="30" font-family="SF Pro Display, system-ui" font-size="13" fill="#374151" text-anchor="middle">App Name</text>
    </g>

    <!-- Sidebar -->
    <g id="sidebar" transform="translate(0, 52)">
      <rect width="240" height="748" fill="#f9fafb"/>
      <line x1="240" y1="0" x2="240" y2="748" stroke="#e5e7eb" stroke-width="1"/>
      <!-- Sidebar content -->
    </g>

    <!-- Main content area -->
    <g id="main-content" transform="translate(240, 52)">
      <rect width="560" height="748" fill="#fff"/>
      <line x1="560" y1="0" x2="560" y2="748" stroke="#e5e7eb" stroke-width="1"/>
      <!-- Main content -->
    </g>

    <!-- Right panel -->
    <g id="right-panel" transform="translate(800, 52)">
      <rect width="500" height="748" fill="#fff"/>
      <!-- Right panel content -->
    </g>
  </g>
</svg>
```

---

## Component Library

### macOS Title Bar

```svg
<!-- Standard title bar with traffic lights -->
<g id="title-bar">
  <rect width="1200" height="52" rx="12" fill="#f9fafb"/>
  <rect y="40" width="1200" height="12" fill="#f9fafb"/>

  <!-- Traffic lights -->
  <g transform="translate(20, 26)">
    <circle cx="0" cy="0" r="6" fill="#ef4444"/>
    <circle cx="20" cy="0" r="6" fill="#eab308"/>
    <circle cx="40" cy="0" r="6" fill="#22c55e"/>
  </g>

  <!-- Centered title -->
  <text x="600" y="30" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#374151" text-anchor="middle">Window Title</text>

  <!-- Right side buttons -->
  <g transform="translate(1100, 14)">
    <rect width="70" height="28" rx="6" fill="#fff" stroke="#e5e7eb"/>
    <text x="35" y="18" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#374151" text-anchor="middle">Open</text>
  </g>
  <g transform="translate(1180, 14)">
    <rect width="90" height="28" rx="6" fill="#111827"/>
    <text x="45" y="18" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#fff" text-anchor="middle">Commit</text>
  </g>
</g>

<!-- Dark mode title bar -->
<g id="title-bar-dark">
  <rect width="1200" height="52" rx="12" fill="#1f2937"/>
  <rect y="40" width="1200" height="12" fill="#1f2937"/>

  <g transform="translate(20, 26)">
    <circle cx="0" cy="0" r="6" fill="#ef4444"/>
    <circle cx="20" cy="0" r="6" fill="#eab308"/>
    <circle cx="40" cy="0" r="6" fill="#22c55e"/>
  </g>

  <text x="600" y="30" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#e5e7eb" text-anchor="middle">Window Title</text>
</g>
```

### Sidebar Navigation

```svg
<!-- Sidebar with sections -->
<g id="sidebar" transform="translate(0, 52)">
  <rect width="240" height="700" fill="#f9fafb"/>

  <!-- Nav items -->
  <g transform="translate(12, 16)">
    <!-- New item with icon -->
    <g>
      <rect width="216" height="32" rx="6" fill="transparent"/>
      <rect x="8" y="8" width="16" height="16" rx="3" fill="#e5e7eb"/>
      <text x="36" y="22" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">New thread</text>
    </g>

    <!-- Section header -->
    <text y="60" font-family="InterVariable, Inter, sans-serif" font-size="11" font-weight="600" fill="#9ca3af" letter-spacing="0.5">THREADS</text>

    <!-- Thread items -->
    <g transform="translate(0, 75)">
      <!-- Active item -->
      <rect width="216" height="36" rx="6" fill="#e5e7eb"/>
      <rect x="8" y="8" width="20" height="20" rx="4" fill="#d1d5db"/>
      <text x="36" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#111827">Codex</text>
      <!-- Nested items -->
      <g transform="translate(24, 40)">
        <text x="16" y="14" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Create Codex app CTA</text>
        <text x="180" y="14" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#9ca3af">4h</text>
      </g>
      <g transform="translate(24, 68)">
        <text x="16" y="14" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Implement dark mode</text>
        <text x="180" y="14" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#9ca3af">8h</text>
      </g>
    </g>
  </g>

  <!-- Border -->
  <line x1="240" y1="0" x2="240" y2="700" stroke="#e5e7eb"/>
</g>
```

### Chat Interface

```svg
<!-- Chat message area -->
<g id="chat-area" transform="translate(240, 52)">
  <rect width="500" height="650" fill="#fff"/>

  <!-- User message bubble -->
  <g transform="translate(50, 30)">
    <rect width="400" height="50" rx="12" fill="#f3f4f6"/>
    <text x="16" y="30" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Create a compelling launch hero for the new Codex app</text>
  </g>

  <!-- Assistant response -->
  <g transform="translate(30, 100)">
    <text y="0" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">
      <tspan x="0" dy="0">I'll update the hero copy to clearly communicate what</tspan>
      <tspan x="0" dy="20">Codex app does, add outcome-focused bullets, and</tspan>
      <tspan x="0" dy="20">ensure the CTAs align with launch goals.</tspan>
    </text>

    <!-- Metadata -->
    <text y="80" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#9ca3af">Thought 7s</text>
    <text y="100" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#9ca3af">Explored 2 files</text>

    <!-- File action items -->
    <g transform="translate(0, 120)">
      <text font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Edited</text>
      <text x="50" font-family="SF Mono, monospace" font-size="13" fill="#374151">hero.tsx</text>
      <path d="M420 4 L424 8 L432 0" stroke="#22c55e" stroke-width="2" fill="none"/>
    </g>

    <g transform="translate(0, 150)">
      <text font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Read</text>
      <text x="50" font-family="SF Mono, monospace" font-size="13" fill="#374151">build.py</text>
    </g>
  </g>

  <!-- Input area at bottom -->
  <g transform="translate(20, 600)">
    <rect width="460" height="80" rx="12" fill="#fff" stroke="#e5e7eb"/>
    <text x="16" y="30" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#9ca3af">Ask Codex anything</text>

    <!-- Model selector -->
    <g transform="translate(16, 45)">
      <text font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#6b7280">+ GPT-5.2-Codex</text>
    </g>

    <!-- Send button -->
    <circle cx="430" cy="40" r="16" fill="#111827"/>
    <path d="M425 40 L430 35 L435 40 M430 35 L430 47" stroke="#fff" stroke-width="2" fill="none"/>
  </g>
</g>
```

### Code Diff Panel

```svg
<!-- Code diff view -->
<g id="diff-panel" transform="translate(740, 52)">
  <rect width="460" height="700" fill="#fff"/>

  <!-- Header -->
  <g transform="translate(16, 16)">
    <text font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#374151">2 files changed</text>
    <text x="110" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#22c55e">+9</text>
    <text x="130" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#ef4444">-6</text>

    <!-- Accept/reject buttons -->
    <text x="400" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#9ca3af">×</text>
    <path d="M420 4 L424 8 L432 0" stroke="#9ca3af" stroke-width="2" fill="none"/>
  </g>

  <!-- File section -->
  <g transform="translate(0, 50)">
    <!-- File header -->
    <rect width="460" height="32" fill="#f9fafb"/>
    <text x="16" y="21" font-family="SF Mono, monospace" font-size="12" fill="#374151">src/hero.tsx</text>
    <text x="120" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#22c55e">+8</text>
    <text x="145" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#ef4444">-5</text>

    <!-- Code lines -->
    <g transform="translate(0, 40)" font-family="SF Mono, monospace" font-size="12">
      <!-- Context line -->
      <text x="16" y="16" fill="#6b7280">export const hero = {</text>

      <!-- Removed lines (red background) -->
      <g transform="translate(0, 24)">
        <rect width="460" height="20" fill="#fee2e2"/>
        <text x="8" y="14" fill="#ef4444">−</text>
        <text x="24" y="14" fill="#991b1b">eyebrow: "New",</text>
      </g>
      <g transform="translate(0, 44)">
        <rect width="460" height="20" fill="#fee2e2"/>
        <text x="8" y="14" fill="#ef4444">−</text>
        <text x="24" y="14" fill="#991b1b">title: "Codex",</text>
      </g>
      <g transform="translate(0, 64)">
        <rect width="460" height="20" fill="#fee2e2"/>
        <text x="8" y="14" fill="#ef4444">−</text>
        <text x="24" y="14" fill="#991b1b">subtitle: "AI for developers",</text>
      </g>

      <!-- Added lines (green background) -->
      <g transform="translate(0, 88)">
        <rect width="460" height="20" fill="#dcfce7"/>
        <text x="8" y="14" fill="#22c55e">+</text>
        <text x="24" y="14" fill="#166534">eyebrow: "Introducing",</text>
      </g>
      <g transform="translate(0, 108)">
        <rect width="460" height="20" fill="#dcfce7"/>
        <text x="8" y="14" fill="#22c55e">+</text>
        <text x="24" y="14" fill="#166534">title: "Codex app",</text>
      </g>
      <g transform="translate(0, 128)">
        <rect width="460" height="20" fill="#dcfce7"/>
        <text x="8" y="14" fill="#22c55e">+</text>
        <text x="24" y="14" fill="#166534">subtitle: "Your AI pair programmer",</text>
      </g>
      <g transform="translate(0, 148)">
        <rect width="460" height="20" fill="#dcfce7"/>
        <text x="8" y="14" fill="#22c55e">+</text>
        <text x="24" y="14" fill="#166534">primaryCta: "Get started",</text>
      </g>
      <g transform="translate(0, 168)">
        <rect width="460" height="20" fill="#dcfce7"/>
        <text x="8" y="14" fill="#22c55e">+</text>
        <text x="24" y="14" fill="#166534">secondaryCta: "Download the CLI",</text>
      </g>

      <!-- Context line -->
      <text x="16" y="204" fill="#6b7280">};</text>
    </g>
  </g>
</g>
```

### Buttons (macOS Style)

```svg
<!-- Primary button (dark) -->
<g>
  <rect width="90" height="28" rx="6" fill="#111827"/>
  <text x="45" y="18" font-family="InterVariable, Inter, sans-serif" font-size="12" font-weight="500" fill="#fff" text-anchor="middle">Commit</text>
</g>

<!-- Secondary button -->
<g>
  <rect width="70" height="28" rx="6" fill="#fff" stroke="#d1d5db"/>
  <text x="35" y="18" font-family="InterVariable, Inter, sans-serif" font-size="12" font-weight="500" fill="#374151" text-anchor="middle">Open</text>
</g>

<!-- Icon button -->
<g>
  <rect width="28" height="28" rx="6" fill="#f3f4f6"/>
  <!-- Icon goes here -->
</g>

<!-- Pill button with icon -->
<g>
  <rect width="100" height="28" rx="14" fill="#f3f4f6"/>
  <text x="50" y="18" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#374151" text-anchor="middle">+ Add</text>
</g>
```

### Status Badges

```svg
<!-- Time badge -->
<text font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#9ca3af">4h</text>

<!-- File change badge -->
<g>
  <text font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#22c55e">+9</text>
  <text x="20" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#ef4444">-6</text>
</g>

<!-- Success checkmark -->
<path d="M0 4 L4 8 L12 0" stroke="#22c55e" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"/>

<!-- Pending dot -->
<circle r="4" fill="#eab308"/>

<!-- Error X -->
<g stroke="#ef4444" stroke-width="2" stroke-linecap="round">
  <path d="M0 0 L8 8"/>
  <path d="M8 0 L0 8"/>
</g>
```

### Folder/File Tree Icons

```svg
<!-- Folder icon -->
<g fill="#eab308">
  <path d="M2 6 L2 18 Q2 20 4 20 L20 20 Q22 20 22 18 L22 10 Q22 8 20 8 L12 8 L10 6 L4 6 Q2 6 2 8"/>
</g>

<!-- File icon -->
<g fill="none" stroke="#6b7280" stroke-width="1.5">
  <path d="M6 2 L6 22 L18 22 L18 8 L12 2 Z"/>
  <path d="M12 2 L12 8 L18 8"/>
</g>

<!-- Code file icon (.tsx, .py) -->
<g>
  <rect width="20" height="24" rx="2" fill="#f3f4f6" stroke="#d1d5db"/>
  <text x="10" y="16" font-family="SF Mono" font-size="8" fill="#6b7280" text-anchor="middle">.tsx</text>
</g>
```

---

## Layout Patterns

### Three-Column (IDE Style)

```
+--[Title Bar]------------------------+
|  •••  |  Title  |  [Btn] [Btn]     |
+-------+-------------+---------------+
|       |             |               |
| Side  |   Main      |   Detail      |
| bar   |   Content   |   Panel       |
|       |             |               |
|       |             |   (code diff, |
|       |             |    preview,   |
|       |             |    settings)  |
|       |             |               |
+-------+-------------+---------------+
```

### Two-Column (Chat App)

```
+--[Title Bar]------------------------+
|  •••  |  Title  |                  |
+-------+----------------------------+
|       |                            |
| Side  |        Chat Area           |
| bar   |                            |
|       |   [Messages]               |
|       |                            |
|       |   [Input Box]              |
+-------+----------------------------+
```

### Split View (Comparison)

```
+--[Title Bar]------------------------+
|  •••  |  Title  |                  |
+----------------+-------------------+
|                |                   |
|   Left Panel   |   Right Panel     |
|   (Before)     |   (After)         |
|                |                   |
+----------------+-------------------+
```

---

## Complete Example: AI Coding Assistant

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1400 900">
  <defs>
    <!-- Background gradient -->
    <linearGradient id="bg" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" stop-color="#c4b5fd"/>
      <stop offset="40%" stop-color="#a5b4fc"/>
      <stop offset="100%" stop-color="#93c5fd"/>
    </linearGradient>

    <!-- Window shadow -->
    <filter id="shadow" x="-5%" y="-5%" width="110%" height="115%">
      <feDropShadow dx="0" dy="8" stdDeviation="24" flood-color="#000" flood-opacity="0.2"/>
    </filter>
  </defs>

  <!-- Gradient background -->
  <rect width="100%" height="100%" fill="url(#bg)"/>

  <!-- Main window -->
  <g filter="url(#shadow)" transform="translate(40, 40)">
    <!-- Window frame -->
    <rect width="1320" height="820" rx="12" fill="#fff"/>

    <!-- Title bar -->
    <rect width="1320" height="48" rx="12" fill="#f9fafb"/>
    <rect y="36" width="1320" height="12" fill="#f9fafb"/>
    <line y1="48" x2="1320" y2="48" stroke="#e5e7eb"/>

    <!-- Traffic lights -->
    <circle cx="24" cy="24" r="6" fill="#ef4444"/>
    <circle cx="44" cy="24" r="6" fill="#eab308"/>
    <circle cx="64" cy="24" r="6" fill="#22c55e"/>

    <!-- Title -->
    <text x="180" y="28" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#374151">Create Codex app CTA</text>
    <g transform="translate(330, 16)">
      <rect width="110" height="20" rx="4" fill="#f3f4f6"/>
      <text x="10" y="14" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#6b7280">📁 openai/codex</text>
    </g>

    <!-- Right buttons -->
    <g transform="translate(1150, 12)">
      <rect width="60" height="26" rx="6" fill="#fff" stroke="#d1d5db"/>
      <text x="30" y="17" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#374151" text-anchor="middle">Open</text>
    </g>
    <g transform="translate(1220, 12)">
      <rect width="80" height="26" rx="6" fill="#1f2937"/>
      <text x="40" y="17" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#fff" text-anchor="middle">⬜ Commit</text>
    </g>

    <!-- Sidebar -->
    <g transform="translate(0, 48)">
      <rect width="240" height="772" fill="#fafafa"/>
      <line x1="240" y1="0" x2="240" y2="772" stroke="#e5e7eb"/>

      <!-- Nav items -->
      <g transform="translate(12, 16)">
        <g transform="translate(0, 0)">
          <rect x="4" y="4" width="16" height="16" rx="3" fill="#e5e7eb"/>
          <text x="32" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">New thread</text>
        </g>
        <g transform="translate(0, 32)">
          <rect x="4" y="4" width="16" height="16" rx="3" fill="#e5e7eb"/>
          <text x="32" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Automations</text>
        </g>
        <g transform="translate(0, 64)">
          <rect x="4" y="4" width="16" height="16" rx="3" fill="#e5e7eb"/>
          <text x="32" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Skills</text>
        </g>
      </g>

      <!-- Threads section -->
      <text x="16" y="140" font-family="InterVariable, Inter, sans-serif" font-size="11" font-weight="500" fill="#9ca3af" letter-spacing="0.5">Threads</text>

      <!-- Thread items -->
      <g transform="translate(12, 155)">
        <!-- Codex group -->
        <g>
          <rect x="4" y="4" width="16" height="16" rx="3" fill="#e5e7eb"/>
          <text x="32" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1f2937">Codex</text>
        </g>
        <g transform="translate(24, 28)">
          <text x="0" y="14" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Create Codex app CTA</text>
          <text x="168" y="14" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#9ca3af">4h</text>
        </g>
        <g transform="translate(24, 52)">
          <text x="0" y="14" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Implement dark mode</text>
          <text x="168" y="14" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#9ca3af">8h</text>
        </g>

        <!-- ChatGPT group -->
        <g transform="translate(0, 90)">
          <rect x="4" y="4" width="16" height="16" rx="3" fill="#e5e7eb"/>
          <text x="32" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1f2937">ChatGPT</text>
        </g>
        <g transform="translate(24, 118)">
          <text x="0" y="14" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Voice mode shortcuts</text>
          <text x="168" y="14" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#9ca3af">2h</text>
        </g>

        <!-- Sora group -->
        <g transform="translate(0, 155)">
          <rect x="4" y="4" width="16" height="16" rx="3" fill="#e5e7eb"/>
          <text x="32" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1f2937">Sora</text>
        </g>
        <g transform="translate(24, 183)">
          <text x="0" y="14" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Persist prompt presets</text>
          <text x="168" y="14" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#9ca3af">5h</text>
        </g>

        <!-- Atlas group -->
        <g transform="translate(0, 220)">
          <rect x="4" y="4" width="16" height="16" rx="3" fill="#e5e7eb"/>
          <text x="32" y="16" font-family="InterVariable, Inter, sans-serif" font-size="13" font-weight="500" fill="#1f2937">Atlas</text>
        </g>
        <g transform="translate(24, 248)">
          <text x="0" y="14" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Add Status filter facet</text>
          <text x="168" y="14" font-family="InterVariable, Inter, sans-serif" font-size="11" fill="#9ca3af">3h</text>
        </g>
      </g>
    </g>

    <!-- Main chat area -->
    <g transform="translate(240, 48)">
      <rect width="520" height="772" fill="#fff"/>
      <line x1="520" y1="0" x2="520" y2="772" stroke="#e5e7eb"/>

      <!-- User message -->
      <g transform="translate(40, 30)">
        <rect width="440" height="50" rx="12" fill="#f3f4f6"/>
        <text x="20" y="30" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#374151">Create a compelling launch hero for the new</text>
        <text x="20" y="48" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#374151">Codex app on openai.com/codex</text>
      </g>

      <!-- Assistant response -->
      <g transform="translate(24, 110)">
        <text font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#374151">
          <tspan x="0" dy="0">I'll update the hero copy to clearly communicate what Codex app</tspan>
          <tspan x="0" dy="22">does, add outcome-focused bullets, and ensure the CTAs align with</tspan>
          <tspan x="0" dy="22">launch goals.</tspan>
        </text>

        <text y="90" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#9ca3af">Thought 7s</text>
        <text y="112" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#9ca3af">Explored 2 files</text>

        <!-- File actions -->
        <g transform="translate(16, 140)">
          <text font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Edited</text>
          <text x="55" font-family="SF Mono, monospace" font-size="13" fill="#374151">hero.tsx</text>
          <path d="M440 5 L444 9 L452 1" stroke="#22c55e" stroke-width="2" fill="none"/>
        </g>
        <g transform="translate(16, 170)">
          <text font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#374151">Read</text>
          <text x="55" font-family="SF Mono, monospace" font-size="13" fill="#374151">build.py</text>
        </g>
        <g transform="translate(16, 200)">
          <text font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">Edited</text>
          <text x="55" font-family="SF Mono, monospace" font-size="13" fill="#374151">build.py</text>
          <path d="M440 5 L444 9 L452 1" stroke="#22c55e" stroke-width="2" fill="none"/>
        </g>

        <!-- Summary -->
        <text y="260" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#374151">
          <tspan x="0" dy="0">Updated the launch hero to emphasize real developer outcomes (repo</tspan>
          <tspan x="0" dy="22">understanding, safe execution, PR delivery), and aligned the CTAs with</tspan>
          <tspan x="0" dy="22">launch intent.</tspan>
        </text>
      </g>

      <!-- Input area -->
      <g transform="translate(24, 660)">
        <rect width="472" height="90" rx="12" fill="#fff" stroke="#e5e7eb"/>
        <text x="20" y="35" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#9ca3af">Ask Codex anything</text>

        <g transform="translate(16, 55)">
          <text font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">+</text>
          <text x="24" font-family="InterVariable, Inter, sans-serif" font-size="13" fill="#6b7280">GPT-5.2-Codex</text>
          <path d="M130 3 L134 7 L138 3" stroke="#9ca3af" stroke-width="1.5" fill="none"/>
        </g>

        <!-- Send button -->
        <circle cx="440" cy="45" r="18" fill="#10b981"/>
        <path d="M435 45 L440 40 L445 45 M440 40 L440 52" stroke="#fff" stroke-width="2" fill="none"/>
      </g>
    </g>

    <!-- Code diff panel -->
    <g transform="translate(760, 48)">
      <rect width="560" height="772" fill="#fff"/>

      <!-- Header -->
      <g transform="translate(20, 20)">
        <text font-family="InterVariable, Inter, sans-serif" font-size="14" font-weight="500" fill="#374151">2 files changed</text>
        <text x="115" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#22c55e">+9</text>
        <text x="140" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#ef4444">-6</text>

        <text x="490" font-family="InterVariable, Inter, sans-serif" font-size="16" fill="#9ca3af">×</text>
        <path d="M510 5 L514 9 L522 1" stroke="#9ca3af" stroke-width="2" fill="none"/>
      </g>

      <!-- hero.tsx file -->
      <g transform="translate(0, 60)">
        <rect width="560" height="32" fill="#f9fafb"/>
        <text x="20" y="21" font-family="SF Mono, monospace" font-size="13" fill="#374151">src/hero.tsx</text>
        <text x="130" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#22c55e">+8</text>
        <text x="155" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#ef4444">-5</text>
        <text x="500" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#9ca3af">×</text>
        <path d="M520 10 L524 14 L532 6" stroke="#9ca3af" stroke-width="2" fill="none"/>
      </g>

      <!-- Code diff content -->
      <g transform="translate(20, 110)" font-family="SF Mono, monospace" font-size="13">
        <text fill="#6b7280">
          <tspan fill="#c084fc">export const</tspan> hero = {
        </text>

        <!-- Removed lines -->
        <g transform="translate(-20, 24)">
          <rect width="560" height="22" fill="#fee2e2"/>
          <text x="12" y="16" fill="#ef4444">−</text>
          <text x="40" y="16" fill="#991b1b">eyebrow: <tspan fill="#a21caf">"New"</tspan>,</text>
        </g>
        <g transform="translate(-20, 46)">
          <rect width="560" height="22" fill="#fee2e2"/>
          <text x="12" y="16" fill="#ef4444">−</text>
          <text x="40" y="16" fill="#991b1b">title: <tspan fill="#a21caf">"Codex"</tspan>,</text>
        </g>
        <g transform="translate(-20, 68)">
          <rect width="560" height="22" fill="#fee2e2"/>
          <text x="12" y="16" fill="#ef4444">−</text>
          <text x="40" y="16" fill="#991b1b">subtitle: <tspan fill="#a21caf">"AI for developers"</tspan>,</text>
        </g>

        <!-- Added lines -->
        <g transform="translate(-20, 94)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534">eyebrow: <tspan fill="#7c3aed">"Introducing"</tspan>,</text>
        </g>
        <g transform="translate(-20, 116)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534">title: <tspan fill="#7c3aed">"Codex app"</tspan>,</text>
        </g>
        <g transform="translate(-20, 138)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534">subtitle: <tspan fill="#7c3aed">"Your AI pair programmer"</tspan>,</text>
        </g>
        <g transform="translate(-20, 160)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534">primaryCta: <tspan fill="#7c3aed">"Get started"</tspan>,</text>
        </g>
        <g transform="translate(-20, 182)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534">secondaryCta: <tspan fill="#7c3aed">"Download the CLI"</tspan>,</text>
        </g>

        <text y="220" fill="#6b7280">};</text>

        <!-- heroBullets section -->
        <text y="260" fill="#6b7280">
          <tspan fill="#c084fc">export const</tspan> heroBullets = [
        </text>

        <g transform="translate(-20, 284)">
          <rect width="560" height="22" fill="#fee2e2"/>
          <text x="12" y="16" fill="#ef4444">−</text>
          <text x="40" y="16" fill="#991b1b"><tspan fill="#a21caf">"Write code faster"</tspan>,</text>
        </g>
        <g transform="translate(-20, 306)">
          <rect width="560" height="22" fill="#fee2e2"/>
          <text x="12" y="16" fill="#ef4444">−</text>
          <text x="40" y="16" fill="#991b1b"><tspan fill="#a21caf">"Understand any repo"</tspan>,</text>
        </g>

        <g transform="translate(-20, 332)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534"><tspan fill="#7c3aed">"Understands your repo in seconds"</tspan>,</text>
        </g>
        <g transform="translate(-20, 354)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534"><tspan fill="#7c3aed">"Executes commands safely in a sandbox"</tspan>,</text>
        </g>
        <g transform="translate(-20, 376)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534"><tspan fill="#7c3aed">"Turns issues into reviewed, production-ready PRs"</tspan>,</text>
        </g>

        <text y="414" fill="#6b7280">];</text>
      </g>

      <!-- build.py file section -->
      <g transform="translate(0, 560)">
        <rect width="560" height="32" fill="#f9fafb"/>
        <text x="20" y="21" font-family="SF Mono, monospace" font-size="13" fill="#374151">tools/build.py</text>
        <text x="140" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#22c55e">+1</text>
        <text x="160" font-family="InterVariable, Inter, sans-serif" font-size="12" fill="#ef4444">-1</text>
        <text x="500" font-family="InterVariable, Inter, sans-serif" font-size="14" fill="#9ca3af">×</text>
        <path d="M520 10 L524 14 L532 6" stroke="#9ca3af" stroke-width="2" fill="none"/>
      </g>

      <g transform="translate(20, 610)" font-family="SF Mono, monospace" font-size="13">
        <text fill="#6b7280">
          <tspan fill="#c084fc">def</tspan> <tspan fill="#3b82f6">build</tspan>():
        </text>

        <g transform="translate(-20, 24)">
          <rect width="560" height="22" fill="#fee2e2"/>
          <text x="12" y="16" fill="#ef4444">−</text>
          <text x="40" y="16" fill="#991b1b">print(<tspan fill="#a21caf">"building"</tspan>)</text>
        </g>
        <g transform="translate(-20, 46)">
          <rect width="560" height="22" fill="#dcfce7"/>
          <text x="12" y="16" fill="#22c55e">+</text>
          <text x="40" y="16" fill="#166534">print(<tspan fill="#7c3aed">"building launch hero..."</tspan>)</text>
        </g>

        <text y="90" fill="#6b7280">
          <tspan fill="#c084fc">if</tspan> __name__ == <tspan fill="#7c3aed">"__main__"</tspan>:
        </text>
        <text y="112" fill="#6b7280">    build()</text>
      </g>
    </g>
  </g>
</svg>
```

---

## Quality Checklist

Before finalizing:

- [ ] Window has proper macOS chrome (traffic lights, title bar)
- [ ] Shadow is soft and appropriately sized
- [ ] Background gradient is smooth and appealing
- [ ] Typography is consistent (system-ui for UI, monospace for code)
- [ ] Panels have clear visual hierarchy
- [ ] Borders and dividers are subtle (#e5e7eb)
- [ ] Code syntax highlighting is readable
- [ ] Diff colors are standard (green for add, red for remove)
- [ ] Content looks realistic (not placeholder text)
- [ ] Overall composition is balanced

**Automatic rejection if:**
- No window shadow (looks flat/pasted on)
- Wrong traffic light colors or sizing
- Inconsistent typography mixing
- Harsh background colors
- Code is unreadable or poorly formatted
- Diff highlighting colors are non-standard

---

## Mobile-Friendly SVG Rules

All SVGs must render well on mobile (375px width and up):

1. **Always use `viewBox`** — never fixed `width`/`height`. Let SVGs scale responsively.
2. **Minimum text size**: 12px equivalent at viewBox scale. Code text can go to 11px minimum.
3. **Test at 375px wide**: Verify window chrome, sidebar labels, and code text remain legible.
4. **Responsive embed**: Use `width="100%" height="auto"` or CSS `max-width: 100%` in HTML.
5. **Simplify panels at small sizes**: Consider reducing to 2-column or single-panel layouts if the full 3-column gets unreadable at mobile widths.

## Execution Steps

1. **Define the app type** - What kind of desktop app? (IDE, chat, settings, etc.)
2. **Choose layout** - Three-column, two-column, split view?
3. **Set canvas and background** - Size, gradient colors
4. **Create window frame** - macOS chrome, shadow
5. **Build sidebar** - Navigation items, sections
6. **Create main content** - Chat messages, file browser, etc.
7. **Add detail panel** - Code diff, preview, settings
8. **Apply typography** - System fonts, proper sizing
9. **Add status elements** - Badges, checkmarks, timestamps
10. **Polish** - Shadows, borders, spacing
11. **Review** - Does it look like a real app?
