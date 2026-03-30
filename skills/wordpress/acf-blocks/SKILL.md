---
name: acf-blocks
description: ACF custom Gutenberg blocks. 29 block types with field specs, examples, and markup patterns.
---

# ACF Blocks

Custom Advanced Custom Fields (ACF) blocks. Each block has its own reference file in `references/` with field keys, types, examples, and markup.

## How to Use

1. Read the specific block reference file before generating markup
2. Use the exact field keys shown (prefix varies: most use `field_`, CTA uses `acf_`)
3. Blocks using **InnerBlocks** wrap standard WordPress blocks (paragraphs, lists) inside them
4. Self-closing blocks (`/-->`) contain all data in the JSON attributes
5. All string values in data must be strings (even numbers: `"4.5"` not `4.5`)
6. Repeater rows use sequential keys: `row-0`, `row-1`, `row-2`

## Block Types

| Block | File | InnerBlocks? | Common Use |
|-------|------|-------------|------------|
| Accordion/FAQ | `accordion.md` | No | FAQ sections with schema |
| Callout | `callout.md` | **Yes** | Warning/tip/note boxes |
| Changelog | `changelog.md` | No | Version history |
| Checklist | `checklist.md` | No | Interactive checklists |
| Code Block | `code-block.md` | No | Syntax-highlighted code |
| Compare | `compare.md` | No | Product comparisons |
| Coupon Code | `coupon-code.md` | No | Discount codes |
| CTA | `cta.md` | **Yes** or legacy | Call-to-action boxes |
| Email Form | `email-form.md` | No | Newsletter signups |
| Feature Grid | `feature-grid.md` | No | Feature lists |
| Gallery | `gallery.md` | No | Image galleries |
| Hero | `hero.md` | No | Hero sections |
| Opinion Box | `opinion-box.md` | **Yes** | Author opinion quotes |
| Product List | `pl-block.md` | No | Product listings |
| Post Display | `post-display.md` | No | Related posts |
| Product Box | `product-box.md` | No | Single product highlight |
| Product Cards | `product-cards.md` | No | Product card grid |
| Product Review | `product-review.md` | No | Full review with rating |
| Pros & Cons | `pros-cons.md` | No | Pros/cons lists |
| Section | `section-block.md` | No | Content sections |
| Star Rating | `star-rating.md` | No | Star ratings |
| Stats | `stats.md` | No | Statistics display |
| Tabs | `tabs.md` | No | Tabbed content |
| Team Member | `team-member.md` | No | Team member cards |
| Testimonial | `testimonial.md` | No | Customer testimonials |
| Thread Builder | `thread-builder.md` | No | Social thread format |
| TOC | `toc.md` | No | Table of contents |
| URL Preview | `url-preview.md` | No | URL preview cards |
| Video | `video.md` | No | Video embeds |

## Key Patterns

### Self-closing block (no InnerBlocks)
```html
<!-- wp:acf/block-name {"name":"acf/block-name","data":{...}} /-->
```

### InnerBlocks block (callout, opinion-box, cta)
```html
<!-- wp:acf/block-name {"name":"acf/block-name","data":{...},"mode":"preview"} -->
<!-- wp:paragraph -->
<p>Content goes here as standard WordPress blocks.</p>
<!-- /wp:paragraph -->
<!-- /wp:acf/block-name -->
```

## FAQ Schema

To enable FAQ schema on accordion blocks, set `"field_acf_accord_enable_faq_schema":"1"` in the data.
