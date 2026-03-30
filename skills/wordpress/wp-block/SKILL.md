---
name: wp-block
description: Quick scaffold for Gutenberg block development with block.json, PHP registration, and React components.
---

# Skill: WordPress Block Development

Build custom Gutenberg blocks using the WordPress Block API and @wordpress/scripts.

## Before Starting

1. Load `/CLAUDE/context/wordpress-dev.md` for standards
2. Ensure Node.js 20+ and npm installed
3. Understand React basics and WordPress data layer

## Block Types

### Static Block
Renders same content in editor and frontend from saved markup.

### Dynamic Block
Renders via PHP callback, content generated server-side.

### Interactive Block
Uses @wordpress/interactivity API for frontend interactivity without full React.

## Project Setup

### Using @wordpress/create-block

```bash
# Create new block plugin
npx @wordpress/create-block my-block --namespace gt

# Create dynamic block
npx @wordpress/create-block my-dynamic-block --namespace gt --variant dynamic

# Create interactive block
npx @wordpress/create-block my-interactive-block --namespace gt --template @wordpress/create-block-interactive-template
```

### Manual Setup (for existing plugins)

```bash
# Initialize npm
npm init -y

# Install dependencies
npm install @wordpress/scripts --save-dev

# Add to package.json scripts
```

```json
{
  "scripts": {
    "build": "wp-scripts build",
    "start": "wp-scripts start",
    "format": "wp-scripts format",
    "lint:css": "wp-scripts lint-style",
    "lint:js": "wp-scripts lint-js",
    "packages-update": "wp-scripts packages-update"
  }
}
```

### File Structure

```
my-block/
├── my-block.php              # Plugin file / block registration
├── package.json
├── src/
│   ├── block.json            # Block metadata
│   ├── index.js              # Block registration
│   ├── edit.js               # Editor component
│   ├── save.js               # Save component
│   ├── style.scss            # Frontend + editor styles
│   ├── editor.scss           # Editor-only styles
│   └── view.js               # Frontend interactivity (optional)
└── build/                    # Compiled output (gitignored)
```

## block.json

```json
{
    "$schema": "https://schemas.wp.org/trunk/block.json",
    "apiVersion": 3,
    "name": "gt/my-block",
    "version": "1.0.0",
    "title": "My Block",
    "category": "widgets",
    "icon": "smiley",
    "description": "A custom block that does something useful.",
    "keywords": ["custom", "example"],
    "textdomain": "my-block",
    "attributes": {
        "content": {
            "type": "string",
            "source": "html",
            "selector": "p"
        },
        "alignment": {
            "type": "string",
            "default": "left"
        },
        "backgroundColor": {
            "type": "string"
        },
        "showIcon": {
            "type": "boolean",
            "default": true
        },
        "iconSize": {
            "type": "number",
            "default": 24
        }
    },
    "supports": {
        "html": false,
        "align": ["wide", "full"],
        "anchor": true,
        "className": true,
        "color": {
            "background": true,
            "text": true,
            "link": true
        },
        "spacing": {
            "margin": true,
            "padding": true,
            "blockGap": true
        },
        "typography": {
            "fontSize": true,
            "lineHeight": true
        },
        "__experimentalBorder": {
            "color": true,
            "radius": true,
            "style": true,
            "width": true
        }
    },
    "example": {
        "attributes": {
            "content": "Example content for the block preview."
        }
    },
    "editorScript": "file:./index.js",
    "editorStyle": "file:./index.css",
    "style": "file:./style-index.css",
    "viewScript": "file:./view.js",
    "render": "file:./render.php"
}
```

## Block Registration (PHP)

### Static Block

```php
<?php
/**
 * Plugin Name: My Block
 * Description: A custom Gutenberg block.
 * Version: 1.0.0
 * Author: Gaurav Tiwari
 * Text Domain: my-block
 *
 * @package MyBlock
 */

defined( 'ABSPATH' ) || exit;

/**
 * Register block.
 */
function gt_my_block_init() {
    register_block_type( __DIR__ . '/build' );
}
add_action( 'init', 'gt_my_block_init' );
```

### Dynamic Block

```php
<?php
/**
 * Register dynamic block.
 */
function gt_my_block_init() {
    register_block_type(
        __DIR__ . '/build',
        array(
            'render_callback' => 'gt_my_block_render',
        )
    );
}
add_action( 'init', 'gt_my_block_init' );

/**
 * Render callback.
 *
 * @param array    $attributes Block attributes.
 * @param string   $content    Block content.
 * @param WP_Block $block      Block instance.
 * @return string
 */
function gt_my_block_render( $attributes, $content, $block ) {
    // Get block wrapper attributes.
    $wrapper_attributes = get_block_wrapper_attributes(
        array(
            'class' => 'gt-my-block',
        )
    );

    // Build output.
    $output = sprintf(
        '<div %1$s><p>%2$s</p></div>',
        $wrapper_attributes,
        esc_html( $attributes['content'] ?? '' )
    );

    return $output;
}
```

### Using render.php Template

```php
<?php
/**
 * Block render template.
 *
 * @var array    $attributes Block attributes.
 * @var string   $content    Block content.
 * @var WP_Block $block      Block instance.
 *
 * @package MyBlock
 */

defined( 'ABSPATH' ) || exit;

$content_text = $attributes['content'] ?? '';
$show_icon    = $attributes['showIcon'] ?? true;
?>
<div <?php echo get_block_wrapper_attributes( array( 'class' => 'gt-my-block' ) ); ?>>
    <?php if ( $show_icon ) : ?>
        <span class="gt-my-block__icon" aria-hidden="true">★</span>
    <?php endif; ?>
    <p class="gt-my-block__content"><?php echo esc_html( $content_text ); ?></p>
</div>
```

## Block JavaScript

### index.js

```javascript
/**
 * Block registration.
 */
import { registerBlockType } from '@wordpress/blocks';
import './style.scss';
import Edit from './edit';
import save from './save';
import metadata from './block.json';

registerBlockType( metadata.name, {
    edit: Edit,
    save,
} );
```

### edit.js (Simple)

```javascript
/**
 * Editor component.
 */
import { __ } from '@wordpress/i18n';
import {
    useBlockProps,
    RichText,
    BlockControls,
    AlignmentToolbar,
    InspectorControls,
} from '@wordpress/block-editor';
import {
    PanelBody,
    ToggleControl,
    RangeControl,
} from '@wordpress/components';
import './editor.scss';

export default function Edit( { attributes, setAttributes } ) {
    const { content, alignment, showIcon, iconSize } = attributes;

    const blockProps = useBlockProps( {
        className: `has-text-align-${ alignment }`,
    } );

    return (
        <>
            <BlockControls>
                <AlignmentToolbar
                    value={ alignment }
                    onChange={ ( newAlignment ) =>
                        setAttributes( { alignment: newAlignment } )
                    }
                />
            </BlockControls>

            <InspectorControls>
                <PanelBody title={ __( 'Settings', 'my-block' ) }>
                    <ToggleControl
                        label={ __( 'Show Icon', 'my-block' ) }
                        checked={ showIcon }
                        onChange={ ( value ) =>
                            setAttributes( { showIcon: value } )
                        }
                    />
                    { showIcon && (
                        <RangeControl
                            label={ __( 'Icon Size', 'my-block' ) }
                            value={ iconSize }
                            onChange={ ( value ) =>
                                setAttributes( { iconSize: value } )
                            }
                            min={ 16 }
                            max={ 64 }
                        />
                    ) }
                </PanelBody>
            </InspectorControls>

            <div { ...blockProps }>
                { showIcon && (
                    <span
                        className="gt-my-block__icon"
                        style={ { fontSize: iconSize } }
                    >
                        ★
                    </span>
                ) }
                <RichText
                    tagName="p"
                    className="gt-my-block__content"
                    value={ content }
                    onChange={ ( value ) =>
                        setAttributes( { content: value } )
                    }
                    placeholder={ __( 'Enter text…', 'my-block' ) }
                />
            </div>
        </>
    );
}
```

### save.js

```javascript
/**
 * Save component.
 */
import { useBlockProps, RichText } from '@wordpress/block-editor';

export default function save( { attributes } ) {
    const { content, alignment, showIcon, iconSize } = attributes;

    const blockProps = useBlockProps.save( {
        className: `has-text-align-${ alignment }`,
    } );

    return (
        <div { ...blockProps }>
            { showIcon && (
                <span
                    className="gt-my-block__icon"
                    style={ { fontSize: iconSize } }
                    aria-hidden="true"
                >
                    ★
                </span>
            ) }
            <RichText.Content
                tagName="p"
                className="gt-my-block__content"
                value={ content }
            />
        </div>
    );
}
```

## Advanced Patterns

### Using InnerBlocks

```javascript
import { useBlockProps, InnerBlocks } from '@wordpress/block-editor';

const ALLOWED_BLOCKS = [ 'core/paragraph', 'core/heading', 'core/image' ];

const TEMPLATE = [
    [ 'core/heading', { placeholder: 'Enter heading...' } ],
    [ 'core/paragraph', { placeholder: 'Enter content...' } ],
];

export default function Edit() {
    const blockProps = useBlockProps();

    return (
        <div { ...blockProps }>
            <InnerBlocks
                allowedBlocks={ ALLOWED_BLOCKS }
                template={ TEMPLATE }
                templateLock={ false }
            />
        </div>
    );
}

export function save() {
    const blockProps = useBlockProps.save();

    return (
        <div { ...blockProps }>
            <InnerBlocks.Content />
        </div>
    );
}
```

### Using useSelect for Data

```javascript
import { useSelect } from '@wordpress/data';
import { store as coreStore } from '@wordpress/core-data';

export default function Edit( { attributes } ) {
    const { postId } = attributes;

    const post = useSelect(
        ( select ) => {
            if ( ! postId ) return null;
            return select( coreStore ).getEntityRecord(
                'postType',
                'post',
                postId
            );
        },
        [ postId ]
    );

    const isLoading = useSelect(
        ( select ) => {
            if ( ! postId ) return false;
            return select( coreStore ).isResolving( 'getEntityRecord', [
                'postType',
                'post',
                postId,
            ] );
        },
        [ postId ]
    );

    if ( isLoading ) {
        return <p>Loading...</p>;
    }

    return (
        <div { ...useBlockProps() }>
            { post ? post.title.rendered : 'No post selected' }
        </div>
    );
}
```

### Post/Term Selector

```javascript
import { useState } from '@wordpress/element';
import { ComboboxControl } from '@wordpress/components';
import { useSelect } from '@wordpress/data';
import { store as coreStore } from '@wordpress/core-data';

function PostSelector( { value, onChange } ) {
    const [ search, setSearch ] = useState( '' );

    const posts = useSelect(
        ( select ) => {
            return select( coreStore ).getEntityRecords( 'postType', 'post', {
                per_page: 10,
                search,
                _fields: 'id,title',
            } );
        },
        [ search ]
    );

    const options = ( posts || [] ).map( ( post ) => ( {
        value: post.id,
        label: post.title.rendered,
    } ) );

    return (
        <ComboboxControl
            label="Select Post"
            value={ value }
            onChange={ onChange }
            options={ options }
            onFilterValueChange={ setSearch }
        />
    );
}
```

## Interactivity API

### view.js (Frontend Interactivity)

```javascript
/**
 * Frontend interactivity.
 */
import { store, getContext } from '@wordpress/interactivity';

store( 'gt/my-block', {
    state: {
        get isOpen() {
            const context = getContext();
            return context.isOpen;
        },
    },
    actions: {
        toggle() {
            const context = getContext();
            context.isOpen = ! context.isOpen;
        },
        open() {
            const context = getContext();
            context.isOpen = true;
        },
        close() {
            const context = getContext();
            context.isOpen = false;
        },
    },
    callbacks: {
        onToggle() {
            const context = getContext();
            console.log( 'Toggled:', context.isOpen );
        },
    },
} );
```

### render.php with Interactivity

```php
<?php
/**
 * Interactive block render.
 */

$unique_id = wp_unique_id( 'gt-accordion-' );
?>
<div
    <?php echo get_block_wrapper_attributes(); ?>
    data-wp-interactive="gt/my-block"
    <?php echo wp_interactivity_data_wp_context( array( 'isOpen' => false ) ); ?>
>
    <button
        data-wp-on--click="actions.toggle"
        data-wp-bind--aria-expanded="state.isOpen"
        aria-controls="<?php echo esc_attr( $unique_id ); ?>"
    >
        <?php esc_html_e( 'Toggle Content', 'my-block' ); ?>
    </button>

    <div
        id="<?php echo esc_attr( $unique_id ); ?>"
        data-wp-bind--hidden="!state.isOpen"
        data-wp-watch="callbacks.onToggle"
    >
        <?php echo wp_kses_post( $content ); ?>
    </div>
</div>
```

## Styles

### style.scss (Frontend + Editor)

```scss
.wp-block-gt-my-block {
    padding: 1.5rem;
    border: 1px solid #ddd;
    border-radius: 4px;

    &__icon {
        display: inline-block;
        margin-right: 0.5rem;
        color: var(--wp--preset--color--accent, #0073aa);
    }

    &__content {
        margin: 0;
    }

    // Alignment variations
    &.has-text-align-center {
        text-align: center;
    }

    &.has-text-align-right {
        text-align: right;
    }

    // Support for color settings
    &.has-background {
        padding: 2rem;
    }
}
```

### editor.scss (Editor Only)

```scss
.wp-block-gt-my-block {
    // Editor-specific styles
    outline: 2px dashed transparent;
    transition: outline-color 0.2s;

    &:focus-within {
        outline-color: var(--wp-admin-theme-color, #007cba);
    }

    // Placeholder styling
    .components-placeholder {
        margin: 0;
    }
}
```

## Block Variations

```javascript
import { registerBlockVariation } from '@wordpress/blocks';

registerBlockVariation( 'core/group', {
    name: 'gt-card',
    title: 'Card',
    description: 'A card container with shadow and padding.',
    attributes: {
        className: 'is-style-gt-card',
        style: {
            spacing: {
                padding: {
                    top: 'var:preset|spacing|40',
                    right: 'var:preset|spacing|40',
                    bottom: 'var:preset|spacing|40',
                    left: 'var:preset|spacing|40',
                },
            },
            border: {
                radius: '8px',
            },
        },
        backgroundColor: 'base',
    },
    isActive: ( blockAttributes ) =>
        blockAttributes.className?.includes( 'is-style-gt-card' ),
    scope: [ 'inserter', 'transform' ],
    icon: 'id-alt',
} );
```

## Block Transforms

```javascript
import { createBlock } from '@wordpress/blocks';

const transforms = {
    from: [
        {
            type: 'block',
            blocks: [ 'core/paragraph' ],
            transform: ( { content } ) => {
                return createBlock( 'gt/my-block', {
                    content,
                } );
            },
        },
        {
            type: 'shortcode',
            tag: 'my_shortcode',
            transform: ( { named: { content } } ) => {
                return createBlock( 'gt/my-block', {
                    content: content || '',
                } );
            },
        },
    ],
    to: [
        {
            type: 'block',
            blocks: [ 'core/paragraph' ],
            transform: ( { content } ) => {
                return createBlock( 'core/paragraph', {
                    content,
                } );
            },
        },
    ],
};

// Add to block registration
registerBlockType( metadata.name, {
    edit: Edit,
    save,
    transforms,
} );
```

## Deprecations

```javascript
const deprecated = [
    {
        attributes: {
            content: {
                type: 'string',
                source: 'html',
                selector: '.my-block-content', // Old selector
            },
        },
        save( { attributes } ) {
            return (
                <div className="my-old-block">
                    <p className="my-block-content">{ attributes.content }</p>
                </div>
            );
        },
        migrate( attributes ) {
            return {
                ...attributes,
                // Transform old attributes to new format
            };
        },
    },
];

registerBlockType( metadata.name, {
    edit: Edit,
    save,
    deprecated,
} );
```

## Testing Blocks

### Jest Tests

```javascript
/**
 * @jest-environment jsdom
 */
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import Edit from '../edit';

// Mock WordPress packages
jest.mock( '@wordpress/block-editor', () => ( {
    useBlockProps: () => ( { className: 'test-block' } ),
    RichText: ( { value, onChange, placeholder } ) => (
        <input
            value={ value }
            onChange={ ( e ) => onChange( e.target.value ) }
            placeholder={ placeholder }
        />
    ),
    InspectorControls: ( { children } ) => <div>{ children }</div>,
    BlockControls: ( { children } ) => <div>{ children }</div>,
} ) );

describe( 'Edit component', () => {
    const defaultAttributes = {
        content: '',
        alignment: 'left',
        showIcon: true,
        iconSize: 24,
    };

    it( 'renders correctly', () => {
        const setAttributes = jest.fn();

        render(
            <Edit
                attributes={ defaultAttributes }
                setAttributes={ setAttributes }
            />
        );

        expect( screen.getByPlaceholderText( 'Enter text…' ) ).toBeInTheDocument();
    } );

    it( 'updates content on change', async () => {
        const setAttributes = jest.fn();
        const user = userEvent.setup();

        render(
            <Edit
                attributes={ defaultAttributes }
                setAttributes={ setAttributes }
            />
        );

        await user.type( screen.getByPlaceholderText( 'Enter text…' ), 'Hello' );

        expect( setAttributes ).toHaveBeenCalled();
    } );
} );
```

## Build Commands

```bash
# Development (watch mode)
npm start

# Production build
npm run build

# Lint JavaScript
npm run lint:js

# Lint CSS
npm run lint:css

# Format code
npm run format

# Update WordPress packages
npm run packages-update

# Create production zip
npm run plugin-zip
```

## Quality Checklist

- [ ] block.json has all required fields
- [ ] Block registered in PHP init hook
- [ ] All strings translatable with text domain
- [ ] Styles work in both editor and frontend
- [ ] Block supports validated (color, spacing, typography)
- [ ] Deprecations handle old saved content
- [ ] No console errors in editor
- [ ] Responsive on all screen sizes
- [ ] Accessible (ARIA labels, keyboard navigation)
- [ ] Passes @wordpress/scripts lint
- [ ] Unit tests written and passing
