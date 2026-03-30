# Bricks Conditions Skill

This skill covers the element and template conditions system in Bricks Builder.

## Conditions Architecture

### Core File

| File             | Purpose                                               |
| ---------------- | ----------------------------------------------------- |
| `conditions.php` | Conditions class with groups, options, and evaluation |

### Condition Types

1. **Element Conditions**: Show/hide elements based on conditions
2. **Template Conditions**: Determine which template applies to which pages

## Built-in Condition Groups

| Group         | Description                    |
| ------------- | ------------------------------ |
| `post`        | Post-related conditions        |
| `user`        | User/authentication conditions |
| `date`        | Date and time conditions       |
| `woocommerce` | WooCommerce product conditions |
| `other`       | Browser, URL, dynamic data     |

## Built-in Conditions

### Post Conditions

| Key              | Description        | Compare Options                        |
| ---------------- | ------------------ | -------------------------------------- |
| `post_id`        | Post ID            | ==, !=, >=, <=, >, <                   |
| `post_title`     | Post title         | is, is not, contains, does not contain |
| `post_parent`    | Parent post ID     | ==, !=, >=, <=, >, <                   |
| `post_status`    | Post status        | is, is not                             |
| `post_author`    | Author             | is, is not                             |
| `post_date`      | Publish date       | ==, !=, >=, <=, >, <                   |
| `featured_image` | Has featured image | is, is not                             |

### User Conditions

| Key               | Description       | Compare Options      |
| ----------------- | ----------------- | -------------------- |
| `user_logged_in`  | Login status      | is, is not           |
| `user_id`         | User ID           | ==, !=, >=, <=, >, < |
| `user_registered` | Registration date | after, before        |
| `user_role`       | User role         | is, is not           |

### Date Conditions

| Key        | Description   | Compare Options      |
| ---------- | ------------- | -------------------- |
| `weekday`  | Day of week   | ==, !=, >=, <=, >, < |
| `date`     | Current date  | ==, !=, >=, <=, >, < |
| `time`     | Current time  | ==, !=, >=, <=, >, < |
| `datetime` | Date and time | ==, !=, >=, <=, >, < |

### WooCommerce Conditions

| Key                             | Description                         |
| ------------------------------- | ----------------------------------- |
| `woo_product_type`              | Simple, grouped, external, variable |
| `woo_product_sale`              | On sale status                      |
| `woo_product_new`               | New product status                  |
| `woo_product_stock_status`      | In stock, out of stock, backorder   |
| `woo_product_stock_quantity`    | Quantity comparison                 |
| `woo_product_stock_management`  | Management enabled                  |
| `woo_product_sold_individually` | Sold individually                   |
| `woo_product_purchased_by_user` | User has purchased                  |
| `woo_product_featured`          | Featured product                    |
| `woo_product_rating`            | Product rating                      |
| `woo_product_category`          | Product category                    |
| `woo_product_tag`               | Product tag                         |

### Other Conditions

| Key                | Description                               |
| ------------------ | ----------------------------------------- |
| `dynamic_data`     | Any dynamic data tag                      |
| `browser`          | Chrome, Firefox, Safari, Edge, Opera, IE  |
| `operating_system` | Windows, macOS, Linux, iOS, Android, etc. |
| `current_url`      | Current page URL                          |
| `referer`          | Referrer URL                              |

## Creating Custom Conditions

### Add Custom Condition Group

```php
add_filter( 'bricks/conditions/groups', function( $groups ) {
    $groups[] = [
        'name'  => 'my_plugin',
        'label' => 'My Plugin',
    ];
    return $groups;
} );
```

### Add Custom Condition Option

```php
add_filter( 'bricks/conditions/options', function( $options ) {
    // Simple boolean condition
    $options[] = [
        'key'     => 'my_custom_condition',
        'group'   => 'my_plugin',
        'label'   => 'My Custom Condition',
        'compare' => [
            'type'    => 'select',
            'options' => [
                '==' => esc_html__( 'is', 'my-plugin' ),
                '!=' => esc_html__( 'is not', 'my-plugin' ),
            ],
        ],
        'value'   => [
            'type'    => 'select',
            'options' => [
                '1' => esc_html__( 'True', 'my-plugin' ),
                '0' => esc_html__( 'False', 'my-plugin' ),
            ],
        ],
    ];
    
    // Text input condition
    $options[] = [
        'key'     => 'my_meta_field',
        'group'   => 'my_plugin',
        'label'   => 'Custom Meta Field',
        'compare' => [
            'type'        => 'select',
            'options'     => [
                '=='           => 'is',
                '!='           => 'is not',
                'contains'     => 'contains',
                'contains_not' => 'does not contain',
                'empty'        => 'is empty',
                'empty_not'    => 'is not empty',
            ],
            'placeholder' => '==',
        ],
        'value'   => [
            'type'        => 'text',
            'placeholder' => 'Value to compare',
        ],
    ];
    
    // Number condition with math operators
    $options[] = [
        'key'     => 'my_numeric_condition',
        'group'   => 'my_plugin',
        'label'   => 'Numeric Value',
        'compare' => [
            'type'    => 'select',
            'options' => [
                '==' => '==',
                '!=' => '!=',
                '>=' => '>=',
                '<=' => '<=',
                '>'  => '>',
                '<'  => '<',
            ],
        ],
        'value'   => [
            'type'        => 'number',
            'placeholder' => '0',
        ],
    ];
    
    // Multi-select condition
    $options[] = [
        'key'     => 'my_terms_condition',
        'group'   => 'my_plugin',
        'label'   => 'Has Terms',
        'compare' => [
            'type'    => 'select',
            'options' => [
                '==' => 'has',
                '!=' => 'does not have',
            ],
        ],
        'value'   => [
            'type'        => 'select',
            'options'     => $this->get_term_options(),
            'multiple'    => true,
            'placeholder' => 'Select terms',
        ],
    ];
    
    // Date picker condition
    $options[] = [
        'key'     => 'my_date_condition',
        'group'   => 'my_plugin',
        'label'   => 'Custom Date',
        'compare' => [
            'type'    => 'select',
            'options' => [
                '<' => 'before',
                '>' => 'after',
            ],
        ],
        'value'   => [
            'type'       => 'datepicker',
            'enableTime' => false,
        ],
    ];
    
    return $options;
} );
```

### Evaluate Custom Condition

```php
add_filter( 'bricks/conditions/result', function( $result, $condition, $post_id ) {
    $key = $condition['key'] ?? '';
    
    // Handle my_custom_condition
    if ( $key === 'my_custom_condition' ) {
        $compare = $condition['compare'] ?? '==';
        $value   = $condition['value'] ?? '';
        
        // Get actual condition value
        $actual_value = my_plugin_check_condition();
        
        // Evaluate
        if ( $compare === '==' ) {
            $result = $actual_value == $value;
        } else {
            $result = $actual_value != $value;
        }
    }
    
    // Handle my_meta_field
    if ( $key === 'my_meta_field' ) {
        $compare = $condition['compare'] ?? '==';
        $value   = $condition['value'] ?? '';
        
        $meta_value = get_post_meta( $post_id, 'my_meta_field', true );
        
        switch ( $compare ) {
            case '==':
                $result = $meta_value === $value;
                break;
            case '!=':
                $result = $meta_value !== $value;
                break;
            case 'contains':
                $result = strpos( $meta_value, $value ) !== false;
                break;
            case 'contains_not':
                $result = strpos( $meta_value, $value ) === false;
                break;
            case 'empty':
                $result = empty( $meta_value );
                break;
            case 'empty_not':
                $result = ! empty( $meta_value );
                break;
        }
    }
    
    // Handle numeric condition
    if ( $key === 'my_numeric_condition' ) {
        $compare = $condition['compare'] ?? '==';
        $value   = floatval( $condition['value'] ?? 0 );
        
        $actual = floatval( get_post_meta( $post_id, 'my_number', true ) );
        
        switch ( $compare ) {
            case '==':
                $result = $actual == $value;
                break;
            case '!=':
                $result = $actual != $value;
                break;
            case '>=':
                $result = $actual >= $value;
                break;
            case '<=':
                $result = $actual <= $value;
                break;
            case '>':
                $result = $actual > $value;
                break;
            case '<':
                $result = $actual < $value;
                break;
        }
    }
    
    return $result;
}, 10, 3 );
```

## Condition Option Structure

```php
$option = [
    'key'     => 'condition_key',      // Unique identifier
    'group'   => 'group_name',         // Group to display in
    'label'   => 'Display Label',      // Human-readable label
    'compare' => [                     // Comparison operator control
        'type'        => 'select',     // Control type
        'options'     => [],           // Available options
        'placeholder' => '',           // Placeholder text
    ],
    'value'   => [                     // Value control
        'type'        => 'text',       // Control type: text, select, number, datepicker
        'options'     => [],           // For select type
        'multiple'    => false,        // Allow multiple selection
        'placeholder' => '',           // Placeholder text
        'enableTime'  => false,        // For datepicker
        'description' => '',           // Help text
    ],
];
```

## Condition Evaluation Flow

```
Element with Conditions
    ↓
Get Condition Settings
    ↓
For Each Condition:
    ↓
Check Condition Key
    ↓
Get Compare & Value
    ↓
Apply Filter: bricks/conditions/result
    ↓
Built-in Evaluation (if not matched)
    ↓
AND/OR Logic Between Conditions
    ↓
Return: Show or Hide Element
```

## Dynamic Data in Conditions

Use dynamic data tags in condition values:

```php
// In condition value field
{post_id}
{cf_my_custom_field}
{url_parameter:status}
```

The `dynamic_data` condition type supports any DD tag:

```php
$condition = [
    'key'     => 'dynamic_data',
    'compare' => '==',
    'value'   => 'expected_value',
    // The actual value is rendered from the dynamic data field
];
```

## Multiple Conditions

Conditions support AND/OR logic:

```php
// Element settings structure
$element['settings']['_conditions'] = [
    'relation' => 'AND', // or 'OR'
    'conditions' => [
        [
            'key'     => 'user_logged_in',
            'compare' => '==',
            'value'   => '1',
        ],
        [
            'key'     => 'user_role',
            'compare' => '==',
            'value'   => ['administrator', 'editor'],
        ],
    ],
];
```

## Template Conditions

Template conditions determine when a template applies:

```php
$template_conditions = [
    [
        'main'    => 'postType',
        'sub'     => 'post',
        'compare' => '==',
    ],
    [
        'main'    => 'archiveType',
        'sub'     => 'category',
        'compare' => '==',
    ],
];
```

### Template Condition Types

| Main            | Sub Options                  | Description      |
| --------------- | ---------------------------- | ---------------- |
| `entireWebsite` | -                            | All pages        |
| `frontpage`     | -                            | Front page only  |
| `postType`      | `post`, `page`, CPTs         | Single post/page |
| `archiveType`   | `author`, `date`, taxonomies | Archive pages    |
| `searchResults` | -                            | Search results   |
| `error`         | -                            | 404 page         |

## Hooks Reference

```php
// Add condition groups
add_filter( 'bricks/conditions/groups', function( $groups ) {
    return $groups;
} );

// Add condition options
add_filter( 'bricks/conditions/options', function( $options ) {
    return $options;
} );

// Evaluate condition result
add_filter( 'bricks/conditions/result', function( $result, $condition, $post_id ) {
    return $result;
}, 10, 3 );
```

## Example: Time-Based Visibility

```php
// Show element only during business hours
add_filter( 'bricks/conditions/options', function( $options ) {
    $options[] = [
        'key'     => 'business_hours',
        'group'   => 'date',
        'label'   => 'Business Hours',
        'compare' => [
            'type'    => 'select',
            'options' => [
                '==' => 'is during',
                '!=' => 'is not during',
            ],
        ],
        'value'   => [
            'type'    => 'select',
            'options' => [
                'business' => 'Business Hours (9-5 Mon-Fri)',
                'weekend'  => 'Weekend',
                'evening'  => 'Evening (6pm-10pm)',
            ],
        ],
    ];
    return $options;
} );

add_filter( 'bricks/conditions/result', function( $result, $condition, $post_id ) {
    if ( $condition['key'] !== 'business_hours' ) {
        return $result;
    }
    
    $value   = $condition['value'] ?? '';
    $compare = $condition['compare'] ?? '==';
    
    $current_time = current_time( 'timestamp' );
    $hour         = date( 'G', $current_time );
    $day          = date( 'N', $current_time );
    
    $is_match = false;
    
    switch ( $value ) {
        case 'business':
            $is_match = ( $day >= 1 && $day <= 5 ) && ( $hour >= 9 && $hour < 17 );
            break;
        case 'weekend':
            $is_match = ( $day >= 6 );
            break;
        case 'evening':
            $is_match = ( $hour >= 18 && $hour < 22 );
            break;
    }
    
    return $compare === '==' ? $is_match : ! $is_match;
}, 10, 3 );
```

## Best Practices

1. **Use specific condition keys**: Avoid generic names that might conflict
2. **Handle edge cases**: Check for empty/null values
3. **Cache expensive checks**: Don't query database on every condition check
4. **Use appropriate comparison operators**: Match the data type
5. **Document custom conditions**: Make them discoverable for other developers
6. **Test with AND/OR logic**: Ensure conditions work in combination
