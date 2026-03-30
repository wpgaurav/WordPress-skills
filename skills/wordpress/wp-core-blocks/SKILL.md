---
name: wp-core-blocks
description: "Complete reference for WordPress core blocks: all 113+ blocks with their attributes, supports, categories, and markup examples. Use when building layouts with core Gutenberg blocks."
compatibility: "WordPress 6.8+ (113 blocks). WordPress 6.9+ adds Accordion block."
---

# WordPress Core Blocks Reference

## When to Use

Use this skill when:
- Building layouts using WordPress core blocks
- Looking up block attributes, supports, or parent blocks
- Understanding which blocks to use for specific layouts
- Converting designs to block markup

## Block Categories

WordPress organizes blocks into 7 main categories:

| Category | Purpose | Key Blocks |
|----------|---------|------------|
| **Text** | Content and typography | Paragraph, Heading, List, Quote, Table, Code |
| **Media** | Images, video, audio | Image, Gallery, Cover, Video, Audio, File |
| **Design** | Layout and structure | Group, Columns, Row, Stack, Separator, Spacer |
| **Widgets** | Dynamic content | Archives, Calendar, Categories, Search, Latest Posts |
| **Theme** | Site structure | Navigation, Site Title, Query Loop, Post Content |
| **Embed** | External content | YouTube, Twitter, Vimeo, etc. |
| **Reusable** | Synced patterns | Pattern block |

## Layout Blocks (Design Category)

### core/group

Container block for grouping content. Most versatile layout block.

**Attributes:**
```json
{
  "tagName": "div",        // div, section, main, article, aside, header, footer
  "templateLock": false,   // false, "all", "insert", "contentOnly"
  "allowedBlocks": []      // Array of allowed block names
}
```

**Supports:**
- `align`: full, wide, left, center, right
- `background`: backgroundImage, backgroundSize
- `color`: background, gradients, text, link, heading, button
- `dimensions`: minHeight
- `spacing`: margin, padding, blockGap
- `layout`: constrained, flex, grid
- `position`: sticky

**Markup:**
```html
<!-- wp:group {"align":"full","layout":{"type":"constrained"}} -->
<div class="wp-block-group alignfull">
  <!-- Inner blocks -->
</div>
<!-- /wp:group -->
```

**With background and styles:**
```html
<!-- wp:group {"align":"full","style":{"spacing":{"padding":{"top":"4rem","bottom":"4rem"}},"color":{"background":"#f0f0f0"}}} -->
<div class="wp-block-group alignfull has-background" style="background-color:#f0f0f0;padding-top:4rem;padding-bottom:4rem">
  <!-- Inner blocks -->
</div>
<!-- /wp:group -->
```

### core/columns

Multi-column layout container. Contains core/column blocks.

**Attributes:**
```json
{
  "verticalAlignment": "center",  // top, center, bottom, stretch
  "isStackedOnMobile": true
}
```

**Supports:**
- `align`: full, wide
- `color`: background, gradients, text, link
- `spacing`: margin, padding, blockGap
- `layout`: default (flex-based)

**Markup:**
```html
<!-- wp:columns {"verticalAlignment":"center"} -->
<div class="wp-block-columns are-vertically-aligned-center">
  <!-- wp:column {"width":"33.33%"} -->
  <div class="wp-block-column" style="flex-basis:33.33%">
    <!-- Content -->
  </div>
  <!-- /wp:column -->
  <!-- wp:column {"width":"66.66%"} -->
  <div class="wp-block-column" style="flex-basis:66.66%">
    <!-- Content -->
  </div>
  <!-- /wp:column -->
</div>
<!-- /wp:columns -->
```

### core/column

Single column within columns block.

**Attributes:**
```json
{
  "verticalAlignment": "center",
  "width": "50%",
  "allowedBlocks": [],
  "templateLock": false
}
```

### core/row

Horizontal flex container. Items arranged in a row.

**Attributes:**
```json
{
  "verticalAlignment": "center",  // top, center, bottom, stretch
  "justifyContent": "left"        // left, center, right, space-between
}
```

**Markup:**
```html
<!-- wp:group {"layout":{"type":"flex","flexWrap":"nowrap","justifyContent":"space-between"}} -->
<div class="wp-block-group">
  <!-- Items arranged horizontally -->
</div>
<!-- /wp:group -->
```

### core/stack

Vertical flex container. Items stacked vertically.

**Markup:**
```html
<!-- wp:group {"layout":{"type":"flex","orientation":"vertical"}} -->
<div class="wp-block-group">
  <!-- Items stacked vertically -->
</div>
<!-- /wp:group -->
```

### core/cover

Image/video background with overlay and content.

**Attributes:**
```json
{
  "url": "image.jpg",
  "id": 123,
  "alt": "Description",
  "hasParallax": false,
  "isRepeated": false,
  "dimRatio": 50,
  "overlayColor": "black",
  "customOverlayColor": "#000000",
  "minHeight": 500,
  "minHeightUnit": "px",
  "contentPosition": "center center"
}
```

**Supports:**
- `align`: full, wide, left, center, right
- `color`: text, background (for overlay)
- `dimensions`: aspectRatio, minHeight
- `spacing`: margin, padding
- `layout`: constrained

**Markup:**
```html
<!-- wp:cover {"url":"hero.jpg","id":123,"dimRatio":50,"overlayColor":"black","minHeight":500,"align":"full"} -->
<div class="wp-block-cover alignfull" style="min-height:500px">
  <span aria-hidden="true" class="wp-block-cover__background has-black-background-color has-background-dim"></span>
  <img class="wp-block-cover__image-background wp-image-123" alt="" src="hero.jpg" data-object-fit="cover"/>
  <div class="wp-block-cover__inner-container">
    <!-- Content over image -->
  </div>
</div>
<!-- /wp:cover -->
```

### core/separator

Horizontal rule/divider.

**Attributes:**
```json
{
  "opacity": "alpha-channel"  // "alpha-channel", "css"
}
```

**Markup:**
```html
<!-- wp:separator {"className":"is-style-wide"} -->
<hr class="wp-block-separator has-alpha-channel-opacity is-style-wide"/>
<!-- /wp:separator -->
```

### core/spacer

Vertical whitespace.

**Attributes:**
```json
{
  "height": "100px"
}
```

**Markup:**
```html
<!-- wp:spacer {"height":"100px"} -->
<div style="height:100px" aria-hidden="true" class="wp-block-spacer"></div>
<!-- /wp:spacer -->
```

## Text Blocks

### core/paragraph

Standard paragraph text.

**Attributes:**
```json
{
  "content": "Text content",
  "dropCap": false,
  "placeholder": "Type / to choose a block"
}
```

**Supports:**
- `color`: background, gradients, text, link
- `spacing`: margin, padding
- `typography`: fontSize, lineHeight

**Markup:**
```html
<!-- wp:paragraph -->
<p>Your paragraph content here.</p>
<!-- /wp:paragraph -->
```

**With styling:**
```html
<!-- wp:paragraph {"style":{"typography":{"fontSize":"18px"},"color":{"text":"#333333"}}} -->
<p class="has-text-color" style="color:#333333;font-size:18px">Styled paragraph.</p>
<!-- /wp:paragraph -->
```

### core/heading

Headings h1-h6.

**Attributes:**
```json
{
  "content": "Heading Text",
  "level": 2,
  "textAlign": "center"
}
```

**Markup:**
```html
<!-- wp:heading {"level":2,"textAlign":"center"} -->
<h2 class="wp-block-heading has-text-align-center">Centered H2 Heading</h2>
<!-- /wp:heading -->
```

### core/list

Ordered or unordered lists.

**Attributes:**
```json
{
  "ordered": false,
  "start": 1,
  "reversed": false,
  "type": "1"   // For ordered: 1, A, a, I, i
}
```

**Markup:**
```html
<!-- wp:list -->
<ul class="wp-block-list">
  <!-- wp:list-item -->
  <li>First item</li>
  <!-- /wp:list-item -->
  <!-- wp:list-item -->
  <li>Second item</li>
  <!-- /wp:list-item -->
</ul>
<!-- /wp:list -->
```

### core/quote

Blockquote with optional citation.

**Attributes:**
```json
{
  "citation": "Author Name"
}
```

**Markup:**
```html
<!-- wp:quote -->
<blockquote class="wp-block-quote">
  <!-- wp:paragraph -->
  <p>Quote text here.</p>
  <!-- /wp:paragraph -->
  <cite>Author Name</cite>
</blockquote>
<!-- /wp:quote -->
```

### core/table

Data tables.

**Attributes:**
```json
{
  "hasFixedLayout": true,
  "caption": "Table caption",
  "head": [{"cells": [{"content": "Header", "tag": "th"}]}],
  "body": [{"cells": [{"content": "Cell", "tag": "td"}]}],
  "foot": []
}
```

**Markup:**
```html
<!-- wp:table {"hasFixedLayout":true} -->
<figure class="wp-block-table">
  <table class="has-fixed-layout">
    <thead>
      <tr><th>Header 1</th><th>Header 2</th></tr>
    </thead>
    <tbody>
      <tr><td>Cell 1</td><td>Cell 2</td></tr>
    </tbody>
  </table>
</figure>
<!-- /wp:table -->
```

### core/code

Code snippets without syntax highlighting.

**Markup:**
```html
<!-- wp:code -->
<pre class="wp-block-code"><code>const hello = "world";</code></pre>
<!-- /wp:code -->
```

### core/preformatted

Preformatted text preserving whitespace.

**Markup:**
```html
<!-- wp:preformatted -->
<pre class="wp-block-preformatted">  Preserves
    all   whitespace</pre>
<!-- /wp:preformatted -->
```

### core/details

Collapsible details/summary.

**Attributes:**
```json
{
  "showContent": false,
  "summary": "Click to expand"
}
```

**Markup:**
```html
<!-- wp:details -->
<details class="wp-block-details">
  <summary>Click to expand</summary>
  <!-- wp:paragraph -->
  <p>Hidden content revealed on click.</p>
  <!-- /wp:paragraph -->
</details>
<!-- /wp:details -->
```

### core/accordion (WordPress 6.9+)

Collapsible accordion sections.

**Attributes:**
```json
{
  "autoclose": false,      // Close other panels when one opens
  "headingLevel": 3,       // Heading level for accordion titles
  "iconPosition": "end",   // "start" or "end"
  "showIcon": true
}
```

**Markup:**
```html
<!-- wp:accordion {"autoclose":true} -->
<div class="wp-block-accordion">
  <!-- wp:accordion-heading -->
  <h3 class="wp-block-accordion-heading">Section Title</h3>
  <!-- /wp:accordion-heading -->
  <!-- wp:accordion-panel -->
  <div class="wp-block-accordion-panel">
    <!-- Panel content -->
  </div>
  <!-- /wp:accordion-panel -->
</div>
<!-- /wp:accordion -->
```

## Media Blocks

### core/image

Single image with optional caption and link.

**Attributes:**
```json
{
  "id": 123,
  "url": "image.jpg",
  "alt": "Description",
  "caption": "Image caption",
  "href": "link.html",
  "linkTarget": "_blank",
  "linkClass": "",
  "width": "600px",
  "height": "auto",
  "aspectRatio": "16/9",
  "scale": "cover",
  "sizeSlug": "large"
}
```

**Supports:**
- `align`: full, wide, left, center, right
- `filter`: duotone
- `shadow`
- `border`

**Markup:**
```html
<!-- wp:image {"id":123,"sizeSlug":"large","linkDestination":"none"} -->
<figure class="wp-block-image size-large">
  <img src="image.jpg" alt="Description" class="wp-image-123"/>
  <figcaption class="wp-element-caption">Caption text</figcaption>
</figure>
<!-- /wp:image -->
```

**Linked image:**
```html
<!-- wp:image {"id":123,"sizeSlug":"large","linkDestination":"custom"} -->
<figure class="wp-block-image size-large">
  <a href="https://example.com"><img src="image.jpg" alt="" class="wp-image-123"/></a>
</figure>
<!-- /wp:image -->
```

### core/gallery

Image gallery with layout options.

**Attributes:**
```json
{
  "images": [],
  "ids": [1, 2, 3],
  "columns": 3,
  "linkTo": "none",        // none, media, attachment, custom
  "sizeSlug": "large",
  "randomOrder": false
}
```

**Markup:**
```html
<!-- wp:gallery {"columns":3,"linkTo":"none"} -->
<figure class="wp-block-gallery has-nested-images columns-3 is-cropped">
  <!-- wp:image {"id":1} -->
  <figure class="wp-block-image"><img src="img1.jpg" alt="" class="wp-image-1"/></figure>
  <!-- /wp:image -->
  <!-- wp:image {"id":2} -->
  <figure class="wp-block-image"><img src="img2.jpg" alt="" class="wp-image-2"/></figure>
  <!-- /wp:image -->
</figure>
<!-- /wp:gallery -->
```

### core/video

Video player.

**Attributes:**
```json
{
  "id": 123,
  "src": "video.mp4",
  "poster": "poster.jpg",
  "caption": "Video caption",
  "autoplay": false,
  "controls": true,
  "loop": false,
  "muted": false,
  "playsInline": false,
  "preload": "metadata"
}
```

**Markup:**
```html
<!-- wp:video {"id":123} -->
<figure class="wp-block-video">
  <video controls src="video.mp4" poster="poster.jpg"></video>
</figure>
<!-- /wp:video -->
```

### core/audio

Audio player.

**Attributes:**
```json
{
  "id": 123,
  "src": "audio.mp3",
  "caption": "Audio caption",
  "autoplay": false,
  "loop": false,
  "preload": "none"
}
```

### core/file

Downloadable file with button.

**Attributes:**
```json
{
  "id": 123,
  "href": "file.pdf",
  "fileName": "Document.pdf",
  "textLinkHref": "file.pdf",
  "textLinkTarget": "",
  "showDownloadButton": true,
  "downloadButtonText": "Download"
}
```

### core/media-text

Two-column media and text layout.

**Attributes:**
```json
{
  "mediaId": 123,
  "mediaUrl": "image.jpg",
  "mediaType": "image",
  "mediaPosition": "left",   // left, right
  "mediaWidth": 50,
  "isStackedOnMobile": true,
  "verticalAlignment": "center",
  "imageFill": false
}
```

**Markup:**
```html
<!-- wp:media-text {"mediaId":123,"mediaType":"image","mediaPosition":"left"} -->
<div class="wp-block-media-text is-stacked-on-mobile">
  <figure class="wp-block-media-text__media">
    <img src="image.jpg" alt="" class="wp-image-123 size-full"/>
  </figure>
  <div class="wp-block-media-text__content">
    <!-- wp:paragraph -->
    <p>Content beside media.</p>
    <!-- /wp:paragraph -->
  </div>
</div>
<!-- /wp:media-text -->
```

## Interactive Blocks

### core/buttons

Button group container.

**Attributes:**
```json
{
  "layout": {
    "type": "flex",
    "justifyContent": "center"
  }
}
```

**Markup:**
```html
<!-- wp:buttons {"layout":{"type":"flex","justifyContent":"center"}} -->
<div class="wp-block-buttons">
  <!-- wp:button -->
  <div class="wp-block-button"><a class="wp-block-button__link wp-element-button">Click Me</a></div>
  <!-- /wp:button -->
  <!-- wp:button {"className":"is-style-outline"} -->
  <div class="wp-block-button is-style-outline"><a class="wp-block-button__link wp-element-button">Secondary</a></div>
  <!-- /wp:button -->
</div>
<!-- /wp:buttons -->
```

### core/button

Single button (must be inside core/buttons).

**Attributes:**
```json
{
  "text": "Button Text",
  "url": "https://example.com",
  "linkTarget": "_blank",
  "rel": "noopener noreferrer",
  "width": 50,             // 25, 50, 75, 100 (percentage)
  "backgroundColor": "primary",
  "textColor": "white"
}
```

**Supports:**
- `color`: background, gradients, text
- `typography`: fontSize, lineHeight
- `border`: radius, color, width
- `spacing`: padding

**Markup with custom colors:**
```html
<!-- wp:button {"backgroundColor":"primary","textColor":"white"} -->
<div class="wp-block-button">
  <a class="wp-block-button__link has-white-color has-primary-background-color has-text-color has-background wp-element-button" href="#">Primary Button</a>
</div>
<!-- /wp:button -->
```

### core/search

Search form.

**Attributes:**
```json
{
  "label": "Search",
  "showLabel": true,
  "placeholder": "Search...",
  "buttonText": "Search",
  "buttonPosition": "button-inside",  // button-inside, button-outside, no-button
  "buttonUseIcon": false,
  "width": 100,
  "widthUnit": "%"
}
```

### core/social-links

Social media icon links.

**Attributes:**
```json
{
  "iconColor": "white",
  "iconColorValue": "#ffffff",
  "iconBackgroundColor": "primary",
  "iconBackgroundColorValue": "#0073aa",
  "size": "has-normal-icon-size",
  "openInNewTab": true,
  "showLabels": false
}
```

**Markup:**
```html
<!-- wp:social-links {"iconColor":"white","iconBackgroundColor":"primary","openInNewTab":true} -->
<ul class="wp-block-social-links has-icon-color has-icon-background-color">
  <!-- wp:social-link {"url":"https://twitter.com/user","service":"twitter"} /-->
  <!-- wp:social-link {"url":"https://facebook.com/user","service":"facebook"} /-->
  <!-- wp:social-link {"url":"https://linkedin.com/in/user","service":"linkedin"} /-->
</ul>
<!-- /wp:social-links -->
```

## Query & Post Blocks (Theme Category)

### core/query

Query loop for displaying posts.

**Attributes:**
```json
{
  "queryId": 0,
  "query": {
    "perPage": 10,
    "pages": 0,
    "offset": 0,
    "postType": "post",
    "order": "desc",
    "orderBy": "date",
    "author": "",
    "search": "",
    "exclude": [],
    "sticky": "",
    "inherit": true,
    "taxQuery": null,
    "parents": []
  },
  "namespace": ""
}
```

**Markup:**
```html
<!-- wp:query {"queryId":1,"query":{"perPage":6,"postType":"post","order":"desc","orderBy":"date"}} -->
<div class="wp-block-query">
  <!-- wp:post-template -->
    <!-- wp:post-featured-image /-->
    <!-- wp:post-title {"isLink":true} /-->
    <!-- wp:post-excerpt /-->
    <!-- wp:post-date /-->
  <!-- /wp:post-template -->
  <!-- wp:query-pagination -->
    <!-- wp:query-pagination-previous /-->
    <!-- wp:query-pagination-numbers /-->
    <!-- wp:query-pagination-next /-->
  <!-- /wp:query-pagination -->
  <!-- wp:query-no-results -->
    <!-- wp:paragraph -->
    <p>No posts found.</p>
    <!-- /wp:paragraph -->
  <!-- /wp:query-no-results -->
</div>
<!-- /wp:query -->
```

### core/post-template

Template for each post in query. Contains the layout for individual posts.

### core/post-title

Displays post title.

**Attributes:**
```json
{
  "level": 2,
  "isLink": true,
  "rel": "",
  "linkTarget": "_self"
}
```

### core/post-content

Displays full post content.

### core/post-excerpt

Displays post excerpt.

**Attributes:**
```json
{
  "moreText": "Read more",
  "showMoreOnNewLine": true,
  "excerptLength": 55
}
```

### core/post-featured-image

Displays post featured image.

**Attributes:**
```json
{
  "isLink": false,
  "aspectRatio": "16/9",
  "scale": "cover",
  "sizeSlug": "post-thumbnail",
  "width": "",
  "height": ""
}
```

### core/post-date

Displays post date.

**Attributes:**
```json
{
  "format": "",
  "isLink": false
}
```

### core/post-author

Displays post author.

**Attributes:**
```json
{
  "showAvatar": true,
  "showBio": false,
  "byline": "By",
  "isLink": false,
  "avatarSize": 48
}
```

### core/post-terms

Displays post categories or tags.

**Attributes:**
```json
{
  "term": "category",   // category, post_tag, or custom taxonomy
  "separator": ", ",
  "prefix": ""
}
```

## Navigation Blocks

### core/navigation

Site navigation menu.

**Attributes:**
```json
{
  "ref": 123,              // Navigation menu post ID
  "overlayMenu": "mobile", // never, mobile, always
  "icon": "menu",          // menu, handle
  "hasIcon": true,
  "openSubmenusOnClick": false,
  "showSubmenuIcon": true
}
```

**Supports:**
- `color`: background, text, link
- `typography`: fontSize, fontFamily, fontWeight
- `spacing`: margin, padding, blockGap
- `layout`: flex

### core/navigation-link

Navigation menu item.

**Attributes:**
```json
{
  "label": "Link Text",
  "url": "/page/",
  "description": "",
  "kind": "post-type",     // post-type, custom, taxonomy
  "type": "page",
  "id": 123,
  "opensInNewTab": false,
  "isTopLevelLink": true
}
```

### core/page-list

Auto-generated list of pages.

**Attributes:**
```json
{
  "parentPageID": 0,
  "isNested": false
}
```

## Widget Blocks

### core/latest-posts

Displays recent posts.

**Attributes:**
```json
{
  "categories": [],
  "selectedAuthor": "",
  "postsToShow": 5,
  "displayPostContent": false,
  "displayPostContentRadio": "excerpt",
  "excerptLength": 55,
  "displayAuthor": false,
  "displayPostDate": false,
  "displayFeaturedImage": false,
  "featuredImageAlign": "left",
  "featuredImageSizeSlug": "thumbnail",
  "addLinkToFeaturedImage": false,
  "postLayout": "list",
  "columns": 3,
  "order": "desc",
  "orderBy": "date"
}
```

**Markup (dynamic block):**
```html
<!-- wp:latest-posts {"postsToShow":3,"displayPostDate":true,"displayFeaturedImage":true,"postLayout":"grid","columns":3} /-->
```

### core/archives

Archive links by date.

**Attributes:**
```json
{
  "displayAsDropdown": false,
  "showLabel": true,
  "showPostCounts": false,
  "type": "monthly"
}
```

### core/categories

Category list.

**Attributes:**
```json
{
  "displayAsDropdown": false,
  "showHierarchy": false,
  "showPostCounts": false,
  "showOnlyTopLevel": false,
  "showEmpty": false
}
```

### core/tag-cloud

Tag cloud.

**Attributes:**
```json
{
  "numberOfTags": 45,
  "taxonomy": "post_tag",
  "showTagCounts": false,
  "smallestFontSize": "8pt",
  "largestFontSize": "22pt"
}
```

### core/calendar

Calendar showing posts by date.

**Markup (dynamic block):**
```html
<!-- wp:calendar /-->
```

### core/rss

RSS feed display.

**Attributes:**
```json
{
  "feedURL": "https://example.com/feed/",
  "itemsToShow": 5,
  "displayExcerpt": false,
  "displayAuthor": false,
  "displayDate": false,
  "blockLayout": "list",
  "columns": 2
}
```

## Site Blocks (Theme Category)

### core/site-title

Displays site title.

**Attributes:**
```json
{
  "level": 1,
  "isLink": true,
  "linkTarget": "_self"
}
```

### core/site-tagline

Displays site tagline.

### core/site-logo

Displays site logo.

**Attributes:**
```json
{
  "width": 120,
  "isLink": true,
  "linkTarget": "_self",
  "shouldSyncIcon": true
}
```

### core/template-part

Reusable template part (header, footer, etc.).

**Attributes:**
```json
{
  "slug": "header",
  "theme": "theme-name",
  "tagName": "header",
  "area": "header"
}
```

### core/post-comments-form

Comments form.

### core/comments

Comments display.

## Common Style Attributes

All blocks support these style patterns:

### Spacing
```json
{
  "style": {
    "spacing": {
      "margin": {"top": "2rem", "bottom": "2rem"},
      "padding": {"top": "1rem", "right": "1rem", "bottom": "1rem", "left": "1rem"},
      "blockGap": "1rem"
    }
  }
}
```

### Colors
```json
{
  "style": {
    "color": {
      "background": "#ffffff",
      "text": "#333333",
      "gradient": "linear-gradient(135deg,#667eea 0%,#764ba2 100%)"
    }
  },
  "backgroundColor": "primary",    // Preset name
  "textColor": "contrast"          // Preset name
}
```

### Typography
```json
{
  "style": {
    "typography": {
      "fontSize": "1.25rem",
      "fontWeight": "600",
      "lineHeight": "1.5",
      "letterSpacing": "0.02em",
      "textTransform": "uppercase"
    }
  },
  "fontSize": "large"              // Preset name
}
```

### Border
```json
{
  "style": {
    "border": {
      "color": "#e0e0e0",
      "style": "solid",
      "width": "1px",
      "radius": "8px"
    }
  }
}
```

### Shadow
```json
{
  "style": {
    "shadow": "0 4px 6px rgba(0,0,0,0.1)"
  }
}
```

## Block Variations

Some blocks have built-in variations:

**Group variations:**
- `group` - Default constrained layout
- `group-row` - Horizontal flex layout
- `group-stack` - Vertical flex layout

**Columns variations:**
- `two-columns-equal` - 50/50 split
- `two-columns-one-third-two-thirds` - 33/66 split
- `two-columns-two-thirds-one-third` - 66/33 split
- `three-columns-equal` - 33/33/33 split

**Embed variations:**
Each embed service is a variation of core/embed (YouTube, Vimeo, Twitter, etc.)

## Dynamic vs Static Blocks

### Static Blocks
Markup saved in post content. Block validates on load.
- `core/paragraph`, `core/heading`, `core/image`, `core/group`, `core/columns`

### Dynamic Blocks
Server-rendered. Only attributes saved.
- `core/latest-posts`, `core/archives`, `core/calendar`, `core/query`
- All theme blocks (`core/site-title`, `core/post-title`, etc.)

Dynamic block markup:
```html
<!-- wp:latest-posts {"postsToShow":3} /-->
```

Static block markup:
```html
<!-- wp:paragraph -->
<p>Content here</p>
<!-- /wp:paragraph -->
```

## Resources

- [Core Blocks Reference](https://developer.wordpress.org/block-editor/reference-guides/core-blocks/)
- [Block Editor Handbook](https://developer.wordpress.org/block-editor/)
- [WordPress Block Pattern Directory](https://wordpress.org/patterns/)
- [GitHub: Gutenberg Block Library](https://github.com/WordPress/gutenberg/tree/trunk/packages/block-library)
