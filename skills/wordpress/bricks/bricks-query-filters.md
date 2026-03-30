# Bricks Query Filters Skill

This skill covers the filter elements and indexer system in Bricks Builder for faceted filtering.

## Query Filters Architecture

### Core Files

| File                        | Purpose                         |
| --------------------------- | ------------------------------- |
| `query-filters.php`         | Main Query Filters class        |
| `query-filters-indexer.php` | Filter indexer for performance  |
| `elements/filter-base.php`  | Base class for filter elements  |
| `elements/filter-*.php`     | Individual filter element types |

### Filter Element Types

| Element        | File                        | Description                 |
| -------------- | --------------------------- | --------------------------- |
| Checkbox       | `filter-checkbox.php`       | Multi-select checkboxes     |
| Radio          | `filter-radio.php`          | Single-select radio buttons |
| Select         | `filter-select.php`         | Dropdown select             |
| Range          | `filter-range.php`          | Price/number range slider   |
| Datepicker     | `filter-datepicker.php`     | Date range picker           |
| Search         | `filter-search.php`         | Text search input           |
| Active Filters | `filter-active-filters.php` | Display active filters      |
| Submit         | `filter-submit.php`         | Submit/reset button         |

## Filter Workflow

```
User Interacts with Filter
    ↓
AJAX Request with Filter Parameters
    ↓
Query Modification (bricks/posts/query_vars)
    ↓
Results Rendered
    ↓
Response with New HTML + Counts
    ↓
UI Updated
```

## Filter Sources

Filters can filter by various data sources:

| Source            | Description            | Example                |
| ----------------- | ---------------------- | ---------------------- |
| `taxonomy`        | Taxonomy terms         | Categories, tags       |
| `post_meta`       | Post meta fields       | Custom fields          |
| `wp_field`        | WordPress fields       | Post date, author      |
| `wc_attribute`    | WooCommerce attributes | Size, color            |
| `wc_stock_status` | Stock status           | In stock, out of stock |
| `wc_price`        | Product price          | Price range            |
| `wc_rating`       | Product rating         | Star rating            |

## Filter Element Settings

### Common Settings

```php
$settings = [
    // Target query element (Posts, Products, etc.)
    'filterTargetId' => 'element-id',
    
    // Data source
    'filterSource' => 'taxonomy',
    
    // Taxonomy (when source is taxonomy)
    'filterTaxonomy' => 'product_cat',
    
    // Meta key (when source is post_meta)
    'filterMetaKey' => 'price',
    
    // Auto-submit on change
    'filterAutoSubmit' => true,
    
    // Show counts
    'filterShowCount' => true,
    
    // Hide empty options
    'filterHideEmpty' => true,
    
    // Default value
    'filterDefaultValue' => '',
];
```

### Checkbox/Radio Settings

```php
$settings = [
    // Display options
    'filterOptionsLayout' => 'vertical', // 'vertical', 'horizontal', 'grid'
    
    // Show all option
    'filterShowAll' => true,
    'filterShowAllLabel' => 'All',
    
    // Hierarchy display
    'filterHierarchical' => true,
    
    // Image display for options
    'filterShowImages' => false,
    
    // Color swatches (for color attributes)
    'filterShowColors' => false,
];
```

### Range Settings

```php
$settings = [
    // Range type
    'filterRangeType' => 'slider', // 'slider', 'inputs'
    
    // Min/Max values
    'filterRangeMin' => 0,
    'filterRangeMax' => 1000,
    
    // Step
    'filterRangeStep' => 10,
    
    // Prefix/Suffix for display
    'filterRangePrefix' => '$',
    'filterRangeSuffix' => '',
];
```

### Datepicker Settings

```php
$settings = [
    // Date format
    'filterDateFormat' => 'Y-m-d',
    
    // Enable time
    'filterEnableTime' => false,
    
    // Range mode
    'filterDateRange' => true,
];
```

## Filter Indexer

The indexer pre-calculates filter options for performance:

### Indexing Process

```
Post Saved/Updated
    ↓
Hook: save_post
    ↓
Indexer Runs
    ↓
Filter Values Stored in Custom Table
    ↓
Fast Lookup on Frontend
```

### Custom Indexer Hook

```php
// Add custom data to filter index
add_filter( 'bricks/query_filters_indexer/post/{filter_source}', function( $rows, $post, $filter_id, $settings ) {
    // $rows: Array of indexed values
    // $post: Current post object
    // $filter_id: Filter element ID
    // $settings: Filter settings
    
    // Add custom indexed value
    $rows[] = [
        'value' => 'my-custom-value',
        'label' => 'My Custom Label',
    ];
    
    return $rows;
}, 10, 4 );
```

### Trigger Reindex

```php
// Reindex all posts for a filter
\Bricks\Query_Filters_Indexer::reindex_all();

// Reindex specific post
\Bricks\Query_Filters_Indexer::reindex_post( $post_id );
```

## Custom Filter Sources

### Register Custom Source

```php
// Add custom filter source option
add_filter( 'bricks/query_filters/sources', function( $sources ) {
    $sources['my_custom_source'] = 'My Custom Source';
    return $sources;
} );

// Handle custom source in query
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id ) {
    // Check for filter parameters
    if ( isset( $_GET['my_custom_source'] ) ) {
        $value = sanitize_text_field( $_GET['my_custom_source'] );
        
        // Modify query based on filter value
        $query_vars['meta_query'][] = [
            'key'   => 'my_custom_field',
            'value' => $value,
        ];
    }
    
    return $query_vars;
}, 10, 3 );
```

### Custom Filter Options

```php
// Provide options for custom filter source
add_filter( 'bricks/query_filters/options/{source}', function( $options, $filter_settings ) {
    // Return array of options
    return [
        ['value' => 'option1', 'label' => 'Option 1', 'count' => 10],
        ['value' => 'option2', 'label' => 'Option 2', 'count' => 5],
    ];
}, 10, 2 );
```

## Filter Query Modification

### Automatic Query Modification

Bricks automatically modifies queries based on filter parameters:

```php
// URL: ?_tax_category=123
// Results in tax_query being added

// URL: ?_meta_price_min=100&_meta_price_max=500
// Results in meta_query being added
```

### Manual Query Modification

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id ) {
    // Only modify for filtered queries
    if ( empty( $_GET['_brx_filter'] ) ) {
        return $query_vars;
    }
    
    // Your custom query modifications
    
    return $query_vars;
}, 10, 3 );
```

## Filter Hooks

### Filters

```php
// Modify filter index arguments
add_filter( 'bricks/query_filters/index_args', function( $args, $source, $settings, $type ) {
    return $args;
}, 10, 4 );

// Modify filter options
add_filter( 'bricks/query_filters/options', function( $options, $filter_id, $settings ) {
    // Add custom option
    $options[] = [
        'value' => 'custom',
        'label' => 'Custom Option',
        'count' => 0,
    ];
    return $options;
}, 10, 3 );

// Modify active filter display
add_filter( 'bricks/query_filters/active_filter_label', function( $label, $filter_id, $value ) {
    return $label;
}, 10, 3 );
```

### Actions

```php
// Before indexing post
add_action( 'bricks/query_filters/index_post/before', function( $post_id ) {
    // Setup before indexing
}, 10, 1 );

// After indexing post
add_action( 'bricks/query_filters/index_post/after', function( $post_id ) {
    // Cleanup after indexing
}, 10, 1 );

// Before indexing user
add_action( 'bricks/query_filters/index_user/before', function( $user_id ) {
    // Setup before user indexing
}, 10, 1 );
```

## Filter URL Parameters

Filter parameters use specific prefixes:

| Prefix     | Source      | Example                         |
| ---------- | ----------- | ------------------------------- |
| `_tax_`    | Taxonomy    | `_tax_category=5`               |
| `_meta_`   | Post meta   | `_meta_color=red`               |
| `_wp_`     | WP field    | `_wp_author=1`                  |
| `_wc_`     | WooCommerce | `_wc_stock=instock`             |
| `_search_` | Search      | `_search_s=keyword`             |
| `_range_`  | Range       | `_range_price_min=100`          |
| `_date_`   | Datepicker  | `_date_created_from=2024-01-01` |

## Creating Custom Filter Element

```php
<?php
namespace Bricks;

if ( ! defined( 'ABSPATH' ) ) exit;

class Element_Filter_My_Custom extends Element_Filter_Base {
    public $name     = 'filter-my-custom';
    public $category = 'filter';
    
    public function get_label() {
        return 'My Custom Filter';
    }
    
    public function set_controls() {
        // Call parent controls
        parent::set_controls();
        
        // Add custom controls
        $this->controls['myCustomOption'] = [
            'tab'   => 'content',
            'label' => 'My Option',
            'type'  => 'text',
        ];
    }
    
    public function render() {
        $settings = $this->settings;
        
        // Get filter options
        $options = $this->get_filter_options();
        
        // Get current filter value
        $current_value = $this->get_current_filter_value();
        
        // Render filter HTML
        echo '<div class="brxe-filter-my-custom">';
        
        foreach ( $options as $option ) {
            $checked = in_array( $option['value'], (array) $current_value ) ? 'checked' : '';
            
            echo '<label>';
            echo '<input type="checkbox" name="my_filter" value="' . esc_attr( $option['value'] ) . '" ' . $checked . '>';
            echo esc_html( $option['label'] );
            if ( $settings['filterShowCount'] ?? false ) {
                echo ' (' . absint( $option['count'] ) . ')';
            }
            echo '</label>';
        }
        
        echo '</div>';
    }
}
```

## AJAX Filter Response

The AJAX response includes:

```json
{
    "html": "<div>Updated results HTML</div>",
    "pagination": "<div>Updated pagination HTML</div>",
    "count": 42,
    "maxPages": 5,
    "filterCounts": {
        "filter-abc123": {
            "option1": 10,
            "option2": 5
        }
    }
}
```

## Performance Considerations

1. **Enable indexer**: Use the filter indexer for large datasets
2. **Limit filter options**: Don't show thousands of options
3. **Use auto-submit wisely**: Debounce rapid changes
4. **Cache filter counts**: Use transients for expensive count queries
5. **Index strategically**: Only index needed data sources

## Best Practices

1. **Clear filter labels**: Help users understand filter options
2. **Show counts**: Display result counts for each option
3. **Hide empty options**: Remove options with zero results
4. **Reset functionality**: Always provide a way to clear filters
5. **URL preservation**: Maintain filter state in URL for sharing
6. **Mobile optimization**: Consider collapsible filters on mobile
7. **Loading indicators**: Show feedback during AJAX requests
