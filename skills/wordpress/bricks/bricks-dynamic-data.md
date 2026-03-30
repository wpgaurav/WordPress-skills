# Bricks Dynamic Data Skill

This skill covers the dynamic data system in Bricks Builder, including creating custom providers and tags.

## Dynamic Data Architecture

### System Overview

Dynamic data in Bricks follows a provider-based architecture:

```
Providers Class (manager)
├── Provider WP (WordPress core tags)
├── Provider ACF (Advanced Custom Fields)
├── Provider MetaBox (Meta Box fields)
├── Provider Pods (Pods fields)
├── Provider JetEngine
├── Provider CMB2
├── Provider Toolset
└── Provider Woo (WooCommerce)
```

### Core Files

| File                                                | Purpose                           |
| --------------------------------------------------- | --------------------------------- |
| `integrations/dynamic-data/providers.php`           | Main manager class                |
| `integrations/dynamic-data/providers/base.php`      | Abstract base class for providers |
| `integrations/dynamic-data/dynamic-data-parser.php` | Tag parsing logic                 |

## Dynamic Data Tag Syntax

### Basic Tag Format

```
{tag_name}
{tag_name:filter1}
{tag_name:filter1:filter2}
{tag_name:filter1|value}
```

### Common Filters

| Filter                 | Description           | Example                                |
| ---------------------- | --------------------- | -------------------------------------- |
| `:20`                  | Trim to N words       | `{post_excerpt:20}`                    |
| `:link`                | Wrap in anchor tag    | `{post_title:link}`                    |
| `:newTab`              | Open link in new tab  | `{post_title:link:newTab}`             |
| `:image`               | Output as image       | `{featured_image:image}`               |
| `:value`               | Return raw value      | `{acf_field:value}`                    |
| `:plain`               | Strip HTML tags       | `{post_terms_category:plain}`          |
| `:format`              | Keep HTML formatting  | `{post_excerpt:format:20}`             |
| `:url`                 | Return URL only       | `{acf_file:url}`                       |
| `:raw`                 | Skip parsing (escape) | `{tag_name:raw}`                       |
| `:timestamp`           | Return timestamp      | `{post_date:timestamp}`                |
| `:human_time_diff`     | Human readable time   | `{post_date:human_time_diff}`          |
| `:fallback('text')`    | Fallback value        | `{cf_field:fallback('N/A')}`           |
| `:fallback-image(123)` | Fallback image        | `{featured_image:fallback-image(123)}` |

### Date Format Filter

```
{post_date:Y-m-d}
{post_date:F j, Y}
{post_date:human_time_diff}
```

### Array Value Filter

```
{acf_link_field:array_value|title}
{acf_link_field:array_value|url}
```

### Context Types

| Context | Description       | Use                            |
| ------- | ----------------- | ------------------------------ |
| `text`  | Plain text output | Default for most elements      |
| `link`  | URL output        | Link controls, href attributes |
| `image` | Image ID/URL      | Image elements                 |
| `media` | Media array       | Gallery, carousel              |

## Creating Custom Dynamic Data Tags

### Method 1: Using `echo` Tag (Simplest)

```php
// Register a custom function
function my_custom_dd_function() {
    return get_option( 'my_custom_option' );
}

// Usage in Bricks: {echo:my_custom_dd_function}
```

### Method 2: Custom Provider (Full Control)

Create a custom provider by extending the base class:

```php
<?php
namespace Bricks\Integrations\Dynamic_Data\Providers;

if ( ! defined( 'ABSPATH' ) ) exit;

class Provider_My_Custom extends Base {

    /**
     * Check if provider should load
     */
    public static function load_me() {
        // Return true if your plugin is active
        return class_exists( 'My_Plugin' );
    }

    /**
     * Register dynamic data tags
     */
    public function register_tags() {
        // Basic tag
        $this->tags['my_custom_field'] = [
            'name'     => 'my_custom_field',
            'label'    => 'My Custom Field',
            'group'    => 'My Plugin',
            'provider' => $this->name,
        ];

        // Tag with field configuration
        $this->tags['my_repeater_field'] = [
            'name'     => 'my_repeater_field',
            'label'    => 'My Repeater',
            'group'    => 'My Plugin',
            'provider' => $this->name,
            'field'    => [
                'type' => 'repeater',
            ],
        ];
    }

    /**
     * Get the value of a tag
     *
     * @param string  $tag     Tag name
     * @param WP_Post $post    Current post
     * @param array   $args    Arguments from the tag
     * @param string  $context Context: text, link, image, media
     */
    public function get_tag_value( $tag, $post, $args, $context ) {
        $post_id = isset( $post->ID ) ? $post->ID : 0;
        $filters = $this->get_filters_from_args( $args );
        $value   = '';

        switch ( $tag ) {
            case 'my_custom_field':
                $value = get_post_meta( $post_id, 'my_custom_field', true );
                break;

            case 'my_repeater_field':
                $value = $this->get_repeater_value( $post_id, $filters, $context );
                break;
        }

        // Format and return value
        return $this->format_value_for_context( $value, $tag, $post_id, $filters, $context );
    }

    /**
     * Get repeater field value
     */
    private function get_repeater_value( $post_id, $filters, $context ) {
        $data = get_post_meta( $post_id, 'my_repeater', true );
        
        if ( empty( $data ) || ! is_array( $data ) ) {
            return '';
        }

        // Return array for loop queries
        if ( isset( $filters['is-array'] ) ) {
            return wp_json_encode( $data );
        }

        return $data;
    }
}
```

### Registering Custom Provider

```php
add_filter( 'bricks/dynamic_data/register_providers', function( $providers ) {
    $providers[] = 'my-custom';
    return $providers;
} );

// Load provider class file
add_action( 'init', function() {
    require_once 'path/to/provider-my-custom.php';
}, 9 ); // Before Bricks registers providers at priority 10000
```

## Query Loop Integration

Providers can add support for query loops by defining `$loop_tags`:

```php
class Provider_My_Custom extends Base {

    public function register_tags() {
        // Regular tags...

        // Loop tag (appears in Query Type dropdown)
        $this->loop_tags['my_repeater_loop'] = [
            'name'  => 'my_repeater_loop',
            'label' => 'My Repeater Loop',
            'group' => 'My Plugin',
        ];
    }

    /**
     * Set loop query results
     */
    public function set_loop_query( $results, $query ) {
        if ( $query->object_type !== 'my_repeater_loop' ) {
            return $results;
        }

        $post_id = get_the_ID();
        $data = get_post_meta( $post_id, 'my_repeater', true );

        if ( ! is_array( $data ) ) {
            return [];
        }

        $query->count = count( $data );
        $query->max_num_pages = 1;

        return $data;
    }

    /**
     * Set loop object during iteration
     */
    public function set_loop_object( $loop_object, $loop_key, $query ) {
        if ( $query->object_type !== 'my_repeater_loop' ) {
            return $loop_object;
        }

        return $loop_object; // Return current item
    }
}
```

## Dynamic Data Hooks

### Filters

```php
// Register custom providers
add_filter( 'bricks/dynamic_data/register_providers', function( $providers ) {
    $providers[] = 'my-custom';
    return $providers;
} );

// Exclude tags from DD logic
add_filter( 'bricks/dynamic_data/exclude_tags', function( $tags ) {
    $tags[] = 'my_special_tag';
    return $tags;
} );

// Replace nonexistent tags with empty string
add_filter( 'bricks/dynamic_data/replace_nonexistent_tags', '__return_true' );

// Modify separator for text context
add_filter( 'bricks/dynamic_data/text_separator', function( $sep, $tag, $post_id, $filters ) {
    if ( $tag === 'my_tag' ) {
        return ' | ';
    }
    return $sep;
}, 10, 4 );

// Format value before output
add_filter( 'bricks/dynamic_data/format_value', function( $value, $tag, $post_id, $filters, $context ) {
    if ( $tag === 'my_tag' && empty( $value ) ) {
        return 'Default Value';
    }
    return $value;
}, 10, 5 );
```

### Actions

```php
// After all tags are registered
add_action( 'bricks/dynamic_data/tags_registered', function() {
    // Do something after tags are ready
} );

// Before dynamic action execution
add_action( 'bricks/dynamic_data/before_do_action', function( $action, $filters, $context, $post ) {
    // Before action execution
}, 10, 4 );

// After dynamic action execution
add_action( 'bricks/dynamic_data/after_do_action', function( $action, $filters, $context, $post, $value ) {
    // After action execution
}, 10, 5 );
```

## PHP Functions for Dynamic Data

### Render Dynamic Data

```php
// Render content with dynamic data
$content = bricks_render_dynamic_data( $content, $post_id, $context );

// Using Providers class
$value = \Bricks\Integrations\Dynamic_Data\Providers::render_content( $content, $post_id, $context );

// Render single tag
$value = \Bricks\Integrations\Dynamic_Data\Providers::render_tag( $tag, $post_id, $context );
```

### In Elements

```php
public function render() {
    $settings = $this->settings;
    
    // Render dynamic data in text
    $title = isset( $settings['title'] )
        ? $this->render_dynamic_data( $settings['title'] )
        : '';
    
    echo '<h2>' . $title . '</h2>';
}
```

## Common Tag Reference

### WordPress Core Tags

| Tag                     | Description         |
| ----------------------- | ------------------- |
| `{post_title}`          | Post title          |
| `{post_content}`        | Post content        |
| `{post_excerpt}`        | Post excerpt        |
| `{post_date}`           | Post date           |
| `{post_modified}`       | Modified date       |
| `{post_id}`             | Post ID             |
| `{post_url}`            | Post permalink      |
| `{post_type}`           | Post type           |
| `{post_status}`         | Post status         |
| `{featured_image}`      | Featured image ID   |
| `{featured_image_tag}`  | Featured image HTML |
| `{author_name}`         | Author display name |
| `{author_avatar}`       | Author avatar       |
| `{author_url}`          | Author archive URL  |
| `{post_terms_TAXONOMY}` | Post terms          |
| `{cf_META_KEY}`         | Custom field value  |
| `{site_title}`          | Site name           |
| `{site_url}`            | Site URL            |
| `{current_page_url}`    | Current page URL    |
| `{url_parameter:KEY}`   | URL parameter value |
| `{wp_user_*}`           | Current user data   |

### Query Loop Tags

| Tag                     | Description   |
| ----------------------- | ------------- |
| `{query_results_count}` | Total results |
| `{query_current_page}`  | Current page  |
| `{query_total_pages}`   | Total pages   |

## Best Practices

1. **Always escape output**: Use `esc_html()`, `esc_attr()`, `wp_kses_post()` appropriately
2. **Check for empty values**: Handle fallbacks gracefully
3. **Use proper context**: Match context to the expected output type
4. **Cache expensive operations**: Use transients for database-heavy operations
5. **Document custom tags**: Maintain documentation for custom dynamic data
6. **Test in loops**: Ensure tags work correctly inside query loops
