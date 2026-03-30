# Etch Plugin Architecture Skill

Complete technical reference for the Etch plugin's internal architecture, initialization flow, rendering pipeline, and class hierarchy.

## Plugin Overview

Etch is a WordPress plugin + companion block theme providing a visual/code builder for creating custom WordPress blocks and pages. It uses a dual rendering pipeline: a **Preprocessor** (legacy, transforms blocks at `the_content` / `get_block_templates` filter level) and a **Blocks system** (modern, uses native `register_block_type` with render callbacks).

- **Version:** 1.2.0
- **PHP Requirement:** 8.1+
- **WordPress Requirement:** 5.9+
- **Namespace:** `Etch\`
- **Entry Point:** `etch/etch.php`

## Initialization Flow

```
etch.php
  → Plugin::get_instance()        # Singleton pattern
    → Plugin::__construct()        # Sets version, paths
    → Plugin::init()               # Core initialization sequence
    → Plugin::run()                # Hooks into plugins_loaded
```

### Init Sequence (Plugin::init)

The init method creates instances in this exact order:

1. **Flag** — Feature flag system (`etch/config/flags.json`)
2. **Logger** / **LoggerConfig** — Logging subsystem
3. **ServerTiming** — Performance measurement headers
4. **EtchGlobal** — Global state management
5. **WpAdmin** — Admin panel customizations
6. **AssetRegistry** — Script/style registration
7. **ViteManager** — Frontend dev server integration
8. **Preprocessor** — Block transformation pipeline
9. **BlocksRegistry** — Registers all 11 custom blocks
10. **Styles** — Global style management
11. **Hooks** — WordPress action/filter hooks
12. **FiltersManager** — Custom filter management
13. **WpApi** — REST API initialization
14. **Services** — Business logic services
15. **UpdateManager** / **MigrationChecker** — Version management

### Builder Context

Etch runs in two contexts:

| Context | Detection | Behavior |
|---------|-----------|----------|
| **Builder** | `$_GET['etch'] === 'magic'` | Loads blank template, Svelte app, disables WP admin bar |
| **Frontend** | Normal request | Preprocessor transforms blocks, render callbacks generate HTML |
| **Editor** | `is_admin()` + block editor pages | Skips preprocessing, serves raw block data |

### Builder Template Syntax

The Etch builder frontend uses a **Svelte-inspired template language** for authoring blocks. Each section shows three code panels:

| Panel | Purpose |
|-------|--------|
| **HTML** | Svelte-like template with elements, components (`<SectionIntro />`), slots (`{#slot nav}...{/slot}`), loops (`{#loop}...{/loop}`), and conditions (`{#if}...{/if}`) |
| **CSS** | Scoped CSS for the section, using the section class as root selector. Supports nesting, CSS variables, and `&:hover` syntax |
| **JavaScript** | Optional per-section JavaScript |

The template compiles to/from block JSON. Components are PascalCase tags referencing `wp_block` posts. Props use `attribute="string"` for strings and `attribute={value}` for booleans/expressions.

Special HTML attributes:
- `data-etch-element` — Identifies element role in tree panel (`"section"`, `"container"`)
- `data-etch-note` — Editor-only developer annotations (stripped in frontend)

## Directory Structure

```
etch/
├── etch.php                          # Entry point, Plugin bootstrap
├── classes/
│   ├── Plugin.php                    # Main singleton class
│   ├── Blocks/                       # Block registration & rendering
│   │   ├── BlocksRegistry.php        # Central registry for all blocks
│   │   ├── ElementBlock/             # etch/element
│   │   ├── TextBlock/                # etch/text
│   │   ├── LoopBlock/                # etch/loop
│   │   ├── ComponentBlock/           # etch/component
│   │   ├── ConditionBlock/           # etch/condition + ConditionEvaluator
│   │   ├── DynamicElementBlock/      # etch/dynamic-element
│   │   ├── DynamicImageBlock/        # etch/dynamic-image
│   │   ├── SvgBlock/                 # etch/svg
│   │   ├── RawHtmlBlock/             # etch/raw-html
│   │   ├── SlotContentBlock/         # etch/slot-content
│   │   ├── SlotPlaceholderBlock/     # etch/slot-placeholder
│   │   ├── Global/                   # Shared services
│   │   │   ├── DynamicContent/       # Context stack & expression system
│   │   │   ├── Utilities/            # Modifiers, expression processing
│   │   │   ├── StylesRegister.php    # CSS collection & output
│   │   │   ├── ScriptRegister.php    # JS collection & output
│   │   │   ├── CachedPattern.php     # Pattern/component caching
│   │   │   ├── CachedLoopPresets.php # Loop data caching
│   │   │   └── ComponentSlotContextProvider.php
│   │   ├── Types/                    # Typed attribute classes
│   │   ├── Utilities/                # Block utility helpers
│   │   └── Tests/                    # Block unit tests
│   ├── Preprocessor/                 # Legacy block transformation
│   │   ├── Preprocessor.php          # Main preprocessor class
│   │   ├── Blocks/                   # Block processors (BaseBlock, etc.)
│   │   ├── BlocksRegistry/           # EtchBlock, ContentWrapper
│   │   ├── Data/                     # Data models
│   │   ├── Registry/                 # Script/Style registries
│   │   └── Utilities/                # Parser, LoopHandlerManager
│   ├── RestApi/                      # REST API layer
│   │   ├── RoutesRegister.php        # Route registration
│   │   └── Routes/                   # 24 route classes
│   ├── Services/                     # Business logic
│   ├── Helpers/                      # Utility helpers (Logger, Flag, etc.)
│   ├── Traits/                       # Shared traits (Singleton, DynamicData)
│   ├── WpAdmin/                      # Admin panel features
│   ├── Assets/                       # Asset management
│   ├── Vite/                         # Vite dev server integration
│   ├── Lifecycle/                    # Update & migration management
│   └── Filters/                      # Filter management
├── apps/dist/                        # Compiled Svelte/Vite frontend
├── config/flags.json                 # Feature flags
└── vendor/                           # Composer dependencies
```

## Rendering Pipeline

### 1. Preprocessor Pipeline (Template & Content)

The `Preprocessor` class hooks into:
- `the_content` filter (priority 1) via `prepare_content_blocks()`
- `get_block_templates` filter (priority 10) via `prepare_template_blocks()`

Flow:
```
WordPress content → parse_blocks() → parse_etch_blocks() → serialize_blocks() → output
```

`parse_etch_blocks()` recursively processes blocks:
```php
foreach ($blocks as $block) {
    $block_instance = BaseBlock::create_from_block($block);
    $processed_result = $block_instance->process();
    // May expand single block into multiple (components)
}
```

### 2. Block Render Pipeline (Modern)

Each block class registers via `register_block_type()` with a `render_callback`. The flow:

```
WordPress renders block
  → render_callback($attributes, $content, $block)
    → Parse typed attributes (e.g., ElementAttributes::from_array())
    → Get dynamic sources via DynamicContextProvider::get_sources_for_wp_block($block)
    → Resolve dynamic expressions in attributes
    → Register styles (StylesRegister::register_block_styles())
    → Register scripts (ScriptRegister::register_script())
    → Process shortcodes (ShortcodeProcessor::process())
    → Build HTML output
    → Return rendered string
```

### Editor Context Detection

The Preprocessor skips processing in editor contexts:

```php
// Skip if Etch builder is active
if (isset($_GET['etch']) && 'magic' === $_GET['etch']) return;

// Skip in Gutenberg editor
if (wp_is_serving_rest_request() && $_GET['context'] === 'edit') return;
if (is_admin() && in_array($pagenow, ['post.php', 'post-new.php', 'site-editor.php'])) return;
```

## Key Classes Reference

| Class | Location | Purpose |
|-------|----------|---------|
| `Plugin` | `classes/Plugin.php` | Main singleton, initialization |
| `BlocksRegistry` | `classes/Blocks/BlocksRegistry.php` | Registers all 11 block types |
| `Preprocessor` | `classes/Preprocessor/Preprocessor.php` | Content/template transformation |
| `DynamicContextProvider` | `classes/Blocks/Global/DynamicContent/` | Context stack for expressions |
| `DynamicContentProcessor` | `classes/Blocks/Global/Utilities/` | Expression resolution engine |
| `Modifiers` | `classes/Blocks/Global/Utilities/` | 40+ modifier functions |
| `LoopHandlerManager` | `classes/Preprocessor/Utilities/` | Loop type dispatch & caching |
| `ConditionEvaluator` | `classes/Blocks/ConditionBlock/` | Condition evaluation logic |
| `ComponentSlotContextProvider` | `classes/Blocks/Global/` | Slot content management |
| `CachedPattern` | `classes/Blocks/Global/` | Pattern/component caching |
| `RoutesRegister` | `classes/RestApi/` | REST API route registration |
| `WpApi` | `classes/WpApi.php` | WordPress API wrappers, global data |
| `StylesRegister` | `classes/Blocks/Global/` | CSS collection & output |
| `ScriptRegister` | `classes/Blocks/Global/` | JS collection & output |

## Typed Attribute System

Every block has a corresponding typed attributes class in `Blocks/Types/`:

| Class | Block | Key Properties |
|-------|-------|---------------|
| `ElementAttributes` | `etch/element`, `etch/svg`, `etch/dynamic-element`, `etch/dynamic-image` | `tag`, `attributes` (object), `styles` (array) |
| `TextAttributes` | `etch/text` | `content` (string) |
| `LoopAttributes` | `etch/loop` | `target`, `itemId`, `indexId`, `loopId`, `loopParams` |
| `ComponentAttributes` | `etch/component` | `ref` (number), `attributes` (object) |
| `ConditionAttributes` | `etch/condition` | `condition` (object), `conditionString` (string) |
| `RawHtmlAttributes` | `etch/raw-html` | `content`, `unsafe` |
| `SlotContentAttributes` | `etch/slot-content` | `name` (string) |
| `SlotPlaceholderAttributes` | `etch/slot-placeholder` | `name` (string) |

All attribute classes extend `BaseAttributes` and use `from_array()` factory method.

## Feature Flags

Feature flags are loaded from `etch/config/flags.json` with per-site overrides via `wp-content/uploads/etch/flags.user.json`.

```php
Flag::is_on('ENABLE_DEBUG_LOG')  // Check if flag is enabled
```

See `CLAUDE.md` or `GEMINI.md` for the complete flag list.

## Data Storage

| Storage | Key | Purpose |
|---------|-----|---------|
| Option | `etch_styles` | Global CSS styles |
| Option | `etch_loops` | Loop preset definitions |
| Option | `etch_settings` | Plugin settings |
| Option | `etch_global_stylesheets` | Global stylesheet references |
| Post Type | `wp_block` | Patterns/components |
| Post Meta | `etch_component_properties` | Component property definitions |
| Post Meta | `etch_component_html_key` | Component HTML identifier |
| Post Meta | `etch_component_legacy_id` | Legacy component ID (migration) |

## Extension Points

### Filters

- `etch_autocomplition_classes` — Add CSS class autocompletion entries
- `etch_loop_handlers` — Register custom loop handlers
- `render_block` — Standard WordPress block render filter

### Loop Handlers

Custom loop types can be registered by implementing `LoopHandlerInterface`:

```php
interface LoopHandlerInterface {
    public function get_loop_data(string $loop_id, array $params = []): array;
}
```

Built-in handlers: `wp-query`, `main-query`, `json`, `wp-terms`, `wp-users`

## Testing

- Framework: `WP_UnitTestCase`
- Test locations: `classes/Blocks/Tests/`, `classes/Preprocessor/Tests/`, `classes/Services/Tests/`
- Helper traits: `BlockTestHelper`, `ShortcodeTestHelper`
- File pattern: `*.test.php`
