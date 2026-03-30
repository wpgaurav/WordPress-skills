---
name: bricks-templates
description: Create and work with Bricks templates programmatically.
---

# Bricks Templates Skill

This skill covers creating and working with Bricks templates programmatically.

## Template Types

Bricks supports these template types (stored in `_bricks_template_type` meta):

| Type | Purpose | Meta Key for Content |
|------|---------|---------------------|
| `header` | Site header | `_bricks_page_header_2` |
| `footer` | Site footer | `_bricks_page_footer_2` |
| `content` | Single post/page content | `_bricks_page_content_2` |
| `section` | Reusable section | `_bricks_page_content_2` |
| `archive` | Archive pages | `_bricks_page_content_2` |
| `search` | Search results | `_bricks_page_content_2` |
| `error` | 404 error page | `_bricks_page_content_2` |
| `popup` | Popup/modal | `_bricks_page_content_2` |
| `password_protection` | Password protected content | `_bricks_page_content_2` |

## Post Type & Taxonomies

```php
// Post type slug
BRICKS_DB_TEMPLATE_SLUG = 'bricks_template'

// Taxonomies
BRICKS_DB_TEMPLATE_TAX_TAG = 'template_tag'
BRICKS_DB_TEMPLATE_TAX_BUNDLE = 'template_bundle'
```

## Creating Templates Programmatically

### Basic Template Creation

```php
/**
 * Create a Bricks template programmatically
 */
function create_bricks_template( $title, $type, $elements = [] ) {
    // Create the template post
    $template_id = wp_insert_post( [
        'post_title'  => $title,
        'post_type'   => BRICKS_DB_TEMPLATE_SLUG,
        'post_status' => 'publish',
    ] );

    if ( is_wp_error( $template_id ) ) {
        return $template_id;
    }

    // Set template type
    update_post_meta( $template_id, BRICKS_DB_TEMPLATE_TYPE, $type );

    // Set template content based on type
    $meta_key = BRICKS_DB_PAGE_CONTENT;
    if ( $type === 'header' ) {
        $meta_key = BRICKS_DB_PAGE_HEADER;
    } elseif ( $type === 'footer' ) {
        $meta_key = BRICKS_DB_PAGE_FOOTER;
    }

    if ( ! empty( $elements ) ) {
        update_post_meta( $template_id, $meta_key, $elements );
    }

    return $template_id;
}
```

### Element Data Structure

Templates store elements as arrays with this structure:

```php
$elements = [
    [
        'id'       => 'abc123', // 6-character alphanumeric ID
        'name'     => 'section',
        'parent'   => 0, // 0 for root, or parent element ID
        'children' => [ 'def456' ], // Child element IDs
        'settings' => [
            // Element-specific settings
        ],
    ],
    [
        'id'       => 'def456',
        'name'     => 'heading',
        'parent'   => 'abc123',
        'children' => [],
        'settings' => [
            'text' => 'Hello World',
            'tag'  => 'h1',
        ],
    ],
];
```

### Example: Create Header Template

```php
function create_header_template() {
    $elements = [
        [
            'id'       => Bricks\Helpers::generate_random_id( false ),
            'name'     => 'section',
            'parent'   => 0,
            'children' => [],
            'settings' => [
                'tag'      => 'header',
                '_padding' => [
                    'top'    => '20px',
                    'right'  => '40px',
                    'bottom' => '20px',
                    'left'   => '40px',
                ],
            ],
        ],
    ];

    return create_bricks_template( 'My Header', 'header', $elements );
}
```

## Template Conditions

Templates use conditions to determine when they apply. Set via `_bricks_template_settings` meta:

```php
$template_settings = [
    'templateConditions' => [
        [
            'main'    => 'postType',
            'sub'     => 'post',
            'compare' => '==',
        ],
    ],
];

update_post_meta( $template_id, BRICKS_DB_TEMPLATE_SETTINGS, $template_settings );
```

### Condition Types

| Main | Sub Options | Description |
|------|-------------|-------------|
| `entireWebsite` | - | Applies everywhere |
| `frontpage` | - | Front page only |
| `postType` | `post`, `page`, `{cpt}` | Specific post type |
| `archiveType` | `author`, `date`, `post_tag`, `category` | Archive pages |
| `searchResults` | - | Search results page |
| `error` | - | 404 page |

## Rendering Templates

### Using Shortcode

```php
// In PHP
echo do_shortcode( '[bricks_template id="123"]' );

// In Bricks element
// Use the Template element and select the template
```

### Programmatic Rendering

```php
// Get template elements
$elements = get_post_meta( $template_id, BRICKS_DB_PAGE_CONTENT, true );

// Render elements
if ( ! empty( $elements ) && is_array( $elements ) ) {
    echo \Bricks\Frontend::render_data( $elements );
}
```

## Template API Endpoints

REST API namespace: `bricks/v1/`

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/get-templates/` | GET | Get all templates |
| `/get-templates/{id}` | GET | Get specific template |
| `/get-templates-data/` | GET | Get templates with metadata |
| `/get-template-authors/` | GET | Get template authors |
| `/get-template-bundles/` | GET | Get template bundles |
| `/get-template-tags/` | GET | Get template tags |

## Template Helpers

```php
// Get template type
$type = \Bricks\Templates::get_template_type( $template_id );

// Get templates by type
$templates = \Bricks\Templates::get_templates_by_type( 'section' );

// Get templates list for select control
$list = \Bricks\Templates::get_templates_list( ['section', 'content'] );

// Check if post is a Bricks template
$is_template = \Bricks\Helpers::is_bricks_template( $post_id );
```

## Remote Templates

Enable remote template access in settings, then query from other sites:

```php
// Settings to enable
// Bricks > Settings > Templates
// - Enable "My Templates Access"
// - Optionally set whitelist URLs
// - Optionally set password
```

## Import/Export

Templates can be exported as JSON:

```php
// Export structure
$export = [
    'content'        => $elements,
    'templateType'   => $type,
    'globalClasses'  => $classes,
    'globalElements' => $global_elements,
];
```

## Hooks for Templates

### Filters

```php
// Modify templates data from API
add_filter( 'bricks/api/get_templates_data', function( $templates_data ) {
    // Modify templates data
    return $templates_data;
} );

// Control template access
add_filter( 'bricks/get_templates', function( $templates, $args ) {
    // Filter templates based on $args['site'], $args['licenseKey'], etc.
    return $templates;
}, 10, 2 );
```

### Actions

```php
// After template import
add_action( 'bricks/template/after_import', function( $template_id, $data ) {
    // Process imported template
}, 10, 2 );
```

## Best Practices

1. **Generate unique IDs**: Always use `\Bricks\Helpers::generate_random_id( false )` for element IDs
2. **Validate element structure**: Ensure parent/children relationships are correct
3. **Set proper conditions**: Templates without conditions won't apply
4. **Use appropriate meta keys**: Header/footer use different meta keys than content
5. **Regenerate CSS**: After programmatic changes, CSS may need regeneration
