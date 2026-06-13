# Pattern Index

Ready-to-use Bricks JSON. Two formats:

- **Clipboard** files (`"source": "bricksCopiedElements"`) — copy file contents, paste into the builder structure panel (Cmd/Ctrl+V).
- **Template** files (`"type": "header" | "footer" | "popup"`) — import via Bricks → Templates → Import.

| File | Format | Demonstrates |
|------|--------|--------------|
| [hero-centered.json](hero-centered.json) | clipboard | Dark hero, radial gradient overlay, pill eyebrow, clamp() type, dual CTAs, mobile stacking |
| [hero-split-image.json](hero-split-image.json) | clipboard | Two-column hero, asymmetric widths, entrance animation on media, social proof line |
| [logo-strip.json](logo-strip.json) | clipboard | auto-fit grid, grayscale hover filter via global class |
| [feature-grid.json](feature-grid.json) | clipboard | 3→2→1 responsive grid, card + icon global classes, staggered enterView reveals |
| [pricing-table.json](pricing-table.json) | clipboard | 3 tiers, featured card with absolute badge, list element, shared classes, anchor `_cssId` |
| [testimonials-slider.json](testimonials-slider.json) | clipboard | slider-nested (splide) with autoplay/loop, responsive perPage, dark section |
| [faq-accordion.json](faq-accordion.json) | clipboard | accordion-nested with required `_hidden` structural classes, `faqSchema` JSON-LD |
| [cta-section.json](cta-section.json) | clipboard | Gradient CTA card, zoomIn reveal, hover lift button |
| [contact-section.json](contact-section.json) | clipboard | Form element with fields/actions/email template, info column with icon-boxes |
| [team-grid-acf.json](team-grid-acf.json) | clipboard | ACF repeater query loop (`acf_team_members`), dynamic image + `@fallback` |
| [blog-archive-filters.json](blog-archive-filters.json) | clipboard | Query loop + live search + taxonomy filter + sort + results summary + AJAX pagination |
| [bem-hero.json](bem-hero.json) | clipboard | **BEM test**: all styling in `hero`/`hero__*` classes + shared `btn` base with `btn--primary`/`btn--ghost` modifiers; elements carry only content |
| [bem-card-grid.json](bem-card-grid.json) | clipboard | **BEM test**: `card` base + `card--featured` modifier (stacked class ids), descendant styling via class `_cssCustom`, responsive grid inside `cards__grid` class |
| [bem-pricing.json](bem-pricing.json) | clipboard | **BEM test**: `plan`/`plan--featured`, `plan__cta`/`plan__cta--solid`, inline `<span class="plan__period">` styled from the parent class |
| [header-template.json](header-template.json) | template (header) | nav-nested + dropdown, sticky header settings, blur backdrop, slide-up-after |
| [footer-template.json](footer-template.json) | template (footer) | 4-col grid, link classes with hover, social-icons, `{current_date:Y}` copyright |
| [popup-newsletter.json](popup-newsletter.json) | template (popup) | popup settings (width/backdrop/limits), embedded form, show-once via localStorage limit |

## BEM patterns (`bem-*.json`)

These three files demonstrate the class-first workflow: **zero visual settings on elements** — every style lives in a BEM-named global class (`block__element--modifier`), applied via `_cssGlobalClasses`. Modifiers are extra class ids stacked after the base (`["bmcard", "bmcftd"]` → `card card--featured`), placed later in the `globalClasses` array so equal-specificity CSS wins. Element `label`s show the intended class names for inspection in the structure panel. Paste any two BEM files into the same site and identically named classes dedupe by name, keeping styles in sync.

## Adapting patterns

- Colors are plain hex/rgba — swap for the site's palette ids or `var(--…)` raw values.
- ACF patterns assume field names noted in element labels; rename tags to the real fields.
- Element ids are namespaced per file and regenerate on import; safe to combine multiple patterns into one page by concatenating their `content` arrays (keep ids unique) and merging `globalClasses`.
