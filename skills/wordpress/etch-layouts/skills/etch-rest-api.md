# Etch REST API Skill

Complete reference for the Etch plugin's REST API endpoints, route structure, and usage patterns.

## Base URL

```
/wp-json/etch/v1/
```

All routes require authentication (WordPress nonce or application password). Routes inherit permissions from `BaseRoute` which checks `edit_posts` capability.

## Route Groups

The REST API is organized into 20+ route classes registered by `RoutesRegister`:

| Route Class | Namespace | Purpose |
|-------------|-----------|---------|
| `BlocksRoutes` | `etch/v1` | Block CRUD operations |
| `StylesRoutes` | `etch/v1` | Global style management |
| `LoopsRoutes` | `etch/v1` | Loop preset management |
| `QueriesRoutes` | `etch/v1` | Dynamic data queries (posts, terms, users) |
| `UiRoutes` | `etch/v1` | Editor UI state persistence |
| `ComponentsRoutes` | `etch/v1` | Component (pattern) management |
| `ComponentFieldRoutes` | `etch/v1` | Component field operations (flag-gated) |
| `CptRoutes` | `etch/v1` | Custom post type operations |
| `CustomFieldsRoutes` | `etch/v1` | Custom field retrieval |
| `PostTypesRoutes` | `etch/v1` | Post type listing |
| `TemplatesRoutes` | `etch/v1` | WordPress template management |
| `TaxonomyRoutes` | `etch/v1` | Individual taxonomy operations |
| `TaxonomiesRoutes` | `etch/v1` | Taxonomy listing and management |
| `SiteRoutes` | `etch/v1` | Site-wide information |
| `UserRoutes` | `etch/v1` | Current user data |
| `MediaRoutes` | `etch/v1` | Media library operations |
| `OptionPagesRoutes` | `etch/v1` | ACF option pages |
| `SettingsRoutes` | `etch/v1` | Plugin settings management |
| `ArchiveRoutes` | `etch/v1` | Archive page data |
| `CssToolbarRoutes` | `etch/v1` | CSS toolbar utilities |
| `BlockParserRoutes` | `etch/v1` | Block parsing operations |
| `PatternsRoutes` | `etch/v1` | Block pattern management |
| `AiRoutes` | `etch/v1` | AI chat integration |

## Key Endpoint Categories

### Blocks

Manages block data for pages/posts being edited:

- `GET /blocks/{post_id}` — Get blocks for a post
- `PUT /blocks/{post_id}` — Save blocks for a post
- `POST /blocks/parse` — Parse block markup

### Styles

Global style management:

- `GET /styles` — Get all global styles
- `PUT /styles` — Save global styles
- `GET /stylesheets` — Get global stylesheets
- `PUT /stylesheets` — Save global stylesheets

### Components

Pattern/component management:

- `GET /components` — List all components
- `GET /components/{id}` — Get a specific component
- `POST /components` — Create a component
- `PUT /components/{id}` — Update a component
- `DELETE /components/{id}` — Delete a component

### Loops

Loop preset management:

- `GET /loops` — Get all loop presets
- `PUT /loops` — Save loop presets

### Queries

Dynamic data retrieval for the builder preview:

- `GET /queries/posts` — Query posts with parameters
- `GET /queries/terms` — Query taxonomy terms
- `GET /queries/users` — Query users
- `GET /queries/main-query` — Get main query results

### Templates

WordPress template management:

- `GET /templates` — List templates
- `GET /templates/{slug}` — Get template by slug
- `PUT /templates/{slug}` — Update template
- `POST /templates` — Create template

### Settings

Plugin settings:

- `GET /settings` — Get all settings
- `PUT /settings` — Update settings

### Media

Media library operations:

- `GET /media` — List media items
- `GET /media/{id}` — Get media item details

### Custom Fields

- `GET /custom-fields/{post_type}` — Get custom field definitions for a post type
- `GET /custom-fields/{post_id}/values` — Get custom field values for a post

### Site Information

- `GET /site` — Get site-wide information (name, URL, logo, etc.)

### User

- `GET /user` — Get current user data

### UI State

Editor UI state persistence (per-user):

- `GET /ui` — Get UI state
- `PUT /ui` — Save UI state

## Caching

The `WpApi::set_caching_headers()` method adds caching headers to responses:

```php
set_caching_headers(int $cache_time, WP_REST_Response $response)
```

Sets `Cache-Control: max-age={$cache_time}` and `Expires` header.

## Global Data Enqueued for Editor

When the Etch builder loads, `WpApi` enqueues several global data objects via `wp_localize_script`:

| Data Key | Source | Description |
|----------|--------|-------------|
| `etchGlobalStyles` | `etch_styles` option | All global CSS styles |
| `etchGlobalStylesheets` | `etch_global_stylesheets` option | Global stylesheet references |
| `etchGlobalComponents` | `wp_block` posts | All component definitions |
| `etchGlobalLoops` | `etch_loops` option | Loop preset definitions |
| `etchGlobalUiState` | User meta | Per-user editor UI state |
| `etchGlobalLicenseStatus` | License module | License status |
| `etchAutocompletionClasses` | Filter + stylesheets | CSS class autocomplete data |
| `etchGlobalSettings` | `etch_settings` option | Plugin settings |

## Feature Flag Gating

Some routes are conditionally registered based on feature flags:

```php
if (Flag::is_on('ENABLE_BLOCK_COPY_PASTE_JSON_TO_CUSTOM_FIELD_SAVE')) {
    (new ComponentFieldRoutes())->register_routes();
}
```

## Authentication

All routes require authentication. The `BaseRoute` class provides:

```php
public function permission_check(): bool {
    return current_user_can('edit_posts');
}
```

Individual routes may override this with stricter permissions.

## Extending the API

To add custom routes, create a new route class extending `BaseRoute`:

```php
namespace Etch\RestApi\Routes;

class MyCustomRoutes extends BaseRoute {
    public function register_routes() {
        register_rest_route('etch/v1', '/my-endpoint', [
            'methods' => 'GET',
            'callback' => [$this, 'get_data'],
            'permission_callback' => [$this, 'permission_check'],
        ]);
    }
    
    public function get_data($request) {
        return new \WP_REST_Response(['data' => 'value']);
    }
}
```

Then register it in `RoutesRegister::register_routes()`.
