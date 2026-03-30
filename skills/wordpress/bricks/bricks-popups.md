# Bricks Popups Skill

This skill covers the popup system in Bricks Builder, including templates, triggers, AJAX loading, and customization.

## Popup Architecture

### Core File

| File         | Purpose                                                        |
| ------------ | -------------------------------------------------------------- |
| `popups.php` | Popups class with controls, rendering, and breakpoint handling |

### Popup Workflow

```
Create Popup Template
    ↓
Design Popup Content
    ↓
Configure Popup Settings (Template Settings)
    ↓
Set Trigger (Interactions on element or auto-trigger)
    ↓
Assign Template Conditions
    ↓
Render in Footer (wp_footer)
```

## Popup Template Creation

### Programmatically Create Popup Template

```php
// Create popup template
$popup_id = wp_insert_post([
    'post_title'  => 'My Popup',
    'post_type'   => BRICKS_DB_TEMPLATE_SLUG,
    'post_status' => 'publish',
]);

// Set template type
update_post_meta( $popup_id, BRICKS_DB_TEMPLATE_TYPE, 'popup' );

// Set popup content
$elements = [
    [
        'id'       => \Bricks\Helpers::generate_random_id( false ),
        'name'     => 'container',
        'parent'   => 0,
        'children' => [],
        'settings' => [
            '_padding' => [
                'top'    => '30px',
                'right'  => '30px',
                'bottom' => '30px',
                'left'   => '30px',
            ],
        ],
    ],
];

update_post_meta( $popup_id, BRICKS_DB_PAGE_CONTENT, $elements );
```

## Popup Settings (Template Settings Panel)

### General Settings

```php
$settings = [
    // Padding around popup container
    'popupPadding' => [
        'top' => '30px', 'right' => '30px', 'bottom' => '30px', 'left' => '30px',
    ],
    
    // Horizontal alignment (justify-content)
    'popupJustifyConent' => 'center', // flex-start, center, flex-end
    
    // Vertical alignment (align-items)
    'popupAlignItems' => 'center', // flex-start, center, flex-end
    
    // Close behavior
    'popupCloseOn' => '', // 'backdrop', 'esc', 'none' (default: both)
    
    // Z-index
    'popupZindex' => 10000,
    
    // Body scroll when popup open
    'popupBodyScroll' => false,
    
    // Scroll to top when popup opens
    'popupScrollToTop' => false,
    
    // Disable auto focus on first focusable element
    'popupDisableAutoFocus' => false,
];
```

### AJAX Loading

```php
$settings = [
    // Fetch content via AJAX (for dynamic context)
    'popupAjax' => true,
    
    // WooCommerce Quick View popup
    'popupIsWoo' => true,
    
    // AJAX Loader settings
    'popupAjaxLoaderAnimation' => 'spinner', // Various animations
    'popupAjaxLoaderColor'     => ['raw' => '#333'],
    'popupAjaxLoaderScale'     => 1,
    'popupAjaxLoaderSelector'  => '.brx-popup-content',
];
```

### Info Box (Map Markers)

```php
$settings = [
    // Enable for map info boxes
    'popupIsInfoBox' => true,
    
    // Info box width in pixels
    'popupInfoBoxWidth' => 300,
];
```

### Breakpoints

```php
$settings = [
    // Breakpoint mode
    'popupBreakpointMode' => 'at', // 'at' (start at breakpoint) or 'on' (show on specific breakpoints)
    
    // Start showing at this breakpoint
    'popupShowAt' => 'tablet_portrait', // breakpoint key
    
    // Show only on these breakpoints (when mode is 'on')
    'popupShowOn' => ['desktop', 'laptop'], // array of breakpoint keys
];
```

### Backdrop Settings

```php
$settings = [
    // Disable backdrop entirely
    'popupDisableBackdrop' => false,
    
    // Backdrop background
    'popupBackground' => [
        'color' => ['raw' => 'rgba(0,0,0,0.5)'],
    ],
    
    // Backdrop transition
    'popupBackdropTransition' => 'opacity 0.3s ease',
];
```

### Content Settings

```php
$settings = [
    'popupContentPadding'    => ['top' => '30px', 'right' => '30px', 'bottom' => '30px', 'left' => '30px'],
    'popupContentWidth'      => '600px',
    'popupContentMinWidth'   => '300px',
    'popupContentMaxWidth'   => '90vw',
    'popupContentHeight'     => 'auto',
    'popupContentMinHeight'  => '200px',
    'popupContentMaxHeight'  => '90vh',
    'popupContentBackground' => ['color' => ['raw' => '#ffffff']],
    'popupContentBorder'     => [
        'radius' => ['top' => '8px', 'right' => '8px', 'bottom' => '8px', 'left' => '8px'],
    ],
    'popupContentBoxShadow' => [
        'values' => ['blur' => '20', 'offsetY' => '10'],
        'color'  => ['raw' => 'rgba(0,0,0,0.15)'],
    ],
];
```

### Popup Limits

```php
$settings = [
    // Limit per page load
    'popupLimitWindow' => 1,
    
    // Limit per session (sessionStorage)
    'popupLimitSessionStorage' => 1,
    
    // Limit across sessions (localStorage)
    'popupLimitLocalStorage' => 1,
    
    // Show again after X hours
    'popupLimitTimeStorage' => 24,
];
```

## Popup Triggers (Interactions)

### Open Popup via Interaction

Add interaction to any element:

```json
{
  "_interactions": [
    {
      "trigger": "click",
      "action": "popup",
      "popup": {
        "type": "open",
        "id": 123,
        "animation": "fadeIn",
        "duration": 300
      }
    }
  ]
}
```

### Trigger Types

| Trigger       | Description                |
| ------------- | -------------------------- |
| `click`       | On element click           |
| `hover`       | On element hover           |
| `load`        | On page load               |
| `scroll`      | On scroll position         |
| `exit-intent` | When mouse leaves viewport |
| `custom`      | Custom JavaScript event    |

### Animations

| Animation      | Description       |
| -------------- | ----------------- |
| `fadeIn`       | Fade in           |
| `fadeOut`      | Fade out          |
| `slideInUp`    | Slide from bottom |
| `slideInDown`  | Slide from top    |
| `slideInLeft`  | Slide from left   |
| `slideInRight` | Slide from right  |
| `zoomIn`       | Scale up          |
| `zoomOut`      | Scale down        |

## JavaScript API

### Open Popup

```javascript
// Open popup by template ID
bricksOpenPopup( popupId, contextId );

// With options
bricksOpenPopup( 123, {
    postId: 456,      // Post context for dynamic data
    termId: 789,      // Term context
    userId: 1,        // User context
});
```

### Close Popup

```javascript
// Close specific popup
bricksClosePopup( popupId );

// Close all popups
bricksCloseAllPopups();
```

### Popup Events

```javascript
// Popup opened
document.addEventListener( 'bricks/popup/open', function( e ) {
    console.log( 'Popup opened:', e.detail.popupId );
});

// Popup closed
document.addEventListener( 'bricks/popup/close', function( e ) {
    console.log( 'Popup closed:', e.detail.popupId );
});

// AJAX popup content loaded
document.addEventListener( 'bricks/popup/ajax/loaded', function( e ) {
    console.log( 'AJAX content loaded:', e.detail.popupId );
});
```

## PHP Rendering

### Generate Popup HTML

```php
// Get popup HTML
$html = \Bricks\Popups::generate_popup_html( $popup_id );

// Build looping popup (inside query loops)
\Bricks\Popups::build_looping_popup_html( $popup_id );
```

### Render Popup Content

```php
// Get popup elements
$elements = \Bricks\Database::get_data( $popup_id );

// Render popup content
$content = \Bricks\Frontend::render_data( $elements, 'popup' );
```

## Popup Hooks

### Filters

```php
// Modify popup attributes
add_filter( 'bricks/popup/attributes', function( $attributes, $popup_id ) {
    $attributes['data-custom'] = 'value';
    $attributes['class'][]     = 'my-custom-popup';
    return $attributes;
}, 10, 2 );
```

### Template Settings Filters

Popup settings can be controlled via Theme Styles:

```php
// Access Theme Style popup settings
$close_on = \Bricks\Theme_Styles::get_setting_by_key( 'popup', 'popupCloseOn' );
$show_at  = \Bricks\Theme_Styles::get_setting_by_key( 'popup', 'popupShowAt' );
```

## AJAX Popup Loading

### How It Works

1. Click trigger opens popup shell
2. AJAX request fetches popup content with context
3. Content is inserted into popup
4. JavaScript is initialized for dynamic elements

### Context Passing

```javascript
// Pass context when opening AJAX popup
bricksOpenPopup( 123, {
    postId: currentPostId,    // For post context
    termId: currentTermId,    // For term context
    userId: currentUserId,    // For user context
});
```

### Server-Side Rendering

```php
// REST API endpoint handles AJAX popup content
// bricks/v1/render_popup_content

// Action before rendering
add_action( 'bricks/render_popup_content/start', function( $request_data ) {
    // Setup before popup content is rendered
    $post_id = $request_data['postId'] ?? 0;
}, 10, 1 );
```

## Popup HTML Structure

```html
<div class="brx-popup brxe-popup-{id}" data-popup-id="{id}">
    <!-- Backdrop -->
    <div class="brx-popup-backdrop"></div>
    
    <!-- Content wrapper -->
    <div class="brx-popup-content">
        <!-- Popup elements rendered here -->
    </div>
</div>
```

## CSS Selectors

```css
/* Popup container */
.brx-popup { }

/* Specific popup by ID */
.brxe-popup-123 { }

/* Backdrop */
.brx-popup .brx-popup-backdrop { }

/* Content area */
.brx-popup .brx-popup-content { }

/* Open state */
.brx-popup.brx-open { }

/* Transition states */
.brx-popup.brx-popup-entering { }
.brx-popup.brx-popup-leaving { }
```

## Popup Limit Storage

Popup limits use browser storage:

```javascript
// Per page load (window variable)
window.brx_popup_{id}_total

// Per session
sessionStorage.brx_popup_{id}_total

// Across sessions
localStorage.brx_popup_{id}_total

// Time-based storage
localStorage.brx_popup_{id}_timestamp
```

## WooCommerce Quick View

For product quick view popups:

1. Create popup template with single product elements
2. Enable `popupAjax` setting
3. Enable `popupIsWoo` setting
4. Add interaction trigger on product archive item

```php
// The popup receives product context automatically
// Use single product elements inside the popup template
```

## Map Info Box Popups

For Google/Leaflet map marker popups:

1. Create popup template
2. Enable `popupIsInfoBox` setting
3. Set `popupInfoBoxWidth`
4. Reference popup in map marker settings

```php
// Info box popups behave differently:
// - No backdrop
// - Positioned relative to marker
// - Different close behavior
```

## Best Practices

1. **Use AJAX for loops**: Enable AJAX loading for popups inside query loops
2. **Set appropriate limits**: Prevent popup fatigue with session/local limits
3. **Optimize content**: Keep popup content lightweight for fast loading
4. **Test accessibility**: Ensure keyboard navigation and screen readers work
5. **Set breakpoints**: Hide popups on small screens if appropriate
6. **Use animations wisely**: Keep animations fast (200-300ms)
7. **Handle close properly**: Always provide a way to close the popup
8. **Preload critical popups**: Use `popupLoad` interaction for important popups
