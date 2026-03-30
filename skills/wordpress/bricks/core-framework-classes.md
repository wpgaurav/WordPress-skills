# Core Framework CSS Quick Reference

This document provides a quick reference for the Core Framework utility classes included with Bricks Builder.

> **Source File**: `core-framework.css` (3136 lines)

## CSS Custom Properties (Variables)

### Colors

**Primary Color Scale:**
```css
--primary: #2364a9;
--primary-5 through --primary-90  /* Opacity variants */
--primary-d-1 through --primary-d-4  /* Darker shades */
--primary-l-1 through --primary-l-4  /* Lighter shades */
```

**Secondary Color Scale:**
```css
--secondary: #3fa6d9;
--secondary-5 through --secondary-90
--secondary-d-1 through --secondary-d-4
--secondary-l-1 through --secondary-l-4
```

**Tertiary Color Scale:**
```css
--tertiary: #F5C301;
--tertiary-5 through --tertiary-90
--tertiary-d-1 through --tertiary-d-4
--tertiary-l-1 through --tertiary-l-4
```

**Base Colors:**
```css
--base: #161616;
--bg-body: #e6e6e6;
--bg-surface: #ffffff;
--text-body: hsl(0, 0%, 25%);
--text-title: hsl(0, 0%, 0%);
```

**Light/Dark:**
```css
--light: #ffffff;
--light-5 through --light-90
--dark: #000000;
--dark-5 through --dark-90
```

**Status Colors:**
```css
--success: hsl(136, 95%, 56%);
--success-5 through --success-90
--error: hsl(351, 95%, 56%);
--error-5 through --error-90
```

### Spacing Scale

```css
--space-4xs: clamp(0.52rem, ...)
--space-3xs: clamp(0.66rem, ...)
--space-2xs: clamp(0.82rem, ...)
--space-xs:  clamp(1.02rem, ...)
--space-s:   clamp(1.28rem, ...)
--space-m:   clamp(1.6rem, ...)
--space-l:   clamp(2rem, ...)
--space-xl:  clamp(2.5rem, ...)
--space-2xl: clamp(3.13rem, ...)
--space-3xl: clamp(3.91rem, ...)
--space-4xl: clamp(4.88rem, ...)
```

### Typography Scale

```css
--text-xs:  clamp(1.09rem, ...)  /* ~11px */
--text-s:   clamp(1.36rem, ...)  /* ~14px */
--text-m:   clamp(1.7rem, ...)   /* ~17px */
--text-l:   clamp(2.13rem, ...)  /* ~21px */
--text-xl:  clamp(2.66rem, ...)  /* ~27px */
--text-2xl: clamp(3.32rem, ...)  /* ~33px */
--text-3xl: clamp(4.15rem, ...)  /* ~42px */
--text-4xl: clamp(5.19rem, ...)  /* ~52px */
```

### Border Radius

```css
--radius-xs:   clamp(0.4rem, ...)
--radius-s:    clamp(0.6rem, ...)
--radius-m:    clamp(1rem, ...)
--radius-l:    clamp(1.6rem, ...)
--radius-xl:   clamp(2.6rem, ...)
--radius-full: 999rem;
```

### Shadows

```css
--shadow-xs: 0 1px 2px var(--shadow-primary);
--shadow-s:  0 1.5px 3px var(--shadow-primary);
--shadow-m:  0 2px 6px var(--shadow-primary);
--shadow-l:  0 3px 12px var(--shadow-primary);
--shadow-xl: 0 6px 48px var(--shadow-primary);
```

### Grid Columns

```css
--columns-1 through --columns-12
/* Example: --columns-3: repeat(3, minmax(0, 1fr)); */
```

## Component Classes

### Buttons (.btn)

```css
.btn              /* Primary button */
.btn.small        /* Small size */
.btn.large        /* Large size */
.btn.secondary    /* Secondary style */
.btn.tertiary     /* Tertiary style */
.btn.ghost        /* Transparent background */
.btn.slight       /* Subtle style */
.btn.no-bg        /* No background */
```

### Badge (.badge)

```css
.badge            /* Default badge */
.badge.secondary  /* Secondary style */
```

### Link (.link)

```css
.link             /* Styled link */
.link.secondary   /* Secondary color */
.link.tertiary    /* Tertiary color */
```

### Input (.input)

```css
.input            /* Form input */
/* States: :focus, :hover, :invalid, :disabled */
```

### Select (.select)

```css
.select           /* Dropdown select */
/* States: :focus, :hover, :invalid, :disabled */
```

### Card (.card)

```css
.card             /* Card container */
.card.primary     /* Primary background */
.card.secondary   /* Secondary background */
```

### Icon (.icon)

```css
.icon             /* Icon element */
.icon.small       /* Small size */
.icon.large       /* Large size */
.icon.secondary   /* Secondary color */
.icon.tertiary    /* Tertiary color */
.icon.outline     /* With border */
.icon.filled      /* With background */
```

### Avatar (.avatar)

```css
.avatar           /* Avatar image */
.avatar.small     /* Small size */
.avatar.large     /* Large size */
```

### Divider (.divider)

```css
.divider          /* Horizontal divider */
.divider.vertical /* Vertical divider */
```

### Form Elements

```css
.checkbox         /* Custom checkbox */
.radio            /* Custom radio button */
```

### Expand Click (.expand-click)

```css
.expand-click     /* Makes child link cover entire parent */
```

## Utility Classes

### Background Colors

```css
.bg-primary, .bg-primary-5, .bg-primary-10, ... .bg-primary-90
.bg-primary-d-1, .bg-primary-d-2, .bg-primary-d-3, .bg-primary-d-4
.bg-primary-l-1, .bg-primary-l-2, .bg-primary-l-3, .bg-primary-l-4

.bg-secondary (same pattern as primary)
.bg-tertiary (same pattern as primary)
.bg-base (same pattern as primary)
.bg-light (same pattern as primary)
.bg-dark (same pattern as primary)
.bg-success (same pattern as primary)
.bg-error (same pattern as primary)

.bg-body          /* Body background */
.bg-surface       /* Surface background */
```

### Text Colors

```css
.text-primary, .text-primary-5, ... .text-primary-90
.text-primary-d-1, .text-primary-d-2, .text-primary-d-3, .text-primary-d-4
.text-primary-l-1, .text-primary-l-2, .text-primary-l-3, .text-primary-l-4

.text-secondary (same pattern)
.text-tertiary (same pattern)
.text-base (same pattern)
.text-light (same pattern)
.text-dark (same pattern)
.text-success (same pattern)
.text-error (same pattern)

.text-body        /* Body text color */
.text-title       /* Title text color */
```

### Border Colors

```css
.border-primary, .border-primary-5, ... .border-primary-90
.border-primary-d-1 through .border-primary-d-4
.border-primary-l-1 through .border-primary-l-4

/* Same pattern for: secondary, tertiary, base, light, dark, success, error */
```

## Dark Mode

### Theme Classes

```css
html.cf-theme-dark { }       /* Dark mode enabled */
html.cf-theme-light { }      /* Light mode enabled */
.theme-inverted { }          /* Inverted theme */
.theme-always-light { }      /* Always light */
.theme-always-dark { }       /* Always dark */
```

Dark mode automatically adjusts all color variables.

## Usage in Bricks

### In Element Settings

Apply Core Framework classes via `_cssGlobalClasses`:

```json
{
  "settings": {
    "_cssGlobalClasses": ["btn", "btn-primary"]
  }
}
```

### In Custom CSS

Reference variables:

```css
.my-element {
    background: var(--primary);
    padding: var(--space-m);
    font-size: var(--text-m);
    border-radius: var(--radius-m);
    box-shadow: var(--shadow-m);
}
```

### Responsive Variables

All spacing and typography use `clamp()` for fluid scaling between 320px and 1440px viewport widths.

## Best Practices

1. **Use variables over hardcoded values**
2. **Leverage component classes** for consistent UI elements
3. **Use spacing scale** for consistent margins/padding
4. **Use typography scale** for font sizes
5. **Apply dark mode** via `.cf-theme-dark` class on html
6. **Use opacity variants** for backgrounds (-5 through -90)
7. **Use shade variants** for contrast (-d-1 through -l-4)
