# Bricks Builder Permissions Skill

This skill covers the builder access control and user capabilities system in Bricks Builder.

## Permissions Architecture

### Core Files

| File                      | Purpose                            |
| ------------------------- | ---------------------------------- |
| `builder-permissions.php` | Builder access control             |
| `capabilities.php`        | WordPress capabilities integration |

## Access Control Levels

### Builder Access

Who can access the Bricks Builder:

| Setting        | Description                               |
| -------------- | ----------------------------------------- |
| Administrators | WordPress admins always have access       |
| Roles          | Specific user roles can be granted access |
| Capabilities   | Custom capability requirement             |

### Feature Access

What features users can access within the builder:

| Feature         | Description               |
| --------------- | ------------------------- |
| Code Element    | Execute custom code       |
| Code CSS/JS     | Add custom CSS/JavaScript |
| Custom Fonts    | Upload custom fonts       |
| Template Access | Create/edit templates     |
| Theme Styles    | Modify theme styles       |

## Bricks Settings Configuration

### Builder Access (Settings > Builder Access)

```php
// Which roles can access the builder
$settings = [
    // Allow these roles to use the builder
    'builderAccess' => ['administrator', 'editor'],
    
    // Capability required (alternative to roles)
    'builderAccessCapability' => 'edit_pages',
];
```

### Code Execution

```php
$settings = [
    // Who can use code elements
    'codeExecution' => 'administrators', // 'administrators', 'roles', 'disabled'
    
    // Specific roles for code execution (when codeExecution is 'roles')
    'codeExecutionRoles' => ['administrator', 'editor'],
    
    // Disable code execution entirely
    'codeExecutionDisabled' => false,
];
```

## Checking Permissions

### Builder Access

```php
// Check if current user can access builder
$can_edit = \Bricks\Capabilities::current_user_can_use_builder();

// Check for specific post
$can_edit_post = \Bricks\Capabilities::current_user_can_use_builder( $post_id );
```

### Code Execution

```php
// Check if code execution is enabled globally
$code_enabled = \Bricks\Helpers::code_execution_enabled();

// Check if current user can execute code
$can_execute = \Bricks\Capabilities::current_user_has_full_access();
```

### Template Access

```php
// Check if user can access templates
$can_templates = \Bricks\Capabilities::current_user_can_edit_templates();

// Check specific template
$can_template = \Bricks\Capabilities::current_user_can_edit_template( $template_id );
```

## Custom Capabilities

### Register Custom Capability

```php
// Add custom capability requirement
add_filter( 'bricks/capabilities/builder_access', function( $capabilities ) {
    $capabilities[] = 'my_custom_capability';
    return $capabilities;
} );

// Grant capability to role
$role = get_role( 'editor' );
$role->add_cap( 'my_custom_capability' );
```

### Override Access Check

```php
// Override builder access check
add_filter( 'bricks/builder/can_edit', function( $can_edit, $post_id, $user_id ) {
    // Custom logic
    if ( get_user_meta( $user_id, 'approved_builder_user', true ) ) {
        return true;
    }
    return $can_edit;
}, 10, 3 );
```

## Per-User Restrictions

### Restrict Code Access

```php
// Disable code execution for specific users
add_filter( 'bricks/code/execute_code', function( $execute, $user_id ) {
    // Disable for user ID 5
    if ( $user_id === 5 ) {
        return false;
    }
    return $execute;
}, 10, 2 );
```

### Restrict Element Access

```php
// Hide certain elements from users
add_filter( 'bricks/elements/registered', function( $elements ) {
    // Only allow code element for administrators
    if ( ! current_user_can( 'administrator' ) ) {
        unset( $elements['code'] );
    }
    return $elements;
} );
```

## Template Permissions

### Per-Template Access

```php
// Restrict template editing
add_filter( 'bricks/template/can_edit', function( $can_edit, $template_id, $user_id ) {
    // Check if user is assigned to this template
    $allowed_users = get_post_meta( $template_id, '_allowed_users', true );
    
    if ( is_array( $allowed_users ) && ! in_array( $user_id, $allowed_users ) ) {
        return false;
    }
    
    return $can_edit;
}, 10, 3 );
```

### Template Type Restrictions

```php
// Restrict header/footer template editing
add_filter( 'bricks/template/can_edit', function( $can_edit, $template_id ) {
    $type = get_post_meta( $template_id, BRICKS_DB_TEMPLATE_TYPE, true );
    
    // Only administrators can edit header/footer
    if ( in_array( $type, ['header', 'footer'] ) && ! current_user_can( 'administrator' ) ) {
        return false;
    }
    
    return $can_edit;
}, 10, 2 );
```

## Global Classes Permissions

```php
// Restrict global class editing
add_filter( 'bricks/global_classes/can_edit', function( $can_edit, $user_id ) {
    // Only administrators can edit global classes
    return current_user_can( 'administrator' );
}, 10, 2 );
```

## Theme Styles Permissions

```php
// Restrict theme styles editing
add_filter( 'bricks/theme_styles/can_edit', function( $can_edit, $user_id ) {
    // Only administrators can edit theme styles
    return current_user_can( 'administrator' );
}, 10, 2 );
```

## Helper Functions

```php
// Check if current user is administrator
\Bricks\Capabilities::is_administrator();

// Check if user has full access
\Bricks\Capabilities::current_user_has_full_access();

// Check builder access for post
\Bricks\Capabilities::current_user_can_use_builder( $post_id );

// Check template editing
\Bricks\Capabilities::current_user_can_edit_templates();

// Check code execution
\Bricks\Helpers::code_execution_enabled();
```

## Security Considerations

### Code Execution Security

Code execution should be restricted to trusted users:

```php
// Filter dangerous code patterns
add_filter( 'bricks/code/allowed_functions', function( $functions ) {
    // Remove dangerous functions
    unset( $functions['exec'] );
    unset( $functions['shell_exec'] );
    unset( $functions['system'] );
    return $functions;
} );
```

### Sanitization

All builder input is sanitized:

```php
// Element settings are sanitized on save
// Code is signed and verified before execution
```

## Multisite Permissions

### Network-wide Settings

```php
// In wp-config.php
define( 'BRICKS_MULTISITE_BUILDER_ACCESS', 'super_admin' );
```

### Per-Site Overrides

Each site can have its own builder access settings via Bricks > Settings.

## Hooks Reference

```php
// Builder access check
add_filter( 'bricks/builder/can_edit', function( $can, $post_id, $user_id ) {
    return $can;
}, 10, 3 );

// Code execution check
add_filter( 'bricks/code/execute_code', function( $execute, $user_id ) {
    return $execute;
}, 10, 2 );

// Template access check
add_filter( 'bricks/template/can_edit', function( $can, $template_id, $user_id ) {
    return $can;
}, 10, 3 );

// Global classes access
add_filter( 'bricks/global_classes/can_edit', function( $can, $user_id ) {
    return $can;
}, 10, 2 );

// Theme styles access
add_filter( 'bricks/theme_styles/can_edit', function( $can, $user_id ) {
    return $can;
}, 10, 2 );
```

## Best Practices

1. **Principle of least privilege**: Only grant necessary access
2. **Restrict code execution**: Limit to administrators only
3. **Use role-based access**: Don't rely on individual user permissions
4. **Audit regularly**: Review who has builder access
5. **Test permissions**: Verify restrictions work as expected
6. **Document access levels**: Maintain documentation of who can do what
7. **Use custom capabilities**: For granular control, create custom caps
