---
name: wp-block-patterns
description: "Create, register, and organize WordPress block patterns. File-based patterns, PHP registration, categories, and synced patterns."
compatibility: "WordPress 6.0+ for file-based patterns. WordPress 6.3+ for pattern overrides."
---

# WordPress Block Patterns

## When to Use

Use this skill when:
- Creating reusable block layouts for themes
- Building a pattern library
- Registering patterns programmatically
- Working with synced (reusable) patterns
- Setting up pattern categories

## Pattern Basics

Block patterns are pre-designed block layouts users can insert with one click. Two types:

1. **Unsynced patterns** - Independent copies inserted each time
2. **Synced patterns** - Global patterns that update everywhere when changed

## File-Based Patterns (Recommended)

Since WordPress 6.0, create patterns by placing PHP files in your theme's `/patterns/` directory.

### Directory Structure

```
your-theme/
├── patterns/
│   ├── hero-section.php
│   ├── pricing-table.php
│   ├── testimonial-grid.php
│   ├── call-to-action.php
│   └── team-members.php
├── style.css
└── theme.json
```

### Pattern File Template

```php
<?php
/**
 * Title: Hero Section
 * Slug: theme-name/hero-section
 * Categories: featured, banner
 * Keywords: hero, banner, header, intro
 * Description: A full-width hero section with heading, text, and buttons.
 * Viewport Width: 1400
 * Block Types: core/post-content
 * Post Types: page, post
 * Inserter: true
 */
?>
<!-- wp:cover {"url":"<?php echo esc_url( get_template_directory_uri() ); ?>/assets/images/hero-bg.jpg","dimRatio":60,"overlayColor":"black","minHeight":600,"align":"full"} -->
<div class="wp-block-cover alignfull" style="min-height:600px">
  <span aria-hidden="true" class="wp-block-cover__background has-black-background-color has-background-dim-60 has-background-dim"></span>
  <div class="wp-block-cover__inner-container">
    <!-- wp:heading {"textAlign":"center","level":1} -->
    <h1 class="wp-block-heading has-text-align-center">Welcome to Our Site</h1>
    <!-- /wp:heading -->
    <!-- wp:paragraph {"align":"center"} -->
    <p class="has-text-align-center">Your compelling tagline goes here.</p>
    <!-- /wp:paragraph -->
    <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
    <div class="wp-block-buttons">
      <!-- wp:button -->
      <div class="wp-block-button"><a class="wp-block-button__link wp-element-button">Get Started</a></div>
      <!-- /wp:button -->
    </div>
    <!-- /wp:buttons -->
  </div>
</div>
<!-- /wp:cover -->
```

### Required Headers

| Header | Required | Description |
|--------|----------|-------------|
| `Title` | Yes | Display name in pattern inserter |
| `Slug` | Yes | Unique identifier (namespace/pattern-name) |

### Optional Headers

| Header | Description | Example |
|--------|-------------|---------|
| `Categories` | Comma-separated categories | `featured, hero, banner` |
| `Keywords` | Search terms | `hero, header, intro, welcome` |
| `Description` | Longer description for accessibility | `Full-width hero with...` |
| `Viewport Width` | Preview width in inserter | `1400` |
| `Block Types` | Show in block transforms | `core/post-content, core/group` |
| `Post Types` | Limit to specific post types | `page, post, product` |
| `Inserter` | Show in inserter | `true` or `false` |
| `Template Types` | For template patterns | `front-page, single` |

## PHP Registration Method

For plugins or dynamic patterns:

```php
function my_register_patterns() {
    register_block_pattern(
        'my-plugin/hero-section',
        array(
            'title'       => __( 'Hero Section', 'my-plugin' ),
            'description' => __( 'A full-width hero with heading and CTA', 'my-plugin' ),
            'categories'  => array( 'featured', 'banner' ),
            'keywords'    => array( 'hero', 'header', 'intro' ),
            'content'     => '<!-- wp:cover {"dimRatio":50} -->...',
            'blockTypes'  => array( 'core/post-content' ),
            'postTypes'   => array( 'page' ),
            'inserter'    => true,
        )
    );
}
add_action( 'init', 'my_register_patterns' );
```

### Loading Content from File

```php
function my_register_patterns() {
    $patterns = array(
        'hero-section',
        'pricing-table',
        'testimonials',
    );

    foreach ( $patterns as $pattern ) {
        $file = plugin_dir_path( __FILE__ ) . "patterns/{$pattern}.html";

        if ( file_exists( $file ) ) {
            register_block_pattern(
                "my-plugin/{$pattern}",
                array(
                    'title'      => ucwords( str_replace( '-', ' ', $pattern ) ),
                    'categories' => array( 'my-plugin-patterns' ),
                    'content'    => file_get_contents( $file ),
                )
            );
        }
    }
}
add_action( 'init', 'my_register_patterns' );
```

## Pattern Categories

### Register Custom Category

```php
function my_register_pattern_categories() {
    register_block_pattern_category(
        'my-theme-sections',
        array(
            'label'       => __( 'Theme Sections', 'my-theme' ),
            'description' => __( 'Pre-designed sections for building pages', 'my-theme' ),
        )
    );
}
add_action( 'init', 'my_register_pattern_categories' );
```

### Core Categories

WordPress includes these default categories:

| Slug | Label |
|------|-------|
| `featured` | Featured |
| `text` | Text |
| `gallery` | Gallery |
| `banner` | Banners |
| `header` | Headers |
| `footer` | Footers |
| `call-to-action` | Call to Action |
| `team` | Team |
| `testimonials` | Testimonials |
| `pricing` | Pricing |
| `contact` | Contact |
| `about` | About |
| `portfolio` | Portfolio |
| `services` | Services |

### Unregister Core Categories

```php
function my_unregister_pattern_categories() {
    unregister_block_pattern_category( 'buttons' );
}
add_action( 'init', 'my_unregister_pattern_categories' );
```

## Using Patterns in Templates

### In Block Templates (HTML)

```html
<!-- wp:pattern {"slug":"theme-name/hero-section"} /-->
```

This inserts the pattern content directly (not a reference).

### In PHP Templates

```php
<?php echo do_blocks( '<!-- wp:pattern {"slug":"theme-name/hero-section"} /-->' ); ?>
```

### In Block Templates (array format)

```php
$template = array(
    array( 'core/pattern', array( 'slug' => 'theme-name/hero-section' ) ),
    array( 'core/paragraph', array( 'placeholder' => 'Add content...' ) ),
);
```

## Synced Patterns (Reusable Blocks)

### Creating Synced Patterns

Users create these from the editor:
1. Select blocks
2. Click "Create pattern"
3. Choose "Synced"

### Programmatic Synced Pattern

```php
$pattern_id = wp_insert_post( array(
    'post_type'    => 'wp_block',
    'post_title'   => 'Global CTA',
    'post_content' => '<!-- wp:group -->...',
    'post_status'  => 'publish',
) );

// Add to pattern category
wp_set_object_terms( $pattern_id, 'my-category', 'wp_pattern_category' );
```

### Querying Synced Patterns

```php
$patterns = get_posts( array(
    'post_type'      => 'wp_block',
    'posts_per_page' => -1,
    'post_status'    => 'publish',
) );

foreach ( $patterns as $pattern ) {
    echo $pattern->post_title . ': ' . $pattern->ID . "\n";
}
```

## Pattern Content Best Practices

### 1. Wrap in Container

Always wrap patterns in a Group or similar container:

```html
<!-- wp:group {"align":"full","layout":{"type":"constrained"}} -->
<div class="wp-block-group alignfull">
  <!-- Pattern content -->
</div>
<!-- /wp:group -->
```

### 2. Use Theme Assets

Reference theme assets properly:

```php
<!-- wp:image {"id":0,"sizeSlug":"full"} -->
<figure class="wp-block-image size-full">
  <img src="<?php echo esc_url( get_template_directory_uri() ); ?>/assets/images/placeholder.jpg" alt=""/>
</figure>
<!-- /wp:image -->
```

### 3. Translatable Strings

Use translation functions for text:

```php
<!-- wp:heading -->
<h2 class="wp-block-heading"><?php esc_html_e( 'Our Services', 'theme-name' ); ?></h2>
<!-- /wp:heading -->
```

### 4. Placeholder Images

Use placeholder images for demo content:

```php
<?php
$placeholder = 'https://images.unsplash.com/photo-placeholder?w=1200&h=600';
// Or use theme asset
$placeholder = get_template_directory_uri() . '/assets/images/placeholder.jpg';
?>
<!-- wp:image {"sizeSlug":"full"} -->
<figure class="wp-block-image size-full">
  <img src="<?php echo esc_url( $placeholder ); ?>" alt="<?php esc_attr_e( 'Placeholder image', 'theme-name' ); ?>"/>
</figure>
<!-- /wp:image -->
```

### 5. Use Theme Presets

Reference theme.json presets instead of hardcoded values:

```html
<!-- Good: Uses preset -->
<!-- wp:group {"backgroundColor":"primary","textColor":"white"} -->

<!-- Avoid: Hardcoded values -->
<!-- wp:group {"style":{"color":{"background":"#0073aa","text":"#ffffff"}}} -->
```

## Pattern Variations

### Contextual Patterns

Show patterns for specific blocks using `Block Types`:

```php
<?php
/**
 * Title: Button Group
 * Slug: theme/button-group
 * Block Types: core/buttons
 */
?>
<!-- wp:buttons {"layout":{"type":"flex"}} -->
...
<!-- /wp:buttons -->
```

This pattern appears when transforming or replacing a Buttons block.

### Page-Level Patterns

For full page layouts:

```php
<?php
/**
 * Title: About Page
 * Slug: theme/page-about
 * Categories: page
 * Block Types: core/post-content
 * Post Types: page
 */
?>
<!-- wp:group {"align":"full"} -->
  <!-- Full page layout -->
<!-- /wp:group -->
```

## Content Locking

### Template Lock

Prevent editing pattern structure:

```php
<!-- wp:group {"templateLock":"all"} -->
<!-- Locked content - no adding/removing blocks -->
<!-- /wp:group -->

<!-- wp:group {"templateLock":"insert"} -->
<!-- Can modify but not add new blocks -->
<!-- /wp:group -->

<!-- wp:group {"templateLock":"contentOnly"} -->
<!-- Only text/content editable, not structure -->
<!-- /wp:group -->
```

### Content-Only Editing (6.1+)

Mark specific content as editable:

```html
<!-- wp:group {"templateLock":"contentOnly"} -->
<div class="wp-block-group">
  <!-- wp:heading -->
  <h2 class="wp-block-heading">Edit This Title</h2>
  <!-- /wp:heading -->
  <!-- wp:paragraph -->
  <p>And this paragraph.</p>
  <!-- /wp:paragraph -->
</div>
<!-- /wp:group -->
```

In block.json, mark editable attributes:
```json
{
  "attributes": {
    "content": {
      "type": "string",
      "__experimentalRole": "content"
    }
  }
}
```

## Pattern Overrides (6.3+)

Allow specific block content to be unique per instance:

```html
<!-- wp:group {"metadata":{"name":"Card","patternName":"theme/card"}} -->
<div class="wp-block-group">
  <!-- wp:heading {"metadata":{"bindings":{"content":{"source":"pattern_overrides"}}}} -->
  <h2>Default Title</h2>
  <!-- /wp:heading -->
  <!-- wp:paragraph {"metadata":{"bindings":{"content":{"source":"pattern_overrides"}}}} -->
  <p>Default description text.</p>
  <!-- /wp:paragraph -->
</div>
<!-- /wp:group -->
```

## Hiding Core Patterns

### Unregister Specific Pattern

```php
function my_unregister_patterns() {
    unregister_block_pattern( 'core/query-standard-posts' );
}
add_action( 'init', 'my_unregister_patterns', 20 );
```

### Hide All Core Patterns

In theme.json:
```json
{
  "version": 3,
  "settings": {
    "blocks": {
      "core/query": {
        "patterns": []
      }
    }
  }
}
```

### Disable Remote Patterns

Prevent loading from WordPress.org Pattern Directory:

```php
add_filter( 'should_load_remote_block_patterns', '__return_false' );
```

## Complete Pattern Example

### Testimonial Section Pattern

`patterns/testimonials.php`:
```php
<?php
/**
 * Title: Testimonials
 * Slug: theme-name/testimonials
 * Categories: testimonials, featured
 * Keywords: testimonial, review, quote, customer
 * Description: A grid of customer testimonials with photos and quotes.
 * Viewport Width: 1400
 * Block Types: core/post-content
 */

$testimonials = array(
    array(
        'name'    => 'Sarah Johnson',
        'role'    => 'CEO, TechStart',
        'quote'   => 'This product transformed our workflow completely.',
        'image'   => get_template_directory_uri() . '/assets/images/avatar-1.jpg',
    ),
    array(
        'name'    => 'Michael Chen',
        'role'    => 'Developer, AppCo',
        'quote'   => 'The best tool we\'ve used for our team.',
        'image'   => get_template_directory_uri() . '/assets/images/avatar-2.jpg',
    ),
    array(
        'name'    => 'Emily Davis',
        'role'    => 'Designer, CreativeLab',
        'quote'   => 'Intuitive and powerful. Highly recommended.',
        'image'   => get_template_directory_uri() . '/assets/images/avatar-3.jpg',
    ),
);
?>
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"5rem","bottom":"5rem"}}},"backgroundColor":"light-gray","layout":{"type":"constrained","contentSize":"1200px"}} -->
<div class="wp-block-group alignfull has-light-gray-background-color has-background" style="padding-top:5rem;padding-bottom:5rem">

  <!-- wp:heading {"textAlign":"center"} -->
  <h2 class="wp-block-heading has-text-align-center"><?php esc_html_e( 'What Our Customers Say', 'theme-name' ); ?></h2>
  <!-- /wp:heading -->

  <!-- wp:columns {"style":{"spacing":{"blockGap":{"left":"2rem"}}}} -->
  <div class="wp-block-columns">
    <?php foreach ( $testimonials as $testimonial ) : ?>
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px"}},"backgroundColor":"white"} -->
      <div class="wp-block-group has-white-background-color has-background" style="border-radius:12px;padding:2rem 1.5rem">
        <!-- wp:paragraph {"style":{"typography":{"fontStyle":"italic"}}} -->
        <p style="font-style:italic">"<?php echo esc_html( $testimonial['quote'] ); ?>"</p>
        <!-- /wp:paragraph -->
        <!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap"}} -->
        <div class="wp-block-group">
          <!-- wp:image {"width":"48px","height":"48px","scale":"cover","sizeSlug":"thumbnail","style":{"border":{"radius":"50%"}}} -->
          <figure class="wp-block-image size-thumbnail is-resized" style="border-radius:50%">
            <img src="<?php echo esc_url( $testimonial['image'] ); ?>" alt="<?php echo esc_attr( $testimonial['name'] ); ?>" style="border-radius:50%;object-fit:cover;width:48px;height:48px"/>
          </figure>
          <!-- /wp:image -->
          <!-- wp:group -->
          <div class="wp-block-group">
            <!-- wp:paragraph {"style":{"typography":{"fontWeight":"600"},"spacing":{"margin":{"bottom":"0"}}}} -->
            <p style="font-weight:600;margin-bottom:0"><?php echo esc_html( $testimonial['name'] ); ?></p>
            <!-- /wp:paragraph -->
            <!-- wp:paragraph {"style":{"color":{"text":"#666666"},"typography":{"fontSize":"0.875rem"}}} -->
            <p class="has-text-color" style="color:#666666;font-size:0.875rem"><?php echo esc_html( $testimonial['role'] ); ?></p>
            <!-- /wp:paragraph -->
          </div>
          <!-- /wp:group -->
        </div>
        <!-- /wp:group -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
    <?php endforeach; ?>
  </div>
  <!-- /wp:columns -->

</div>
<!-- /wp:group -->
```

## Resources

- [Block Patterns Documentation](https://developer.wordpress.org/block-editor/reference-guides/block-api/block-patterns/)
- [Theme Patterns Guide](https://developer.wordpress.org/themes/features/block-patterns/)
- [WordPress Pattern Directory](https://wordpress.org/patterns/)
- [10up Patterns Best Practices](https://gutenberg.10up.com/reference/Patterns/overview/)
