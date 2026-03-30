---
name: accessibility-audit
description: Run WCAG 2.2 accessibility audits on Builderius templates. Use when auditing page accessibility, fixing ARIA issues, checking heading hierarchy, reviewing landmark structure, or ensuring inclusive design. Requires Builderius builder connection.
---

# Builderius Accessibility Audit

Comprehensive WCAG 2.2 accessibility auditing and remediation for Builderius templates using MCP tools.

## When to Use This Skill

- Auditing a template for WCAG 2.2 Level AA compliance
- Fixing accessibility issues flagged in an audit
- Reviewing landmark structure and heading hierarchy
- Adding ARIA attributes to interactive components
- Checking Collection loops for accessible patterns
- Ensuring forms have proper labels and error handling
- Verifying image alt text coverage

## Important: Use Builderius MCP Tools

**ALWAYS use Builderius MCP tools for all operations:**

- `builderius_builder_get_state` → Get all modules, hierarchy, settings, data variables
- `builderius_builder_list_tabs` → See which template is active
- `builderius_builder_update_module_setting` → Change tag, content, css settings
- `builderius_builder_add_html_attribute` → Add aria-*, id, role attributes
- `builderius_builder_remove_html_attribute` → Remove incorrect attributes
- `builderius_builder_add_module_class` → Add CSS classes (e.g., skip-navigation)
- `builderius_builder_add_module` → Add new modules (skip links, labels, etc.)
- `builderius_builder_delete_module` → Remove inaccessible elements
- `builderius_builder_get_css_framework` → Check for focus styles, contrast variables

**NEVER search the filesystem for module data. The MCP tools are your primary data source.**

## Audit Workflow

### Phase 1: Scope & Extraction

1. **Identify the template**: Call `builderius_builder_list_tabs` to confirm which template is active.

2. **Extract full module tree**: Call `builderius_builder_get_state` to get:
   - `modules` — All module definitions with settings (tag, content, htmlAttribute, tagClass)
   - `indexes` — Parent-child hierarchy (key = parent ID, value = child ID array)
   - `indexes.root` — Top-level modules

3. **Parse the module tree**: Build the document outline by traversing `indexes` from root, reading each module's `tag` setting to understand the HTML structure.

### Phase 2: Accessibility Checks

Run all checks against the extracted module tree. For each issue found, record:
- Module ID and label
- WCAG criterion violated
- Severity (Critical / Major / Minor)
- Issue description
- Recommended fix with specific Builderius tool call

#### Check 1: Page Landmarks (WCAG 1.3.1)

Verify the template has proper landmark structure:

| Required | How to Check |
|----------|-------------|
| `<main>` exists | Find HtmlElement with `tag=main` in root modules |
| Only one `<main>` | Count modules with `tag=main` — must be exactly 1 |
| `<main>` has `id="content"` | Check `htmlAttribute` array for `{name: "id", value: "content"}` |
| Sections have `aria-labelledby` | Each `tag=section` should have `aria-labelledby` in `htmlAttribute` |
| Sections have associated headings | The `aria-labelledby` value should match an `id` on a heading child |
| `<nav>` elements have `aria-label` | Each `tag=nav` should have `aria-label` in `htmlAttribute` |
| No `aria-label` contains "navigation" | Screen readers already announce `<nav>` as navigation |

**Severity:** Section without aria-labelledby = Major. Missing main = Critical.

#### Check 2: Heading Hierarchy (WCAG 1.3.1, 2.4.6)

Traverse the module tree in document order and check:

| Rule | Severity |
|------|----------|
| Exactly one `h1` per template | Critical if missing, Major if multiple |
| No skipped levels (h1→h3 without h2) | Critical |
| Headings in logical order within each section | Major |
| Eyebrow/label text not using heading tags | Minor |
| Heading inside Collection/Template is one level below parent section | Major |

**How to check:** Collect all modules with `tag` matching `h1`–`h6`. Walk the tree in order. Verify the sequence never jumps more than one level down.

#### Check 3: Image Alt Text (WCAG 1.1.1)

For every module with `tag=img`:

| Check | How | Severity |
|-------|-----|----------|
| Has `alt` attribute | Check `htmlAttribute` for `{name: "alt"}` | Critical if missing |
| Alt text is meaningful | Value should not be empty string, filename, or "image" | Major if decorative without `alt=""` |
| Decorative images have `alt=""` | If truly decorative, `alt` should be empty string | Minor |
| Alt text doesn't duplicate adjacent text | e.g., `alt="{{post_title}}"` when title is already in an adjacent heading | Minor |

**In Collection loops:** Check the Template's img module. Alt text like `{{post_title}}` is acceptable but consider adding context: `"Movie poster for {{post_title}}"`.

#### Check 4: Link Accessibility (WCAG 2.4.4, 4.1.2)

For every module with `tag=a`:

| Check | Severity |
|-------|----------|
| Has visible text content OR aria-label | Critical if empty link |
| Link text is descriptive (not "click here", "read more" alone) | Major |
| `href` is present and not empty | Major |
| Icon-only links have aria-label | Critical |

**HtmlCode links:** Check `contentHtml` for `<a>` tags within HtmlCode modules. Verify they have accessible names, especially icon-only social media links.

#### Check 5: Button Accessibility (WCAG 4.1.2)

For every module with `tag=button`:

| Check | Severity |
|-------|----------|
| Has visible text content OR aria-label | Critical if no accessible name |
| Icon-only buttons have aria-label | Critical |
| Not using `tag=div` for clickable actions | Critical (should be button or link) |

#### Check 6: Form Accessibility (WCAG 1.3.1, 4.1.2)

For SmartForm modules and form-related HtmlElements:

| Check | Severity |
|-------|----------|
| SmartForm has `aria-label` or `aria-labelledby` | Major |
| Every `tag=input` has an associated `<label>` (via `for`/`id`) or `aria-label` | Critical |
| Every `tag=textarea` has a label | Critical |
| Every `tag=select` has a label | Critical |
| Required fields have `aria-required="true"` | Major |
| Error messages use `aria-describedby` linked to the input | Major |
| Fieldsets used for related groups with `<legend>` | Minor |

#### Check 7: ARIA Usage (WCAG 4.1.2)

Scan all modules for ARIA attributes in `htmlAttribute`:

| Check | Severity |
|-------|----------|
| No redundant roles on native elements (role="button" on `<button>`) | Minor |
| `aria-label` not duplicating visible text | Minor |
| `aria-hidden="true"` not used on focusable elements | Critical |
| `aria-expanded` paired with `aria-controls` | Major |
| `role` attributes have required ARIA properties | Major |

#### Check 8: List Semantics (WCAG 1.3.1)

| Check | Severity |
|-------|----------|
| Groups of similar items use `<ul>` or `<ol>`, not `<div>` | Major |
| Lists with `list-style: none` have `role="list"` | Minor (Safari/VoiceOver) |
| Collection loops rendering lists use `tag=ul` on Collection | Major |
| List items use `tag=li` | Major |

#### Check 9: Focus & Keyboard (WCAG 2.4.7, 2.1.1)

| Check | Severity |
|-------|----------|
| No `outline: none` without replacement focus style | Major |
| Interactive elements (links, buttons) are keyboard accessible | Critical |
| Tab order follows visual order (no positive `tabindex`) | Major |
| Modals/dialogs trap focus appropriately | Major |

**How to check:** Review entity CSS and framework CSS for focus styles. Call `get_css_framework` and search for `:focus` and `:focus-visible` rules.

#### Check 10: Skip Navigation (WCAG 2.4.1)

| Check | Severity |
|-------|----------|
| Skip link exists as first focusable element | Major |
| Skip link targets `#content` or similar main content ID | Major |
| Skip link has visible focus state (class: `skip-navigation`) | Minor |

**How to check:** Look at first child of root in `indexes`. Should be an `<a>` with `href="#content"` and class `skip-navigation`.

#### Check 11: Color & Contrast (WCAG 1.4.3, 1.4.11)

| Check | How | Severity |
|-------|-----|----------|
| No hardcoded colors | Search entity CSS for hex/rgb values instead of CSS variables | Minor |
| Color not sole indicator of meaning | Review error states, status indicators | Major |
| Framework variables used for all colors | Ensures centralized contrast control | Minor |

**Note:** Automated tools cannot fully verify contrast ratios. Flag potential issues and recommend manual testing with axe DevTools or WAVE.

#### Check 12: HtmlCode Modules (Special Attention)

HtmlCode modules inject raw HTML outside the module system. They bypass all semantic checks:

| Check | Severity |
|-------|----------|
| SVG icons have `aria-hidden="true"` if decorative | Major |
| Links within HtmlCode have accessible names | Critical |
| No interactive elements without keyboard support | Critical |
| Content is not a replacement for proper module structure | Minor |

### Phase 3: Scoring

Calculate an accessibility score (0–100):

```
Start at 100
  Critical issue: -10 points each (min 0)
  Major issue:     -5 points each
  Minor issue:     -2 points each
  Minimum score:    0
```

### Phase 4: Report

Generate a structured report:

```
=====================================================
ACCESSIBILITY AUDIT: [Template Name]
=====================================================

Score: XX/100

CRITICAL (X issues)
─────────────────────
[A11Y-C1] Missing h1 heading
  Module: (none — missing)
  WCAG: 1.3.1, 2.4.6
  Fix: Add HtmlElement tag=h1 as first child of main

[A11Y-C2] Icon-only links without accessible names
  Module: u95460baf6 "Social Links" (HtmlCode)
  WCAG: 2.4.4, 4.1.2
  Fix: Add aria-label to each <a> in contentHtml

MAJOR (X issues)
─────────────────────
[A11Y-M1] Sections missing aria-labelledby
  Modules: m_tst_section, m_sg_section, u6a1a297d7, ...
  WCAG: 1.3.1
  Fix: Add id to section heading, aria-labelledby to section

MINOR (X issues)
─────────────────────
[A11Y-m1] Movie poster alt duplicates heading
  Module: u9cedc324b "Movie Poster"
  WCAG: 1.1.1
  Fix: Change alt to "Movie poster for {{post_title}}"

=====================================================
SUMMARY
─────────────────────────────────────────────────────
Total: X issues (Y critical, Z major, W minor)
Score: XX/100

Quick Wins:
  1. Add skip navigation link (+10 pts, 2 min)
  2. Add aria-labelledby to sections (+5 pts each)
  3. Add h1 heading (+10 pts, 1 min)
=====================================================
```

### Phase 5: Fix Suggestions

For each issue, provide the exact Builderius tool call to fix it:

**Add skip navigation link:**
```
builderius_builder_add_module:
  name: HtmlElement
  label: Skip Navigation
  parentId: (root, index 0 — before Site Header)
  settings: [
    {name: "tag", value: "a"},
    {name: "href", value: "#content"},
    {name: "content", value: "Skip to content"},
    {name: "tagClass", value: ["skip-navigation"]}
  ]
```

**Add aria-labelledby to a section:**
```
builderius_builder_add_html_attribute:
  moduleId: (heading module ID)
  name: id
  value: movies-heading

builderius_builder_add_html_attribute:
  moduleId: (section module ID)
  name: aria-labelledby
  value: movies-heading
```

**Fix alt text on an image:**
```
builderius_builder_add_html_attribute:
  moduleId: u9cedc324b
  name: alt
  value: "Movie poster for {{post_title}}"
```

**Change a div to a semantic element:**
```
builderius_builder_update_module_setting:
  moduleId: m_sg_header
  name: tag
  value: header
```

### Phase 6: Apply Fixes (With Approval)

**Always ask the user before applying fixes.** Present the fix list and let them choose:

```
Which fixes would you like me to apply?

[1] Add skip navigation link (Critical fix, safe)
[2] Add h1 heading (Critical fix, safe)
[3] Add aria-labelledby to 7 sections (Major fix, safe)
[4] Change 5 header divs to <header> (Major fix, may affect CSS)
[5] Update movie poster alt text (Minor fix, safe)
[6] Fix HtmlCode social links (Critical fix, requires manual contentHtml edit)

Type numbers to apply (e.g., "1,2,3,5"), "all", or "none"
```

After applying fixes:
- Report success/failure for each
- Recalculate the score
- Show improvement

## WCAG 2.2 Quick Reference

### Level A (Must Fix)

| Criterion | Check |
|-----------|-------|
| 1.1.1 Non-text Content | Images have alt text |
| 1.3.1 Info and Relationships | Semantic HTML, headings, landmarks, labels |
| 2.1.1 Keyboard | All functionality keyboard accessible |
| 2.4.1 Bypass Blocks | Skip navigation link |
| 2.4.2 Page Titled | Template has a title |
| 2.4.4 Link Purpose | Links have descriptive text |
| 4.1.2 Name, Role, Value | Custom controls have accessible names |

### Level AA (Should Fix)

| Criterion | Check |
|-----------|-------|
| 1.4.3 Contrast Minimum | 4.5:1 text, 3:1 large text |
| 1.4.11 Non-text Contrast | 3:1 for UI components |
| 2.4.6 Headings and Labels | Descriptive headings |
| 2.4.7 Focus Visible | Visible focus indicators |
| 2.5.8 Target Size | 24x24px minimum for interactive elements |

### Level AAA (Nice to Have)

| Criterion | Check |
|-----------|-------|
| 1.4.6 Enhanced Contrast | 7:1 text ratio |
| 2.4.10 Section Headings | Sections organized with headings |
| 2.5.5 Target Size Enhanced | 44x44px for touch targets |

## Builderius-Specific Patterns

### Collection Loop Accessibility

Each item in a Collection loop should be individually identifiable:

```
Collection tag=ul (role=list, aria-label="Movies collection")
  Template
    HtmlElement tag=li
      HtmlElement tag=article (aria-label={{post_title}})
        HtmlElement tag=img (alt="Poster for {{post_title}}")
        HtmlElement tag=h3
          HtmlElement tag=a (href={{{permalink}}}, content={{post_title}})
        HtmlElement tag=p (content={{post_excerpt}})
```

### Component Module Accessibility

Component modules are transparent — they render no wrapper HTML. The accessibility attributes must be on the component's internal modules, not the Component module itself (which has no `htmlAttribute` setting).

### Interactive Modules (Tabs, Accordion, Modal)

Builderius interactive modules render as web components (`<builderius-tabs>`, `<builderius-accordion>`, etc.) with built-in keyboard handling. Verify:

- Tabs: Children have `role="tab"` and `role="tabpanel"`
- Accordion: Sections have proper `aria-expanded` states
- Modal: Has `aria-modal="true"` and focus trapping

### HtmlCode Module Risk

HtmlCode injects raw HTML that bypasses all module-level checks. **Every HtmlCode module should be manually audited** for:
- Missing `aria-label` on links
- Missing `alt` on images
- Missing `aria-hidden` on decorative content
- Interactive elements without keyboard support

## What This Skill Checks

- Landmark structure (main, nav, header, footer, section, article)
- Heading hierarchy (h1–h6 order, single h1)
- Image alt text (presence and quality)
- Link and button accessible names
- Form labels and error handling
- ARIA usage (correctness, no redundancy)
- List semantics
- Skip navigation
- Focus visibility
- Color usage (hardcoded vs. variables)
- HtmlCode module content
- Collection loop patterns

## What This Skill Does NOT Check

- Actual color contrast ratios (requires visual analysis)
- Animation/motion preferences (prefers-reduced-motion)
- Screen reader behavior (requires manual testing)
- Content readability (language level, clarity)
- Third-party embedded content
- Site Header/Footer component internals (audit those separately)

## Testing Resources

- **Automated:** axe DevTools, WAVE, Lighthouse
- **Keyboard:** Tab, Shift+Tab, Enter, Space, Escape
- **Screen readers:** VoiceOver (macOS), NVDA/JAWS (Windows), TalkBack (Android)
- **References:** [WCAG 2.2 Quick Reference](https://www.w3.org/WAI/WCAG22/quickref/), [WAI-ARIA Practices](https://www.w3.org/WAI/ARIA/apg/)
- See `references/aria-patterns.md` for ARIA implementation patterns
- See `references/wcag-checklist.md` for audit checklists
