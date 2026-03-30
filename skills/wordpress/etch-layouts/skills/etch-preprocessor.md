# Etch Preprocessor Skill

Technical reference for the legacy Preprocessor system that transforms Etch blocks before WordPress renders them.

## Overview

The Preprocessor is a **legacy transformation layer** that hooks into WordPress content and template filters to transform Etch block structures before they reach WordPress's native block rendering pipeline. It operates alongside the modern Blocks system (which uses `register_block_type` with render callbacks).

## How It Works

### Content Pipeline

```
WordPress → the_content filter (priority 1)
  → Preprocessor::prepare_content_blocks($content)
    → parse_blocks($content)          # WordPress parser
    → parse_etch_blocks($blocks)       # Recursive transform
    → serialize_blocks($blocks)        # Back to markup
  → Modified content continues through WordPress pipeline
```

### Template Pipeline  

```
WordPress → get_block_templates filter (priority 10)
  → Preprocessor::prepare_template_blocks($query_result, $query, $template_type)
    → extract_template_hierarchy($query)
    → process_template_hierarchy($query_result, $hierarchy)
      → find first matching template slug
      → parse_blocks($template->content)
      → parse_etch_blocks($blocks)
      → serialize_blocks() → template->content
```

### Template Hierarchy

The preprocessor handles WordPress template hierarchy (most specific first):
1. Extracts `slug__in` from the query
2. Iterates hierarchy order (most to least specific)
3. Finds first template matching a slug in `$query_result`
4. Processes only that template

## Editor Context Bypass

The preprocessor skips transformation in these contexts:

1. **Etch Builder active**: `$_GET['etch'] === 'magic'`
2. **REST API edit context**: `wp_is_serving_rest_request() && $_GET['context'] === 'edit'`
3. **Admin block editor**: `is_admin()` on `post.php`, `post-new.php`, `site-editor.php`
4. **Block editor screen**: `get_current_screen()->is_block_editor()`

## Block Processing System

### BaseBlock Factory

`BaseBlock::create_from_block($block)` creates the appropriate processor:

| Block Name | Processor Class |
|------------|-----------------|
| `etch/element` | `HtmlBlock` |
| `etch/text` | `PassthroughBlock` |
| `etch/svg` | `HtmlBlock` |
| `etch/loop` | `LoopBlock` |
| `etch/condition` | `ConditionBlock` |
| `etch/component` | `ComponentBlock` |
| `etch/raw-html` | `PassthroughBlock` |
| Other blocks | `WpBlock` |

Each processor's `process()` method transforms the block data array and returns the modified block (or array of blocks for components).

### PassthroughBlock

For blocks that need no preprocessing (like `etch/text`, `etch/raw-html`). Simply returns the block unchanged.

### PassthroughKillBlock

Removes blocks entirely from the output (returns empty).

### HtmlBlock

Transforms `etch/element` and `etch/svg` blocks:
- Processes element attributes
- Resolves tag names
- Sets up innerHTML with opening/closing tags
- Recursively processes innerBlocks

### ComponentBlock

Transforms `etch/component` blocks:
- Fetches the referenced pattern post
- Resolves component attributes
- Injects pattern blocks as expanded output
- Handles prop passing and expression substitution
- May return an **array** of blocks (expanding a single component block into multiple output blocks)

### LoopBlock (Preprocessor)

Transforms `etch/loop` blocks:
- Resolves loop data via LoopHandlerManager
- Duplicates innerBlocks for each iteration
- Substitutes loop context in each copy

### ConditionBlock (Preprocessor)

Transforms `etch/condition` blocks:
- Evaluates the condition
- Returns innerBlocks if truthy, empty if falsy

## LoopHandlerManager

Central dispatch for loop data resolution:

### Initialization

```php
LoopHandlerManager::initialize_handlers();
// Registers: wp-query, main-query, json, wp-terms, wp-users
```

### Loop Preset Resolution

```
1. normalize_loop_id($loop_id)         # Resolve user-friendly key to database key
2. determine_loop_type($normalized_id) # Get handler type from preset
3. get_loop_handler($type)             # Get handler instance
4. handler->get_loop_data($id, $params) # Execute query
5. CachedLoopPresets caches result      # Prevent re-queries
```

### Loop Presets Storage

Presets are stored in `etch_loops` WordPress option. Each preset is an `EtchDataGlobalLoop` object with:
- `key` — User-friendly identifier (e.g., "posts", "nav")
- `type` — Handler type (e.g., "wp-query", "main-query")
- Handler-specific configuration

### Built-in Loop Handlers

#### WpQueryLoopHandler (`wp-query`)
Standard WordPress `WP_Query`. Accepts parameters like `$count`, `$type`, `$orderby`, etc.

#### WpMainQueryLoopHandler (`main-query`)
Uses the current page's main query (for archive pages, search results, etc.). Does not accept standard query parameters. Uses global `$wp_query`.

#### JsonLoopHandler (`json`)
Returns static JSON data defined in the loop preset. No WordPress queries.

#### WpTermsLoopHandler (`wp-terms`)
Queries taxonomy terms via `get_terms()`. Parameters include `$taxonomy`, `$count`, `$orderby`, etc.

#### WpUsersLoopHandler (`wp-users`)
Queries WordPress users via `get_users()`. Parameters include `$count`, `$role`, `$orderby`, etc.

### Custom Loop Handlers

Implement `LoopHandlerInterface`:

```php
interface LoopHandlerInterface {
    public function get_loop_data(string $loop_id, array $params = []): array;
}
```

Register in `LoopHandlerManager::initialize_handlers()`.

## Content Wrapper

The `ContentWrapper` (in both `Preprocessor\BlocksRegistry` and `Blocks\Global`) wraps Etch block output with necessary container markup.

## EtchBlock Registration

The `EtchBlock` class (in `Preprocessor\BlocksRegistry`) registers the `etch/block` dynamic block type:
- API version 3
- Render callback returns content as-is
- Supports `className` but not `html`

## Style & Script Registries

### Preprocessor Registry

Both `Preprocessor\Registry\StylesRegister` and `Preprocessor\Registry\ScriptRegister` collect styles and scripts during preprocessing:

### Blocks Registry

`Blocks\Global\StylesRegister` collects CSS during block rendering and outputs them:
- `register_block_styles($styles, $original_attrs, $resolved_attrs)` — Registers style IDs
- Handles dynamic class name resolution (replaces class names in CSS when dynamic expressions change them)

`Blocks\Global\ScriptRegister` collects JavaScript during block rendering:
- `register_script($attrs)` — Registers script from block attributes

## Dual Pipeline Coexistence

The Preprocessor and Blocks systems coexist:

| Concern | Preprocessor | Blocks System |
|---------|-------------|---------------|
| Timing | Before WordPress renders | During WordPress render |
| Hook | `the_content` / `get_block_templates` | `register_block_type` render_callback |
| Output | Transforms block data arrays | Returns HTML strings |
| Context | Uses old `ContextProvider` | Uses `DynamicContextProvider` |
| Still Active? | Yes, for template processing | Yes, for all block rendering |

The Preprocessor transforms the block tree first, then WordPress renders each block using its registered render_callback.

## Common Issues

1. **Double processing** — Blocks may be processed by both the preprocessor and their render callback. The preprocessor handles tree-level concerns (component expansion, loop duplication), while render callbacks handle element-level rendering.

2. **Editor context detection** — Multiple checks are needed because WordPress has various entry points for editor requests.

3. **Template hierarchy** — Only the first matching template is processed, following WordPress's specificity rules.
