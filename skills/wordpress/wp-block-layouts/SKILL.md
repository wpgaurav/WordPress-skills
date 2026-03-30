---
name: wp-block-layouts
description: "Ready-to-use WordPress Block Editor layout patterns: hero sections, pricing tables, testimonials, feature grids, CTAs, and more. All patterns use core blocks only."
compatibility: "WordPress 6.6+. Uses theme.json v3 style attributes."
---

# WordPress Block Layout Patterns

## When to Use

Use this skill when:
- Building landing pages with WordPress blocks
- Creating section layouts (hero, pricing, testimonials, CTAs)
- Converting designs to block markup
- Need ready-to-paste pattern code

## Quick Reference

| Pattern | Best Blocks | Layout Type |
|---------|-------------|-------------|
| Hero | Cover, Group, Heading, Buttons | full-width, centered |
| Features Grid | Columns, Group, Heading, Paragraph | 2-4 columns |
| Pricing Table | Columns, Group, Heading, List, Button | 3 columns |
| Testimonials | Columns, Group, Quote, Image | 2-3 columns |
| CTA Banner | Cover, Group, Heading, Buttons | full-width |
| Team | Columns, Image, Heading, Paragraph | 3-4 columns |
| FAQ | Details, Group | single column |
| Logo Bar | Group (row), Image | horizontal flex |
| Stats | Columns, Heading, Paragraph | 3-4 columns |

## Hero Sections

### Simple Hero with Background Image

```html
<!-- wp:cover {"url":"https://example.com/hero-bg.jpg","id":123,"dimRatio":60,"overlayColor":"black","minHeight":600,"align":"full","style":{"spacing":{"padding":{"top":"var:preset|spacing|80","bottom":"var:preset|spacing|80"}}}} -->
<div class="wp-block-cover alignfull" style="min-height:600px;padding-top:var(--wp--preset--spacing--80);padding-bottom:var(--wp--preset--spacing--80)">
  <span aria-hidden="true" class="wp-block-cover__background has-black-background-color has-background-dim-60 has-background-dim"></span>
  <img class="wp-block-cover__image-background wp-image-123" alt="" src="https://example.com/hero-bg.jpg" data-object-fit="cover"/>
  <div class="wp-block-cover__inner-container">
    <!-- wp:group {"layout":{"type":"constrained","contentSize":"800px"}} -->
    <div class="wp-block-group">
      <!-- wp:heading {"textAlign":"center","level":1,"style":{"typography":{"fontSize":"3.5rem","fontWeight":"700"},"color":{"text":"#ffffff"}}} -->
      <h1 class="wp-block-heading has-text-align-center has-text-color" style="color:#ffffff;font-size:3.5rem;font-weight:700">Build Something Amazing</h1>
      <!-- /wp:heading -->
      <!-- wp:paragraph {"align":"center","style":{"typography":{"fontSize":"1.25rem"},"color":{"text":"#e0e0e0"},"spacing":{"margin":{"top":"1.5rem","bottom":"2rem"}}}} -->
      <p class="has-text-align-center has-text-color" style="color:#e0e0e0;font-size:1.25rem;margin-top:1.5rem;margin-bottom:2rem">Create stunning websites with the power of WordPress blocks. No coding required.</p>
      <!-- /wp:paragraph -->
      <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
      <div class="wp-block-buttons">
        <!-- wp:button {"backgroundColor":"white","textColor":"black","style":{"border":{"radius":"4px"},"spacing":{"padding":{"top":"0.875rem","bottom":"0.875rem","left":"2rem","right":"2rem"}}}} -->
        <div class="wp-block-button"><a class="wp-block-button__link has-black-color has-white-background-color has-text-color has-background wp-element-button" style="border-radius:4px;padding-top:0.875rem;padding-right:2rem;padding-bottom:0.875rem;padding-left:2rem">Get Started</a></div>
        <!-- /wp:button -->
        <!-- wp:button {"className":"is-style-outline","style":{"border":{"radius":"4px","width":"2px"},"spacing":{"padding":{"top":"0.875rem","bottom":"0.875rem","left":"2rem","right":"2rem"}},"color":{"text":"#ffffff"}}} -->
        <div class="wp-block-button is-style-outline"><a class="wp-block-button__link has-text-color wp-element-button" style="border-radius:4px;border-width:2px;color:#ffffff;padding-top:0.875rem;padding-right:2rem;padding-bottom:0.875rem;padding-left:2rem">Learn More</a></div>
        <!-- /wp:button -->
      </div>
      <!-- /wp:buttons -->
    </div>
    <!-- /wp:group -->
  </div>
</div>
<!-- /wp:cover -->
```

### Hero with Side Image (Media & Text)

```html
<!-- wp:media-text {"mediaId":123,"mediaLink":"","mediaType":"image","mediaWidth":50,"verticalAlignment":"center","align":"full","style":{"spacing":{"padding":{"top":"4rem","right":"2rem","bottom":"4rem","left":"2rem"}}}} -->
<div class="wp-block-media-text alignfull is-stacked-on-mobile is-vertically-aligned-center" style="padding-top:4rem;padding-right:2rem;padding-bottom:4rem;padding-left:2rem">
  <figure class="wp-block-media-text__media">
    <img src="https://example.com/hero-image.jpg" alt="Hero illustration" class="wp-image-123 size-full"/>
  </figure>
  <div class="wp-block-media-text__content">
    <!-- wp:heading {"level":1,"style":{"typography":{"fontSize":"2.75rem","fontWeight":"700","lineHeight":"1.2"}}} -->
    <h1 class="wp-block-heading" style="font-size:2.75rem;font-weight:700;line-height:1.2">Transform Your Business with Modern Solutions</h1>
    <!-- /wp:heading -->
    <!-- wp:paragraph {"style":{"typography":{"fontSize":"1.125rem"},"spacing":{"margin":{"top":"1.5rem","bottom":"2rem"}},"color":{"text":"#555555"}}} -->
    <p class="has-text-color" style="color:#555555;font-size:1.125rem;margin-top:1.5rem;margin-bottom:2rem">Streamline your workflow and boost productivity with our all-in-one platform designed for growing teams.</p>
    <!-- /wp:paragraph -->
    <!-- wp:buttons -->
    <div class="wp-block-buttons">
      <!-- wp:button {"backgroundColor":"primary","textColor":"white","style":{"border":{"radius":"6px"}}} -->
      <div class="wp-block-button"><a class="wp-block-button__link has-white-color has-primary-background-color has-text-color has-background wp-element-button" style="border-radius:6px">Start Free Trial</a></div>
      <!-- /wp:button -->
      <!-- wp:button {"className":"is-style-outline"} -->
      <div class="wp-block-button is-style-outline"><a class="wp-block-button__link wp-element-button">Watch Demo</a></div>
      <!-- /wp:button -->
    </div>
    <!-- /wp:buttons -->
  </div>
</div>
<!-- /wp:media-text -->
```

### Gradient Hero (No Image)

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"6rem","bottom":"6rem","left":"2rem","right":"2rem"}},"color":{"gradient":"linear-gradient(135deg,rgb(102,126,234) 0%,rgb(118,75,162) 100%)"}},"layout":{"type":"constrained","contentSize":"900px"}} -->
<div class="wp-block-group alignfull has-background" style="background:linear-gradient(135deg,rgb(102,126,234) 0%,rgb(118,75,162) 100%);padding-top:6rem;padding-right:2rem;padding-bottom:6rem;padding-left:2rem">
  <!-- wp:heading {"textAlign":"center","level":1,"style":{"typography":{"fontSize":"3rem","fontWeight":"700"},"color":{"text":"#ffffff"}}} -->
  <h1 class="wp-block-heading has-text-align-center has-text-color" style="color:#ffffff;font-size:3rem;font-weight:700">The Simplest Way to Build Websites</h1>
  <!-- /wp:heading -->
  <!-- wp:paragraph {"align":"center","style":{"typography":{"fontSize":"1.25rem"},"color":{"text":"rgba(255,255,255,0.9)"},"spacing":{"margin":{"top":"1.5rem","bottom":"2.5rem"}}}} -->
  <p class="has-text-align-center has-text-color" style="color:rgba(255,255,255,0.9);font-size:1.25rem;margin-top:1.5rem;margin-bottom:2.5rem">Join thousands of creators building beautiful sites without writing a single line of code.</p>
  <!-- /wp:paragraph -->
  <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
  <div class="wp-block-buttons">
    <!-- wp:button {"backgroundColor":"white","textColor":"black","style":{"border":{"radius":"50px"},"spacing":{"padding":{"top":"1rem","bottom":"1rem","left":"2.5rem","right":"2.5rem"}},"typography":{"fontWeight":"600"}}} -->
    <div class="wp-block-button"><a class="wp-block-button__link has-black-color has-white-background-color has-text-color has-background wp-element-button" style="border-radius:50px;padding-top:1rem;padding-right:2.5rem;padding-bottom:1rem;padding-left:2.5rem;font-weight:600">Get Started Free</a></div>
    <!-- /wp:button -->
  </div>
  <!-- /wp:buttons -->
</div>
<!-- /wp:group -->
```

## Feature Sections

### Features Grid (3 Columns with Icons)

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"5rem","bottom":"5rem","left":"2rem","right":"2rem"}}},"backgroundColor":"light-gray","layout":{"type":"constrained","contentSize":"1200px"}} -->
<div class="wp-block-group alignfull has-light-gray-background-color has-background" style="padding-top:5rem;padding-right:2rem;padding-bottom:5rem;padding-left:2rem">
  <!-- wp:heading {"textAlign":"center","style":{"typography":{"fontSize":"2.5rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
  <h2 class="wp-block-heading has-text-align-center" style="font-size:2.5rem;font-weight:700;margin-bottom:1rem">Why Choose Us</h2>
  <!-- /wp:heading -->
  <!-- wp:paragraph {"align":"center","style":{"typography":{"fontSize":"1.125rem"},"color":{"text":"#666666"},"spacing":{"margin":{"bottom":"3rem"}}}} -->
  <p class="has-text-align-center has-text-color" style="color:#666666;font-size:1.125rem;margin-bottom:3rem">Everything you need to build and grow your online presence.</p>
  <!-- /wp:paragraph -->
  <!-- wp:columns {"style":{"spacing":{"blockGap":{"left":"2rem"}}}} -->
  <div class="wp-block-columns">
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px"}},"backgroundColor":"white","layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-white-background-color has-background" style="border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:paragraph {"style":{"typography":{"fontSize":"2.5rem"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
        <p style="font-size:2.5rem;margin-bottom:1rem">🚀</p>
        <!-- /wp:paragraph -->
        <!-- wp:heading {"level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"bottom":"0.75rem"}}}} -->
        <h3 class="wp-block-heading" style="font-size:1.25rem;font-weight:600;margin-bottom:0.75rem">Lightning Fast</h3>
        <!-- /wp:heading -->
        <!-- wp:paragraph {"style":{"color":{"text":"#666666"}}} -->
        <p class="has-text-color" style="color:#666666">Optimized for speed with built-in performance enhancements that keep your site running smoothly.</p>
        <!-- /wp:paragraph -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px"}},"backgroundColor":"white","layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-white-background-color has-background" style="border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:paragraph {"style":{"typography":{"fontSize":"2.5rem"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
        <p style="font-size:2.5rem;margin-bottom:1rem">🔒</p>
        <!-- /wp:paragraph -->
        <!-- wp:heading {"level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"bottom":"0.75rem"}}}} -->
        <h3 class="wp-block-heading" style="font-size:1.25rem;font-weight:600;margin-bottom:0.75rem">Secure by Default</h3>
        <!-- /wp:heading -->
        <!-- wp:paragraph {"style":{"color":{"text":"#666666"}}} -->
        <p class="has-text-color" style="color:#666666">Enterprise-grade security with automatic updates, SSL certificates, and malware protection.</p>
        <!-- /wp:paragraph -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px"}},"backgroundColor":"white","layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-white-background-color has-background" style="border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:paragraph {"style":{"typography":{"fontSize":"2.5rem"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
        <p style="font-size:2.5rem;margin-bottom:1rem">🎨</p>
        <!-- /wp:paragraph -->
        <!-- wp:heading {"level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"bottom":"0.75rem"}}}} -->
        <h3 class="wp-block-heading" style="font-size:1.25rem;font-weight:600;margin-bottom:0.75rem">Easy Customization</h3>
        <!-- /wp:heading -->
        <!-- wp:paragraph {"style":{"color":{"text":"#666666"}}} -->
        <p class="has-text-color" style="color:#666666">Drag and drop your way to a beautiful site with our intuitive block editor and templates.</p>
        <!-- /wp:paragraph -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
  </div>
  <!-- /wp:columns -->
</div>
<!-- /wp:group -->
```

### Features Alternating (Left/Right)

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"5rem","bottom":"5rem"}}},"layout":{"type":"constrained","contentSize":"1200px"}} -->
<div class="wp-block-group alignfull" style="padding-top:5rem;padding-bottom:5rem">
  <!-- Feature 1: Image Left -->
  <!-- wp:media-text {"mediaId":123,"mediaType":"image","mediaWidth":50,"verticalAlignment":"center","style":{"spacing":{"margin":{"bottom":"4rem"}}}} -->
  <div class="wp-block-media-text is-stacked-on-mobile is-vertically-aligned-center" style="margin-bottom:4rem">
    <figure class="wp-block-media-text__media">
      <img src="https://example.com/feature-1.jpg" alt="Feature 1" class="wp-image-123 size-full"/>
    </figure>
    <div class="wp-block-media-text__content">
      <!-- wp:heading {"level":3,"style":{"typography":{"fontSize":"1.75rem","fontWeight":"600"}}} -->
      <h3 class="wp-block-heading" style="font-size:1.75rem;font-weight:600">Powerful Analytics Dashboard</h3>
      <!-- /wp:heading -->
      <!-- wp:paragraph {"style":{"spacing":{"margin":{"top":"1rem"}},"color":{"text":"#555555"}}} -->
      <p class="has-text-color" style="color:#555555;margin-top:1rem">Track your performance with real-time insights. Monitor traffic, conversions, and user behavior all in one place.</p>
      <!-- /wp:paragraph -->
      <!-- wp:paragraph {"style":{"spacing":{"margin":{"top":"1.5rem"}}}} -->
      <p style="margin-top:1.5rem"><a href="#">Learn more →</a></p>
      <!-- /wp:paragraph -->
    </div>
  </div>
  <!-- /wp:media-text -->
  <!-- Feature 2: Image Right -->
  <!-- wp:media-text {"mediaId":124,"mediaPosition":"right","mediaType":"image","mediaWidth":50,"verticalAlignment":"center"} -->
  <div class="wp-block-media-text has-media-on-the-right is-stacked-on-mobile is-vertically-aligned-center">
    <div class="wp-block-media-text__content">
      <!-- wp:heading {"level":3,"style":{"typography":{"fontSize":"1.75rem","fontWeight":"600"}}} -->
      <h3 class="wp-block-heading" style="font-size:1.75rem;font-weight:600">Seamless Integrations</h3>
      <!-- /wp:heading -->
      <!-- wp:paragraph {"style":{"spacing":{"margin":{"top":"1rem"}},"color":{"text":"#555555"}}} -->
      <p class="has-text-color" style="color:#555555;margin-top:1rem">Connect with your favorite tools. We integrate with 100+ apps including Slack, Zapier, and Google Workspace.</p>
      <!-- /wp:paragraph -->
      <!-- wp:paragraph {"style":{"spacing":{"margin":{"top":"1.5rem"}}}} -->
      <p style="margin-top:1.5rem"><a href="#">View integrations →</a></p>
      <!-- /wp:paragraph -->
    </div>
    <figure class="wp-block-media-text__media">
      <img src="https://example.com/feature-2.jpg" alt="Feature 2" class="wp-image-124 size-full"/>
    </figure>
  </div>
  <!-- /wp:media-text -->
</div>
<!-- /wp:group -->
```

## Pricing Tables

### Three-Tier Pricing

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"5rem","bottom":"5rem","left":"2rem","right":"2rem"}}},"layout":{"type":"constrained","contentSize":"1100px"}} -->
<div class="wp-block-group alignfull" style="padding-top:5rem;padding-right:2rem;padding-bottom:5rem;padding-left:2rem">
  <!-- wp:heading {"textAlign":"center","style":{"typography":{"fontSize":"2.5rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
  <h2 class="wp-block-heading has-text-align-center" style="font-size:2.5rem;font-weight:700;margin-bottom:1rem">Simple, Transparent Pricing</h2>
  <!-- /wp:heading -->
  <!-- wp:paragraph {"align":"center","style":{"color":{"text":"#666666"},"spacing":{"margin":{"bottom":"3rem"}}}} -->
  <p class="has-text-align-center has-text-color" style="color:#666666;margin-bottom:3rem">Choose the plan that works best for you. All plans include a 14-day free trial.</p>
  <!-- /wp:paragraph -->
  <!-- wp:columns {"style":{"spacing":{"blockGap":{"left":"1.5rem"}}}} -->
  <div class="wp-block-columns">
    <!-- Starter Plan -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px","color":"#e5e5e5","width":"1px"}},"layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-border-color" style="border-color:#e5e5e5;border-width:1px;border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:heading {"level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"bottom":"0.5rem"}}}} -->
        <h3 class="wp-block-heading" style="font-size:1.25rem;font-weight:600;margin-bottom:0.5rem">Starter</h3>
        <!-- /wp:heading -->
        <!-- wp:paragraph {"style":{"color":{"text":"#666666"},"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <p class="has-text-color" style="color:#666666;margin-bottom:1.5rem">Perfect for individuals</p>
        <!-- /wp:paragraph -->
        <!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap","verticalAlignment":"bottom"},"style":{"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <div class="wp-block-group" style="margin-bottom:1.5rem">
          <!-- wp:paragraph {"style":{"typography":{"fontSize":"3rem","fontWeight":"700","lineHeight":"1"}}} -->
          <p style="font-size:3rem;font-weight:700;line-height:1">$9</p>
          <!-- /wp:paragraph -->
          <!-- wp:paragraph {"style":{"color":{"text":"#666666"}}} -->
          <p class="has-text-color" style="color:#666666">/month</p>
          <!-- /wp:paragraph -->
        </div>
        <!-- /wp:group -->
        <!-- wp:list {"style":{"spacing":{"margin":{"bottom":"2rem"}},"color":{"text":"#555555"}}} -->
        <ul class="wp-block-list has-text-color" style="color:#555555;margin-bottom:2rem">
          <!-- wp:list-item -->
          <li>1 website</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>10GB storage</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>Basic analytics</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>Email support</li>
          <!-- /wp:list-item -->
        </ul>
        <!-- /wp:list -->
        <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
        <div class="wp-block-buttons">
          <!-- wp:button {"width":100,"className":"is-style-outline"} -->
          <div class="wp-block-button has-custom-width wp-block-button__width-100 is-style-outline"><a class="wp-block-button__link wp-element-button">Get Started</a></div>
          <!-- /wp:button -->
        </div>
        <!-- /wp:buttons -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
    <!-- Pro Plan (Featured) -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px","color":"#0073aa","width":"2px"}},"layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-border-color" style="border-color:#0073aa;border-width:2px;border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:paragraph {"style":{"typography":{"fontSize":"0.75rem","fontWeight":"600","letterSpacing":"0.1em","textTransform":"uppercase"},"color":{"text":"#0073aa"},"spacing":{"margin":{"bottom":"0.5rem"}}}} -->
        <p class="has-text-color" style="color:#0073aa;font-size:0.75rem;font-weight:600;letter-spacing:0.1em;text-transform:uppercase;margin-bottom:0.5rem">Most Popular</p>
        <!-- /wp:paragraph -->
        <!-- wp:heading {"level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"bottom":"0.5rem"}}}} -->
        <h3 class="wp-block-heading" style="font-size:1.25rem;font-weight:600;margin-bottom:0.5rem">Pro</h3>
        <!-- /wp:heading -->
        <!-- wp:paragraph {"style":{"color":{"text":"#666666"},"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <p class="has-text-color" style="color:#666666;margin-bottom:1.5rem">For growing businesses</p>
        <!-- /wp:paragraph -->
        <!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap","verticalAlignment":"bottom"},"style":{"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <div class="wp-block-group" style="margin-bottom:1.5rem">
          <!-- wp:paragraph {"style":{"typography":{"fontSize":"3rem","fontWeight":"700","lineHeight":"1"}}} -->
          <p style="font-size:3rem;font-weight:700;line-height:1">$29</p>
          <!-- /wp:paragraph -->
          <!-- wp:paragraph {"style":{"color":{"text":"#666666"}}} -->
          <p class="has-text-color" style="color:#666666">/month</p>
          <!-- /wp:paragraph -->
        </div>
        <!-- /wp:group -->
        <!-- wp:list {"style":{"spacing":{"margin":{"bottom":"2rem"}},"color":{"text":"#555555"}}} -->
        <ul class="wp-block-list has-text-color" style="color:#555555;margin-bottom:2rem">
          <!-- wp:list-item -->
          <li>5 websites</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>50GB storage</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>Advanced analytics</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>Priority support</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>Custom domain</li>
          <!-- /wp:list-item -->
        </ul>
        <!-- /wp:list -->
        <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
        <div class="wp-block-buttons">
          <!-- wp:button {"width":100,"backgroundColor":"primary","textColor":"white"} -->
          <div class="wp-block-button has-custom-width wp-block-button__width-100"><a class="wp-block-button__link has-white-color has-primary-background-color has-text-color has-background wp-element-button">Get Started</a></div>
          <!-- /wp:button -->
        </div>
        <!-- /wp:buttons -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
    <!-- Enterprise Plan -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px","color":"#e5e5e5","width":"1px"}},"layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-border-color" style="border-color:#e5e5e5;border-width:1px;border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:heading {"level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"bottom":"0.5rem"}}}} -->
        <h3 class="wp-block-heading" style="font-size:1.25rem;font-weight:600;margin-bottom:0.5rem">Enterprise</h3>
        <!-- /wp:heading -->
        <!-- wp:paragraph {"style":{"color":{"text":"#666666"},"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <p class="has-text-color" style="color:#666666;margin-bottom:1.5rem">For large organizations</p>
        <!-- /wp:paragraph -->
        <!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap","verticalAlignment":"bottom"},"style":{"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <div class="wp-block-group" style="margin-bottom:1.5rem">
          <!-- wp:paragraph {"style":{"typography":{"fontSize":"3rem","fontWeight":"700","lineHeight":"1"}}} -->
          <p style="font-size:3rem;font-weight:700;line-height:1">$99</p>
          <!-- /wp:paragraph -->
          <!-- wp:paragraph {"style":{"color":{"text":"#666666"}}} -->
          <p class="has-text-color" style="color:#666666">/month</p>
          <!-- /wp:paragraph -->
        </div>
        <!-- /wp:group -->
        <!-- wp:list {"style":{"spacing":{"margin":{"bottom":"2rem"}},"color":{"text":"#555555"}}} -->
        <ul class="wp-block-list has-text-color" style="color:#555555;margin-bottom:2rem">
          <!-- wp:list-item -->
          <li>Unlimited websites</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>500GB storage</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>Custom analytics</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>24/7 phone support</li>
          <!-- /wp:list-item -->
          <!-- wp:list-item -->
          <li>SLA guarantee</li>
          <!-- /wp:list-item -->
        </ul>
        <!-- /wp:list -->
        <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
        <div class="wp-block-buttons">
          <!-- wp:button {"width":100,"className":"is-style-outline"} -->
          <div class="wp-block-button has-custom-width wp-block-button__width-100 is-style-outline"><a class="wp-block-button__link wp-element-button">Contact Sales</a></div>
          <!-- /wp:button -->
        </div>
        <!-- /wp:buttons -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
  </div>
  <!-- /wp:columns -->
</div>
<!-- /wp:group -->
```

## Testimonials

### Testimonial Grid (3 Columns)

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"5rem","bottom":"5rem","left":"2rem","right":"2rem"}}},"backgroundColor":"light-gray","layout":{"type":"constrained","contentSize":"1200px"}} -->
<div class="wp-block-group alignfull has-light-gray-background-color has-background" style="padding-top:5rem;padding-right:2rem;padding-bottom:5rem;padding-left:2rem">
  <!-- wp:heading {"textAlign":"center","style":{"typography":{"fontSize":"2.5rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"3rem"}}}} -->
  <h2 class="wp-block-heading has-text-align-center" style="font-size:2.5rem;font-weight:700;margin-bottom:3rem">What Our Customers Say</h2>
  <!-- /wp:heading -->
  <!-- wp:columns {"style":{"spacing":{"blockGap":{"left":"2rem"}}}} -->
  <div class="wp-block-columns">
    <!-- Testimonial 1 -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px"}},"backgroundColor":"white","layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-white-background-color has-background" style="border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:paragraph {"style":{"typography":{"fontSize":"2rem"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
        <p style="font-size:2rem;margin-bottom:1rem">⭐⭐⭐⭐⭐</p>
        <!-- /wp:paragraph -->
        <!-- wp:paragraph {"style":{"color":{"text":"#333333"},"typography":{"fontStyle":"italic"},"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <p class="has-text-color" style="color:#333333;font-style:italic;margin-bottom:1.5rem">"This product has completely transformed how we work. The interface is intuitive and the support team is incredibly responsive."</p>
        <!-- /wp:paragraph -->
        <!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap"},"style":{"spacing":{"blockGap":"1rem"}}} -->
        <div class="wp-block-group">
          <!-- wp:image {"id":123,"width":"48px","height":"48px","scale":"cover","sizeSlug":"thumbnail","style":{"border":{"radius":"50%"}}} -->
          <figure class="wp-block-image size-thumbnail is-resized" style="border-radius:50%"><img src="https://example.com/avatar1.jpg" alt="Sarah Johnson" class="wp-image-123" style="border-radius:50%;object-fit:cover;width:48px;height:48px"/></figure>
          <!-- /wp:image -->
          <!-- wp:group {"layout":{"type":"constrained"}} -->
          <div class="wp-block-group">
            <!-- wp:paragraph {"style":{"typography":{"fontWeight":"600"},"spacing":{"margin":{"bottom":"0"}}}} -->
            <p style="font-weight:600;margin-bottom:0">Sarah Johnson</p>
            <!-- /wp:paragraph -->
            <!-- wp:paragraph {"style":{"color":{"text":"#666666"},"typography":{"fontSize":"0.875rem"}}} -->
            <p class="has-text-color" style="color:#666666;font-size:0.875rem">CEO, TechStart</p>
            <!-- /wp:paragraph -->
          </div>
          <!-- /wp:group -->
        </div>
        <!-- /wp:group -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
    <!-- Testimonial 2 -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px"}},"backgroundColor":"white","layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-white-background-color has-background" style="border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:paragraph {"style":{"typography":{"fontSize":"2rem"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
        <p style="font-size:2rem;margin-bottom:1rem">⭐⭐⭐⭐⭐</p>
        <!-- /wp:paragraph -->
        <!-- wp:paragraph {"style":{"color":{"text":"#333333"},"typography":{"fontStyle":"italic"},"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <p class="has-text-color" style="color:#333333;font-style:italic;margin-bottom:1.5rem">"We've tried many solutions but nothing comes close. The features are exactly what we needed and the pricing is fair."</p>
        <!-- /wp:paragraph -->
        <!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap"},"style":{"spacing":{"blockGap":"1rem"}}} -->
        <div class="wp-block-group">
          <!-- wp:image {"id":124,"width":"48px","height":"48px","scale":"cover","sizeSlug":"thumbnail","style":{"border":{"radius":"50%"}}} -->
          <figure class="wp-block-image size-thumbnail is-resized" style="border-radius:50%"><img src="https://example.com/avatar2.jpg" alt="Michael Chen" class="wp-image-124" style="border-radius:50%;object-fit:cover;width:48px;height:48px"/></figure>
          <!-- /wp:image -->
          <!-- wp:group {"layout":{"type":"constrained"}} -->
          <div class="wp-block-group">
            <!-- wp:paragraph {"style":{"typography":{"fontWeight":"600"},"spacing":{"margin":{"bottom":"0"}}}} -->
            <p style="font-weight:600;margin-bottom:0">Michael Chen</p>
            <!-- /wp:paragraph -->
            <!-- wp:paragraph {"style":{"color":{"text":"#666666"},"typography":{"fontSize":"0.875rem"}}} -->
            <p class="has-text-color" style="color:#666666;font-size:0.875rem">CTO, GrowthLab</p>
            <!-- /wp:paragraph -->
          </div>
          <!-- /wp:group -->
        </div>
        <!-- /wp:group -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
    <!-- Testimonial 3 -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:group {"style":{"spacing":{"padding":{"top":"2rem","right":"1.5rem","bottom":"2rem","left":"1.5rem"}},"border":{"radius":"12px"}},"backgroundColor":"white","layout":{"type":"constrained"}} -->
      <div class="wp-block-group has-white-background-color has-background" style="border-radius:12px;padding-top:2rem;padding-right:1.5rem;padding-bottom:2rem;padding-left:1.5rem">
        <!-- wp:paragraph {"style":{"typography":{"fontSize":"2rem"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
        <p style="font-size:2rem;margin-bottom:1rem">⭐⭐⭐⭐⭐</p>
        <!-- /wp:paragraph -->
        <!-- wp:paragraph {"style":{"color":{"text":"#333333"},"typography":{"fontStyle":"italic"},"spacing":{"margin":{"bottom":"1.5rem"}}}} -->
        <p class="has-text-color" style="color:#333333;font-style:italic;margin-bottom:1.5rem">"Outstanding quality and attention to detail. Our team's productivity has increased by 40% since we started using this."</p>
        <!-- /wp:paragraph -->
        <!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap"},"style":{"spacing":{"blockGap":"1rem"}}} -->
        <div class="wp-block-group">
          <!-- wp:image {"id":125,"width":"48px","height":"48px","scale":"cover","sizeSlug":"thumbnail","style":{"border":{"radius":"50%"}}} -->
          <figure class="wp-block-image size-thumbnail is-resized" style="border-radius:50%"><img src="https://example.com/avatar3.jpg" alt="Emily Davis" class="wp-image-125" style="border-radius:50%;object-fit:cover;width:48px;height:48px"/></figure>
          <!-- /wp:image -->
          <!-- wp:group {"layout":{"type":"constrained"}} -->
          <div class="wp-block-group">
            <!-- wp:paragraph {"style":{"typography":{"fontWeight":"600"},"spacing":{"margin":{"bottom":"0"}}}} -->
            <p style="font-weight:600;margin-bottom:0">Emily Davis</p>
            <!-- /wp:paragraph -->
            <!-- wp:paragraph {"style":{"color":{"text":"#666666"},"typography":{"fontSize":"0.875rem"}}} -->
            <p class="has-text-color" style="color:#666666;font-size:0.875rem">Director, MediaPro</p>
            <!-- /wp:paragraph -->
          </div>
          <!-- /wp:group -->
        </div>
        <!-- /wp:group -->
      </div>
      <!-- /wp:group -->
    </div>
    <!-- /wp:column -->
  </div>
  <!-- /wp:columns -->
</div>
<!-- /wp:group -->
```

## Call to Action Sections

### Simple CTA Banner

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"4rem","bottom":"4rem","left":"2rem","right":"2rem"}}},"backgroundColor":"primary","textColor":"white","layout":{"type":"constrained","contentSize":"800px"}} -->
<div class="wp-block-group alignfull has-white-color has-primary-background-color has-text-color has-background" style="padding-top:4rem;padding-right:2rem;padding-bottom:4rem;padding-left:2rem">
  <!-- wp:heading {"textAlign":"center","style":{"typography":{"fontSize":"2rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
  <h2 class="wp-block-heading has-text-align-center" style="font-size:2rem;font-weight:700;margin-bottom:1rem">Ready to Get Started?</h2>
  <!-- /wp:heading -->
  <!-- wp:paragraph {"align":"center","style":{"spacing":{"margin":{"bottom":"2rem"}}}} -->
  <p class="has-text-align-center" style="margin-bottom:2rem">Join thousands of satisfied customers and take your business to the next level.</p>
  <!-- /wp:paragraph -->
  <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
  <div class="wp-block-buttons">
    <!-- wp:button {"backgroundColor":"white","textColor":"primary","style":{"border":{"radius":"6px"},"spacing":{"padding":{"top":"0.875rem","bottom":"0.875rem","left":"2rem","right":"2rem"}}}} -->
    <div class="wp-block-button"><a class="wp-block-button__link has-primary-color has-white-background-color has-text-color has-background wp-element-button" style="border-radius:6px;padding-top:0.875rem;padding-right:2rem;padding-bottom:0.875rem;padding-left:2rem">Start Free Trial</a></div>
    <!-- /wp:button -->
    <!-- wp:button {"className":"is-style-outline","style":{"border":{"radius":"6px","width":"2px"},"spacing":{"padding":{"top":"0.875rem","bottom":"0.875rem","left":"2rem","right":"2rem"}}}} -->
    <div class="wp-block-button is-style-outline"><a class="wp-block-button__link wp-element-button" style="border-radius:6px;border-width:2px;padding-top:0.875rem;padding-right:2rem;padding-bottom:0.875rem;padding-left:2rem">Talk to Sales</a></div>
    <!-- /wp:button -->
  </div>
  <!-- /wp:buttons -->
</div>
<!-- /wp:group -->
```

### CTA with Background Image

```html
<!-- wp:cover {"url":"https://example.com/cta-bg.jpg","id":123,"dimRatio":70,"overlayColor":"black","minHeight":400,"align":"full","style":{"spacing":{"padding":{"top":"4rem","bottom":"4rem"}}}} -->
<div class="wp-block-cover alignfull" style="min-height:400px;padding-top:4rem;padding-bottom:4rem">
  <span aria-hidden="true" class="wp-block-cover__background has-black-background-color has-background-dim-70 has-background-dim"></span>
  <img class="wp-block-cover__image-background wp-image-123" alt="" src="https://example.com/cta-bg.jpg" data-object-fit="cover"/>
  <div class="wp-block-cover__inner-container">
    <!-- wp:group {"layout":{"type":"constrained","contentSize":"700px"}} -->
    <div class="wp-block-group">
      <!-- wp:heading {"textAlign":"center","style":{"typography":{"fontSize":"2.5rem","fontWeight":"700"}}} -->
      <h2 class="wp-block-heading has-text-align-center" style="font-size:2.5rem;font-weight:700">Take Your Business to New Heights</h2>
      <!-- /wp:heading -->
      <!-- wp:paragraph {"align":"center","style":{"spacing":{"margin":{"top":"1rem","bottom":"2rem"}}}} -->
      <p class="has-text-align-center" style="margin-top:1rem;margin-bottom:2rem">Get started with a free 30-day trial. No credit card required.</p>
      <!-- /wp:paragraph -->
      <!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
      <div class="wp-block-buttons">
        <!-- wp:button {"backgroundColor":"white","textColor":"black","style":{"border":{"radius":"50px"},"spacing":{"padding":{"top":"1rem","bottom":"1rem","left":"2.5rem","right":"2.5rem"}},"typography":{"fontWeight":"600"}}} -->
        <div class="wp-block-button"><a class="wp-block-button__link has-black-color has-white-background-color has-text-color has-background wp-element-button" style="border-radius:50px;padding-top:1rem;padding-right:2.5rem;padding-bottom:1rem;padding-left:2.5rem;font-weight:600">Get Started Now →</a></div>
        <!-- /wp:button -->
      </div>
      <!-- /wp:buttons -->
    </div>
    <!-- /wp:group -->
  </div>
</div>
<!-- /wp:cover -->
```

## FAQ Section

### Expandable FAQ with Details Block

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"5rem","bottom":"5rem","left":"2rem","right":"2rem"}}},"layout":{"type":"constrained","contentSize":"800px"}} -->
<div class="wp-block-group alignfull" style="padding-top:5rem;padding-right:2rem;padding-bottom:5rem;padding-left:2rem">
  <!-- wp:heading {"textAlign":"center","style":{"typography":{"fontSize":"2.5rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
  <h2 class="wp-block-heading has-text-align-center" style="font-size:2.5rem;font-weight:700;margin-bottom:1rem">Frequently Asked Questions</h2>
  <!-- /wp:heading -->
  <!-- wp:paragraph {"align":"center","style":{"color":{"text":"#666666"},"spacing":{"margin":{"bottom":"3rem"}}}} -->
  <p class="has-text-align-center has-text-color" style="color:#666666;margin-bottom:3rem">Find answers to common questions about our product.</p>
  <!-- /wp:paragraph -->
  <!-- FAQ 1 -->
  <!-- wp:details {"style":{"spacing":{"margin":{"bottom":"1rem"}},"border":{"bottom":{"color":"#e5e5e5","width":"1px"}}}} -->
  <details class="wp-block-details" style="border-bottom-color:#e5e5e5;border-bottom-width:1px;margin-bottom:1rem">
    <summary style="font-weight:600;padding:1rem 0;cursor:pointer">How do I get started?</summary>
    <!-- wp:paragraph {"style":{"spacing":{"padding":{"bottom":"1rem"}}}} -->
    <p style="padding-bottom:1rem">Getting started is easy! Simply sign up for a free account, and you'll be guided through the setup process. No credit card required for the trial period.</p>
    <!-- /wp:paragraph -->
  </details>
  <!-- /wp:details -->
  <!-- FAQ 2 -->
  <!-- wp:details {"style":{"spacing":{"margin":{"bottom":"1rem"}},"border":{"bottom":{"color":"#e5e5e5","width":"1px"}}}} -->
  <details class="wp-block-details" style="border-bottom-color:#e5e5e5;border-bottom-width:1px;margin-bottom:1rem">
    <summary style="font-weight:600;padding:1rem 0;cursor:pointer">What payment methods do you accept?</summary>
    <!-- wp:paragraph {"style":{"spacing":{"padding":{"bottom":"1rem"}}}} -->
    <p style="padding-bottom:1rem">We accept all major credit cards (Visa, Mastercard, American Express), PayPal, and bank transfers for annual plans.</p>
    <!-- /wp:paragraph -->
  </details>
  <!-- /wp:details -->
  <!-- FAQ 3 -->
  <!-- wp:details {"style":{"spacing":{"margin":{"bottom":"1rem"}},"border":{"bottom":{"color":"#e5e5e5","width":"1px"}}}} -->
  <details class="wp-block-details" style="border-bottom-color:#e5e5e5;border-bottom-width:1px;margin-bottom:1rem">
    <summary style="font-weight:600;padding:1rem 0;cursor:pointer">Can I cancel my subscription?</summary>
    <!-- wp:paragraph {"style":{"spacing":{"padding":{"bottom":"1rem"}}}} -->
    <p style="padding-bottom:1rem">Yes, you can cancel your subscription at any time. Your access will continue until the end of your current billing period.</p>
    <!-- /wp:paragraph -->
  </details>
  <!-- /wp:details -->
  <!-- FAQ 4 -->
  <!-- wp:details {"style":{"border":{"bottom":{"color":"#e5e5e5","width":"1px"}}}} -->
  <details class="wp-block-details" style="border-bottom-color:#e5e5e5;border-bottom-width:1px">
    <summary style="font-weight:600;padding:1rem 0;cursor:pointer">Do you offer refunds?</summary>
    <!-- wp:paragraph {"style":{"spacing":{"padding":{"bottom":"1rem"}}}} -->
    <p style="padding-bottom:1rem">We offer a 30-day money-back guarantee on all plans. If you're not satisfied, contact our support team for a full refund.</p>
    <!-- /wp:paragraph -->
  </details>
  <!-- /wp:details -->
</div>
<!-- /wp:group -->
```

## Stats/Numbers Section

### Stats Bar (4 Columns)

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"4rem","bottom":"4rem","left":"2rem","right":"2rem"}}},"backgroundColor":"dark","textColor":"white","layout":{"type":"constrained","contentSize":"1100px"}} -->
<div class="wp-block-group alignfull has-white-color has-dark-background-color has-text-color has-background" style="padding-top:4rem;padding-right:2rem;padding-bottom:4rem;padding-left:2rem">
  <!-- wp:columns -->
  <div class="wp-block-columns">
    <!-- wp:column {"style":{"spacing":{"padding":{"top":"1rem","bottom":"1rem"}}}} -->
    <div class="wp-block-column" style="padding-top:1rem;padding-bottom:1rem">
      <!-- wp:paragraph {"align":"center","style":{"typography":{"fontSize":"3rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"0.5rem"}}}} -->
      <p class="has-text-align-center" style="font-size:3rem;font-weight:700;margin-bottom:0.5rem">10K+</p>
      <!-- /wp:paragraph -->
      <!-- wp:paragraph {"align":"center","style":{"color":{"text":"rgba(255,255,255,0.7)"}}} -->
      <p class="has-text-align-center has-text-color" style="color:rgba(255,255,255,0.7)">Active Users</p>
      <!-- /wp:paragraph -->
    </div>
    <!-- /wp:column -->
    <!-- wp:column {"style":{"spacing":{"padding":{"top":"1rem","bottom":"1rem"}}}} -->
    <div class="wp-block-column" style="padding-top:1rem;padding-bottom:1rem">
      <!-- wp:paragraph {"align":"center","style":{"typography":{"fontSize":"3rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"0.5rem"}}}} -->
      <p class="has-text-align-center" style="font-size:3rem;font-weight:700;margin-bottom:0.5rem">99.9%</p>
      <!-- /wp:paragraph -->
      <!-- wp:paragraph {"align":"center","style":{"color":{"text":"rgba(255,255,255,0.7)"}}} -->
      <p class="has-text-align-center has-text-color" style="color:rgba(255,255,255,0.7)">Uptime</p>
      <!-- /wp:paragraph -->
    </div>
    <!-- /wp:column -->
    <!-- wp:column {"style":{"spacing":{"padding":{"top":"1rem","bottom":"1rem"}}}} -->
    <div class="wp-block-column" style="padding-top:1rem;padding-bottom:1rem">
      <!-- wp:paragraph {"align":"center","style":{"typography":{"fontSize":"3rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"0.5rem"}}}} -->
      <p class="has-text-align-center" style="font-size:3rem;font-weight:700;margin-bottom:0.5rem">24/7</p>
      <!-- /wp:paragraph -->
      <!-- wp:paragraph {"align":"center","style":{"color":{"text":"rgba(255,255,255,0.7)"}}} -->
      <p class="has-text-align-center has-text-color" style="color:rgba(255,255,255,0.7)">Support</p>
      <!-- /wp:paragraph -->
    </div>
    <!-- /wp:column -->
    <!-- wp:column {"style":{"spacing":{"padding":{"top":"1rem","bottom":"1rem"}}}} -->
    <div class="wp-block-column" style="padding-top:1rem;padding-bottom:1rem">
      <!-- wp:paragraph {"align":"center","style":{"typography":{"fontSize":"3rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"0.5rem"}}}} -->
      <p class="has-text-align-center" style="font-size:3rem;font-weight:700;margin-bottom:0.5rem">50+</p>
      <!-- /wp:paragraph -->
      <!-- wp:paragraph {"align":"center","style":{"color":{"text":"rgba(255,255,255,0.7)"}}} -->
      <p class="has-text-align-center has-text-color" style="color:rgba(255,255,255,0.7)">Countries</p>
      <!-- /wp:paragraph -->
    </div>
    <!-- /wp:column -->
  </div>
  <!-- /wp:columns -->
</div>
<!-- /wp:group -->
```

## Logo Bar

### Client/Partner Logos

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"3rem","bottom":"3rem","left":"2rem","right":"2rem"}},"border":{"top":{"color":"#e5e5e5","width":"1px"},"bottom":{"color":"#e5e5e5","width":"1px"}}},"layout":{"type":"constrained","contentSize":"1100px"}} -->
<div class="wp-block-group alignfull" style="border-top-color:#e5e5e5;border-top-width:1px;border-bottom-color:#e5e5e5;border-bottom-width:1px;padding-top:3rem;padding-right:2rem;padding-bottom:3rem;padding-left:2rem">
  <!-- wp:paragraph {"align":"center","style":{"color":{"text":"#888888"},"typography":{"fontSize":"0.875rem","textTransform":"uppercase","letterSpacing":"0.1em"},"spacing":{"margin":{"bottom":"2rem"}}}} -->
  <p class="has-text-align-center has-text-color" style="color:#888888;font-size:0.875rem;text-transform:uppercase;letter-spacing:0.1em;margin-bottom:2rem">Trusted by leading companies</p>
  <!-- /wp:paragraph -->
  <!-- wp:group {"layout":{"type":"flex","flexWrap":"wrap","justifyContent":"center"},"style":{"spacing":{"blockGap":"3rem"}}} -->
  <div class="wp-block-group">
    <!-- wp:image {"id":101,"width":"120px","sizeSlug":"full","style":{"color":{"duotone":["#999999","#999999"]}}} -->
    <figure class="wp-block-image size-full is-resized"><img src="https://example.com/logo1.png" alt="Company 1" class="wp-image-101" style="width:120px"/></figure>
    <!-- /wp:image -->
    <!-- wp:image {"id":102,"width":"120px","sizeSlug":"full","style":{"color":{"duotone":["#999999","#999999"]}}} -->
    <figure class="wp-block-image size-full is-resized"><img src="https://example.com/logo2.png" alt="Company 2" class="wp-image-102" style="width:120px"/></figure>
    <!-- /wp:image -->
    <!-- wp:image {"id":103,"width":"120px","sizeSlug":"full","style":{"color":{"duotone":["#999999","#999999"]}}} -->
    <figure class="wp-block-image size-full is-resized"><img src="https://example.com/logo3.png" alt="Company 3" class="wp-image-103" style="width:120px"/></figure>
    <!-- /wp:image -->
    <!-- wp:image {"id":104,"width":"120px","sizeSlug":"full","style":{"color":{"duotone":["#999999","#999999"]}}} -->
    <figure class="wp-block-image size-full is-resized"><img src="https://example.com/logo4.png" alt="Company 4" class="wp-image-104" style="width:120px"/></figure>
    <!-- /wp:image -->
    <!-- wp:image {"id":105,"width":"120px","sizeSlug":"full","style":{"color":{"duotone":["#999999","#999999"]}}} -->
    <figure class="wp-block-image size-full is-resized"><img src="https://example.com/logo5.png" alt="Company 5" class="wp-image-105" style="width:120px"/></figure>
    <!-- /wp:image -->
  </div>
  <!-- /wp:group -->
</div>
<!-- /wp:group -->
```

## Team Section

### Team Grid (4 Members)

```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"5rem","bottom":"5rem","left":"2rem","right":"2rem"}}},"layout":{"type":"constrained","contentSize":"1200px"}} -->
<div class="wp-block-group alignfull" style="padding-top:5rem;padding-right:2rem;padding-bottom:5rem;padding-left:2rem">
  <!-- wp:heading {"textAlign":"center","style":{"typography":{"fontSize":"2.5rem","fontWeight":"700"},"spacing":{"margin":{"bottom":"1rem"}}}} -->
  <h2 class="wp-block-heading has-text-align-center" style="font-size:2.5rem;font-weight:700;margin-bottom:1rem">Meet Our Team</h2>
  <!-- /wp:heading -->
  <!-- wp:paragraph {"align":"center","style":{"color":{"text":"#666666"},"spacing":{"margin":{"bottom":"3rem"}}}} -->
  <p class="has-text-align-center has-text-color" style="color:#666666;margin-bottom:3rem">The people behind our success.</p>
  <!-- /wp:paragraph -->
  <!-- wp:columns {"style":{"spacing":{"blockGap":{"left":"2rem"}}}} -->
  <div class="wp-block-columns">
    <!-- Team Member 1 -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:image {"id":201,"aspectRatio":"1","scale":"cover","sizeSlug":"medium","style":{"border":{"radius":"12px"}}} -->
      <figure class="wp-block-image size-medium" style="border-radius:12px"><img src="https://example.com/team1.jpg" alt="John Smith" class="wp-image-201" style="border-radius:12px;aspect-ratio:1;object-fit:cover"/></figure>
      <!-- /wp:image -->
      <!-- wp:heading {"textAlign":"center","level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"top":"1rem","bottom":"0.25rem"}}}} -->
      <h3 class="wp-block-heading has-text-align-center" style="font-size:1.25rem;font-weight:600;margin-top:1rem;margin-bottom:0.25rem">John Smith</h3>
      <!-- /wp:heading -->
      <!-- wp:paragraph {"align":"center","style":{"color":{"text":"#666666"}}} -->
      <p class="has-text-align-center has-text-color" style="color:#666666">CEO &amp; Founder</p>
      <!-- /wp:paragraph -->
      <!-- wp:social-links {"iconColor":"contrast","iconColorValue":"#333333","size":"has-small-icon-size","className":"is-style-logos-only","layout":{"type":"flex","justifyContent":"center"},"style":{"spacing":{"margin":{"top":"0.5rem"}}}} -->
      <ul class="wp-block-social-links has-small-icon-size has-icon-color is-style-logos-only" style="margin-top:0.5rem">
        <!-- wp:social-link {"url":"https://twitter.com/","service":"twitter"} /-->
        <!-- wp:social-link {"url":"https://linkedin.com/","service":"linkedin"} /-->
      </ul>
      <!-- /wp:social-links -->
    </div>
    <!-- /wp:column -->
    <!-- Team Member 2 -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:image {"id":202,"aspectRatio":"1","scale":"cover","sizeSlug":"medium","style":{"border":{"radius":"12px"}}} -->
      <figure class="wp-block-image size-medium" style="border-radius:12px"><img src="https://example.com/team2.jpg" alt="Jane Doe" class="wp-image-202" style="border-radius:12px;aspect-ratio:1;object-fit:cover"/></figure>
      <!-- /wp:image -->
      <!-- wp:heading {"textAlign":"center","level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"top":"1rem","bottom":"0.25rem"}}}} -->
      <h3 class="wp-block-heading has-text-align-center" style="font-size:1.25rem;font-weight:600;margin-top:1rem;margin-bottom:0.25rem">Jane Doe</h3>
      <!-- /wp:heading -->
      <!-- wp:paragraph {"align":"center","style":{"color":{"text":"#666666"}}} -->
      <p class="has-text-align-center has-text-color" style="color:#666666">CTO</p>
      <!-- /wp:paragraph -->
      <!-- wp:social-links {"iconColor":"contrast","iconColorValue":"#333333","size":"has-small-icon-size","className":"is-style-logos-only","layout":{"type":"flex","justifyContent":"center"},"style":{"spacing":{"margin":{"top":"0.5rem"}}}} -->
      <ul class="wp-block-social-links has-small-icon-size has-icon-color is-style-logos-only" style="margin-top:0.5rem">
        <!-- wp:social-link {"url":"https://twitter.com/","service":"twitter"} /-->
        <!-- wp:social-link {"url":"https://linkedin.com/","service":"linkedin"} /-->
      </ul>
      <!-- /wp:social-links -->
    </div>
    <!-- /wp:column -->
    <!-- Team Member 3 -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:image {"id":203,"aspectRatio":"1","scale":"cover","sizeSlug":"medium","style":{"border":{"radius":"12px"}}} -->
      <figure class="wp-block-image size-medium" style="border-radius:12px"><img src="https://example.com/team3.jpg" alt="Bob Wilson" class="wp-image-203" style="border-radius:12px;aspect-ratio:1;object-fit:cover"/></figure>
      <!-- /wp:image -->
      <!-- wp:heading {"textAlign":"center","level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"top":"1rem","bottom":"0.25rem"}}}} -->
      <h3 class="wp-block-heading has-text-align-center" style="font-size:1.25rem;font-weight:600;margin-top:1rem;margin-bottom:0.25rem">Bob Wilson</h3>
      <!-- /wp:heading -->
      <!-- wp:paragraph {"align":"center","style":{"color":{"text":"#666666"}}} -->
      <p class="has-text-align-center has-text-color" style="color:#666666">Head of Design</p>
      <!-- /wp:paragraph -->
      <!-- wp:social-links {"iconColor":"contrast","iconColorValue":"#333333","size":"has-small-icon-size","className":"is-style-logos-only","layout":{"type":"flex","justifyContent":"center"},"style":{"spacing":{"margin":{"top":"0.5rem"}}}} -->
      <ul class="wp-block-social-links has-small-icon-size has-icon-color is-style-logos-only" style="margin-top:0.5rem">
        <!-- wp:social-link {"url":"https://twitter.com/","service":"twitter"} /-->
        <!-- wp:social-link {"url":"https://dribbble.com/","service":"dribbble"} /-->
      </ul>
      <!-- /wp:social-links -->
    </div>
    <!-- /wp:column -->
    <!-- Team Member 4 -->
    <!-- wp:column -->
    <div class="wp-block-column">
      <!-- wp:image {"id":204,"aspectRatio":"1","scale":"cover","sizeSlug":"medium","style":{"border":{"radius":"12px"}}} -->
      <figure class="wp-block-image size-medium" style="border-radius:12px"><img src="https://example.com/team4.jpg" alt="Alice Brown" class="wp-image-204" style="border-radius:12px;aspect-ratio:1;object-fit:cover"/></figure>
      <!-- /wp:image -->
      <!-- wp:heading {"textAlign":"center","level":3,"style":{"typography":{"fontSize":"1.25rem","fontWeight":"600"},"spacing":{"margin":{"top":"1rem","bottom":"0.25rem"}}}} -->
      <h3 class="wp-block-heading has-text-align-center" style="font-size:1.25rem;font-weight:600;margin-top:1rem;margin-bottom:0.25rem">Alice Brown</h3>
      <!-- /wp:heading -->
      <!-- wp:paragraph {"align":"center","style":{"color":{"text":"#666666"}}} -->
      <p class="has-text-align-center has-text-color" style="color:#666666">Marketing Lead</p>
      <!-- /wp:paragraph -->
      <!-- wp:social-links {"iconColor":"contrast","iconColorValue":"#333333","size":"has-small-icon-size","className":"is-style-logos-only","layout":{"type":"flex","justifyContent":"center"},"style":{"spacing":{"margin":{"top":"0.5rem"}}}} -->
      <ul class="wp-block-social-links has-small-icon-size has-icon-color is-style-logos-only" style="margin-top:0.5rem">
        <!-- wp:social-link {"url":"https://twitter.com/","service":"twitter"} /-->
        <!-- wp:social-link {"url":"https://linkedin.com/","service":"linkedin"} /-->
      </ul>
      <!-- /wp:social-links -->
    </div>
    <!-- /wp:column -->
  </div>
  <!-- /wp:columns -->
</div>
<!-- /wp:group -->
```

## Best Practices

1. **Use Group blocks for sections** - Wrap each section in a Group with `align: full`
2. **Consistent spacing** - Use theme spacing presets (`var:preset|spacing|50`)
3. **Responsive by default** - Columns stack on mobile automatically
4. **Semantic HTML** - Use appropriate heading levels (H1 once, then H2, H3)
5. **Color presets** - Use `backgroundColor` and `textColor` with preset names when available
6. **Inline styles** - Use `style` attribute for custom values not in presets

## Resources

- [WordPress Block Pattern Directory](https://wordpress.org/patterns/)
- [10up Block Patterns Guide](https://gutenberg.10up.com/reference/Patterns/overview/)
- [Theme.json Reference](https://developer.wordpress.org/block-editor/how-to-guides/themes/global-settings-and-styles/)
