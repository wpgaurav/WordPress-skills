---
name: product-box-block
description: Convert a URL (from clipboard or user input) to an ACF Product Box Block. Fetches the page, extracts product details, and outputs WordPress block markup. Use when the user pastes a product URL, mentions "product box," "ACF product box," or wants to convert a product page to a Gutenberg block.
user_invocable: true
---

# ACF Product Box Block Generator

Convert product URLs to ACF Product Box block markup for WordPress. Fetch the page, extract details, generate the block comment, and copy to clipboard.

## Workflow

1. **Get URL**: From clipboard `{clipboard}`, user message, or ask
2. **Fetch page**: Use WebFetch or firecrawl to get product details
3. **Extract fields**: Apply extraction rules below
4. **Generate block**: Output ACF block comment markup
5. **Copy to clipboard**: `echo '...' | pbcopy`

## Extraction Rules

### Title
- Clean product name from page title or h1
- Remove brand clutter, ASIN codes, excessive keywords
- Improve wording for clarity

### Image
- Best product image from `og:image` or main product image
- Prefer high-resolution, clean product shots

### Features
- Extract key specs/features from `<li>` items or product bullet points
- Improve wording if needed for clarity
- 3-6 features is ideal

### Prices
- Original price (strikethrough/was price)
- Discount percentage
- Current/sale price
- Price note (e.g., "Free shipping", "Prime eligible")

### Badge
- Format: "SAVE X%" with color `#22c55e`
- For free products: "FREE" with color `#22c55e`
- Calculate from original vs current price if not explicit

### Description
- Short one-line summary of the product
- Improve from page meta description or product summary

## Button Rules

### Amazon.com Products
```
Button 1 (Amazon US):
- URL: https://www.amazon.com/dp/{ASIN}/?tag=gtorg0f-20
- Style: "amazon"
- Icon: "cart"
- Text: "Check Price on Amazon"

Button 2 (Amazon India):
- URL: https://www.amazon.in/s?k={Product+Name+Keywords}&tag=gaurtiwa-21
- Style: "primary"
- Icon: "none"
- Class: "md-icon-external"
- Text: "Check on Amazon.in"
```

### Non-Amazon Products
```
Button 1:
- URL: Product page URL (no affiliate tag unless one exists)
- Style: "primary"
- Icon: "none"
- Class: "md-icon-external"
- Text: "Check Price" or "Visit Website"
```

### All Buttons
- `field_pb_cta_rel`: `"nofollow noopener sponsored"`

## ACF Block Format

**CRITICAL**: All field keys use the `field_` prefix. Repeaters use nested `row-N` objects.

### Standard (with image)

```html
<!-- wp:acf/product-box {"name":"acf/product-box","data":{"field_pb_image":"","field_pb_image_url":"IMAGE_URL","field_pb_badge_text":"SAVE 15%","field_pb_badge_color":"#22c55e","field_pb_title":"Product Title","field_pb_title_url":"PRODUCT_URL","field_pb_rating":"4.5","field_pb_rating_count":"1,234 ratings","field_pb_features":{"row-0":{"field_pb_feature_text":"Feature one"},"row-1":{"field_pb_feature_text":"Feature two"},"row-2":{"field_pb_feature_text":"Feature three"}},"field_pb_original_price":"$99.99","field_pb_discount_percent":"-15%","field_pb_current_price":"$84.99","field_pb_price_note":"Free shipping","field_pb_description":"Short product description.","field_pb_buttons":{"row-0":{"field_pb_cta_text":"Check Price on Amazon","field_pb_cta_url":"https://www.amazon.com/dp/ASIN/?tag=gtorg0f-20","field_pb_cta_style":"amazon","field_pb_cta_icon":"cart","field_pb_cta_class":"","field_pb_cta_rel":"nofollow noopener sponsored"},"row-1":{"field_pb_cta_text":"Check on Amazon.in","field_pb_cta_url":"https://www.amazon.in/s?k=Product+Name&tag=gaurtiwa-21","field_pb_cta_style":"primary","field_pb_cta_icon":"none","field_pb_cta_class":"md-icon-external","field_pb_cta_rel":"nofollow noopener sponsored"}}},"mode":"preview"} /-->
```

### No Image Variation

Add `"className":"is-style-no-image"` to block attributes. Omit `field_pb_image` and `field_pb_image_url`.

```html
<!-- wp:acf/product-box {"name":"acf/product-box","className":"is-style-no-image","data":{"field_pb_badge_text":"FREE","field_pb_badge_color":"#22c55e","field_pb_title":"Product Title","field_pb_title_url":"PRODUCT_URL","field_pb_rating":"4.8","field_pb_rating_count":"500 ratings","field_pb_features":{"row-0":{"field_pb_feature_text":"Feature one"}},"field_pb_current_price":"Free","field_pb_description":"Short description.","field_pb_buttons":{"row-0":{"field_pb_cta_text":"Visit Website","field_pb_cta_url":"https://example.com","field_pb_cta_style":"primary","field_pb_cta_icon":"none","field_pb_cta_class":"md-icon-external","field_pb_cta_rel":"nofollow noopener sponsored"}}},"mode":"preview"} /-->
```

## Field Reference

| Field | Key | Type | Notes |
|-------|-----|------|-------|
| Image ID | `field_pb_image` | string | Empty `""` when using URL |
| Image URL | `field_pb_image_url` | string | Direct image URL |
| Badge Text | `field_pb_badge_text` | string | "SAVE X%" or "FREE" |
| Badge Color | `field_pb_badge_color` | string | Hex color, default `#22c55e` |
| Title | `field_pb_title` | string | Clean product name |
| Title URL | `field_pb_title_url` | string | Product page URL |
| Rating | `field_pb_rating` | string | e.g., "4.5" |
| Rating Count | `field_pb_rating_count` | string | e.g., "1,234 ratings" |
| Features | `field_pb_features` | repeater | `row-N` > `field_pb_feature_text` |
| Original Price | `field_pb_original_price` | string | e.g., "$99.99" |
| Discount | `field_pb_discount_percent` | string | e.g., "-15%" |
| Current Price | `field_pb_current_price` | string | e.g., "$84.99" |
| Price Note | `field_pb_price_note` | string | e.g., "Free shipping" |
| Description | `field_pb_description` | string | One-line summary |
| Buttons | `field_pb_buttons` | repeater | See button fields below |

### Button Sub-fields

| Field | Key | Values |
|-------|-----|--------|
| Text | `field_pb_cta_text` | Button label |
| URL | `field_pb_cta_url` | Full URL with affiliate tag |
| Style | `field_pb_cta_style` | `"amazon"`, `"primary"`, `"secondary"` |
| Icon | `field_pb_cta_icon` | `"none"`, `"cart"`, `"external"`, `"download"` |
| Class | `field_pb_cta_class` | `""`, `"md-icon-external"`, `"md-icon-download"` |
| Rel | `field_pb_cta_rel` | `"nofollow noopener sponsored"` |

## Affiliate Tags

| Store | Tag | URL Pattern |
|-------|-----|-------------|
| Amazon.com | `gtorg0f-20` | `amazon.com/dp/{ASIN}/?tag=gtorg0f-20` |
| Amazon.in | `gaurtiwa-21` | `amazon.in/s?k={Keywords}&tag=gaurtiwa-21` |

## Output

1. Generate the block comment markup
2. Copy to clipboard: `echo 'BLOCK_MARKUP' | pbcopy`
3. Show the user a summary of what was extracted
