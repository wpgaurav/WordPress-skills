# Bricks Assets Skill

This skill covers the CSS and JavaScript asset generation and optimization system in Bricks Builder.

## Assets Architecture

### Core File

| File         | Purpose                                        |
| ------------ | ---------------------------------------------- |
| `assets.php` | Assets class for CSS/JS generation and loading |

### Asset Types

| Type               | Description                     | Storage                      |
| ------------------ | ------------------------------- | ---------------------------- |
| CSS Files          | Generated from element settings | `wp-content/uploads/bricks/` |
| Theme Styles CSS   | Global theme styles             | Inline or file               |
| Global Classes CSS | Custom CSS classes              | Inline or file               |
| Custom CSS         | Per-page custom CSS             | Inline or file               |
| Scripts            | JavaScript dependencies         | Enqueued or inline           |

## CSS Generation

### Asset Generation Flow

```
Builder Save
    ↓
Extract Element Settings
    ↓
Generate CSS from Settings
    ↓
Save to CSS File (or inline)
    ↓
Frontend Request
    ↓
Load CSS File/Inline
```

### CSS File Naming

```
/wp-content/uploads/bricks/
├── css/
│   ├── post-{post_id}.min.css      // Page CSS
│   ├── template-{template_id}.min.css // Template CSS
│   ├── theme-styles.min.css        // Theme styles
│   └── global-classes.min.css      // Global classes
```

## Asset Settings (Bricks Settings)

### CSS Loading

```php
// Bricks Settings > Performance
$settings = [
    // CSS loading method
    'cssLoading' => 'file', // 'file' or 'inline'
    
    // Disable CSS file generation
    'disableCssFilesGeneration' => false,
    
    // External CSS files
    'externalCssFiles' => false, // Load from CDN-style URL
    
    // Cache CSS files
    'cacheQueryLoops' => true,
];
```

### Script Loading

```php
$settings = [
    // Load scripts in footer
    'scriptsInFooter' => true,
    
    // Disable jQuery
    'disablejQuery' => false,
    
    // Bundle scripts
    'bundleScripts' => false,
];
```

## CSS Generation Hooks

### Filters

```php
// Modify generated inline CSS
add_filter( 'bricks/frontend/inline_css', function( $css, $post_id ) {
    // Add custom CSS
    $css .= '.my-class { color: red; }';
    return $css;
}, 10, 2 );

// Modify element CSS before generation
add_filter( 'bricks/element/settings', function( $settings, $element ) {
    return $settings;
}, 10, 2 );

// Modify CSS file path
add_filter( 'bricks/assets/css_file_path', function( $path, $post_id ) {
    return $path;
}, 10, 2 );

// Modify CSS file URL
add_filter( 'bricks/assets/css_file_url', function( $url, $post_id ) {
    return $url;
}, 10, 2 );

// Control which CSS files to generate
add_filter( 'bricks/assets/generate_css_files', function( $generate, $post_id ) {
    return $generate;
}, 10, 2 );
```

### Actions

```php
// After CSS file generated
add_action( 'bricks/assets/css_file_generated', function( $post_id, $css ) {
    // Clear CDN cache, etc.
}, 10, 2 );

// Before CSS file generation
add_action( 'bricks/assets/before_generate_css_file', function( $post_id ) {
    // Setup before generation
}, 10, 1 );
```

## Regenerate Assets

### Via Admin

Navigate to **Bricks > Settings > Performance** and click "Regenerate CSS files".

### Via WP-CLI

```bash
# Regenerate all CSS files
wp bricks regenerate_assets

# Regenerate specific post
wp bricks regenerate_assets --post_id=123
```

### Programmatically

```php
// Regenerate all assets
\Bricks\Assets::regenerate_css_files();

// Regenerate specific post
\Bricks\Assets::generate_css_file( $post_id );

// Delete CSS file
\Bricks\Assets::delete_css_file( $post_id );
```

## Inline CSS Generation

### From Element Settings

```php
// Generate inline CSS from element
$css = \Bricks\Assets::generate_inline_css_from_element( 
    $element,           // Element settings
    $controls,          // Control definitions
    $context = ''       // Context (e.g., 'popup')
);
```

### CSS Property Mapping

Controls with `css` property auto-generate CSS:

```php
$controls['backgroundColor'] = [
    'label' => 'Background',
    'type'  => 'color',
    'css'   => [
        [
            'property' => 'background-color',
            'selector' => '', // Root element
        ],
    ],
];

// Generates: .brxe-{element_id} { background-color: #value; }
```

## Script Enqueuing

### Element Scripts

Elements can specify script dependencies:

```php
class Element_My_Custom extends \Bricks\Element {
    public $scripts = ['swiper', 'gsap'];
    
    public function enqueue_scripts() {
        // Enqueue additional scripts
        wp_enqueue_script( 'my-custom-script', 'path/to/script.js', [], '1.0', true );
    }
}
```

### Available Scripts

| Script Handle | Description       |
| ------------- | ----------------- |
| `swiper`      | Slider library    |
| `gsap`        | Animation library |
| `isotope`     | Masonry/filtering |
| `photoswipe`  | Lightbox          |
| `splide`      | Carousel          |
| `mapbox`      | Mapbox maps       |
| `leaflet`     | Leaflet maps      |
| `google-maps` | Google Maps       |

### Custom Script Dependencies

```php
// Add script dependency
add_filter( 'bricks/element/{element_name}/scripts', function( $scripts ) {
    $scripts[] = 'my-custom-script';
    return $scripts;
} );
```

## Asset Optimization

### Recommended Settings

```php
$optimized_settings = [
    // Load CSS as external file
    'cssLoading' => 'file',
    
    // Enable CSS file generation
    'disableCssFilesGeneration' => false,
    
    // Load scripts in footer
    'scriptsInFooter' => true,
    
    // Cache query loops
    'cacheQueryLoops' => true,
];
```

### Minification

Bricks automatically minifies:
- CSS files (`.min.css`)
- Inline CSS

### Critical CSS

For critical CSS handling:

```php
// Add custom critical CSS
add_action( 'wp_head', function() {
    echo '<style id="critical-css">';
    // Critical styles here
    echo '</style>';
}, 1 );
```

## Asset File Paths

### Get Asset Paths

```php
// Get CSS file path
$path = \Bricks\Assets::get_css_file_path( $post_id );

// Get CSS file URL
$url = \Bricks\Assets::get_css_file_url( $post_id );

// Get uploads directory
$uploads_dir = \Bricks\Assets::get_uploads_dir();

// Get uploads URL
$uploads_url = \Bricks\Assets::get_uploads_url();
```

### Directory Structure

```
/wp-content/uploads/bricks/
├── css/
│   ├── post-123.min.css
│   ├── template-456.min.css
│   └── ...
├── fonts/
│   └── custom-font.woff2
└── images/
    └── ...
```

## Global Classes CSS

### Generation

```php
// Global classes are stored in options and generate CSS
// bricks_global_classes → CSS

$global_classes = [
    [
        'id'       => 'abc123',
        'name'     => 'my-button',
        'settings' => [
            'backgroundColor' => ['hex' => '#ff0000'],
            '_padding' => ['top' => '10px', 'right' => '20px', ...],
        ],
    ],
];
```

### CSS Output

```css
.my-button {
    background-color: #ff0000;
    padding: 10px 20px 10px 20px;
}
```

## Theme Styles CSS

Theme styles generate CSS for:
- Typography
- Colors
- Buttons
- Forms
- Layout
- Custom element defaults

### Selector Scope

```css
/* Theme styles use body scope */
body .brxe-button { ... }
body .brxe-heading { ... }
```

## Performance Tips

1. **Use CSS file loading**: External files cache better than inline
2. **Enable file generation**: Don't disable unless necessary
3. **Regenerate after changes**: Always regenerate after theme style updates
4. **Minimize custom CSS**: Use controls instead of custom CSS when possible
5. **Lazy load scripts**: Only load scripts needed on each page
6. **Use WP-CLI for bulk**: Regenerate with WP-CLI after migrations
7. **CDN compatibility**: Use external CSS files for CDN caching

## Troubleshooting

### CSS Not Updating

1. Regenerate CSS files in Bricks settings
2. Clear browser cache
3. Clear CDN/caching plugin cache
4. Check file permissions on uploads folder

### CSS File Not Loading

1. Check if CSS file exists in uploads/bricks/css/
2. Verify CSS loading setting is "file"
3. Check for 404 errors in browser console
4. Verify file URL is accessible

### Missing Styles

1. Ensure element has settings that generate CSS
2. Check if control has `css` property defined
3. Verify breakpoint-specific styles are generated
4. Check inline vs file CSS loading mode
