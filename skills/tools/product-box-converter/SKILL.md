---
name: product-box-converter
description: Convert clipboard content to ACF Product Box blocks. Use when the user pastes AAWP HTML, a product URL, or raw product details and wants an ACF product-box block. Also use when the user mentions "product box," "convert to product box," "AAWP to ACF," or "product block."
user_invocable: true
argument: The clipboard content (AAWP HTML, product URL, or product details) to convert
---

# ACF Product Box Converter

Convert any product source (AAWP HTML, URL, or raw details) into a WordPress ACF Product Box block.

## Input Detection

Determine the input type and follow the corresponding path:

| Input Type | Signal | Action |
|------------|--------|--------|
| **AAWP HTML** | Contains `.aawp-product` classes | Extract fields from HTML structure |
| **Rendered ACF HTML** | Contains `.acf-product-box` classes | Extract fields from rendered output |
| **URL** | Starts with `http` / plain URL | Fetch page, extract product data |
| **Raw details** | Product name, price, features as text | Map directly to fields |

---

## ACF Product Box Block Format

**CRITICAL**: All field keys use the `field_` prefix. Repeaters use nested `row-N` objects, NOT flat indexed keys.

### Default (with image)

```html
<!-- wp:acf/product-box {"name":"acf/product-box","data":{"field_pb_image":"","field_pb_image_url":"https://example.com/image.jpg","field_pb_badge_text":"SAVE 15%","field_pb_badge_color":"#22c55e","field_pb_title":"Product Title","field_pb_title_url":"https://example.com","field_pb_rating":"4.5","field_pb_rating_count":"1,234 ratings","field_pb_features":{"row-0":{"field_pb_feature_text":"Feature one"},"row-1":{"field_pb_feature_text":"Feature two"}},"field_pb_original_price":"$99.99","field_pb_discount_percent":"-15%","field_pb_current_price":"$84.99","field_pb_price_note":"Free shipping","field_pb_description":"Short product description.","field_pb_buttons":{"row-0":{"field_pb_cta_text":"Buy Now","field_pb_cta_url":"https://example.com","field_pb_cta_style":"primary","field_pb_cta_icon":"none","field_pb_cta_class":"","field_pb_cta_rel":"nofollow noopener sponsored"}}},"mode":"preview"} /-->
```

### No Image variation

```html
<!-- wp:acf/product-box {"name":"acf/product-box","className":"is-style-no-image","data":{"field_pb_badge_text":"SAVE 15%","field_pb_badge_color":"#22c55e","field_pb_title":"Product Title","field_pb_title_url":"https://example.com","field_pb_rating":"4.5","field_pb_rating_count":"1,234 ratings","field_pb_features":{"row-0":{"field_pb_feature_text":"Feature one"},"row-1":{"field_pb_feature_text":"Feature two"}},"field_pb_original_price":"$99.99","field_pb_discount_percent":"-15%","field_pb_current_price":"$84.99","field_pb_price_note":"Free shipping","field_pb_description":"Short product description.","field_pb_buttons":{"row-0":{"field_pb_cta_text":"Buy Now","field_pb_cta_url":"https://example.com","field_pb_cta_style":"primary","field_pb_cta_icon":"none","field_pb_cta_class":"","field_pb_cta_rel":"nofollow noopener sponsored"}}},"mode":"preview"} /-->
```

**Key difference:** `"className":"is-style-no-image"` in block attributes. Image fields (`field_pb_image`, `field_pb_image_url`) are omitted entirely.

**When to use no-image variation:**
- No product image available from the source
- User explicitly requests no image
- Product is a digital download, service, or non-physical item where a generic image adds no value

---

## Field Reference

All field keys use the `field_` prefix. Repeater fields use nested `row-N` objects.

### Core Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `field_pb_image` | string | No | WordPress attachment ID (empty string if none) |
| `field_pb_image_url` | string | No | Direct image URL (used when no attachment ID) |
| `field_pb_badge_text` | string | No | Badge label (e.g., "SAVE 15%", "FREE", "BEST SELLER") |
| `field_pb_badge_color` | string | No | Badge hex color (e.g., "#22c55e") |
| `field_pb_title` | string | Yes | Product name |
| `field_pb_title_url` | string | Yes | Link to product page |
| `field_pb_rating` | string | No | Rating value (e.g., "4.5", "5") |
| `field_pb_rating_count` | string | No | Rating count text (e.g., "1,234 ratings") |
| `field_pb_original_price` | string | No | Original/list price with currency symbol |
| `field_pb_discount_percent` | string | No | Discount text (e.g., "-15%", "-100%") |
| `field_pb_current_price` | string | No | Current/sale price with currency symbol (or "FREE") |
| `field_pb_price_note` | string | No | Price note (e.g., "Free shipping", "Buy once, own forever.") |
| `field_pb_description` | string | No | Short product description below pricing |

### Features (Repeater)

Nested object with `row-N` keys. Each row contains `field_pb_feature_text`.

```json
"field_pb_features": {
  "row-0": {"field_pb_feature_text": "First feature"},
  "row-1": {"field_pb_feature_text": "Second feature"},
  "row-2": {"field_pb_feature_text": "Third feature"}
}
```

### Buttons (Repeater)

Nested object with `row-N` keys. Each row contains button subfields.

| Subfield | Type | Description |
|----------|------|-------------|
| `field_pb_cta_text` | string | Button label text |
| `field_pb_cta_url` | string | Button link URL |
| `field_pb_cta_style` | string | `primary`, `secondary`, or `amazon` |
| `field_pb_cta_icon` | string | `none`, `cart`, `external`, or `download` |
| `field_pb_cta_class` | string | CSS class for icon (e.g., `md-icon-download`, `md-icon-external`) |
| `field_pb_cta_rel` | string | Link rel attribute (e.g., `nofollow noopener sponsored`, `bookmark`) |

```json
"field_pb_buttons": {
  "row-0": {
    "field_pb_cta_text": "Buy on Amazon",
    "field_pb_cta_url": "https://amazon.com/dp/...",
    "field_pb_cta_style": "amazon",
    "field_pb_cta_icon": "cart",
    "field_pb_cta_class": "",
    "field_pb_cta_rel": "nofollow noopener sponsored"
  },
  "row-1": {
    "field_pb_cta_text": "Visit Website",
    "field_pb_cta_url": "https://example.com",
    "field_pb_cta_style": "primary",
    "field_pb_cta_icon": "none",
    "field_pb_cta_class": "md-icon-external",
    "field_pb_cta_rel": "nofollow noopener"
  }
}
```

**Icon vs Class**: `field_pb_cta_icon` controls the built-in icon rendering. `field_pb_cta_class` adds a CSS class to the button `<a>` tag for custom icon styling (e.g., MD theme icon classes like `md-icon-download`, `md-icon-external`). When using a custom class icon, set `field_pb_cta_icon` to `"none"`.

---

## Conversion Paths

### Path 1: AAWP HTML Input

Extract fields from AAWP markup using these CSS selectors:

| ACF Field | AAWP Source |
|-----------|-------------|
| `field_pb_badge_text` | `.aawp-product__ribbon` text |
| `field_pb_title` | `.aawp-md-title` link text |
| `field_pb_title_url` | `.aawp-md-title` link `href` |
| `field_pb_image_url` | `.aawp-product__image` `src` |
| `field_pb_features` | Each `<li>` from `.aawp-product__description` → `row-N` |
| `field_pb_original_price` | `.aawp-product__price--old` |
| `field_pb_discount_percent` | `.aawp-product__price--saved` |
| `field_pb_current_price` | `.aawp-product__price--current` |
| `field_pb_buttons` | Each button from `.aawp-md-actions` → `row-N` |

### Path 2: Rendered ACF HTML Input

Extract fields from rendered `.acf-product-box` markup:

| ACF Field | Rendered HTML Source |
|-----------|---------------------|
| `field_pb_image_url` | `.acf-product-box__image img` `src` |
| `field_pb_title` | `.acf-product-box__title a` text |
| `field_pb_title_url` | `.acf-product-box__title a` `href` |
| `field_pb_rating` | Count of `.star--full` elements |
| `field_pb_features` | Each `<li>` from `.acf-product-box__features` → `row-N` |
| `field_pb_original_price` | `.acf-product-box__original-price` |
| `field_pb_discount_percent` | `.acf-product-box__discount` |
| `field_pb_current_price` | `.acf-product-box__current-price` |
| `field_pb_buttons` | Each `.acf-product-box__btn` → `row-N` with text, href, rel, class |

### Path 3: URL Input

1. Fetch the page using `curl` or WebFetch
2. Extract product data from the page:
   - Title from `<title>` or `<h1>` (clean up, remove clutter)
   - Best image from og:image or main product image
   - Price from structured data or price elements
   - Features from product description/bullets
3. Build the block with extracted data
4. All buttons get `field_pb_cta_rel: "nofollow noopener sponsored"`

**Amazon products** - add dual buttons:
- **Amazon.com**: URL format `https://www.amazon.com/dp/ASIN/?tag=gtorg0f-20`, style "amazon", icon "cart"
- **Amazon.in**: URL format `https://www.amazon.in/s?k=Product+Name+Keywords&tag=gaurtiwa-21`, style "primary", class "md-icon-external"

**External (non-Amazon) products** - no affiliate tags, use best image from page

### Path 4: Raw Details Input

Map the provided text directly to fields. Ask for missing required fields (title, URL) if not provided.

---

## Output Rules

1. Output the block comment markup in a code fence, ready to paste into WordPress
2. Then copy the raw block markup (without code fences) to clipboard using `pbcopy` with a heredoc
3. Improve product titles: make them concise and descriptive (remove ASIN, excessive keywords)
4. Improve feature text: clean up HTML entities, fix capitalization, make scannable
5. If discount exists, calculate badge text as "SAVE X%" with `field_pb_badge_color: "#22c55e"`
6. For free products, use badge text "FREE" with `field_pb_badge_color: "#22c55e"`
7. Use `is-style-no-image` when no image is available or explicitly requested
8. `field_pb_image` should be empty string `""` when using `field_pb_image_url` directly
9. Always include all button subfields (`field_pb_cta_text`, `field_pb_cta_url`, `field_pb_cta_style`, `field_pb_cta_icon`, `field_pb_cta_class`, `field_pb_cta_rel`)

---

## Common Button Patterns

### Amazon.com Buy Button
```json
{
  "field_pb_cta_text": "Check Price on Amazon",
  "field_pb_cta_url": "https://www.amazon.com/dp/ASIN/?tag=gtorg0f-20",
  "field_pb_cta_style": "amazon",
  "field_pb_cta_icon": "cart",
  "field_pb_cta_class": "",
  "field_pb_cta_rel": "nofollow noopener sponsored"
}
```

### Amazon.in Button
```json
{
  "field_pb_cta_text": "Check on Amazon.in",
  "field_pb_cta_url": "https://www.amazon.in/s?k=Product+Name+Keywords&tag=gaurtiwa-21",
  "field_pb_cta_style": "primary",
  "field_pb_cta_icon": "none",
  "field_pb_cta_class": "md-icon-external",
  "field_pb_cta_rel": "nofollow noopener sponsored"
}
```

**Amazon URL formats:**
- **Amazon.com**: `https://www.amazon.com/dp/ASIN/?tag=gtorg0f-20` (use ASIN)
- **Amazon.in**: `https://www.amazon.in/s?k=Product+Name+Keywords&tag=gaurtiwa-21` (use title search, unless ASIN given)

### Download Button (free product)
```json
{
  "field_pb_cta_text": "Download for free",
  "field_pb_cta_url": "https://yoursite.com/product/...",
  "field_pb_cta_style": "primary",
  "field_pb_cta_icon": "none",
  "field_pb_cta_class": "md-icon-download",
  "field_pb_cta_rel": "bookmark"
}
```

### External Link Button (non-Amazon, no affiliate tags)
```json
{
  "field_pb_cta_text": "Visit Website",
  "field_pb_cta_url": "https://example.com",
  "field_pb_cta_style": "primary",
  "field_pb_cta_icon": "none",
  "field_pb_cta_class": "md-icon-external",
  "field_pb_cta_rel": "nofollow noopener"
}
```

### Affiliate Link Button (yoursite.com/go/)
```json
{
  "field_pb_cta_text": "Try Free",
  "field_pb_cta_url": "https://yoursite.com/go/product-slug/",
  "field_pb_cta_style": "primary",
  "field_pb_cta_icon": "none",
  "field_pb_cta_class": "md-icon-external",
  "field_pb_cta_rel": "nofollow noopener sponsored"
}
```

---

## Full Example: Rendered ACF HTML to Block

**Input (rendered HTML):**
```html
<div class="acf-product-box align wp-block-acf-product-box">
  <div class="acf-product-box__layout">
    <div class="acf-product-box__image">
      <img src="https://cdn.yoursite.com/wp-content/uploads/2026/02/bhaskaracharyas-lilavati-page2.png" alt="Bhaskaracharya's Lilavati">
    </div>
    <div class="acf-product-box__content">
      <h3 class="acf-product-box__title">
        <a href="https://yoursite.com/product/bhaskaracharyas-lilavati/">Bhaskaracharya's Lilavati: Ancient Indian Mathematics</a>
      </h3>
      <div class="acf-product-box__rating">
        <span class="star star--full">★</span><span class="star star--full">★</span><span class="star star--full">★</span><span class="star star--full">★</span><span class="star star--full">★</span>
      </div>
      <ul class="acf-product-box__features">
        <li>100% Free Download</li>
        <li>Covers arithmetic, geometry, the Kuttaka method, Chakravala algorithm...</li>
      </ul>
      <div class="acf-product-box__pricing">
        <span class="acf-product-box__original-price">$9.99</span>
        <span class="acf-product-box__discount">-100%</span>
        <span class="acf-product-box__current-price">FREE</span>
      </div>
      <div class="acf-product-box__buttons">
        <a href="https://yoursite.com/product/bhaskaracharyas-lilavati/" class="acf-product-box__btn md-icon-download" rel="bookmark">Download</a>
      </div>
    </div>
  </div>
</div>
```

**Output:**
```html
<!-- wp:acf/product-box {"name":"acf/product-box","data":{"field_pb_image":"","field_pb_image_url":"https://cdn.yoursite.com/wp-content/uploads/2026/02/bhaskaracharyas-lilavati-page2.png","field_pb_badge_text":"FREE","field_pb_badge_color":"#22c55e","field_pb_title":"Bhaskaracharya's Lilavati: Ancient Indian Mathematics","field_pb_title_url":"https://yoursite.com/product/bhaskaracharyas-lilavati/","field_pb_rating":"5","field_pb_rating_count":"17 ratings","field_pb_features":{"row-0":{"field_pb_feature_text":"100% Free Download "},"row-1":{"field_pb_feature_text":"Explore the mathematical genius of 12th-century India through Bhaskaracharya's Lilavati. Covers arithmetic, geometry, the Kuttaka method, Chakravala algorithm, and famous problems like the Peacock and the Snake. Includes historical context and comparisons with Greek and Chinese mathematics."}},"field_pb_original_price":"$9.99","field_pb_discount_percent":"-100%","field_pb_current_price":"FREE","field_pb_price_note":"Buy once, own forever.","field_pb_description":"Available in PDF format for download.","field_pb_buttons":{"row-0":{"field_pb_cta_text":"Download for free","field_pb_cta_url":"https://yoursite.com/product/bhaskaracharyas-lilavati/","field_pb_cta_style":"primary","field_pb_cta_icon":"none","field_pb_cta_class":"md-icon-download","field_pb_cta_rel":"bookmark"}}},"mode":"preview"} /-->
```
