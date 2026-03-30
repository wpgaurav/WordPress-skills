---
name: md-theme-blocks
description: Marketers Delight (MD) theme Gutenberg blocks. 26 block references with attributes, examples, and rendering details.
---

# Marketers Delight Theme Blocks

Native Gutenberg blocks provided by the Marketers Delight WordPress theme. ES5 IIFE format (no JSX, no build step), dynamic rendering via PHP `render_callback` (`save()` returns `null`).

## How to Use

1. Read the specific block reference file before generating markup
2. Block names are prefixed with `marketers-delight/`
3. Attributes are set directly in the block comment JSON (not ACF field keys)
4. RichText fields support inline HTML (bold, links, etc.)
5. Color attributes accept hex values or WP color class names
6. Read `references/README.md` for architecture, CSS classes, icon list, and PHP helpers
7. Read `references/icons.md` for the full icon registry

## Block References

All reference files are in `references/`. Each includes: block name, attributes table, JS editor code, PHP render callback, and example output.

### Core Blocks (16)

| Block | Reference | Primary Use |
|-------|-----------|------------|
| Arrow | `arrow.md` | Scroll indicator with icon picker |
| Callout | `callout.md` | Promotional/info boxes with icons and CTAs |
| Content Upgrade | `content-upgrade.md` | Lead generation offer boxes |
| CTA | `cta.md` | Call-to-action sections |
| FAQ | `faq.md` | Accordion FAQ with Schema.org markup |
| Inline Poll | `inline-poll.md` | Interactive reader polls |
| Key Takeaway | `key-takeaway.md` | Summary/highlight boxes |
| Page Block | `page-block.md` | Custom HTML/CSS/JS code sections |
| Plugin Card | `plugin-card.md` | WordPress plugin info (WP.org API) |
| Pull Quote | `pull-quote.md` | Styled quotes with citation |
| Related Content | `related-content.md` | Internal link cards |
| Share Notice | `share-notice.md` | Quoteable text with social share |
| Side Promotion | `side-promotion.md` | Sidebar promotional panels |
| Spoiler | `spoiler.md` | Click-to-reveal hidden content |
| Steps | `steps.md` | Numbered step sequences |
| Theme Card | `theme-card.md` | WordPress theme info (WP.org API) |

### Additional Blocks

| Block | Reference | Primary Use |
|-------|-----------|------------|
| GitHub Card | `github-card.md` | GitHub repository display |
| npm Card | `npm-card.md` | npm package display |
| Book Card | `book-card.md` | Book display (Open Library) |
| YouTube Card | `youtube-card.md` | YouTube video display |
| URL Preview | `url-preview.md` | Rich link preview (OG data) |
| Podcast Card | `podcast-card.md` | Podcast episode display |

### Supporting References

| File | Content |
|------|---------|
| `README.md` | Architecture, CSS classes, icon list, components, helpers |
| `icons.md` | Full PHP icon registry with all icon names |
| `block-enhancements.md` | Block enhancement patterns |
| `block-styles.md` | Block style variations |
| `gallery-blocks.md` | Gallery block patterns |

## Key Difference from ACF Blocks

- MD blocks use `marketers-delight/block-name` namespace
- Attributes are WordPress block attributes, not ACF field keys
- No `field_` prefix — attribute names are plain (e.g., `title`, `text`, `url`)
- RichText content goes in attributes, not InnerBlocks (for most blocks)
- Dynamic rendering: `save()` returns `null`, PHP handles frontend output
