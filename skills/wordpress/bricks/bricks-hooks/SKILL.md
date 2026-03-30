---
name: bricks-hooks
description: Use filters and actions available in Bricks Builder for customization.
---

# Bricks Hooks Skill

This skill covers all filters and actions available in Bricks Builder for customization.

## Filter Reference

### Element Filters

```php
// Modify any element's controls
add_filter( 'bricks/elements/{element_name}/controls', function( $controls ) {
    // Add, modify, or remove controls
    $controls['myNewControl'] = [
        'tab'   => 'content',
        'label' => 'My Control',
        'type'  => 'text',
    ];
    return $controls;
}, 10, 1 );

// Modify element control groups
add_filter( 'bricks/elements/{element_name}/control_groups', function( $groups ) {
    $groups['myGroup'] = [
        'title' => 'My Group',
        'tab'   => 'content',
    ];
    return $groups;
}, 10, 1 );

// Modify element scripts
add_filter( 'bricks/elements/{element_name}/scripts', function( $scripts ) {
    $scripts[] = 'myCustomScript';
    return $scripts;
}, 10, 1 );

// Filter registered elements
add_filter( 'bricks/builder/elements', function( $element_names ) {
    // Add custom element
    $element_names[] = 'my-custom-element';

    // Remove element
    $key = array_search( 'testimonials', $element_names );
    if ( $key !== false ) {
        unset( $element_names[ $key ] );
    }

    return $element_names;
}, 10, 1 );

// Modify rendered element HTML
add_filter( 'bricks/frontend/render_element', function( $html, $element_instance ) {
    if ( $element_instance->name === 'button' ) {
        // Wrap button in custom container
        $html = '<div class="button-wrapper">' . $html . '</div>';
    }
    return $html;
}, 10, 2 );

// Modify element render attributes
add_filter( 'bricks/element/render_attributes', function( $attributes, $key, $element ) {
    if ( $key === '_root' && $element->name === 'image' ) {
        $attributes['class'][] = 'my-image-class';
    }
    return $attributes;
}, 10, 3 );
```

### Frontend Rendering Filters

```php
// Modify render data output
add_filter( 'bricks/frontend/render_data', function( $content, $post, $area ) {
    // $area: 'header', 'content', 'footer'
    return $content;
}, 10, 3 );

// Disable SEO meta tags
add_filter( 'bricks/frontend/disable_seo', function( $disable ) {
    return true; // Disable Bricks SEO
}, 10, 1 );

// Disable Open Graph tags
add_filter( 'bricks/frontend/disable_opengraph', function( $disable ) {
    return true;
}, 10, 1 );

// Modify header attributes
add_filter( 'bricks/header/attributes', function( $attributes ) {
    $attributes['data-custom'] = 'value';
    return $attributes;
}, 10, 1 );

// Modify content attributes
add_filter( 'bricks/content/attributes', function( $attributes ) {
    return $attributes;
}, 10, 1 );

// Modify content tag
add_filter( 'bricks/content/tag', function( $tag ) {
    return 'main'; // Change from default 'div'
}, 10, 1 );

// Add HTML after content begins
add_filter( 'bricks/content/html_after_begin', function( $html, $data, $attrs, $tag ) {
    return '<div class="content-inner">';
}, 10, 4 );

// Add HTML before content ends
add_filter( 'bricks/content/html_before_end', function( $html, $data, $attrs, $tag ) {
    return '</div><!-- .content-inner -->';
}, 10, 4 );

// Modify header output
add_filter( 'bricks/render_header', function( $html ) {
    return $html;
}, 10, 1 );

// Modify footer output
add_filter( 'bricks/render_footer', function( $html ) {
    return $html;
}, 10, 1 );

// Modify loop output
add_filter( 'bricks/frontend/render_loop', function( $output, $element, $element_instance ) {
    return $output;
}, 10, 3 );
```

### Query Filters

```php
// Modify posts query args
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id ) {
    // Modify query vars
    $query_vars['posts_per_page'] = 12;
    return $query_vars;
}, 10, 3 );

// Modify terms query args
add_filter( 'bricks/terms/query_vars', function( $query_vars, $settings, $element_id ) {
    $query_vars['hide_empty'] = false;
    return $query_vars;
}, 10, 3 );

// Modify users query args
add_filter( 'bricks/users/query_vars', function( $query_vars, $settings, $element_id ) {
    return $query_vars;
}, 10, 3 );
```

### Dynamic Data Filters

```php
// Register custom dynamic data providers
add_filter( 'bricks/dynamic_data/register_providers', function( $providers ) {
    $providers[] = 'my_custom_provider';
    return $providers;
}, 10, 1 );
```

### Template Filters

```php
// Modify templates API data
add_filter( 'bricks/api/get_templates_data', function( $templates_data ) {
    return $templates_data;
}, 10, 1 );

// Filter template access
add_filter( 'bricks/get_templates', function( $templates, $args ) {
    // $args contains 'site', 'licenseKey', 'password'
    return $templates;
}, 10, 2 );
```

### Theme Styles Filters

```php
// Modify theme styles
add_filter( 'bricks/theme_styles', function( $styles ) {
    return $styles;
}, 10, 1 );

// Modify theme style controls
add_filter( 'bricks/theme_styles/controls', function( $controls ) {
    return $controls;
}, 10, 1 );

// Modify theme style control groups
add_filter( 'bricks/theme_styles/control_groups', function( $groups ) {
    return $groups;
}, 10, 1 );

// Modify theme style name
add_filter( 'bricks/theme_style_name', function( $name, $theme_style ) {
    return $name;
}, 10, 2 );
```

### Setup & Options Filters

```php
// Modify control options (button sizes, styles, etc.)
add_filter( 'bricks/setup/control_options', function( $options ) {
    // Add custom button size
    $options['buttonSizes']['xl'] = 'Extra Large';

    // Add custom style
    $options['styles']['brand'] = 'Brand';

    return $options;
}, 10, 1 );

// Modify image size options
add_filter( 'bricks/builder/image_size_options', function( $sizes ) {
    return $sizes;
}, 10, 1 );

// Modify map styles
add_filter( 'bricks/builder/map_styles', function( $styles ) {
    $styles['my-style'] = [
        'label' => 'My Custom Style',
        'value' => '[{"featureType":"all",...}]',
    ];
    return $styles;
}, 10, 1 );

// Modify body attributes
add_filter( 'bricks/body/attributes', function( $attributes ) {
    $attributes['data-theme'] = 'dark';
    return $attributes;
}, 10, 1 );
```

### Condition Filters

```php
// Add custom condition groups
add_filter( 'bricks/conditions/groups', function( $groups ) {
    $groups[] = [
        'name'  => 'my_conditions',
        'label' => 'My Conditions',
    ];
    return $groups;
}, 10, 1 );

// Add custom condition options
add_filter( 'bricks/conditions/options', function( $options ) {
    $options[] = [
        'key'     => 'my_condition',
        'group'   => 'my_conditions',
        'label'   => 'My Custom Condition',
        'compare' => [
            'type'    => 'select',
            'options' => [
                '==' => 'is',
                '!=' => 'is not',
            ],
        ],
        'value'   => [
            'type' => 'text',
        ],
    ];
    return $options;
}, 10, 1 );

// Evaluate custom condition
add_filter( 'bricks/conditions/result', function( $result, $condition, $post_id ) {
    if ( $condition['key'] === 'my_condition' ) {
        // Your condition logic
        $current_value = get_post_meta( $post_id, 'my_meta', true );
        $compare_value = $condition['value'] ?? '';
        $compare       = $condition['compare'] ?? '==';

        if ( $compare === '==' ) {
            $result = $current_value === $compare_value;
        } else {
            $result = $current_value !== $compare_value;
        }
    }
    return $result;
}, 10, 3 );
```

### Popup Filters

```php
// Modify popup attributes
add_filter( 'bricks/popup/attributes', function( $attributes, $popup_id ) {
    $attributes['data-popup'] = $popup_id;
    return $attributes;
}, 10, 2 );
```

### Link CSS Selectors

```php
// Modify link CSS selectors for theme styles
add_filter( 'bricks/link_css_selectors', function( $selectors ) {
    $selectors[] = '.my-custom-link';
    return $selectors;
}, 10, 1 );
```

### Assets Filters

```php
// Add additional CSS from elements
add_filter( 'bricks/assets/generate_css_from_element', function( $css_array, $element, $css_type ) {
    // Return array of element data to generate CSS from
    return $css_array;
}, 10, 3 );
```

### Auth Redirects Filters

```php
// Custom redirect URL
add_filter( 'bricks/auth/custom_redirect_url', function( $url, $current_path ) {
    return $url;
}, 10, 2 );

// Custom login redirect
add_filter( 'bricks/auth/custom_login_redirect', function( $page_id ) {
    return $page_id;
}, 10, 1 );

// Custom registration redirect
add_filter( 'bricks/auth/custom_registration_redirect', function( $page_id ) {
    return $page_id;
}, 10, 1 );

// Custom lost password redirect
add_filter( 'bricks/auth/custom_lost_password_redirect', function( $page_id ) {
    return $page_id;
}, 10, 1 );
```

### Pagination Filters

```php
// Custom pagination logic
add_filter( 'bricks/pagination/custom_logic', function( $result, $query_settings, $element ) {
    return $result;
}, 10, 3 );

// Modify current page
add_filter( 'bricks/pagination/current_page', function( $page, $query_settings, $element ) {
    return $page;
}, 10, 3 );

// Modify total pages
add_filter( 'bricks/pagination/total_pages', function( $pages, $query_settings, $element ) {
    return $pages;
}, 10, 3 );
```

### Query Filters (Advanced)

```php
// Modify query filter index arguments
add_filter( 'bricks/query_filters/index_args', function( $args, $source, $settings, $type ) {
    return $args;
}, 10, 4 );

// Custom indexer for filter source
add_filter( 'bricks/query_filters_indexer/post/{filter_source}', function( $rows, $post, $filter_id, $settings ) {
    return $rows;
}, 10, 4 );
```

### Password Protection Filters

```php
// Modify password protection active state
add_filter( 'bricks/password_protection/is_active', function( $active, $template_id, $settings ) {
    return $active;
}, 10, 3 );

// Modify cookie expiration
add_filter( 'bricks/password_protection/cookie_expires', function( $expires ) {
    return time() + 30 * DAY_IN_SECONDS;
}, 10, 1 );
```

### SVG Filters

```php
// Bypass SVG sanitization
add_filter( 'bricks/svg/bypass_sanitization', function( $bypass, $file ) {
    // Bypass for trusted sources
    if ( strpos( $file, 'trusted-path' ) !== false ) {
        return true;
    }
    return $bypass;
}, 10, 2 );
```

### Custom Fonts Filters

```php
// Modify allowed font mime types
add_filter( 'bricks/custom_fonts/mime_types', function( $types ) {
    $types['woff2'] = 'font/woff2';
    return $types;
}, 10, 1 );
```

### AJAX Filters

```php
// Modify get pages query args
add_filter( 'bricks/ajax/get_pages_args', function( $args ) {
    return $args;
}, 10, 1 );

// Modify post title in builder
add_filter( 'bricks/builder/post_title', function( $title, $post_id ) {
    return $title;
}, 10, 2 );

// Modify term name in builder
add_filter( 'bricks/builder/term_name', function( $name, $term_id, $taxonomy ) {
    return $name;
}, 10, 3 );
```

### Code Execution Filter

```php
// Disable code execution in Code element
add_filter( 'bricks/code/disable_execution', function( $disable ) {
    return true; // Disable PHP/JS execution
}, 10, 1 );
```

### WooCommerce Filters

```php
// Modify product filter options
add_filter( 'bricks/woocommerce/products_filters/options', function( $options, $settings ) {
    return $options;
}, 10, 2 );
```

---

## Action Reference

### Frontend Rendering Actions

```php
// Before rendering data
add_action( 'bricks/frontend/before_render_data', function( $elements, $area ) {
    // $area: 'header', 'content', 'footer'
}, 10, 2 );

// After rendering data
add_action( 'bricks/frontend/after_render_data', function( $elements, $area ) {
    // Cleanup, logging, etc.
}, 10, 2 );
```

### Query Actions

```php
// Before query loop
add_action( 'bricks/query/before_loop', function( $query_obj, $args ) {
    // Setup before loop
}, 10, 2 );

// After query loop
add_action( 'bricks/query/after_loop', function( $query_obj, $args ) {
    // Cleanup after loop
}, 10, 2 );

// Query API response
add_action( 'bricks/query/query_api_response', function( $response, $element_id ) {
    // Process API response
}, 10, 2 );
```

### Dynamic Data Actions

```php
// After tags are registered
add_action( 'bricks/dynamic_data/tags_registered', function() {
    // Register additional tags
}, 10, 0 );

// Before do_action dynamic data
add_action( 'bricks/dynamic_data/before_do_action', function( $action, $filters, $context, $post ) {
    // Before WordPress action execution
}, 10, 4 );

// After do_action dynamic data
add_action( 'bricks/dynamic_data/after_do_action', function( $action, $filters, $context, $post, $value ) {
    // After WordPress action execution
}, 10, 5 );
```

### Form Actions

```php
// Custom form action
add_action( 'bricks/form/custom_action', function( $form ) {
    // Access form data: $form->get_fields()
    // Access settings: $form->settings
}, 10, 1 );

// Specific form action (email, webhook, etc.)
add_action( 'bricks/form/action/{action_name}', function( $form ) {
    // Process specific action
}, 10, 1 );
```

### Query Filters Actions

```php
// Before indexing post
add_action( 'bricks/query_filters/index_post/before', function( $post_id ) {
    // Before post is indexed
}, 10, 1 );

// Before indexing user
add_action( 'bricks/query_filters/index_user/before', function( $user_id ) {
    // Before user is indexed
}, 10, 1 );
```

### Filter Element Actions

```php
// Before setting data source from custom field
add_action( 'bricks/filter_element/before_set_data_source_from_custom_field', function( $element ) {
    // Before filter data source is set
}, 10, 1 );
```

### CSS File Generation Actions

```php
// When CSS file is generated
add_action( 'bricks/generate_css_file', function( $type, $file_name ) {
    // $type: 'post', 'theme-styles', 'global-elements', 'global-color-palettes', etc.
    // Log, clear cache, etc.
}, 10, 2 );
```

### API Actions

```php
// Before rendering query page via API
add_action( 'bricks/render_query_page/start', function( $request_data ) {
    // Setup before API rendering
}, 10, 1 );

// Before rendering popup content via API
add_action( 'bricks/render_popup_content/start', function( $request_data ) {
    // Setup before popup rendering
}, 10, 1 );

// Before rendering query result via API
add_action( 'bricks/render_query_result/start', function( $request_data ) {
    // Setup before query result rendering
}, 10, 1 );
```

---

## Common Use Cases

### Adding Custom Element Controls

```php
// Add "Read More" text to Posts element
add_filter( 'bricks/elements/posts/controls', function( $controls ) {
    $controls['readMoreText'] = [
        'tab'         => 'content',
        'group'       => 'content',
        'label'       => esc_html__( 'Read More Text', 'bricks' ),
        'type'        => 'text',
        'default'     => 'Read More',
        'placeholder' => 'Read More',
    ];
    return $controls;
} );
```

### Custom Condition for Templates

```php
// Add "Is Weekend" condition
add_filter( 'bricks/conditions/options', function( $options ) {
    $options[] = [
        'key'     => 'is_weekend',
        'group'   => 'date',
        'label'   => esc_html__( 'Is Weekend', 'bricks' ),
        'compare' => [
            'type'    => 'select',
            'options' => [
                '==' => esc_html__( 'Yes', 'bricks' ),
                '!=' => esc_html__( 'No', 'bricks' ),
            ],
        ],
    ];
    return $options;
} );

add_filter( 'bricks/conditions/result', function( $result, $condition, $post_id ) {
    if ( $condition['key'] === 'is_weekend' ) {
        $is_weekend = in_array( date( 'N' ), [ 6, 7 ] );
        $compare = $condition['compare'] ?? '==';
        $result = $compare === '==' ? $is_weekend : ! $is_weekend;
    }
    return $result;
}, 10, 3 );
```

### Adding Custom Button Style

```php
add_filter( 'bricks/setup/control_options', function( $options ) {
    $options['styles']['gradient'] = esc_html__( 'Gradient', 'bricks' );
    return $options;
} );
```

### Custom Form Handler

```php
add_action( 'bricks/form/custom_action', function( $form ) {
    $fields = $form->get_fields();

    // Get specific field
    $email = '';
    foreach ( $fields as $field ) {
        if ( $field['id'] === 'email' ) {
            $email = $field['value'];
            break;
        }
    }

    // Process form data
    // Send to CRM, save to database, etc.
} );
```

### Modify Posts Query

```php
add_filter( 'bricks/posts/query_vars', function( $vars, $settings, $element_id ) {
    // Only show posts from last 30 days
    $vars['date_query'] = [
        [
            'after' => '30 days ago',
        ],
    ];
    return $vars;
}, 10, 3 );
```

### Add Custom CSS Class to All Elements

```php
add_filter( 'bricks/element/render_attributes', function( $attributes, $key, $element ) {
    if ( $key === '_root' ) {
        $attributes['class'][] = 'bricks-element';
        $attributes['class'][] = 'element-' . $element->name;
    }
    return $attributes;
}, 10, 3 );
```

### Disable Code Element Execution for Non-Admins

```php
add_filter( 'bricks/code/disable_execution', function( $disable ) {
    if ( ! current_user_can( 'manage_options' ) ) {
        return true;
    }
    return $disable;
} );
```

## Hook Priority Guide

| Priority | Use Case |
|----------|----------|
| 1-9 | Run before most other code |
| 10 | Default priority |
| 11-19 | Run after default |
| 20+ | Run later, useful for overrides |
| 99+ | Run last, final modifications |

## Best Practices

1. **Use specific hooks** - Target specific elements rather than global filters when possible
2. **Check for Bricks** - Wrap code in `if ( class_exists( '\Bricks\Elements' ) )` checks
3. **Cache results** - Use transients or static variables for expensive operations
4. **Early returns** - Check conditions early to avoid unnecessary processing
5. **Clean up** - Remove actions/filters when no longer needed
6. **Document** - Comment why each hook is used
