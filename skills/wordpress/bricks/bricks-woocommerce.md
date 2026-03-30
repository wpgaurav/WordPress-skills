# Bricks WooCommerce Skill

This skill covers WooCommerce integration in Bricks Builder, including elements, dynamic data, and customization.

## WooCommerce Architecture

### Core Files

| File                                                   | Purpose                            |
| ------------------------------------------------------ | ---------------------------------- |
| `woocommerce.php`                                      | Main WooCommerce integration class |
| `woocommerce/helpers.php`                              | Helper functions                   |
| `woocommerce/elements/`                                | WooCommerce-specific elements      |
| `woocommerce/theme-styles.php`                         | WooCommerce theme styles           |
| `integrations/dynamic-data/providers/provider-woo.php` | WooCommerce dynamic data           |

### Element Categories

WooCommerce elements are organized in the builder panel:

- **Products** - Archive/listing elements
- **Single Product** - Individual product elements
- **Cart** - Cart-related elements
- **Checkout** - Checkout elements
- **Account** - My Account elements

## WooCommerce Elements (48 Total)

### Product Archive Elements

| Element                     | Description                   |
| --------------------------- | ----------------------------- |
| `woo-products`              | Products grid/list with query |
| `woo-products-filter`       | Product filtering             |
| `woo-products-orderby`      | Sort products dropdown        |
| `woo-products-result-count` | Results count display         |
| `woo-products-pagination`   | Products pagination           |
| `woo-breadcrumbs`           | Breadcrumbs with Woo support  |

### Single Product Elements

| Element                         | Description                         |
| ------------------------------- | ----------------------------------- |
| `woo-product-title`             | Product title                       |
| `woo-product-price`             | Product price                       |
| `woo-product-rating`            | Star rating                         |
| `woo-product-short-description` | Short description                   |
| `woo-product-add-to-cart`       | Add to cart button/form             |
| `woo-product-gallery`           | Product image gallery               |
| `woo-product-tabs`              | Product tabs (description, reviews) |
| `woo-product-meta`              | SKU, categories, tags               |
| `woo-product-stock`             | Stock status                        |
| `woo-product-related`           | Related products                    |
| `woo-product-upsells`           | Upsell products                     |

### Cart Elements

| Element           | Description         |
| ----------------- | ------------------- |
| `woo-cart`        | Full cart           |
| `woo-mini-cart`   | Mini cart widget    |
| `woo-cart-totals` | Cart totals table   |
| `woo-cart-items`  | Cart items list     |
| `woo-cross-sells` | Cross-sell products |

### Checkout Elements

| Element                     | Description        |
| --------------------------- | ------------------ |
| `woo-checkout`              | Full checkout      |
| `woo-checkout-billing`      | Billing form       |
| `woo-checkout-shipping`     | Shipping form      |
| `woo-checkout-order-review` | Order review table |
| `woo-checkout-payment`      | Payment methods    |
| `woo-checkout-coupon`       | Coupon form        |

### Account Elements

| Element                     | Description        |
| --------------------------- | ------------------ |
| `woo-account`               | Full My Account    |
| `woo-account-dashboard`     | Dashboard          |
| `woo-account-orders`        | Orders list        |
| `woo-account-downloads`     | Downloads list     |
| `woo-account-addresses`     | Address management |
| `woo-account-form-login`    | Login form         |
| `woo-account-form-register` | Registration form  |

### Notice Elements

| Element      | Description                                |
| ------------ | ------------------------------------------ |
| `woo-notice` | WooCommerce notices (success, error, info) |

## WooCommerce Dynamic Data

### Product Tags

| Tag                             | Description        |
| ------------------------------- | ------------------ |
| `{woo_product_price}`           | Product price      |
| `{woo_product_regular_price}`   | Regular price      |
| `{woo_product_sale_price}`      | Sale price         |
| `{woo_product_sku}`             | SKU                |
| `{woo_product_stock_quantity}`  | Stock quantity     |
| `{woo_product_stock_status}`    | Stock status       |
| `{woo_product_weight}`          | Weight             |
| `{woo_product_dimensions}`      | Dimensions         |
| `{woo_product_rating}`          | Average rating     |
| `{woo_product_review_count}`    | Review count       |
| `{woo_product_categories}`      | Product categories |
| `{woo_product_tags}`            | Product tags       |
| `{woo_product_gallery}`         | Gallery images     |
| `{woo_product_on_sale}`         | Is on sale         |
| `{woo_product_type}`            | Product type       |
| `{woo_product_add_to_cart_url}` | Add to cart URL    |

### Cart Tags

| Tag                   | Description       |
| --------------------- | ----------------- |
| `{woo_cart_count}`    | Cart item count   |
| `{woo_cart_total}`    | Cart total        |
| `{woo_cart_subtotal}` | Cart subtotal     |
| `{woo_cart_url}`      | Cart page URL     |
| `{woo_checkout_url}`  | Checkout page URL |

### Shop Tags

| Tag                    | Description    |
| ---------------------- | -------------- |
| `{woo_shop_url}`       | Shop page URL  |
| `{woo_my_account_url}` | My Account URL |

## WooCommerce Query Settings

### Products Query

```php
$query_vars = [
    'objectType' => 'post',
    'post_type'  => 'product',
    
    // WooCommerce-specific
    'wc_disable_query_merge' => false, // Merge with main shop query
    
    // Product visibility
    'tax_query' => [
        [
            'taxonomy' => 'product_visibility',
            'field'    => 'name',
            'terms'    => ['exclude-from-catalog'],
            'operator' => 'NOT IN',
        ],
    ],
    
    // Stock status
    'meta_query' => [
        [
            'key'     => '_stock_status',
            'value'   => 'instock',
            'compare' => '=',
        ],
    ],
    
    // On sale products
    'post__in' => wc_get_product_ids_on_sale(),
    
    // Featured products
    'tax_query' => [
        [
            'taxonomy' => 'product_visibility',
            'field'    => 'name',
            'terms'    => ['featured'],
        ],
    ],
];
```

### Product Orderby Options

| Value        | Description       |
| ------------ | ----------------- |
| `menu_order` | Custom menu order |
| `popularity` | Sales count       |
| `rating`     | Average rating    |
| `date`       | Date added        |
| `price`      | Price low to high |
| `price-desc` | Price high to low |

## Quick View Setup

### 1. Create Popup Template

Create a popup template with single product elements.

### 2. Enable Quick View Settings

```php
// Popup template settings
$settings = [
    'popupAjax'  => true,  // Fetch content via AJAX
    'popupIsWoo' => true,  // WooCommerce Quick View mode
];
```

### 3. Add Trigger

Add interaction on product archive item:

```json
{
  "_interactions": [
    {
      "trigger": "click",
      "action": "openPopup",
      "popupId": 123,
      "popupContext": {
        "postId": "{post_id}"
      }
    }
  ]
}
```

## WooCommerce Hooks

### Filters

```php
// Modify WooCommerce products filter options
add_filter( 'bricks/woocommerce/products_filters/options', function( $options, $settings ) {
    return $options;
}, 10, 2 );

// Modify product query
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id ) {
    if ( isset( $query_vars['post_type'] ) && $query_vars['post_type'] === 'product' ) {
        // Modify product queries
    }
    return $query_vars;
}, 10, 3 );
```

### WooCommerce Template Overrides

Bricks integrates with WooCommerce templates:

```php
// Override template location
add_filter( 'woocommerce_locate_template', function( $template, $template_name, $template_path ) {
    // Return custom template path
    return $template;
}, 10, 3 );
```

## Product Variation Swatches

### Settings

```php
$settings = [
    // Enable color/image swatches
    'variationSwatchesEnable' => true,
    
    // Swatch style
    'variationSwatchStyle' => 'color', // 'color', 'image', 'label'
    
    // Swatch size
    'variationSwatchSize' => '30px',
    
    // Swatch border radius
    'variationSwatchBorderRadius' => '50%',
];
```

## WooCommerce Helpers

### Helper Functions

```php
// Check if WooCommerce is active
\Bricks\Woocommerce::is_woocommerce_active();

// Get product object
$product = wc_get_product( $product_id );

// Check if on specific WooCommerce page
is_shop();
is_product();
is_product_category();
is_product_tag();
is_cart();
is_checkout();
is_account_page();

// Get WooCommerce page IDs
wc_get_page_id( 'shop' );
wc_get_page_id( 'cart' );
wc_get_page_id( 'checkout' );
wc_get_page_id( 'myaccount' );
```

## WooCommerce Theme Styles

WooCommerce elements can be styled via Theme Styles:

```php
// Theme Style controls for WooCommerce
$controls = [
    // Product grid
    'wooProductsGap'         => 'Grid gap',
    'wooProductsPadding'     => 'Product padding',
    'wooProductsBackground'  => 'Product background',
    
    // Add to cart button
    'wooAddToCartBackground' => 'Button background',
    'wooAddToCartColor'      => 'Button color',
    
    // Price styling
    'wooPriceColor'          => 'Price color',
    'wooPriceSaleColor'      => 'Sale price color',
    
    // Rating styling
    'wooRatingColor'         => 'Rating star color',
];
```

## Cart AJAX

### Mini Cart Update

```javascript
// Listen for cart update
jQuery( document.body ).on( 'added_to_cart', function( event, fragments, cart_hash ) {
    // Fragments contain updated mini-cart HTML
    console.log( fragments );
});

// Trigger cart refresh
jQuery( document.body ).trigger( 'wc_fragment_refresh' );
```

### Add to Cart AJAX

```javascript
// Custom add to cart
jQuery.post( wc_add_to_cart_params.ajax_url, {
    action: 'woocommerce_add_to_cart',
    add_to_cart: product_id,
    quantity: 1
}, function( response ) {
    jQuery( document.body ).trigger( 'added_to_cart', [ response.fragments, response.cart_hash ] );
});
```

## Custom Product Loops

### Query by Product Attribute

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id ) {
    // Filter by product attribute
    $query_vars['tax_query'][] = [
        'taxonomy' => 'pa_color', // Product attribute
        'field'    => 'slug',
        'terms'    => ['red', 'blue'],
    ];
    
    return $query_vars;
}, 10, 3 );
```

### Query by Custom Field

```php
add_filter( 'bricks/posts/query_vars', function( $query_vars, $settings, $element_id ) {
    // Filter by custom ACF field on products
    $query_vars['meta_query'][] = [
        'key'     => 'featured_product',
        'value'   => '1',
        'compare' => '=',
    ];
    
    return $query_vars;
}, 10, 3 );
```

## WooCommerce Notices

### Display Notices

```php
// Add notice
wc_add_notice( 'Your custom message', 'success' );

// Notice types: 'success', 'error', 'notice'
```

### Notice Element

Use `woo-notice` element to display WooCommerce notices in custom locations.

## Checkout Customization

### Modify Checkout Fields

```php
add_filter( 'woocommerce_checkout_fields', function( $fields ) {
    // Modify billing fields
    $fields['billing']['billing_company']['required'] = true;
    
    // Remove shipping fields
    unset( $fields['shipping']['shipping_company'] );
    
    return $fields;
});
```

### Custom Checkout Actions

```php
// Add content after checkout form
add_action( 'woocommerce_after_checkout_form', function() {
    echo '<div class="custom-checkout-message">Trust badges here</div>';
});
```

## Best Practices

1. **Use Bricks elements over shortcodes**: Better styling control
2. **Test variable products thoroughly**: Ensure variations work correctly
3. **Optimize product queries**: Use indexing for filtered queries
4. **Handle stock carefully**: Always show accurate stock status
5. **Mobile checkout optimization**: Test on all devices
6. **AJAX cart updates**: Ensure mini-cart updates properly
7. **Quick View performance**: Keep popup content lightweight
8. **Accessibility**: Ensure all forms are keyboard accessible
