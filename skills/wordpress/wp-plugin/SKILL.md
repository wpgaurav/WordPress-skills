---
name: wp-plugin
description: Quick scaffold for WordPress plugin development with proper structure, hooks, and best practices.
---

# Skill: WordPress Plugin Development

Build production-ready WordPress plugins following best practices and WordPress coding standards.

## Before Starting

1. Load `/CLAUDE/context/wordpress-dev.md` for standards
2. Check `/CLAUDE/knowledge/wordpress-hooks.md` for hook reference
3. Review `/CLAUDE/knowledge/wordpress-patterns.md` for common patterns

## Plugin Boilerplate

### Main Plugin File

```php
<?php
/**
 * Plugin Name:       Plugin Name
 * Plugin URI:        https://example.com/plugin-name
 * Description:       Short description of the plugin.
 * Version:           1.0.0
 * Requires at least: 6.0
 * Requires PHP:      8.0
 * Author:            Gaurav Tiwari
 * Author URI:        https://yoursite.com
 * License:           GPL v2 or later
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:       plugin-name
 * Domain Path:       /languages
 *
 * @package PluginName
 */

defined( 'ABSPATH' ) || exit;

// Plugin constants
define( 'PLUGIN_NAME_VERSION', '1.0.0' );
define( 'PLUGIN_NAME_FILE', __FILE__ );
define( 'PLUGIN_NAME_PATH', plugin_dir_path( __FILE__ ) );
define( 'PLUGIN_NAME_URL', plugin_dir_url( __FILE__ ) );

// Autoloader
if ( file_exists( PLUGIN_NAME_PATH . 'vendor/autoload.php' ) ) {
    require_once PLUGIN_NAME_PATH . 'vendor/autoload.php';
}

// Initialize plugin
function plugin_name_init() {
    // Load text domain
    load_plugin_textdomain(
        'plugin-name',
        false,
        dirname( plugin_basename( __FILE__ ) ) . '/languages'
    );

    // Initialize main class
    if ( class_exists( 'PluginName\\Plugin' ) ) {
        \PluginName\Plugin::instance();
    }
}
add_action( 'plugins_loaded', 'plugin_name_init' );

// Activation hook
register_activation_hook( __FILE__, 'plugin_name_activate' );
function plugin_name_activate() {
    // Check requirements
    if ( version_compare( PHP_VERSION, '8.0', '<' ) ) {
        deactivate_plugins( plugin_basename( __FILE__ ) );
        wp_die( esc_html__( 'This plugin requires PHP 8.0 or higher.', 'plugin-name' ) );
    }

    // Run activation tasks
    if ( class_exists( 'PluginName\\Activator' ) ) {
        \PluginName\Activator::activate();
    }

    // Set activation flag for redirect
    set_transient( 'plugin_name_activated', true, 30 );
}

// Deactivation hook
register_deactivation_hook( __FILE__, 'plugin_name_deactivate' );
function plugin_name_deactivate() {
    if ( class_exists( 'PluginName\\Deactivator' ) ) {
        \PluginName\Deactivator::deactivate();
    }
}
```

### Main Plugin Class (Singleton)

```php
<?php
/**
 * Main plugin class.
 *
 * @package PluginName
 */

namespace PluginName;

defined( 'ABSPATH' ) || exit;

/**
 * Plugin class.
 */
final class Plugin {

    /**
     * Plugin instance.
     *
     * @var Plugin|null
     */
    private static $instance = null;

    /**
     * Plugin version.
     *
     * @var string
     */
    public $version = PLUGIN_NAME_VERSION;

    /**
     * Get plugin instance.
     *
     * @return Plugin
     */
    public static function instance() {
        if ( null === self::$instance ) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * Constructor.
     */
    private function __construct() {
        $this->define_constants();
        $this->includes();
        $this->init_hooks();
    }

    /**
     * Prevent cloning.
     */
    private function __clone() {}

    /**
     * Prevent unserializing.
     */
    public function __wakeup() {
        throw new \Exception( 'Cannot unserialize singleton' );
    }

    /**
     * Define additional constants.
     */
    private function define_constants() {
        // Add any runtime constants
    }

    /**
     * Include required files.
     */
    private function includes() {
        // Core includes
        require_once PLUGIN_NAME_PATH . 'includes/functions.php';

        // Admin includes
        if ( is_admin() ) {
            require_once PLUGIN_NAME_PATH . 'includes/class-admin.php';
        }

        // Frontend includes
        if ( ! is_admin() ) {
            require_once PLUGIN_NAME_PATH . 'includes/class-frontend.php';
        }
    }

    /**
     * Initialize hooks.
     */
    private function init_hooks() {
        add_action( 'init', array( $this, 'init' ), 0 );
        add_action( 'admin_init', array( $this, 'admin_init' ) );
    }

    /**
     * Init hook callback.
     */
    public function init() {
        // Register post types, taxonomies, etc.
        do_action( 'plugin_name_init' );
    }

    /**
     * Admin init hook callback.
     */
    public function admin_init() {
        // Check for activation redirect
        if ( get_transient( 'plugin_name_activated' ) ) {
            delete_transient( 'plugin_name_activated' );
            if ( ! isset( $_GET['activate-multi'] ) ) {
                wp_safe_redirect( admin_url( 'admin.php?page=plugin-name' ) );
                exit;
            }
        }
    }

    /**
     * Get plugin URL.
     *
     * @param string $path Path to append.
     * @return string
     */
    public function plugin_url( $path = '' ) {
        return PLUGIN_NAME_URL . ltrim( $path, '/' );
    }

    /**
     * Get plugin path.
     *
     * @param string $path Path to append.
     * @return string
     */
    public function plugin_path( $path = '' ) {
        return PLUGIN_NAME_PATH . ltrim( $path, '/' );
    }
}
```

## Admin Settings Page

### Settings Class

```php
<?php
/**
 * Admin settings.
 *
 * @package PluginName
 */

namespace PluginName;

defined( 'ABSPATH' ) || exit;

/**
 * Admin class.
 */
class Admin {

    /**
     * Option name.
     *
     * @var string
     */
    private $option_name = 'plugin_name_settings';

    /**
     * Constructor.
     */
    public function __construct() {
        add_action( 'admin_menu', array( $this, 'add_menu_page' ) );
        add_action( 'admin_init', array( $this, 'register_settings' ) );
        add_action( 'admin_enqueue_scripts', array( $this, 'enqueue_scripts' ) );
    }

    /**
     * Add menu page.
     */
    public function add_menu_page() {
        add_menu_page(
            __( 'Plugin Name', 'plugin-name' ),
            __( 'Plugin Name', 'plugin-name' ),
            'manage_options',
            'plugin-name',
            array( $this, 'render_settings_page' ),
            'dashicons-admin-generic',
            80
        );

        add_submenu_page(
            'plugin-name',
            __( 'Settings', 'plugin-name' ),
            __( 'Settings', 'plugin-name' ),
            'manage_options',
            'plugin-name',
            array( $this, 'render_settings_page' )
        );
    }

    /**
     * Register settings.
     */
    public function register_settings() {
        register_setting(
            'plugin_name_settings_group',
            $this->option_name,
            array(
                'type'              => 'array',
                'sanitize_callback' => array( $this, 'sanitize_settings' ),
                'default'           => $this->get_defaults(),
            )
        );

        // General section
        add_settings_section(
            'plugin_name_general',
            __( 'General Settings', 'plugin-name' ),
            array( $this, 'render_section_description' ),
            'plugin-name'
        );

        // Add fields
        add_settings_field(
            'enable_feature',
            __( 'Enable Feature', 'plugin-name' ),
            array( $this, 'render_checkbox_field' ),
            'plugin-name',
            'plugin_name_general',
            array(
                'id'          => 'enable_feature',
                'description' => __( 'Enable the main feature.', 'plugin-name' ),
            )
        );

        add_settings_field(
            'api_key',
            __( 'API Key', 'plugin-name' ),
            array( $this, 'render_text_field' ),
            'plugin-name',
            'plugin_name_general',
            array(
                'id'          => 'api_key',
                'type'        => 'password',
                'description' => __( 'Enter your API key.', 'plugin-name' ),
            )
        );
    }

    /**
     * Get default settings.
     *
     * @return array
     */
    private function get_defaults() {
        return array(
            'enable_feature' => false,
            'api_key'        => '',
        );
    }

    /**
     * Get option value.
     *
     * @param string $key     Option key.
     * @param mixed  $default Default value.
     * @return mixed
     */
    public function get_option( $key, $default = null ) {
        $options = get_option( $this->option_name, $this->get_defaults() );
        return $options[ $key ] ?? $default ?? $this->get_defaults()[ $key ] ?? null;
    }

    /**
     * Sanitize settings.
     *
     * @param array $input Input values.
     * @return array
     */
    public function sanitize_settings( $input ) {
        $sanitized = array();

        $sanitized['enable_feature'] = isset( $input['enable_feature'] ) ? (bool) $input['enable_feature'] : false;
        $sanitized['api_key']        = sanitize_text_field( $input['api_key'] ?? '' );

        return $sanitized;
    }

    /**
     * Render settings page.
     */
    public function render_settings_page() {
        if ( ! current_user_can( 'manage_options' ) ) {
            return;
        }

        // Show saved message
        if ( isset( $_GET['settings-updated'] ) ) {
            add_settings_error(
                'plugin_name_messages',
                'plugin_name_message',
                __( 'Settings saved.', 'plugin-name' ),
                'updated'
            );
        }

        settings_errors( 'plugin_name_messages' );
        ?>
        <div class="wrap">
            <h1><?php echo esc_html( get_admin_page_title() ); ?></h1>
            <form action="options.php" method="post">
                <?php
                settings_fields( 'plugin_name_settings_group' );
                do_settings_sections( 'plugin-name' );
                submit_button();
                ?>
            </form>
        </div>
        <?php
    }

    /**
     * Render section description.
     */
    public function render_section_description() {
        echo '<p>' . esc_html__( 'Configure the general settings below.', 'plugin-name' ) . '</p>';
    }

    /**
     * Render checkbox field.
     *
     * @param array $args Field arguments.
     */
    public function render_checkbox_field( $args ) {
        $value = $this->get_option( $args['id'] );
        ?>
        <label>
            <input
                type="checkbox"
                name="<?php echo esc_attr( $this->option_name . '[' . $args['id'] . ']' ); ?>"
                value="1"
                <?php checked( $value, true ); ?>
            />
            <?php echo esc_html( $args['description'] ); ?>
        </label>
        <?php
    }

    /**
     * Render text field.
     *
     * @param array $args Field arguments.
     */
    public function render_text_field( $args ) {
        $value = $this->get_option( $args['id'] );
        $type  = $args['type'] ?? 'text';
        ?>
        <input
            type="<?php echo esc_attr( $type ); ?>"
            name="<?php echo esc_attr( $this->option_name . '[' . $args['id'] . ']' ); ?>"
            value="<?php echo esc_attr( $value ); ?>"
            class="regular-text"
        />
        <?php if ( ! empty( $args['description'] ) ) : ?>
            <p class="description"><?php echo esc_html( $args['description'] ); ?></p>
        <?php endif; ?>
        <?php
    }

    /**
     * Enqueue admin scripts.
     *
     * @param string $hook Current admin page.
     */
    public function enqueue_scripts( $hook ) {
        if ( 'toplevel_page_plugin-name' !== $hook ) {
            return;
        }

        wp_enqueue_style(
            'plugin-name-admin',
            PLUGIN_NAME_URL . 'assets/css/admin.css',
            array(),
            PLUGIN_NAME_VERSION
        );

        wp_enqueue_script(
            'plugin-name-admin',
            PLUGIN_NAME_URL . 'assets/js/admin.js',
            array( 'jquery' ),
            PLUGIN_NAME_VERSION,
            true
        );

        wp_localize_script(
            'plugin-name-admin',
            'pluginNameAdmin',
            array(
                'ajaxUrl' => admin_url( 'admin-ajax.php' ),
                'nonce'   => wp_create_nonce( 'plugin_name_admin' ),
            )
        );
    }
}
```

## AJAX Handler

```php
<?php
/**
 * AJAX handler.
 *
 * @package PluginName
 */

namespace PluginName;

defined( 'ABSPATH' ) || exit;

/**
 * Ajax class.
 */
class Ajax {

    /**
     * Constructor.
     */
    public function __construct() {
        // Admin AJAX
        add_action( 'wp_ajax_plugin_name_action', array( $this, 'handle_action' ) );

        // Public AJAX (logged in + logged out)
        add_action( 'wp_ajax_plugin_name_public', array( $this, 'handle_public_action' ) );
        add_action( 'wp_ajax_nopriv_plugin_name_public', array( $this, 'handle_public_action' ) );
    }

    /**
     * Handle admin AJAX action.
     */
    public function handle_action() {
        // Verify nonce
        if ( ! check_ajax_referer( 'plugin_name_admin', 'nonce', false ) ) {
            wp_send_json_error(
                array( 'message' => __( 'Security check failed.', 'plugin-name' ) ),
                403
            );
        }

        // Check capabilities
        if ( ! current_user_can( 'manage_options' ) ) {
            wp_send_json_error(
                array( 'message' => __( 'Permission denied.', 'plugin-name' ) ),
                403
            );
        }

        // Get and sanitize input
        $data = isset( $_POST['data'] ) ? sanitize_text_field( wp_unslash( $_POST['data'] ) ) : '';

        if ( empty( $data ) ) {
            wp_send_json_error(
                array( 'message' => __( 'Missing required data.', 'plugin-name' ) ),
                400
            );
        }

        // Process the request
        try {
            $result = $this->process_data( $data );
            wp_send_json_success( array( 'result' => $result ) );
        } catch ( \Exception $e ) {
            wp_send_json_error(
                array( 'message' => $e->getMessage() ),
                500
            );
        }
    }

    /**
     * Process data.
     *
     * @param string $data Input data.
     * @return mixed
     * @throws \Exception On error.
     */
    private function process_data( $data ) {
        // Implementation
        return $data;
    }

    /**
     * Handle public AJAX action.
     */
    public function handle_public_action() {
        // Verify nonce
        if ( ! check_ajax_referer( 'plugin_name_public', 'nonce', false ) ) {
            wp_send_json_error( array( 'message' => __( 'Invalid request.', 'plugin-name' ) ) );
        }

        // Rate limiting (optional)
        $ip = sanitize_text_field( wp_unslash( $_SERVER['REMOTE_ADDR'] ?? '' ) );
        if ( $this->is_rate_limited( $ip ) ) {
            wp_send_json_error(
                array( 'message' => __( 'Too many requests. Please try again later.', 'plugin-name' ) ),
                429
            );
        }

        // Process request
        wp_send_json_success( array( 'message' => 'Success' ) );
    }

    /**
     * Check if IP is rate limited.
     *
     * @param string $ip IP address.
     * @return bool
     */
    private function is_rate_limited( $ip ) {
        $transient_key = 'plugin_name_rate_' . md5( $ip );
        $requests      = (int) get_transient( $transient_key );

        if ( $requests >= 10 ) {
            return true;
        }

        set_transient( $transient_key, $requests + 1, MINUTE_IN_SECONDS );
        return false;
    }
}
```

## REST API Endpoint

```php
<?php
/**
 * REST API.
 *
 * @package PluginName
 */

namespace PluginName;

defined( 'ABSPATH' ) || exit;

/**
 * REST_API class.
 */
class REST_API {

    /**
     * Namespace.
     *
     * @var string
     */
    private $namespace = 'plugin-name/v1';

    /**
     * Constructor.
     */
    public function __construct() {
        add_action( 'rest_api_init', array( $this, 'register_routes' ) );
    }

    /**
     * Register routes.
     */
    public function register_routes() {
        register_rest_route(
            $this->namespace,
            '/items',
            array(
                array(
                    'methods'             => \WP_REST_Server::READABLE,
                    'callback'            => array( $this, 'get_items' ),
                    'permission_callback' => array( $this, 'get_items_permission' ),
                    'args'                => $this->get_collection_params(),
                ),
                array(
                    'methods'             => \WP_REST_Server::CREATABLE,
                    'callback'            => array( $this, 'create_item' ),
                    'permission_callback' => array( $this, 'create_item_permission' ),
                    'args'                => $this->get_create_params(),
                ),
            )
        );

        register_rest_route(
            $this->namespace,
            '/items/(?P<id>[\d]+)',
            array(
                array(
                    'methods'             => \WP_REST_Server::READABLE,
                    'callback'            => array( $this, 'get_item' ),
                    'permission_callback' => array( $this, 'get_item_permission' ),
                    'args'                => array(
                        'id' => array(
                            'validate_callback' => function( $param ) {
                                return is_numeric( $param );
                            },
                        ),
                    ),
                ),
                array(
                    'methods'             => \WP_REST_Server::EDITABLE,
                    'callback'            => array( $this, 'update_item' ),
                    'permission_callback' => array( $this, 'update_item_permission' ),
                ),
                array(
                    'methods'             => \WP_REST_Server::DELETABLE,
                    'callback'            => array( $this, 'delete_item' ),
                    'permission_callback' => array( $this, 'delete_item_permission' ),
                ),
            )
        );
    }

    /**
     * Get collection params.
     *
     * @return array
     */
    private function get_collection_params() {
        return array(
            'page'     => array(
                'default'           => 1,
                'sanitize_callback' => 'absint',
            ),
            'per_page' => array(
                'default'           => 10,
                'sanitize_callback' => 'absint',
            ),
            'search'   => array(
                'sanitize_callback' => 'sanitize_text_field',
            ),
        );
    }

    /**
     * Get create params.
     *
     * @return array
     */
    private function get_create_params() {
        return array(
            'title' => array(
                'required'          => true,
                'sanitize_callback' => 'sanitize_text_field',
            ),
            'content' => array(
                'sanitize_callback' => 'wp_kses_post',
            ),
        );
    }

    /**
     * Get items permission callback.
     *
     * @return bool
     */
    public function get_items_permission() {
        return true; // Public endpoint
    }

    /**
     * Create item permission callback.
     *
     * @return bool
     */
    public function create_item_permission() {
        return current_user_can( 'edit_posts' );
    }

    /**
     * Get items.
     *
     * @param \WP_REST_Request $request Request object.
     * @return \WP_REST_Response
     */
    public function get_items( $request ) {
        $page     = $request->get_param( 'page' );
        $per_page = $request->get_param( 'per_page' );
        $search   = $request->get_param( 'search' );

        // Fetch items (example)
        $items = array(); // Your query here

        return rest_ensure_response( $items );
    }

    /**
     * Create item.
     *
     * @param \WP_REST_Request $request Request object.
     * @return \WP_REST_Response|\WP_Error
     */
    public function create_item( $request ) {
        $title   = $request->get_param( 'title' );
        $content = $request->get_param( 'content' );

        // Create item (example)
        $item_id = wp_insert_post(
            array(
                'post_title'   => $title,
                'post_content' => $content,
                'post_status'  => 'publish',
                'post_type'    => 'post',
            )
        );

        if ( is_wp_error( $item_id ) ) {
            return $item_id;
        }

        return rest_ensure_response(
            array(
                'id'      => $item_id,
                'message' => __( 'Item created successfully.', 'plugin-name' ),
            )
        );
    }
}
```

## Custom Post Type

```php
<?php
/**
 * Register custom post type.
 *
 * @package PluginName
 */

namespace PluginName;

defined( 'ABSPATH' ) || exit;

/**
 * Post_Types class.
 */
class Post_Types {

    /**
     * Constructor.
     */
    public function __construct() {
        add_action( 'init', array( $this, 'register_post_types' ) );
        add_action( 'init', array( $this, 'register_taxonomies' ) );
    }

    /**
     * Register post types.
     */
    public function register_post_types() {
        $labels = array(
            'name'                  => _x( 'Items', 'Post type general name', 'plugin-name' ),
            'singular_name'         => _x( 'Item', 'Post type singular name', 'plugin-name' ),
            'menu_name'             => _x( 'Items', 'Admin Menu text', 'plugin-name' ),
            'add_new'               => __( 'Add New', 'plugin-name' ),
            'add_new_item'          => __( 'Add New Item', 'plugin-name' ),
            'edit_item'             => __( 'Edit Item', 'plugin-name' ),
            'new_item'              => __( 'New Item', 'plugin-name' ),
            'view_item'             => __( 'View Item', 'plugin-name' ),
            'search_items'          => __( 'Search Items', 'plugin-name' ),
            'not_found'             => __( 'No items found.', 'plugin-name' ),
            'not_found_in_trash'    => __( 'No items found in Trash.', 'plugin-name' ),
            'all_items'             => __( 'All Items', 'plugin-name' ),
            'archives'              => __( 'Item Archives', 'plugin-name' ),
            'insert_into_item'      => __( 'Insert into item', 'plugin-name' ),
            'uploaded_to_this_item' => __( 'Uploaded to this item', 'plugin-name' ),
        );

        $args = array(
            'labels'             => $labels,
            'public'             => true,
            'publicly_queryable' => true,
            'show_ui'            => true,
            'show_in_menu'       => true,
            'show_in_rest'       => true,
            'query_var'          => true,
            'rewrite'            => array( 'slug' => 'items' ),
            'capability_type'    => 'post',
            'has_archive'        => true,
            'hierarchical'       => false,
            'menu_position'      => 20,
            'menu_icon'          => 'dashicons-portfolio',
            'supports'           => array( 'title', 'editor', 'thumbnail', 'excerpt', 'custom-fields' ),
        );

        register_post_type( 'pn_item', $args );
    }

    /**
     * Register taxonomies.
     */
    public function register_taxonomies() {
        $labels = array(
            'name'              => _x( 'Categories', 'taxonomy general name', 'plugin-name' ),
            'singular_name'     => _x( 'Category', 'taxonomy singular name', 'plugin-name' ),
            'search_items'      => __( 'Search Categories', 'plugin-name' ),
            'all_items'         => __( 'All Categories', 'plugin-name' ),
            'parent_item'       => __( 'Parent Category', 'plugin-name' ),
            'parent_item_colon' => __( 'Parent Category:', 'plugin-name' ),
            'edit_item'         => __( 'Edit Category', 'plugin-name' ),
            'update_item'       => __( 'Update Category', 'plugin-name' ),
            'add_new_item'      => __( 'Add New Category', 'plugin-name' ),
            'new_item_name'     => __( 'New Category Name', 'plugin-name' ),
            'menu_name'         => __( 'Categories', 'plugin-name' ),
        );

        $args = array(
            'hierarchical'      => true,
            'labels'            => $labels,
            'show_ui'           => true,
            'show_admin_column' => true,
            'show_in_rest'      => true,
            'query_var'         => true,
            'rewrite'           => array( 'slug' => 'item-category' ),
        );

        register_taxonomy( 'pn_item_category', array( 'pn_item' ), $args );
    }
}
```

## Uninstall

```php
<?php
/**
 * Uninstall script.
 *
 * @package PluginName
 */

// Exit if not called from WordPress.
if ( ! defined( 'WP_UNINSTALL_PLUGIN' ) ) {
    exit;
}

// Delete options
delete_option( 'plugin_name_settings' );
delete_option( 'plugin_name_version' );

// Delete transients
delete_transient( 'plugin_name_cache' );

// Delete user meta (if applicable)
delete_metadata( 'user', 0, 'plugin_name_user_data', '', true );

// Drop custom tables (if applicable)
global $wpdb;
$wpdb->query( "DROP TABLE IF EXISTS {$wpdb->prefix}plugin_name_table" );

// Clear scheduled hooks
wp_clear_scheduled_hook( 'plugin_name_cron_event' );

// Clean up uploads (optional - be careful)
// $upload_dir = wp_upload_dir();
// $plugin_dir = $upload_dir['basedir'] . '/plugin-name';
// if ( is_dir( $plugin_dir ) ) {
//     // Recursive delete
// }
```

## Quality Checklist

Before releasing:

- [ ] Main plugin file has correct headers
- [ ] All classes use namespace
- [ ] Singleton pattern implemented correctly
- [ ] All hooks prefixed with plugin slug
- [ ] Settings use Settings API
- [ ] AJAX handlers verify nonces
- [ ] REST API has permission callbacks
- [ ] All strings translatable
- [ ] Uninstall.php cleans up properly
- [ ] Activation checks PHP/WP version
- [ ] Assets loaded conditionally
- [ ] No PHP errors/warnings
- [ ] PHPCS passes
- [ ] Security audit complete
