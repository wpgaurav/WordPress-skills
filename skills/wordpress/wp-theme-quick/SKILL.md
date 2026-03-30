---
name: wp-theme-quick
description: Build modern WordPress block themes following Full Site Editing (FSE) best practices.
---

# Skill: WordPress Theme Development

Build modern WordPress block themes following Full Site Editing (FSE) best practices.

## Before Starting

1. Load `/CLAUDE/context/wordpress-dev.md` for standards
2. Review theme.json documentation
3. Understand block template hierarchy

## Theme Types

### Block Theme (Recommended)

Full Site Editing theme using HTML templates and theme.json.

```
theme-name/
├── style.css
├── theme.json
├── functions.php
├── screenshot.png
├── readme.txt
├── parts/
│   ├── header.html
│   ├── footer.html
│   └── sidebar.html
├── patterns/
│   ├── hero.php
│   └── cta.php
├── templates/
│   ├── index.html
│   ├── single.html
│   ├── page.html
│   ├── archive.html
│   ├── 404.html
│   └── search.html
├── styles/
│   └── dark.json
└── assets/
    ├── css/
    ├── js/
    ├── fonts/
    └── images/
```

### Classic Theme

Traditional PHP-based theme (legacy approach).

## style.css Header

```css
/*
Theme Name:       Theme Name
Theme URI:        https://example.com/theme-name
Author:           Gaurav Tiwari
Author URI:       https://yoursite.com
Description:      A lightweight, performance-focused WordPress theme.
Version:          1.0.0
Requires at least: 6.0
Tested up to:     6.5
Requires PHP:     8.0
License:          GNU General Public License v2 or later
License URI:      https://www.gnu.org/licenses/gpl-2.0.html
Text Domain:      theme-name
Tags:             block-patterns, block-styles, custom-colors, custom-logo, custom-menu, editor-style, featured-images, full-site-editing, template-editing, wide-blocks

Theme Name is a lightweight starter theme built for speed and simplicity.
*/
```

## theme.json

```json
{
    "$schema": "https://schemas.wp.org/trunk/theme.json",
    "version": 3,
    "settings": {
        "appearanceTools": true,
        "useRootPaddingAwareAlignments": true,
        "layout": {
            "contentSize": "768px",
            "wideSize": "1200px"
        },
        "color": {
            "custom": true,
            "customDuotone": true,
            "customGradient": true,
            "defaultDuotone": false,
            "defaultGradients": false,
            "defaultPalette": false,
            "palette": [
                {
                    "color": "#1a1a1a",
                    "name": "Primary",
                    "slug": "primary"
                },
                {
                    "color": "#0073aa",
                    "name": "Accent",
                    "slug": "accent"
                },
                {
                    "color": "#ffffff",
                    "name": "Base",
                    "slug": "base"
                },
                {
                    "color": "#f5f5f5",
                    "name": "Base Alt",
                    "slug": "base-alt"
                },
                {
                    "color": "#333333",
                    "name": "Contrast",
                    "slug": "contrast"
                }
            ]
        },
        "typography": {
            "customFontSize": true,
            "dropCap": false,
            "fluid": true,
            "fontFamilies": [
                {
                    "fontFace": [
                        {
                            "fontFamily": "Inter",
                            "fontStyle": "normal",
                            "fontWeight": "400",
                            "src": ["file:./assets/fonts/inter-regular.woff2"]
                        },
                        {
                            "fontFamily": "Inter",
                            "fontStyle": "normal",
                            "fontWeight": "600",
                            "src": ["file:./assets/fonts/inter-semibold.woff2"]
                        },
                        {
                            "fontFamily": "Inter",
                            "fontStyle": "normal",
                            "fontWeight": "700",
                            "src": ["file:./assets/fonts/inter-bold.woff2"]
                        }
                    ],
                    "fontFamily": "\"Inter\", sans-serif",
                    "name": "Inter",
                    "slug": "inter"
                },
                {
                    "fontFamily": "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen-Sans, Ubuntu, Cantarell, 'Helvetica Neue', sans-serif",
                    "name": "System Font",
                    "slug": "system"
                }
            ],
            "fontSizes": [
                {
                    "fluid": {
                        "min": "0.875rem",
                        "max": "1rem"
                    },
                    "name": "Small",
                    "size": "1rem",
                    "slug": "small"
                },
                {
                    "fluid": {
                        "min": "1rem",
                        "max": "1.125rem"
                    },
                    "name": "Medium",
                    "size": "1.125rem",
                    "slug": "medium"
                },
                {
                    "fluid": {
                        "min": "1.25rem",
                        "max": "1.5rem"
                    },
                    "name": "Large",
                    "size": "1.5rem",
                    "slug": "large"
                },
                {
                    "fluid": {
                        "min": "1.5rem",
                        "max": "2rem"
                    },
                    "name": "X-Large",
                    "size": "2rem",
                    "slug": "x-large"
                },
                {
                    "fluid": {
                        "min": "2rem",
                        "max": "3rem"
                    },
                    "name": "XX-Large",
                    "size": "3rem",
                    "slug": "xx-large"
                }
            ],
            "lineHeight": true,
            "textDecoration": true,
            "writingMode": true
        },
        "spacing": {
            "customSpacingSize": true,
            "spacingScale": {
                "steps": 7
            },
            "spacingSizes": [
                {
                    "name": "1",
                    "size": "0.5rem",
                    "slug": "10"
                },
                {
                    "name": "2",
                    "size": "1rem",
                    "slug": "20"
                },
                {
                    "name": "3",
                    "size": "1.5rem",
                    "slug": "30"
                },
                {
                    "name": "4",
                    "size": "2rem",
                    "slug": "40"
                },
                {
                    "name": "5",
                    "size": "3rem",
                    "slug": "50"
                },
                {
                    "name": "6",
                    "size": "4rem",
                    "slug": "60"
                },
                {
                    "name": "7",
                    "size": "6rem",
                    "slug": "70"
                }
            ],
            "units": ["px", "em", "rem", "%", "vw", "vh"]
        },
        "border": {
            "color": true,
            "radius": true,
            "style": true,
            "width": true
        },
        "shadow": {
            "defaultPresets": false,
            "presets": [
                {
                    "name": "Small",
                    "shadow": "0 1px 2px 0 rgb(0 0 0 / 0.05)",
                    "slug": "sm"
                },
                {
                    "name": "Medium",
                    "shadow": "0 4px 6px -1px rgb(0 0 0 / 0.1)",
                    "slug": "md"
                },
                {
                    "name": "Large",
                    "shadow": "0 10px 15px -3px rgb(0 0 0 / 0.1)",
                    "slug": "lg"
                }
            ]
        },
        "blocks": {
            "core/button": {
                "border": {
                    "radius": true
                }
            },
            "core/pullquote": {
                "border": {
                    "color": true,
                    "radius": true,
                    "style": true,
                    "width": true
                }
            }
        }
    },
    "styles": {
        "color": {
            "background": "var(--wp--preset--color--base)",
            "text": "var(--wp--preset--color--contrast)"
        },
        "elements": {
            "button": {
                "border": {
                    "radius": "4px"
                },
                "color": {
                    "background": "var(--wp--preset--color--accent)",
                    "text": "var(--wp--preset--color--base)"
                },
                ":hover": {
                    "color": {
                        "background": "var(--wp--preset--color--primary)"
                    }
                }
            },
            "h1": {
                "typography": {
                    "fontSize": "var(--wp--preset--font-size--xx-large)",
                    "fontWeight": "700",
                    "lineHeight": "1.2"
                }
            },
            "h2": {
                "typography": {
                    "fontSize": "var(--wp--preset--font-size--x-large)",
                    "fontWeight": "700",
                    "lineHeight": "1.3"
                }
            },
            "h3": {
                "typography": {
                    "fontSize": "var(--wp--preset--font-size--large)",
                    "fontWeight": "600",
                    "lineHeight": "1.4"
                }
            },
            "link": {
                "color": {
                    "text": "var(--wp--preset--color--accent)"
                },
                ":hover": {
                    "color": {
                        "text": "var(--wp--preset--color--primary)"
                    }
                }
            }
        },
        "spacing": {
            "blockGap": "1.5rem",
            "padding": {
                "left": "var(--wp--preset--spacing--30)",
                "right": "var(--wp--preset--spacing--30)"
            }
        },
        "typography": {
            "fontFamily": "var(--wp--preset--font-family--inter)",
            "fontSize": "var(--wp--preset--font-size--medium)",
            "lineHeight": "1.6"
        },
        "blocks": {
            "core/site-title": {
                "typography": {
                    "fontSize": "var(--wp--preset--font-size--large)",
                    "fontWeight": "700"
                }
            },
            "core/navigation": {
                "typography": {
                    "fontSize": "var(--wp--preset--font-size--small)"
                }
            },
            "core/post-title": {
                "typography": {
                    "fontSize": "var(--wp--preset--font-size--xx-large)"
                }
            }
        }
    },
    "templateParts": [
        {
            "area": "header",
            "name": "header",
            "title": "Header"
        },
        {
            "area": "footer",
            "name": "footer",
            "title": "Footer"
        },
        {
            "area": "uncategorized",
            "name": "sidebar",
            "title": "Sidebar"
        }
    ],
    "customTemplates": [
        {
            "name": "blank",
            "postTypes": ["page", "post"],
            "title": "Blank"
        },
        {
            "name": "full-width",
            "postTypes": ["page"],
            "title": "Full Width"
        }
    ]
}
```

## functions.php

```php
<?php
/**
 * Theme functions and definitions.
 *
 * @package ThemeName
 */

defined( 'ABSPATH' ) || exit;

// Theme constants.
define( 'THEME_NAME_VERSION', wp_get_theme()->get( 'Version' ) );
define( 'THEME_NAME_PATH', get_template_directory() );
define( 'THEME_NAME_URL', get_template_directory_uri() );

/**
 * Theme setup.
 */
function theme_name_setup() {
    // Make theme available for translation.
    load_theme_textdomain( 'theme-name', THEME_NAME_PATH . '/languages' );

    // Add support for block styles.
    add_theme_support( 'wp-block-styles' );

    // Enqueue editor styles.
    add_editor_style( 'style.css' );
}
add_action( 'after_setup_theme', 'theme_name_setup' );

/**
 * Enqueue scripts and styles.
 */
function theme_name_scripts() {
    // Main stylesheet.
    wp_enqueue_style(
        'theme-name-style',
        get_stylesheet_uri(),
        array(),
        THEME_NAME_VERSION
    );

    // Additional CSS (if needed).
    if ( file_exists( THEME_NAME_PATH . '/assets/css/custom.css' ) ) {
        wp_enqueue_style(
            'theme-name-custom',
            THEME_NAME_URL . '/assets/css/custom.css',
            array( 'theme-name-style' ),
            filemtime( THEME_NAME_PATH . '/assets/css/custom.css' )
        );
    }

    // JavaScript.
    if ( file_exists( THEME_NAME_PATH . '/assets/js/main.js' ) ) {
        wp_enqueue_script(
            'theme-name-scripts',
            THEME_NAME_URL . '/assets/js/main.js',
            array(),
            filemtime( THEME_NAME_PATH . '/assets/js/main.js' ),
            true
        );
    }
}
add_action( 'wp_enqueue_scripts', 'theme_name_scripts' );

/**
 * Register block patterns.
 */
function theme_name_register_patterns() {
    // Register pattern category.
    register_block_pattern_category(
        'theme-name',
        array(
            'label' => __( 'Theme Name', 'theme-name' ),
        )
    );
}
add_action( 'init', 'theme_name_register_patterns' );

/**
 * Register block styles.
 */
function theme_name_register_block_styles() {
    // Button styles.
    register_block_style(
        'core/button',
        array(
            'name'  => 'outline-accent',
            'label' => __( 'Outline Accent', 'theme-name' ),
        )
    );

    // Group styles.
    register_block_style(
        'core/group',
        array(
            'name'  => 'card',
            'label' => __( 'Card', 'theme-name' ),
        )
    );
}
add_action( 'init', 'theme_name_register_block_styles' );

/**
 * Filter allowed block types.
 *
 * @param array|bool $allowed_blocks Allowed blocks.
 * @param object     $editor_context Block editor context.
 * @return array
 */
function theme_name_allowed_blocks( $allowed_blocks, $editor_context ) {
    // Optionally restrict blocks.
    // Return array of allowed block names or true for all.
    return $allowed_blocks;
}
add_filter( 'allowed_block_types_all', 'theme_name_allowed_blocks', 10, 2 );

// Include additional files.
require_once THEME_NAME_PATH . '/inc/template-functions.php';
require_once THEME_NAME_PATH . '/inc/block-patterns.php';
```

## Block Templates

### templates/index.html

```html
<!-- wp:template-part {"slug":"header","area":"header"} /-->

<!-- wp:group {"tagName":"main","layout":{"type":"constrained"}} -->
<main class="wp-block-group">
    <!-- wp:query {"queryId":1,"query":{"perPage":10,"pages":0,"offset":0,"postType":"post","order":"desc","orderBy":"date","author":"","search":"","exclude":[],"sticky":"","inherit":true}} -->
    <div class="wp-block-query">
        <!-- wp:post-template -->
        <!-- wp:group {"style":{"spacing":{"blockGap":"var:preset|spacing|20"}},"layout":{"type":"flex","flexWrap":"nowrap","verticalAlignment":"top"}} -->
        <div class="wp-block-group">
            <!-- wp:post-featured-image {"isLink":true,"width":"200px","height":"150px"} /-->
            <!-- wp:group {"layout":{"type":"constrained"}} -->
            <div class="wp-block-group">
                <!-- wp:post-title {"isLink":true,"fontSize":"large"} /-->
                <!-- wp:post-excerpt {"moreText":"Read more"} /-->
                <!-- wp:post-date {"fontSize":"small"} /-->
            </div>
            <!-- /wp:group -->
        </div>
        <!-- /wp:group -->
        <!-- /wp:post-template -->

        <!-- wp:query-pagination {"layout":{"type":"flex","justifyContent":"center"}} -->
        <!-- wp:query-pagination-previous /-->
        <!-- wp:query-pagination-numbers /-->
        <!-- wp:query-pagination-next /-->
        <!-- /wp:query-pagination -->

        <!-- wp:query-no-results -->
        <!-- wp:paragraph -->
        <p>No posts found.</p>
        <!-- /wp:paragraph -->
        <!-- /wp:query-no-results -->
    </div>
    <!-- /wp:query -->
</main>
<!-- /wp:group -->

<!-- wp:template-part {"slug":"footer","area":"footer"} /-->
```

### templates/single.html

```html
<!-- wp:template-part {"slug":"header","area":"header"} /-->

<!-- wp:group {"tagName":"main","layout":{"type":"constrained"}} -->
<main class="wp-block-group">
    <!-- wp:group {"style":{"spacing":{"padding":{"top":"var:preset|spacing|50","bottom":"var:preset|spacing|50"}}}} -->
    <div class="wp-block-group">
        <!-- wp:post-title {"level":1} /-->

        <!-- wp:group {"style":{"spacing":{"blockGap":"var:preset|spacing|10"}},"layout":{"type":"flex"},"fontSize":"small"} -->
        <div class="wp-block-group">
            <!-- wp:post-date /-->
            <!-- wp:paragraph -->
            <p>·</p>
            <!-- /wp:paragraph -->
            <!-- wp:post-author {"showAvatar":false} /-->
            <!-- wp:paragraph -->
            <p>·</p>
            <!-- /wp:paragraph -->
            <!-- wp:post-terms {"term":"category"} /-->
        </div>
        <!-- /wp:group -->

        <!-- wp:post-featured-image {"aspectRatio":"16/9"} /-->

        <!-- wp:post-content {"layout":{"type":"constrained"}} /-->

        <!-- wp:post-terms {"term":"post_tag","prefix":"Tags: "} /-->

        <!-- wp:separator {"className":"is-style-wide"} -->
        <hr class="wp-block-separator has-alpha-channel-opacity is-style-wide"/>
        <!-- /wp:separator -->

        <!-- wp:comments -->
        <div class="wp-block-comments">
            <!-- wp:comments-title /-->
            <!-- wp:comment-template -->
            <!-- wp:columns -->
            <div class="wp-block-columns">
                <!-- wp:column {"width":"40px"} -->
                <div class="wp-block-column" style="flex-basis:40px">
                    <!-- wp:avatar {"size":40} /-->
                </div>
                <!-- /wp:column -->
                <!-- wp:column -->
                <div class="wp-block-column">
                    <!-- wp:comment-author-name /-->
                    <!-- wp:comment-date /-->
                    <!-- wp:comment-content /-->
                    <!-- wp:comment-reply-link /-->
                </div>
                <!-- /wp:column -->
            </div>
            <!-- /wp:columns -->
            <!-- /wp:comment-template -->
            <!-- wp:comments-pagination -->
            <!-- wp:comments-pagination-previous /-->
            <!-- wp:comments-pagination-numbers /-->
            <!-- wp:comments-pagination-next /-->
            <!-- /wp:comments-pagination -->
            <!-- wp:post-comments-form /-->
        </div>
        <!-- /wp:comments -->
    </div>
    <!-- /wp:group -->
</main>
<!-- /wp:group -->

<!-- wp:template-part {"slug":"footer","area":"footer"} /-->
```

### parts/header.html

```html
<!-- wp:group {"style":{"spacing":{"padding":{"top":"var:preset|spacing|30","bottom":"var:preset|spacing|30"}}},"backgroundColor":"base","layout":{"type":"constrained"}} -->
<div class="wp-block-group has-base-background-color has-background">
    <!-- wp:group {"layout":{"type":"flex","flexWrap":"wrap","justifyContent":"space-between"}} -->
    <div class="wp-block-group">
        <!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap"}} -->
        <div class="wp-block-group">
            <!-- wp:site-logo {"width":48} /-->
            <!-- wp:site-title {"level":0} /-->
        </div>
        <!-- /wp:group -->

        <!-- wp:navigation {"layout":{"type":"flex","justifyContent":"right"}} /-->
    </div>
    <!-- /wp:group -->
</div>
<!-- /wp:group -->
```

### parts/footer.html

```html
<!-- wp:group {"style":{"spacing":{"padding":{"top":"var:preset|spacing|50","bottom":"var:preset|spacing|50"}}},"backgroundColor":"base-alt","layout":{"type":"constrained"}} -->
<div class="wp-block-group has-base-alt-background-color has-background">
    <!-- wp:group {"layout":{"type":"flex","flexWrap":"wrap","justifyContent":"space-between"}} -->
    <div class="wp-block-group">
        <!-- wp:paragraph {"fontSize":"small"} -->
        <p class="has-small-font-size">© 2024 Site Name. All rights reserved.</p>
        <!-- /wp:paragraph -->

        <!-- wp:social-links {"iconColor":"contrast","iconColorValue":"#333333","size":"has-small-icon-size","className":"is-style-logos-only"} -->
        <ul class="wp-block-social-links has-small-icon-size has-icon-color is-style-logos-only">
            <!-- wp:social-link {"url":"https://twitter.com","service":"twitter"} /-->
            <!-- wp:social-link {"url":"https://linkedin.com","service":"linkedin"} /-->
            <!-- wp:social-link {"url":"https://github.com","service":"github"} /-->
        </ul>
        <!-- /wp:social-links -->
    </div>
    <!-- /wp:group -->
</div>
<!-- /wp:group -->
```

## Block Patterns

### patterns/hero.php

```php
<?php
/**
 * Title: Hero Section
 * Slug: theme-name/hero
 * Categories: theme-name, featured
 * Keywords: hero, banner, heading
 * Viewport Width: 1200
 */
?>
<!-- wp:cover {"overlayColor":"primary","minHeight":500,"isDark":false,"align":"full","layout":{"type":"constrained"}} -->
<div class="wp-block-cover alignfull is-light" style="min-height:500px">
    <span aria-hidden="true" class="wp-block-cover__background has-primary-background-color has-background-dim-100 has-background-dim"></span>
    <div class="wp-block-cover__inner-container">
        <!-- wp:heading {"textAlign":"center","level":1,"style":{"typography":{"fontWeight":"700"}},"textColor":"base","fontSize":"xx-large"} -->
        <h1 class="wp-block-heading has-text-align-center has-base-color has-text-color has-xx-large-font-size" style="font-weight:700"><?php esc_html_e( 'Welcome to Our Site', 'theme-name' ); ?></h1>
        <!-- /wp:heading -->

        <!-- wp:paragraph {"align":"center","textColor":"base","fontSize":"large"} -->
        <p class="has-text-align-center has-base-color has-text-color has-large-font-size"><?php esc_html_e( 'A short tagline describing what you do and why visitors should care.', 'theme-name' ); ?></p>
        <!-- /wp:paragraph -->

        <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
        <div class="wp-block-buttons">
            <!-- wp:button {"backgroundColor":"accent","textColor":"base"} -->
            <div class="wp-block-button"><a class="wp-block-button__link has-base-color has-accent-background-color has-text-color has-background wp-element-button"><?php esc_html_e( 'Get Started', 'theme-name' ); ?></a></div>
            <!-- /wp:button -->
            <!-- wp:button {"className":"is-style-outline"} -->
            <div class="wp-block-button is-style-outline"><a class="wp-block-button__link wp-element-button"><?php esc_html_e( 'Learn More', 'theme-name' ); ?></a></div>
            <!-- /wp:button -->
        </div>
        <!-- /wp:buttons -->
    </div>
</div>
<!-- /wp:cover -->
```

### patterns/cta.php

```php
<?php
/**
 * Title: Call to Action
 * Slug: theme-name/cta
 * Categories: theme-name, call-to-action
 * Keywords: cta, action, button
 */
?>
<!-- wp:group {"style":{"spacing":{"padding":{"top":"var:preset|spacing|50","bottom":"var:preset|spacing|50"}}},"backgroundColor":"base-alt","layout":{"type":"constrained"}} -->
<div class="wp-block-group has-base-alt-background-color has-background">
    <!-- wp:heading {"textAlign":"center"} -->
    <h2 class="wp-block-heading has-text-align-center"><?php esc_html_e( 'Ready to Get Started?', 'theme-name' ); ?></h2>
    <!-- /wp:heading -->

    <!-- wp:paragraph {"align":"center"} -->
    <p class="has-text-align-center"><?php esc_html_e( 'Join thousands of happy customers and transform your business today.', 'theme-name' ); ?></p>
    <!-- /wp:paragraph -->

    <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
    <div class="wp-block-buttons">
        <!-- wp:button {"backgroundColor":"accent"} -->
        <div class="wp-block-button"><a class="wp-block-button__link has-accent-background-color has-background wp-element-button"><?php esc_html_e( 'Start Free Trial', 'theme-name' ); ?></a></div>
        <!-- /wp:button -->
    </div>
    <!-- /wp:buttons -->
</div>
<!-- /wp:group -->
```

## Style Variations

### styles/dark.json

```json
{
    "$schema": "https://schemas.wp.org/trunk/theme.json",
    "version": 3,
    "title": "Dark",
    "settings": {
        "color": {
            "palette": [
                {
                    "color": "#ffffff",
                    "name": "Primary",
                    "slug": "primary"
                },
                {
                    "color": "#60a5fa",
                    "name": "Accent",
                    "slug": "accent"
                },
                {
                    "color": "#0f172a",
                    "name": "Base",
                    "slug": "base"
                },
                {
                    "color": "#1e293b",
                    "name": "Base Alt",
                    "slug": "base-alt"
                },
                {
                    "color": "#f1f5f9",
                    "name": "Contrast",
                    "slug": "contrast"
                }
            ]
        }
    },
    "styles": {
        "color": {
            "background": "var(--wp--preset--color--base)",
            "text": "var(--wp--preset--color--contrast)"
        }
    }
}
```

## Performance Optimizations

### Preload Fonts

```php
/**
 * Preload fonts.
 */
function theme_name_preload_fonts() {
    ?>
    <link rel="preload" href="<?php echo esc_url( THEME_NAME_URL . '/assets/fonts/inter-regular.woff2' ); ?>" as="font" type="font/woff2" crossorigin>
    <link rel="preload" href="<?php echo esc_url( THEME_NAME_URL . '/assets/fonts/inter-bold.woff2' ); ?>" as="font" type="font/woff2" crossorigin>
    <?php
}
add_action( 'wp_head', 'theme_name_preload_fonts', 1 );
```

### Remove Unused Features

```php
/**
 * Remove unnecessary features.
 */
function theme_name_cleanup() {
    // Remove emoji scripts.
    remove_action( 'wp_head', 'print_emoji_detection_script', 7 );
    remove_action( 'wp_print_styles', 'print_emoji_styles' );

    // Remove RSD link.
    remove_action( 'wp_head', 'rsd_link' );

    // Remove wlwmanifest.
    remove_action( 'wp_head', 'wlwmanifest_link' );

    // Remove generator meta.
    remove_action( 'wp_head', 'wp_generator' );
}
add_action( 'init', 'theme_name_cleanup' );
```

## Quality Checklist

Before releasing:

- [ ] style.css header complete with all fields
- [ ] theme.json validates against schema
- [ ] All templates use proper block markup
- [ ] Template parts registered in theme.json
- [ ] Block patterns are translatable
- [ ] Fonts loaded via theme.json (not @import)
- [ ] Screenshot is 1200x900px
- [ ] readme.txt is valid
- [ ] No PHP errors in functions.php
- [ ] Editor styles match frontend
- [ ] Responsive on all screen sizes
- [ ] Passes Theme Check plugin
- [ ] Accessibility audit passed
- [ ] Performance tested (Core Web Vitals)
