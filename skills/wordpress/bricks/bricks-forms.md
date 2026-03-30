# Bricks Forms Skill

This skill covers the form element system in Bricks Builder, including custom actions and validation.

## Form Architecture

### Core Files

| File                                        | Purpose                 |
| ------------------------------------------- | ----------------------- |
| `elements/form.php`                         | Form element class      |
| `integrations/form/init.php`                | Form submission handler |
| `integrations/form/actions/`                | Built-in form actions   |
| `integrations/form/submission-database.php` | Database storage        |
| `integrations/form/submission-table.php`    | Admin submissions table |

### Form Flow

```
Frontend Form Submit
    ↓
AJAX: bricks_form_submit
    ↓
Nonce Verification
    ↓
CAPTCHA Verification (reCAPTCHA/hCaptcha/Turnstile)
    ↓
Honeypot Check
    ↓
Field Validation
    ↓
File Handling
    ↓
Custom Validation (filter)
    ↓
Run Form Actions
    ↓
Return Response
```

## Built-in Form Actions

| Action            | File                  | Description               |
| ----------------- | --------------------- | ------------------------- |
| `email`           | `email.php`           | Send email notification   |
| `redirect`        | `redirect.php`        | Redirect after submission |
| `webhook`         | `webhook.php`         | Send data to webhook URL  |
| `mailchimp`       | `mailchimp.php`       | Add to Mailchimp list     |
| `sendgrid`        | `sendgrid.php`        | Send via SendGrid API     |
| `registration`    | `registration.php`    | User registration         |
| `login`           | `login.php`           | User login                |
| `lost-password`   | `lost-password.php`   | Password reset request    |
| `reset-password`  | `reset-password.php`  | Password reset            |
| `create-post`     | `create-post.php`     | Create new post           |
| `update-post`     | `update-post.php`     | Update existing post      |
| `save-submission` | `save-submission.php` | Save to database          |
| `custom`          | `custom.php`          | Custom action handler     |

## Creating Custom Form Actions

### Method 1: Using `bricks/form/custom_action` Hook

```php
add_action( 'bricks/form/custom_action', function( $form ) {
    $fields   = $form->get_fields();
    $settings = $form->get_settings();
    $form_id  = $form->get_id();
    $post_id  = $form->get_post_id();
    $files    = $form->get_uploaded_files();
    
    // Get specific field value
    $email = '';
    foreach ( $fields as $key => $value ) {
        if ( strpos( $key, 'form-field-' ) === 0 ) {
            $field_id = str_replace( 'form-field-', '', $key );
            // Match by field ID
            if ( $field_id === 'email' ) {
                $email = $value;
            }
        }
    }
    
    // Your custom logic here
    $result = my_custom_api_call( $email );
    
    // Set success result
    if ( $result ) {
        $form->set_result([
            'type'    => 'success',
            'message' => 'Custom action completed successfully!',
        ]);
    } else {
        // Set error result (stops further processing)
        $form->set_result([
            'type'    => 'error',
            'message' => 'Custom action failed.',
        ]);
    }
} );
```

### Method 2: Custom Action Class (Recommended)

```php
<?php
namespace Bricks\Integrations\Form\Actions;

if ( ! defined( 'ABSPATH' ) ) exit;

class My_Custom_Action extends Base {

    /**
     * Run the action
     *
     * @param \Bricks\Integrations\Form\Init $form
     */
    public function run( $form ) {
        $settings = $form->get_settings();
        $fields   = $form->get_fields();
        $post_id  = $form->get_post_id();
        
        // Check if this action is enabled
        if ( empty( $settings['myCustomActionEnabled'] ) ) {
            return;
        }
        
        // Get custom settings
        $api_key = $settings['myCustomApiKey'] ?? '';
        
        // Get form field values
        $field_values = $this->get_field_values( $fields );
        
        // Perform action
        $response = $this->send_to_api( $api_key, $field_values );
        
        if ( is_wp_error( $response ) ) {
            $form->set_result([
                'type'    => 'error',
                'message' => $response->get_error_message(),
            ]);
            return;
        }
        
        $form->set_result([
            'type'    => 'success',
            'message' => 'Data sent successfully!',
        ]);
    }
    
    private function get_field_values( $fields ) {
        $values = [];
        
        foreach ( $fields as $key => $value ) {
            if ( strpos( $key, 'form-field-' ) === 0 ) {
                $field_id = str_replace( 'form-field-', '', $key );
                $values[ $field_id ] = $value;
            }
        }
        
        return $values;
    }
    
    private function send_to_api( $api_key, $data ) {
        $response = wp_remote_post( 'https://api.example.com/submit', [
            'headers' => [
                'Authorization' => 'Bearer ' . $api_key,
                'Content-Type'  => 'application/json',
            ],
            'body'    => wp_json_encode( $data ),
            'timeout' => 30,
        ]);
        
        if ( is_wp_error( $response ) ) {
            return $response;
        }
        
        $code = wp_remote_retrieve_response_code( $response );
        
        if ( $code !== 200 ) {
            return new \WP_Error( 'api_error', 'API returned error code: ' . $code );
        }
        
        return json_decode( wp_remote_retrieve_body( $response ), true );
    }
}
```

### Registering Custom Action

```php
// Add action to available actions list
add_filter( 'bricks/elements/form/controls', function( $controls ) {
    // Add to actions options
    $controls['actions']['options']['my-custom'] = 'My Custom Action';
    
    // Add custom controls for the action
    $controls['myCustomSep'] = [
        'type'     => 'separator',
        'label'    => 'My Custom Action Settings',
        'required' => [[ 'actions', '=', 'my-custom' ]],
    ];
    
    $controls['myCustomApiKey'] = [
        'label'    => 'API Key',
        'type'     => 'text',
        'required' => [[ 'actions', '=', 'my-custom' ]],
    ];
    
    return $controls;
} );

// Register the action handler
add_action( 'bricks/form/action/my-custom', function( $form ) {
    $action = new My_Custom_Action( 'my-custom' );
    $action->run( $form );
} );
```

## Form Validation

### Custom Validation Filter

```php
add_filter( 'bricks/form/validate', function( $errors, $form ) {
    $fields = $form->get_fields();
    
    // Get email field
    $email = $fields['form-field-email'] ?? '';
    
    // Custom validation: Block disposable emails
    $disposable_domains = [ 'tempmail.com', 'throwaway.com' ];
    $domain = substr( strrchr( $email, "@" ), 1 );
    
    if ( in_array( $domain, $disposable_domains ) ) {
        $errors[] = 'Disposable email addresses are not allowed.';
    }
    
    // Validate phone number format
    $phone = $fields['form-field-phone'] ?? '';
    if ( $phone && ! preg_match( '/^[0-9\-\+\s\(\)]+$/', $phone ) ) {
        $errors[] = 'Please enter a valid phone number.';
    }
    
    return $errors;
}, 10, 2 );
```

### Required Fields Validation

Bricks automatically validates required fields. Custom handling:

```php
add_filter( 'bricks/form/validate', function( $errors, $form ) {
    $fields   = $form->get_fields();
    $settings = $form->get_settings();
    
    // Check conditional required fields
    $type = $fields['form-field-contact-type'] ?? '';
    
    if ( $type === 'business' && empty( $fields['form-field-company'] ) ) {
        $errors[] = 'Company name is required for business inquiries.';
    }
    
    return $errors;
}, 10, 2 );
```

## File Upload Handling

### File Upload Settings

```php
// Form field settings for file upload
$field = [
    'type'                    => 'file',
    'fileUploadAllowedTypes'  => 'jpg,png,pdf', // Comma-separated extensions
    'fileUploadStorage'       => 'attachment',   // 'attachment', 'directory', or false
    'fileUploadStorageDirectory' => 'custom-uploads', // Custom directory name
];
```

### Custom File Directory Filter

```php
add_filter( 'bricks/form/file_directory', function( $directory_path, $form, $input_name ) {
    $post_id = $form->get_post_id();
    
    // Create user-specific directory
    if ( is_user_logged_in() ) {
        $user_id = get_current_user_id();
        $upload_dir = wp_upload_dir();
        return $upload_dir['basedir'] . '/user-uploads/' . $user_id;
    }
    
    return $directory_path;
}, 10, 3 );
```

### Accessing Uploaded Files

```php
add_action( 'bricks/form/custom_action', function( $form ) {
    $files = $form->get_uploaded_files();
    
    foreach ( $files as $field_name => $uploaded_files ) {
        foreach ( $uploaded_files as $file ) {
            $file_path = $file['file'];      // Full path
            $file_url  = $file['url'];       // URL
            $file_type = $file['type'];      // MIME type
            $file_name = $file['name'];      // Original filename
            $location  = $file['location'];  // 'attachment', 'directory', or 'filter'
            
            // Process file...
        }
    }
} );
```

## Form Hooks Reference

### Filters

```php
// Validate form submission
add_filter( 'bricks/form/validate', function( $errors, $form ) {
    return $errors;
}, 10, 2 );

// Modify form response
add_filter( 'bricks/form/response', function( $response, $form ) {
    $response['customData'] = 'my-value';
    return $response;
}, 10, 2 );

// Customize file directory
add_filter( 'bricks/form/file_directory', function( $path, $form, $input_name ) {
    return $path;
}, 10, 3 );

// Modify reCAPTCHA score threshold
add_filter( 'bricks/form/recaptcha_score_threshold', function( $score ) {
    return 0.7; // Higher = stricter (default: 0.5)
} );

// Customize honeypot result
add_filter( 'bricks/element/form/honeypot/result', function( $result, $field_id, $form ) {
    // Log honeypot trigger
    error_log( 'Honeypot triggered on field: ' . $field_id );
    return $result;
}, 10, 3 );
```

### Actions

```php
// Custom form action (legacy)
add_action( 'bricks/form/custom_action', function( $form ) {
    // Your custom logic
} );

// Specific named action
add_action( 'bricks/form/action/{action_name}', function( $form ) {
    // Handle specific action
} );
```

## Form Element Settings Access

```php
// In action class or filter
$settings = $form->get_settings();

// Available settings
$form_id       = $form->get_id();           // Form element ID
$post_id       = $form->get_post_id();      // Page/Post ID
$fields_config = $settings['fields'];       // Field configurations
$actions       = $settings['actions'];      // Selected actions
$success_msg   = $settings['successMessage'];
$redirect_url  = $settings['redirectUrl'];
$redirect_time = $settings['redirectTimeout'];
```

## Email Action Customization

### Modify Email Content

```php
add_filter( 'bricks/form/email_content', function( $content, $form, $email_type ) {
    // $email_type: 'admin' or 'confirmation'
    
    // Add timestamp
    $content .= "\n\nSubmitted at: " . current_time( 'mysql' );
    
    return $content;
}, 10, 3 );
```

### Modify Email Headers

```php
add_filter( 'bricks/form/email_headers', function( $headers, $form ) {
    $headers[] = 'X-Custom-Header: value';
    return $headers;
}, 10, 2 );
```

## Spam Protection

### CAPTCHA Options

1. **Google reCAPTCHA v3** (invisible)
2. **hCaptcha** (visible checkbox)
3. **Cloudflare Turnstile** (managed challenge)

### Honeypot Field

Add honeypot field in form settings:

```json
{
  "type": "text",
  "id": "honeypot-123",
  "isHoneypot": true,
  "label": "Leave this empty"
}
```

## Form Submission Database

### Querying Submissions

```php
// Get submissions for a specific form
$submissions = \Bricks\Integrations\Form\Submission_Database::get_submissions([
    'form_id' => 'abc123',
    'limit'   => 10,
    'offset'  => 0,
]);

// Delete old submissions
\Bricks\Integrations\Form\Submission_Database::delete_submissions([
    'before' => strtotime( '-30 days' ),
]);
```

## Best Practices

1. **Always sanitize input**: Never trust form data
2. **Use nonces**: Bricks handles this automatically
3. **Validate server-side**: Client-side validation is not enough
4. **Handle files securely**: Validate MIME types, use WordPress functions
5. **Log errors**: Use `Helpers::maybe_log()` for debugging
6. **Test edge cases**: Empty submissions, large files, special characters
7. **Set meaningful error messages**: Help users understand what went wrong
