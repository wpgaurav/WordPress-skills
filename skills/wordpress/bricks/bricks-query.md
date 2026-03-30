# Bricks Query Skill

This skill covers the Query system in Bricks Builder for creating loops over posts, terms, users, and custom data.

## Query Architecture

### Core Files

| File                                 | Purpose                    |
| ------------------------------------ | -------------------------- |
| `query.php`                          | Main Query class           |
| `integrations/query/query-array.php` | Array query handler        |
| `query-filters.php`                  | Filter element integration |
| `query-filters-indexer.php`          | Filter indexing system     |

### Query Object Types

| Type    | Description            | Example Use                 |
| ------- | ---------------------- | --------------------------- |
| `post`  | WordPress posts        | Blog posts, products, pages |
| `term`  | Taxonomy terms         | Categories, tags            |
| `user`  | WordPress users        | Team members, authors       |
| `array` | Custom array data      | Repeater fields, API data   |
| `api`   | External API           | REST endpoints              |
| Custom  | Dynamic data providers | ACF repeaters, Meta Box     |

## Query Class Usage

### Basic Query Setup

```php
// Query is automatically created when using elements with query controls
// For programmatic use:

$element = [
    'id'       => 'abc123',
    'name'     => 'posts',
    'settings' => [
        'query' => [
            'objectType'     => 'post',
            'post_type'      => 'post',
            'posts_per_page' => 10,
            'orderby'        => 'date',
            'order'          => 'DESC',
        ],
    ],
];

$query = new \Bricks\Query( $element );

// Access query results
$results = $query->query_result;
$count   = $query->count;
$pages   = $query->max_num_pages;
```

### Query Loop Rendering

```php
// Render items in a loop
$query->render( function( $loop_object ) use ( $settings ) {
    $post_id = get_the_ID();
    echo '<div class="item">';
    echo '<h3>' . get_the_title( $post_id ) . '</h3>';
    echo '</div>';
} );

// IMPORTANT: Always destroy query when done
$query->destroy();
```

## Query Settings Reference

### Post Query

```php
$query_vars = [
    'objectType'     => 'post',
    'post_type'      => 'post',           // String or array
    'posts_per_page' => 10,               // -1 for all
    'paged'          => 1,
    'orderby'        => 'date',           // date, title, menu_order, meta_value, etc.
    'order'          => 'DESC',           // ASC or DESC
    'post_status'    => 'publish',
    'post__in'       => [1, 2, 3],        // Include specific posts
    'post__not_in'   => [4, 5],           // Exclude specific posts
    'exclude_current_post' => true,       // Exclude current post
    'author'         => 1,                // Author ID
    'author__in'     => [1, 2],           // Multiple authors
    'post_parent'    => 123,              // Parent post ID
    's'              => 'search term',    // Search query
    
    // Tax Query
    'tax_query' => [
        [
            'taxonomy' => 'category',
            'field'    => 'term_id',      // term_id, slug, name
            'terms'    => [1, 2, 3],
            'operator' => 'IN',           // IN, NOT IN, AND, EXISTS
        ],
    ],
    
    // Meta Query
    'meta_query' => [
        'relation' => 'AND',
        [
            'key'     => 'price',
            'value'   => 100,
            'compare' => '>=',
            'type'    => 'NUMERIC',
        ],
    ],
    
    // Date Query
    'date_query' => [
        [
            'after'  => '1 month ago',
            'column' => 'post_date',
        ],
    ],
    
    // Performance
    'no_found_rows'             => false,  // Set true for simple queries
    'update_post_meta_cache'    => true,
    'update_post_term_cache'    => true,
    'disable_query_merge'       => false,  // Don't merge with main query
];
```

### Term Query

```php
$query_vars = [
    'objectType' => 'term',
    'taxonomy'   => 'category',           // String or array
    'number'     => 10,                   // 0 for all
    'offset'     => 0,
    'orderby'    => 'name',               // name, count, slug, term_id
    'order'      => 'ASC',
    'hide_empty' => true,
    'show_empty' => false,                // Opposite of hide_empty
    'parent'     => 0,                    // Parent term ID
    'child_of'   => 0,                    // Child of term ID
    'include'    => [1, 2, 3],            // Include specific terms
    'exclude'    => [4, 5],               // Exclude specific terms
    'current_post_term' => true,          // Terms of current post
];
```

### User Query

```php
$query_vars = [
    'objectType' => 'user',
    'role'       => 'subscriber',         // String or array
    'role__in'   => ['author', 'editor'],
    'role__not_in' => ['administrator'],
    'number'     => 10,
    'offset'     => 0,
    'orderby'    => 'display_name',       // login, nicename, email, registered
    'order'      => 'ASC',
    'include'    => [1, 2, 3],
    'exclude'    => [4, 5],
    'current_post_author' => true,        // Author of current post
    
    // Meta Query
    'meta_query' => [
        [
            'key'     => 'user_level',
            'value'   => 5,
            'compare' => '>=',
        ],
    ],
];
```

### Array Query

```php
$query_vars = [
    'objectType'  => 'array',
    'arrayEditor' => '[{"name":"Item 1"},{"name":"Item 2"}]', // JSON string
    
    // Or from dynamic data
    'arrayEditor' => '{acf_repeater_field}',
    
    // Pagination
    'pagination_enabled' => true,
    'posts_per_page'     => 10,
];
```

## PHP Query Editor

Use the Query Editor for dynamic queries:

```php
// In Query Editor field:
return [
    'post_type'      => 'post',
    'posts_per_page' => 10,
    'tax_query'      => [
        [
            'taxonomy' => 'category',
            'terms'    => get_queried_object_id(),
        ],
    ],
];
```

## Query Hooks

### Filters

```php
// Modify post query vars
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    // Only modify specific element
    if ( $element_id === 'abc123' ) {
        $query_vars['posts_per_page'] = 20;
    }
    
    return $query_vars;
}, 10, 4 );

// Modify term query vars
add_filter( 'bricks/terms/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    $query_vars['hide_empty'] = false;
    return $query_vars;
}, 10, 4 );

// Modify user query vars
add_filter( 'bricks/users/query_vars', function( $query_vars, $settings, $element_id, $element_name ) {
    $query_vars['role__not_in'] = ['administrator'];
    return $query_vars;
}, 10, 4 );

// Control query merge with main WordPress query
add_filter( 'bricks/posts/merge_query', function( $merge, $element_id ) {
    // Disable merge for specific element
    if ( $element_id === 'abc123' ) {
        return false;
    }
    return $merge;
}, 10, 2 );

// Force query to run again (skip caching)
add_filter( 'bricks/query/force_run', function( $force_run, $query ) {
    // Force run for AJAX filter requests
    if ( isset( $_GET['brx_filter'] ) ) {
        return true;
    }
    return $force_run;
}, 10, 2 );

// Modify query vars before preparation
add_filter( 'bricks/query/prepare_query_vars_from_settings', function( $settings, $element_id ) {
    return $settings;
}, 10, 2 );

// Custom query run
add_filter( 'bricks/query/run', function( $results, $query ) {
    // Handle custom object types
    if ( $query->object_type === 'my_custom_type' ) {
        return my_custom_query_function();
    }
    return $results;
}, 10, 2 );

// Modify loop object
add_filter( 'bricks/query/loop_object', function( $loop_object, $loop_key, $query ) {
    return $loop_object;
}, 10, 3 );
```

### Actions

```php
// Before query loop
add_action( 'bricks/query/before_loop', function( $query_obj, $args ) {
    // Setup before loop starts
} );

// After query loop
add_action( 'bricks/query/after_loop', function( $query_obj, $args ) {
    // Cleanup after loop
} );

// API query response
add_action( 'bricks/query/query_api_response', function( $response, $element_id ) {
    // Process API response
}, 10, 2 );
```

## Static Methods

```php
// Check if currently in a loop
$is_looping = \Bricks\Query::is_looping();

// Get current looping query ID
$query_id = \Bricks\Query::is_any_looping();

// Get loop object type
$type = \Bricks\Query::get_loop_object_type( $query_id );

// Get current loop object
$object = \Bricks\Query::get_loop_object( $query_id );

// Get loop object ID
$object_id = \Bricks\Query::get_loop_object_id( $query_id );

// Get current loop index
$index = \Bricks\Query::get_loop_index( $query_id );

// Get query element ID
$element_id = \Bricks\Query::get_query_element_id( $query_id );

// Get query by element ID
$query = \Bricks\Query::get_query_by_element_id( $element_id );

// Get paged query var
$paged = \Bricks\Query::get_paged_query_var( $query_vars );
```

## Nested Queries

Bricks supports nested query loops:

```php
// Outer loop
$outer_query = new \Bricks\Query( $outer_element );

$outer_query->render( function() use ( $inner_element ) {
    $parent_id = get_the_ID();
    
    // Inner loop with parent context
    $inner_element['settings']['query']['post_parent'] = $parent_id;
    $inner_query = new \Bricks\Query( $inner_element );
    
    $inner_query->render( function() {
        // Inner loop content
        echo get_the_title();
    });
    
    $inner_query->destroy();
});

$outer_query->destroy();
```

## Pagination

### Query Pagination Support

```php
// Post query (automatic)
$query_vars['posts_per_page'] = 10;
$query_vars['paged'] = \Bricks\Query::get_paged_query_var( $query_vars );

// Term query
$query_vars['number'] = 10;
$query_vars['offset'] = ( $paged - 1 ) * 10;

// User query
$query_vars['number'] = 10;
$query_vars['offset'] = ( $paged - 1 ) * 10;
```

### Pagination Element Integration

The Pagination element automatically works with query loops. Access pagination data:

```php
$query = \Bricks\Query::get_query_by_element_id( $element_id );

$current_page   = $query->query_vars['paged'] ?? 1;
$total_pages    = $query->max_num_pages;
$total_results  = $query->count;
$per_page       = $query->query_vars['posts_per_page'] ?? 10;
$start_position = $query->start;
$end_position   = $query->end;
```

## Query Caching

Enable query caching in Bricks settings:

```php
// Cache is automatically handled when 'cacheQueryLoops' is enabled
// Cache key includes: element_id, query_vars, parent_object_id

// Manually set cache
$query->set_query_cache( $results );

// Get cached results
$cached = $query->get_query_cache();
```

## Query Results Summary

Display query results summary:

```php
// Available dynamic tags in Query Results Summary element
// {query_results_count}     - Total results
// {query_current_page}      - Current page number  
// {query_total_pages}       - Total pages
// {query_start_position}    - First item position
// {query_end_position}      - Last item position
```

## Special Query Types

### Related Posts Query

```php
$query_vars = [
    'objectType'           => 'post',
    'post_type'            => 'post',
    'posts_per_page'       => 3,
    'exclude_current_post' => true,
    'tax_query'            => [
        [
            'taxonomy' => 'category',
            'terms'    => wp_get_post_terms( get_the_ID(), 'category', ['fields' => 'ids'] ),
        ],
    ],
];
```

### Random Posts

```php
$query_vars = [
    'objectType'     => 'post',
    'posts_per_page' => 5,
    'orderby'        => 'rand',
];
```

### Sticky Posts First

```php
$query_vars = [
    'objectType'         => 'post',
    'ignore_sticky_posts' => false,
    'orderby'            => [
        'menu_order' => 'ASC',
        'date'       => 'DESC',
    ],
];
```

## Best Practices

1. **Always destroy queries**: Call `$query->destroy()` when done
2. **Use `no_found_rows`**: Set `true` for simple queries without pagination
3. **Disable cache updates**: For performance when you don't need meta/terms
4. **Avoid `posts_per_page = -1`**: Use pagination for large datasets
5. **Use indexes**: Ensure database indexes for meta queries
6. **Cache expensive queries**: Use transients for complex queries
7. **Test in nested loops**: Ensure proper context in nested queries
