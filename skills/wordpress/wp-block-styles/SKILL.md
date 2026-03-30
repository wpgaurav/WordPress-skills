---
name: wp-block-styles
description: "Style WordPress blocks with theme.json: presets, block-level styles, style variations, and custom CSS. Configure typography, colors, spacing, and layouts."
compatibility: "WordPress 6.6+ for theme.json v3. Some features require earlier versions."
---

# WordPress Block Styles & theme.json

## When to Use

Use this skill when:
- Configuring theme.json for block styling
- Creating color, typography, and spacing presets
- Adding block style variations
- Customizing specific block appearances
- Setting up global styles

## theme.json Fundamentals

### Basic Structure

```json
{
  "$schema": "https://schemas.wp.org/trunk/theme.json",
  "version": 3,
  "settings": {
    // Enable/disable features, define presets
  },
  "styles": {
    // Apply styles globally and per-block
  },
  "customTemplates": [],
  "templateParts": [],
  "patterns": []
}
```

### Version History

| Version | WordPress | Key Features |
|---------|-----------|--------------|
| 1 | 5.8+ | Initial release |
| 2 | 5.9+ | Layout settings, custom presets |
| 3 | 6.6+ | Style variations, enhanced presets |

## Settings Section

### Layout Settings

```json
{
  "settings": {
    "layout": {
      "contentSize": "840px",
      "wideSize": "1200px"
    },
    "useRootPaddingAwareAlignments": true
  }
}
```

### Color Settings

```json
{
  "settings": {
    "color": {
      "custom": true,
      "customGradient": true,
      "customDuotone": true,
      "defaultPalette": false,
      "defaultGradients": false,
      "defaultDuotone": false,
      "palette": [
        {
          "slug": "primary",
          "color": "#0073aa",
          "name": "Primary"
        },
        {
          "slug": "secondary",
          "color": "#23282d",
          "name": "Secondary"
        },
        {
          "slug": "accent",
          "color": "#d63638",
          "name": "Accent"
        },
        {
          "slug": "light-gray",
          "color": "#f8f9fa",
          "name": "Light Gray"
        },
        {
          "slug": "white",
          "color": "#ffffff",
          "name": "White"
        },
        {
          "slug": "black",
          "color": "#000000",
          "name": "Black"
        }
      ],
      "gradients": [
        {
          "slug": "primary-to-secondary",
          "gradient": "linear-gradient(135deg, #0073aa 0%, #23282d 100%)",
          "name": "Primary to Secondary"
        },
        {
          "slug": "light-to-dark",
          "gradient": "linear-gradient(180deg, #ffffff 0%, #f8f9fa 100%)",
          "name": "Light to Dark"
        }
      ],
      "duotone": [
        {
          "slug": "primary-white",
          "colors": ["#0073aa", "#ffffff"],
          "name": "Primary and White"
        }
      ]
    }
  }
}
```

### Typography Settings

```json
{
  "settings": {
    "typography": {
      "fluid": true,
      "customFontSize": true,
      "dropCap": true,
      "fontStyle": true,
      "fontWeight": true,
      "letterSpacing": true,
      "lineHeight": true,
      "textDecoration": true,
      "textTransform": true,
      "writingMode": true,
      "fontFamilies": [
        {
          "slug": "system",
          "fontFamily": "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen-Sans, Ubuntu, Cantarell, 'Helvetica Neue', sans-serif",
          "name": "System Font"
        },
        {
          "slug": "serif",
          "fontFamily": "Georgia, 'Times New Roman', serif",
          "name": "Serif"
        },
        {
          "slug": "heading",
          "fontFamily": "'Inter', sans-serif",
          "name": "Inter",
          "fontFace": [
            {
              "fontFamily": "Inter",
              "fontWeight": "400 900",
              "fontStyle": "normal",
              "fontStretch": "normal",
              "src": ["file:./assets/fonts/inter-variable.woff2"]
            }
          ]
        }
      ],
      "fontSizes": [
        {
          "slug": "small",
          "size": "0.875rem",
          "name": "Small"
        },
        {
          "slug": "medium",
          "size": "1rem",
          "name": "Medium"
        },
        {
          "slug": "large",
          "size": "1.25rem",
          "name": "Large"
        },
        {
          "slug": "x-large",
          "size": "1.5rem",
          "name": "Extra Large"
        },
        {
          "slug": "xx-large",
          "size": "2rem",
          "name": "2X Large"
        }
      ]
    }
  }
}
```

### Fluid Typography

```json
{
  "settings": {
    "typography": {
      "fluid": true,
      "fontSizes": [
        {
          "slug": "large",
          "size": "1.5rem",
          "fluid": {
            "min": "1.25rem",
            "max": "1.75rem"
          },
          "name": "Large"
        }
      ]
    }
  }
}
```

### Spacing Settings

```json
{
  "settings": {
    "spacing": {
      "margin": true,
      "padding": true,
      "blockGap": true,
      "units": ["px", "em", "rem", "%", "vw", "vh"],
      "spacingScale": {
        "operator": "*",
        "increment": 1.5,
        "steps": 7,
        "mediumStep": 1.5,
        "unit": "rem"
      },
      "spacingSizes": [
        {
          "slug": "10",
          "size": "0.25rem",
          "name": "1"
        },
        {
          "slug": "20",
          "size": "0.5rem",
          "name": "2"
        },
        {
          "slug": "30",
          "size": "0.75rem",
          "name": "3"
        },
        {
          "slug": "40",
          "size": "1rem",
          "name": "4"
        },
        {
          "slug": "50",
          "size": "1.5rem",
          "name": "5"
        },
        {
          "slug": "60",
          "size": "2rem",
          "name": "6"
        },
        {
          "slug": "70",
          "size": "3rem",
          "name": "7"
        },
        {
          "slug": "80",
          "size": "4rem",
          "name": "8"
        }
      ]
    }
  }
}
```

### Border & Shadow Settings

```json
{
  "settings": {
    "border": {
      "color": true,
      "radius": true,
      "style": true,
      "width": true
    },
    "shadow": {
      "presets": [
        {
          "slug": "sm",
          "shadow": "0 1px 2px rgba(0,0,0,0.05)",
          "name": "Small"
        },
        {
          "slug": "md",
          "shadow": "0 4px 6px rgba(0,0,0,0.1)",
          "name": "Medium"
        },
        {
          "slug": "lg",
          "shadow": "0 10px 15px rgba(0,0,0,0.1)",
          "name": "Large"
        },
        {
          "slug": "xl",
          "shadow": "0 20px 25px rgba(0,0,0,0.15)",
          "name": "Extra Large"
        }
      ]
    }
  }
}
```

### Dimension Settings

```json
{
  "settings": {
    "dimensions": {
      "minHeight": true,
      "aspectRatio": true,
      "aspectRatios": [
        {
          "slug": "square",
          "ratio": "1",
          "name": "Square"
        },
        {
          "slug": "4-3",
          "ratio": "4/3",
          "name": "4:3"
        },
        {
          "slug": "16-9",
          "ratio": "16/9",
          "name": "16:9"
        },
        {
          "slug": "21-9",
          "ratio": "21/9",
          "name": "21:9"
        }
      ]
    },
    "position": {
      "sticky": true
    }
  }
}
```

## Styles Section

### Global Styles

```json
{
  "styles": {
    "color": {
      "background": "var(--wp--preset--color--white)",
      "text": "var(--wp--preset--color--secondary)"
    },
    "typography": {
      "fontFamily": "var(--wp--preset--font-family--system)",
      "fontSize": "var(--wp--preset--font-size--medium)",
      "lineHeight": "1.6"
    },
    "spacing": {
      "blockGap": "1.5rem",
      "padding": {
        "top": "0",
        "right": "var(--wp--preset--spacing--50)",
        "bottom": "0",
        "left": "var(--wp--preset--spacing--50)"
      }
    },
    "elements": {
      "link": {
        "color": {
          "text": "var(--wp--preset--color--primary)"
        },
        ":hover": {
          "color": {
            "text": "var(--wp--preset--color--secondary)"
          }
        }
      },
      "heading": {
        "color": {
          "text": "var(--wp--preset--color--secondary)"
        },
        "typography": {
          "fontFamily": "var(--wp--preset--font-family--heading)",
          "fontWeight": "700",
          "lineHeight": "1.2"
        }
      },
      "h1": {
        "typography": {
          "fontSize": "2.5rem"
        }
      },
      "h2": {
        "typography": {
          "fontSize": "2rem"
        }
      },
      "h3": {
        "typography": {
          "fontSize": "1.5rem"
        }
      },
      "button": {
        "color": {
          "background": "var(--wp--preset--color--primary)",
          "text": "var(--wp--preset--color--white)"
        },
        "border": {
          "radius": "4px"
        },
        ":hover": {
          "color": {
            "background": "var(--wp--preset--color--secondary)"
          }
        }
      }
    }
  }
}
```

### Block-Specific Styles

```json
{
  "styles": {
    "blocks": {
      "core/paragraph": {
        "spacing": {
          "margin": {
            "top": "0",
            "bottom": "1.5rem"
          }
        }
      },
      "core/heading": {
        "spacing": {
          "margin": {
            "top": "2rem",
            "bottom": "1rem"
          }
        }
      },
      "core/button": {
        "border": {
          "radius": "6px"
        },
        "spacing": {
          "padding": {
            "top": "0.75rem",
            "right": "1.5rem",
            "bottom": "0.75rem",
            "left": "1.5rem"
          }
        },
        "typography": {
          "fontWeight": "600"
        }
      },
      "core/group": {
        "spacing": {
          "blockGap": "1.5rem"
        }
      },
      "core/columns": {
        "spacing": {
          "blockGap": {
            "left": "2rem"
          }
        }
      },
      "core/separator": {
        "color": {
          "background": "var(--wp--preset--color--light-gray)"
        },
        "border": {
          "width": "0"
        }
      },
      "core/quote": {
        "border": {
          "left": {
            "color": "var(--wp--preset--color--primary)",
            "width": "4px",
            "style": "solid"
          }
        },
        "spacing": {
          "padding": {
            "left": "1.5rem"
          }
        },
        "typography": {
          "fontStyle": "italic"
        }
      },
      "core/code": {
        "color": {
          "background": "var(--wp--preset--color--light-gray)",
          "text": "var(--wp--preset--color--secondary)"
        },
        "border": {
          "radius": "4px"
        },
        "spacing": {
          "padding": "1rem"
        },
        "typography": {
          "fontFamily": "monospace",
          "fontSize": "0.875rem"
        }
      },
      "core/image": {
        "border": {
          "radius": "8px"
        }
      },
      "core/cover": {
        "spacing": {
          "padding": {
            "top": "var(--wp--preset--spacing--70)",
            "bottom": "var(--wp--preset--spacing--70)"
          }
        }
      },
      "core/navigation": {
        "typography": {
          "fontSize": "var(--wp--preset--font-size--small)",
          "fontWeight": "500"
        }
      }
    }
  }
}
```

## Block Style Variations

### Registering via theme.json (6.6+)

```json
{
  "styles": {
    "blocks": {
      "core/button": {
        "variations": {
          "outline": {
            "color": {
              "background": "transparent",
              "text": "var(--wp--preset--color--primary)"
            },
            "border": {
              "color": "var(--wp--preset--color--primary)",
              "style": "solid",
              "width": "2px"
            },
            ":hover": {
              "color": {
                "background": "var(--wp--preset--color--primary)",
                "text": "var(--wp--preset--color--white)"
              }
            }
          },
          "fill": {
            "color": {
              "background": "var(--wp--preset--color--primary)",
              "text": "var(--wp--preset--color--white)"
            }
          }
        }
      },
      "core/separator": {
        "variations": {
          "wide": {
            "border": {
              "width": "2px"
            }
          },
          "dots": {
            "border": {
              "style": "dotted",
              "width": "3px"
            }
          }
        }
      },
      "core/image": {
        "variations": {
          "rounded": {
            "border": {
              "radius": "999px"
            }
          }
        }
      }
    }
  }
}
```

### Registering via PHP

```php
function my_register_block_styles() {
    register_block_style(
        'core/button',
        array(
            'name'         => 'pill',
            'label'        => __( 'Pill', 'theme-name' ),
            'inline_style' => '.wp-block-button.is-style-pill .wp-block-button__link { border-radius: 50px; }',
        )
    );

    register_block_style(
        'core/group',
        array(
            'name'         => 'card',
            'label'        => __( 'Card', 'theme-name' ),
            'style_handle' => 'my-theme-block-styles', // External CSS file
        )
    );

    register_block_style(
        'core/list',
        array(
            'name'  => 'checkmark',
            'label' => __( 'Checkmark', 'theme-name' ),
        )
    );
}
add_action( 'init', 'my_register_block_styles' );
```

### Style via JSON File (6.6+)

Create `styles/block-style-card.json`:

```json
{
  "version": 3,
  "title": "Card",
  "slug": "card",
  "blockTypes": ["core/group"],
  "styles": {
    "color": {
      "background": "var(--wp--preset--color--white)"
    },
    "border": {
      "radius": "12px"
    },
    "shadow": "var(--wp--preset--shadow--md)",
    "spacing": {
      "padding": "var(--wp--preset--spacing--50)"
    }
  }
}
```

## Global Style Variations

### Creating Variations

Place JSON files in `/styles/` directory:

`styles/dark-mode.json`:
```json
{
  "version": 3,
  "title": "Dark Mode",
  "settings": {
    "color": {
      "palette": [
        {
          "slug": "primary",
          "color": "#60a5fa",
          "name": "Primary"
        },
        {
          "slug": "secondary",
          "color": "#f1f5f9",
          "name": "Secondary"
        }
      ]
    }
  },
  "styles": {
    "color": {
      "background": "#0f172a",
      "text": "#e2e8f0"
    },
    "elements": {
      "link": {
        "color": {
          "text": "#60a5fa"
        }
      }
    }
  }
}
```

### Font Variation

`styles/serif.json`:
```json
{
  "version": 3,
  "title": "Serif",
  "settings": {
    "typography": {
      "fontFamilies": [
        {
          "slug": "heading",
          "fontFamily": "'Playfair Display', Georgia, serif",
          "name": "Playfair Display"
        }
      ]
    }
  },
  "styles": {
    "typography": {
      "fontFamily": "var(--wp--preset--font-family--serif)"
    }
  }
}
```

## CSS Custom Properties

### Preset Variables

WordPress generates CSS variables from presets:

```css
/* Colors */
--wp--preset--color--primary
--wp--preset--color--secondary

/* Typography */
--wp--preset--font-size--small
--wp--preset--font-size--medium
--wp--preset--font-family--system

/* Spacing */
--wp--preset--spacing--10
--wp--preset--spacing--50

/* Shadow */
--wp--preset--shadow--sm
--wp--preset--shadow--lg

/* Gradient */
--wp--preset--gradient--primary-to-secondary
```

### Usage in Styles

```json
{
  "styles": {
    "blocks": {
      "core/group": {
        "color": {
          "background": "var(--wp--preset--color--light-gray)"
        },
        "spacing": {
          "padding": "var(--wp--preset--spacing--50)"
        }
      }
    }
  }
}
```

### Custom CSS Properties

```json
{
  "settings": {
    "custom": {
      "lineHeight": {
        "tight": 1.2,
        "normal": 1.6,
        "loose": 2
      },
      "contentWidth": "840px",
      "sidebarWidth": "300px",
      "headerHeight": "80px"
    }
  }
}
```

Generated variables:
```css
--wp--custom--line-height--tight: 1.2;
--wp--custom--line-height--normal: 1.6;
--wp--custom--content-width: 840px;
```

## Custom CSS

### Global Custom CSS

```json
{
  "styles": {
    "css": ".site-header { position: sticky; top: 0; z-index: 100; } .wp-block-button:hover { transform: translateY(-2px); transition: transform 0.2s; }"
  }
}
```

### Per-Block Custom CSS

```json
{
  "styles": {
    "blocks": {
      "core/button": {
        "css": "&:hover { transform: translateY(-2px); } &:active { transform: translateY(0); }"
      },
      "core/image": {
        "css": "& img { transition: transform 0.3s; } &:hover img { transform: scale(1.02); }"
      }
    }
  }
}
```

## Block-Level Settings

### Disable Features for Specific Blocks

```json
{
  "settings": {
    "blocks": {
      "core/paragraph": {
        "color": {
          "custom": false,
          "customGradient": false
        }
      },
      "core/heading": {
        "typography": {
          "customFontSize": false
        }
      },
      "core/group": {
        "layout": {
          "allowEditing": false
        }
      }
    }
  }
}
```

### Custom Presets for Blocks

```json
{
  "settings": {
    "blocks": {
      "core/button": {
        "color": {
          "palette": [
            {
              "slug": "button-primary",
              "color": "#0073aa",
              "name": "Button Primary"
            },
            {
              "slug": "button-secondary",
              "color": "#333333",
              "name": "Button Secondary"
            }
          ]
        }
      }
    }
  }
}
```

## Complete theme.json Example

```json
{
  "$schema": "https://schemas.wp.org/trunk/theme.json",
  "version": 3,
  "settings": {
    "appearanceTools": true,
    "useRootPaddingAwareAlignments": true,
    "layout": {
      "contentSize": "840px",
      "wideSize": "1200px"
    },
    "color": {
      "defaultPalette": false,
      "defaultGradients": false,
      "palette": [
        { "slug": "primary", "color": "#0073aa", "name": "Primary" },
        { "slug": "secondary", "color": "#1e1e1e", "name": "Secondary" },
        { "slug": "accent", "color": "#d63638", "name": "Accent" },
        { "slug": "light", "color": "#f8f9fa", "name": "Light" },
        { "slug": "white", "color": "#ffffff", "name": "White" },
        { "slug": "black", "color": "#000000", "name": "Black" }
      ]
    },
    "typography": {
      "fluid": true,
      "fontFamilies": [
        {
          "slug": "system",
          "fontFamily": "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif",
          "name": "System"
        }
      ],
      "fontSizes": [
        { "slug": "small", "size": "0.875rem", "name": "Small" },
        { "slug": "medium", "size": "1rem", "name": "Medium" },
        { "slug": "large", "size": "1.25rem", "name": "Large" },
        { "slug": "x-large", "size": "1.5rem", "name": "XL" },
        { "slug": "xx-large", "size": "2rem", "name": "2XL" }
      ]
    },
    "spacing": {
      "spacingSizes": [
        { "slug": "10", "size": "0.25rem", "name": "1" },
        { "slug": "20", "size": "0.5rem", "name": "2" },
        { "slug": "30", "size": "0.75rem", "name": "3" },
        { "slug": "40", "size": "1rem", "name": "4" },
        { "slug": "50", "size": "1.5rem", "name": "5" },
        { "slug": "60", "size": "2rem", "name": "6" },
        { "slug": "70", "size": "3rem", "name": "7" },
        { "slug": "80", "size": "5rem", "name": "8" }
      ]
    },
    "shadow": {
      "presets": [
        { "slug": "sm", "shadow": "0 1px 2px rgba(0,0,0,0.05)", "name": "Small" },
        { "slug": "md", "shadow": "0 4px 6px rgba(0,0,0,0.1)", "name": "Medium" },
        { "slug": "lg", "shadow": "0 10px 15px rgba(0,0,0,0.1)", "name": "Large" }
      ]
    }
  },
  "styles": {
    "color": {
      "background": "var(--wp--preset--color--white)",
      "text": "var(--wp--preset--color--secondary)"
    },
    "typography": {
      "fontFamily": "var(--wp--preset--font-family--system)",
      "fontSize": "var(--wp--preset--font-size--medium)",
      "lineHeight": "1.6"
    },
    "spacing": {
      "blockGap": "var(--wp--preset--spacing--50)",
      "padding": {
        "left": "var(--wp--preset--spacing--50)",
        "right": "var(--wp--preset--spacing--50)"
      }
    },
    "elements": {
      "link": {
        "color": { "text": "var(--wp--preset--color--primary)" }
      },
      "heading": {
        "typography": { "fontWeight": "700", "lineHeight": "1.2" }
      },
      "button": {
        "color": {
          "background": "var(--wp--preset--color--primary)",
          "text": "var(--wp--preset--color--white)"
        },
        "border": { "radius": "6px" }
      }
    },
    "blocks": {
      "core/button": {
        "spacing": {
          "padding": {
            "top": "0.75rem",
            "right": "1.5rem",
            "bottom": "0.75rem",
            "left": "1.5rem"
          }
        }
      },
      "core/separator": {
        "color": { "background": "var(--wp--preset--color--light)" },
        "border": { "width": "0" }
      }
    }
  }
}
```

## Resources

- [Global Settings & Styles (theme.json)](https://developer.wordpress.org/block-editor/how-to-guides/themes/global-settings-and-styles/)
- [Block Style Variations](https://developer.wordpress.org/themes/features/block-style-variations/)
- [theme.json Reference](https://developer.wordpress.org/block-editor/reference-guides/theme-json-reference/theme-json-living/)
- [Full Site Editing - theme.json](https://fullsiteediting.com/lessons/theme-json-layout-and-spacing-options/)
