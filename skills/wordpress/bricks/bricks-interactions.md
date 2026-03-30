# Bricks Interactions Skill

This skill covers the Interactions system in Bricks Builder for animations and dynamic behaviors.

## Interactions Architecture

### Core File

| File               | Purpose                                               |
| ------------------ | ----------------------------------------------------- |
| `interactions.php` | Interactions class, triggers, actions, and animations |

## Interaction Structure

Each interaction consists of:
- **Trigger**: When the interaction fires
- **Action**: What happens
- **Target**: Which element(s) are affected
- **Animation**: Visual effect (optional)

### JSON Structure

```json
{
  "_interactions": [
    {
      "id": "abc123",
      "trigger": "click",
      "action": "animate",
      "target": ".my-target",
      "animation": "fadeIn",
      "duration": 500,
      "delay": 0,
      "easing": "ease-out"
    }
  ]
}
```

## Triggers

| Trigger          | Description             | Options                |
| ---------------- | ----------------------- | ---------------------- |
| `click`          | Element click           | -                      |
| `mouseenter`     | Mouse enters element    | -                      |
| `mouseleave`     | Mouse leaves element    | -                      |
| `scroll`         | Scroll position         | `offset`, `direction`  |
| `scrollIntoView` | Element enters viewport | `offset`, `rootMargin` |
| `load`           | Page load               | `delay`                |
| `animationEnd`   | CSS animation ends      | -                      |
| `transitionEnd`  | CSS transition ends     | -                      |
| `custom`         | Custom JS event         | `eventName`            |
| `interval`       | Repeated interval       | `interval`             |

### Scroll Trigger Options

```json
{
  "trigger": "scroll",
  "triggerOptions": {
    "direction": "down",
    "offset": 100,
    "unit": "px"
  }
}
```

### Scroll Into View Options

```json
{
  "trigger": "scrollIntoView",
  "triggerOptions": {
    "rootMargin": "-10%",
    "threshold": 0.5,
    "once": true
  }
}
```

## Actions

### Animation Actions

| Action        | Description        |
| ------------- | ------------------ |
| `animate`     | Play CSS animation |
| `animateIn`   | Entrance animation |
| `animateOut`  | Exit animation     |
| `toggle`      | Toggle CSS class   |
| `addClass`    | Add CSS class      |
| `removeClass` | Remove CSS class   |
| `toggleClass` | Toggle CSS class   |

### Navigation Actions

| Action     | Description       |
| ---------- | ----------------- |
| `scrollTo` | Scroll to element |
| `redirect` | Navigate to URL   |
| `hash`     | Update URL hash   |

### Popup Actions

| Action       | Description      |
| ------------ | ---------------- |
| `popup`      | Open/close popup |
| `openPopup`  | Open popup       |
| `closePopup` | Close popup      |

### Video/Audio Actions

| Action  | Description           |
| ------- | --------------------- |
| `video` | Control video element |
| `audio` | Control audio element |

### Custom Actions

| Action         | Description               |
| -------------- | ------------------------- |
| `custom`       | Execute custom JavaScript |
| `setAttribute` | Set element attribute     |
| `setStyle`     | Set inline style          |

## Animations

### Built-in Animations

**Entrance:**
- `fadeIn`, `fadeInUp`, `fadeInDown`, `fadeInLeft`, `fadeInRight`
- `slideInUp`, `slideInDown`, `slideInLeft`, `slideInRight`
- `zoomIn`, `zoomInUp`, `zoomInDown`
- `bounceIn`, `bounceInUp`, `bounceInDown`
- `flipInX`, `flipInY`

**Exit:**
- `fadeOut`, `fadeOutUp`, `fadeOutDown`, `fadeOutLeft`, `fadeOutRight`
- `slideOutUp`, `slideOutDown`, `slideOutLeft`, `slideOutRight`
- `zoomOut`, `zoomOutUp`, `zoomOutDown`
- `bounceOut`

**Attention:**
- `bounce`, `flash`, `pulse`, `rubberBand`, `shake`
- `swing`, `tada`, `wobble`, `jello`, `heartBeat`

### Animation Options

```json
{
  "animation": "fadeIn",
  "duration": 500,
  "delay": 0,
  "easing": "ease-out",
  "iterations": 1,
  "direction": "normal",
  "fillMode": "forwards"
}
```

### Easing Functions

```
ease
ease-in
ease-out
ease-in-out
linear
cubic-bezier(0.4, 0, 0.2, 1)
```

## Target Selectors

| Type         | Example            | Description             |
| ------------ | ------------------ | ----------------------- |
| Self         | (empty)            | Current element         |
| CSS Selector | `.my-class`        | Any matching element(s) |
| ID           | `#my-id`           | Specific element by ID  |
| Bricks ID    | `%elementId%`      | Bricks element by ID    |
| Closest      | `closest: .parent` | Closest ancestor        |
| Find         | `find: .child`     | Descendants             |

### Advanced Targeting

```json
{
  "target": "closest: .card find: .card-image"
}
```

## Interaction Examples

### Toggle Menu

```json
{
  "_interactions": [
    {
      "trigger": "click",
      "action": "toggleClass",
      "target": ".mobile-menu",
      "className": "is-open"
    }
  ]
}
```

### Scroll Reveal

```json
{
  "_interactions": [
    {
      "trigger": "scrollIntoView",
      "action": "animate",
      "animation": "fadeInUp",
      "duration": 600,
      "delay": 100,
      "triggerOptions": {
        "once": true,
        "threshold": 0.2
      }
    }
  ]
}
```

### Animated Counter

```json
{
  "_interactions": [
    {
      "trigger": "scrollIntoView",
      "action": "custom",
      "customAction": "animateCounter",
      "triggerOptions": {
        "once": true
      }
    }
  ]
}
```

### Video Lightbox

```json
{
  "_interactions": [
    {
      "trigger": "click",
      "action": "openPopup",
      "popupId": 123
    }
  ]
}
```

### Sticky Header Transition

```json
{
  "_interactions": [
    {
      "trigger": "scroll",
      "action": "addClass",
      "className": "is-scrolled",
      "triggerOptions": {
        "offset": 100,
        "direction": "down"
      }
    },
    {
      "trigger": "scroll",
      "action": "removeClass",
      "className": "is-scrolled",
      "triggerOptions": {
        "offset": 100,
        "direction": "up"
      }
    }
  ]
}
```

### Tabs/Accordion

```json
{
  "_interactions": [
    {
      "trigger": "click",
      "action": "toggleClass",
      "target": "closest: .accordion-item",
      "className": "is-active"
    },
    {
      "trigger": "click",
      "action": "animate",
      "target": "closest: .accordion-item find: .accordion-content",
      "animation": "slideDown",
      "duration": 300
    }
  ]
}
```

## Custom JavaScript Actions

### Using Custom Action

```json
{
  "_interactions": [
    {
      "trigger": "click",
      "action": "custom",
      "customAction": "myCustomFunction"
    }
  ]
}
```

### Define Custom Function

```javascript
// In custom JavaScript or Code element
window.myCustomFunction = function( element, settings ) {
    // element: The triggering element
    // settings: Interaction settings
    
    console.log( 'Custom action triggered!' );
    
    // Access interaction data
    const target = settings.target;
    
    // Perform custom logic
    // ...
};
```

## Staggered Animations

For animating multiple elements with delay:

```json
{
  "_interactions": [
    {
      "trigger": "scrollIntoView",
      "action": "animate",
      "target": ".grid-item",
      "animation": "fadeInUp",
      "duration": 500,
      "stagger": 100
    }
  ]
}
```

This adds incremental delay to each matched element.

## Interaction Chains

Trigger multiple actions in sequence:

```json
{
  "_interactions": [
    {
      "id": "step1",
      "trigger": "click",
      "action": "addClass",
      "className": "animating"
    },
    {
      "id": "step2", 
      "trigger": "animationEnd",
      "triggerElement": "%step1%",
      "action": "removeClass",
      "className": "animating"
    }
  ]
}
```

## Responsive Interactions

Limit interactions to specific breakpoints:

```json
{
  "_interactions": [
    {
      "trigger": "click",
      "action": "toggleClass",
      "className": "is-open",
      "breakpoints": ["mobile_portrait", "mobile_landscape"]
    }
  ]
}
```

## JavaScript API

### Trigger Interaction Programmatically

```javascript
// Fire all interactions on element
bricksRunInteraction( element );

// Fire specific interaction
bricksRunInteraction( element, 'interaction-id' );
```

### Listen for Interactions

```javascript
// Interaction started
document.addEventListener( 'bricks/interaction/start', function( e ) {
    console.log( 'Interaction started:', e.detail );
});

// Interaction complete
document.addEventListener( 'bricks/interaction/complete', function( e ) {
    console.log( 'Interaction complete:', e.detail );
});
```

## CSS for Interactions

### Initial State (Hidden)

```css
/* Elements that animate in on scroll */
[data-brx-animate-on-scroll] {
    opacity: 0;
    transform: translateY(20px);
}

/* When animation is active */
[data-brx-animate-on-scroll].brx-animated {
    opacity: 1;
    transform: translateY(0);
}
```

### Toggle States

```css
/* Mobile menu closed */
.mobile-menu {
    transform: translateX(-100%);
    transition: transform 0.3s ease;
}

/* Mobile menu open */
.mobile-menu.is-open {
    transform: translateX(0);
}
```

## Performance Optimization

### Intersection Observer

Scroll-into-view animations use Intersection Observer for performant scroll detection:

```javascript
// Bricks automatically uses IntersectionObserver
// No need for scroll event listeners
```

### will-change Property

```css
/* For frequently animated elements */
.animated-element {
    will-change: transform, opacity;
}
```

### Reduce Motion

```css
/* Respect user's reduced motion preference */
@media (prefers-reduced-motion: reduce) {
    .animated-element {
        animation: none !important;
        transition: none !important;
    }
}
```

## Best Practices

1. **Use `once: true`**: For scroll animations that should only play once
2. **Keep animations short**: 200-500ms for most interactions
3. **Avoid animating layout properties**: Prefer transform and opacity
4. **Test on mobile**: Ensure interactions work with touch events
5. **Provide fallbacks**: Elements should be usable without JS
6. **Use hardware acceleration**: Transform triggers GPU acceleration
7. **Stagger carefully**: Don't stagger too many elements (max 10-15)
8. **Avoid infinite animations**: They can be distracting
