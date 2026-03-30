---
name: seo-rank
description: Comprehensive 2026 SEO audit and optimization. Use when user runs `/seo-rank`, asks to "audit SEO", "check SEO", "optimize for Google", "fix technical SEO", "improve rankings", "check Core Web Vitals", "audit site structure", "fix crawlability", or needs SEO analysis for any web page or site. Complements ai-rank (LLM/agent optimization) — use both together for full search visibility.
---

# SEO Rank Optimizer (2026 Standards)

Audit and optimize web content for traditional search engines (Google, Bing) covering content quality, technical performance, architecture, crawlability, and off-page signals.

**Companion skill:** Use `/ai-rank` for LLM answer engine and AI agent optimization. Use both together for complete search visibility across traditional and AI-powered search.

## Two Frameworks

### SEARCH Framework (Content SEO)
Everything about the content itself — what humans and crawlers read.

### TECH Framework (Technical SEO)
Everything about the infrastructure — how crawlers access, parse, and index.

---

## SEARCH Framework (Content SEO)

### S - Search Intent Alignment
- Classify intent: informational / navigational / transactional / commercial investigation
- Match content format to intent (listicle vs product page vs guide vs comparison)
- Target one primary intent per page; secondary intents get their own pages
- Check SERP features for target queries (featured snippets, PAA, video carousel)
- Analyze top 5 ranking pages to understand what Google rewards for this query

### E - E-E-A-T Signals
- **Experience**: First-person accounts, case studies, screenshots, real usage evidence
- **Expertise**: Author bios with credentials, technical depth, accurate terminology
- **Authoritativeness**: Citations from authoritative sources, industry recognition, backlinks from trusted domains
- **Trustworthiness**: Accurate claims, updated dates, corrections policy, HTTPS, clear contact info, privacy policy
- Author schema markup (Person JSON-LD linked from Article schema)
- Sites demonstrating strong E-E-A-T saw 23% gains after recent core updates

### A - Audience-Centered Quality
- Content originality (not rehashed from competitors)
- Depth appropriate to topic (comprehensive but not padded)
- Reading level matched to audience
- Multimedia support (images, diagrams, video where appropriate)
- User engagement signals: clear above-fold value, scannable structure
- Internal links to keep users exploring (reduces bounce rate)
- No thin content pages (every page must justify its existence)

### R - Relevance & Keywords
- Primary keyword in H1, title tag, meta description, first 100 words, URL slug
- Semantic keyword cluster (related terms, synonyms, LSI) distributed naturally
- Keyword density: natural usage, no stuffing (aim for topical coverage, not repetition)
- Long-tail variations addressed in H2/H3 subheadings
- Content gap analysis vs top 5 ranking pages
- Move beyond keywords to topic authority — cover the full topic comprehensively

### C - CTR Optimization
- Title tag: primary keyword + emotional/power word + brand, under 60 chars
- Meta description: action-oriented, includes keyword, under 155 chars
- URL slug: short, keyword-rich, hyphenated, no dates or IDs
- Structured data for rich results (FAQ, HowTo, Review, Breadcrumb)
- Open Graph tags (og:title, og:description, og:image, og:url, og:type)
- Twitter Card tags (twitter:card, twitter:title, twitter:description, twitter:image)

### H - Heading Hierarchy & Structure
- Single H1 per page matching primary keyword intent
- H2s for major sections matching secondary queries
- H3s for subsections; never skip levels (H1 > H2 > H3)
- Table of contents for content over 1500 words
- FAQ section with question-format headings for PAA targeting
- Lists, tables, steps over wall-of-text paragraphs
- Key takeaways or TL;DR section

---

## TECH Framework (Technical SEO)

### T - Time to Interactive (Core Web Vitals)

The three metrics Google uses as ranking signals (measured at 75th percentile):

- **LCP < 2.5s** (Largest Contentful Paint) — optimize hero images, server response time, critical CSS inlining
- **INP < 200ms** (Interaction to Next Paint — replaced FID in March 2024) — minimize JS execution, yield to main thread, break long tasks
- **CLS < 0.1** (Cumulative Layout Shift) — set explicit width/height on images/embeds, avoid dynamic injection above fold, use font-display: swap

**Business impact:** Sites passing all three CWV thresholds see 24% lower bounce rates. Pages loading under 2s have 9% bounce rate; over 5s reaches 38%.

**Audit commands:**
```bash
# Full Lighthouse performance audit
npx lighthouse <url> --output=json --only-categories=performance --chrome-flags="--headless"

# Quick CWV via PageSpeed Insights API (no install)
curl -s "https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=<encoded-url>&strategy=mobile"
```

### E - Efficient Crawling

- **robots.txt**: allow critical paths, block parameter URLs, admin panels, internal search results
- **sitemap.xml**: all indexable URLs, accurate lastmod dates, under 50K URLs per file (use sitemap index for larger sites)
- **Canonical URLs**: self-referencing on every page; point duplicates to the canonical version
- **Crawl budget**: no infinite scroll traps, handle faceted navigation with noindex or canonical
- **HTTP status codes**: no soft 404s, proper 301 redirects, no redirect chains > 2 hops
- **Index budget**: ensure important pages are crawlable, noindex low-value pages (tag archives, search results)

**Audit commands:**
```bash
# Fetch robots.txt
curl -s <domain>/robots.txt

# Fetch sitemap
curl -s <domain>/sitemap.xml | head -100

# Check redirect chain
curl -sIL <url> | grep -E 'HTTP/|Location:'

# Check canonical
curl -s <url> | grep -i 'rel="canonical"'

# Check for noindex
curl -s <url> | grep -i 'noindex'
curl -sI <url> | grep -i 'x-robots-tag'
```

### C - Code & Rendering

- Server-side rendering or static HTML (no critical content behind client-side JS only)
- Semantic HTML5 elements (`<header>`, `<main>`, `<article>`, `<section>`, `<nav>`, `<footer>`)
- Clean DOM: avoid excessive nesting, keep DOM nodes under 1500
- CSS and JS minified and bundled; critical CSS inlined
- Image optimization: WebP/AVIF format, responsive `srcset`, lazy loading below fold, explicit `width`/`height`
- Font optimization: `font-display: swap`, preload critical fonts, subset if possible
- No unused CSS/JS shipped to client
- HTTP/2 or HTTP/3 enabled
- Gzip or Brotli compression enabled

### H - HTTPS & Security

HTTPS is table stakes. Security headers provide indirect SEO benefit through performance, trust, and reduced bounce from browser warnings.

| Header | Recommended Value |
|--------|-------------------|
| Strict-Transport-Security | `max-age=31536000; includeSubDomains` |
| Content-Security-Policy | Restrict to known sources |
| X-Frame-Options | `DENY` or `SAMEORIGIN` |
| X-Content-Type-Options | `nosniff` |
| Referrer-Policy | `strict-origin-when-cross-origin` |
| Permissions-Policy | Restrict unnecessary APIs |

**Audit command:**
```bash
# Check all security headers
curl -sI <url> | grep -iE 'strict-transport|content-security|x-frame|x-content-type|referrer-policy|permissions-policy'
```

### N - Navigation & Architecture

- Flat URL hierarchy: max 3 clicks from homepage to any page
- Logical URL structure: `/category/subcategory/page-slug`
- Internal linking: every page linked from at least 2 other pages
- Breadcrumb navigation with BreadcrumbList JSON-LD
- HTML sitemap page for deep content discovery
- Pagination: `rel="next"`/`rel="prev"` or load-more with crawlable fallback
- No orphan pages (pages not linked from anywhere)

### I - International & Localization

- hreflang tags for every language variant (including `x-default`)
- **Critical rule**: each language version canonicalizes to ITSELF, never to a "master" version
- hreflang return links (if page A points to page B, B must point back to A)
- URL structure: subdirectory (`/en/`, `/es/`) preferred over subdomains or ccTLDs
- Content localization (not just machine translation) — local examples, currency, cultural references
- Language attribute on `<html>` tag per page
- Google Search Console geotargeting if applicable

**Audit command:**
```bash
# Check hreflang tags
curl -s <url> | grep -i 'hreflang'
```

### C - Compliance & Accessibility (SEO Overlap)

WCAG-compliant sites gain 23% more organic traffic and rank for 27% more keywords (2026 studies). Key overlaps with SEO:

- Alt text on all images (descriptive, not keyword-stuffed)
- Heading hierarchy with no skipped levels (H1 > H2 > H3, never H1 > H3)
- Tap targets minimum 48x48px on mobile
- Font size minimum 16px body text
- Color contrast ratio >= 4.5:1 (WCAG AA)
- Landmark roles (`<main>`, `<nav>`, `<header>`, `<footer>`) for screen readers and crawlers
- Language attribute on `<html>` tag
- Descriptive link anchor text (not "click here")
- Skip navigation links

**Audit command:**
```bash
# Lighthouse accessibility audit
npx lighthouse <url> --output=json --only-categories=accessibility --chrome-flags="--headless"
```

### A - AI & Structured Data

JSON-LD schema on every page. Match schema type to page type:

| Page Type | Schema Types |
|-----------|-------------|
| Homepage | Organization, WebSite (with SearchAction) |
| Blog post | Article, BreadcrumbList |
| Product page | Product (with Offer), BreadcrumbList |
| FAQ page | FAQPage, BreadcrumbList |
| How-to guide | HowTo, BreadcrumbList |
| Author page | Person |
| Local business | LocalBusiness (with geo) |

**Validation:** Google Rich Results Test or `npx structured-data-testing-tool <url>`

**For AI/SGE readiness:** Run `/ai-rank` for LLM answer engine optimization, discovery files (llms.txt, agents.txt), and AI crawler access configuration. Do not duplicate that work here.

**Audit command:**
```bash
# Extract JSON-LD from page
curl -s <url> | grep -oP '<script type="application/ld\+json">.*?</script>' | sed 's/<[^>]*>//g'
```

### L - Local SEO (If Applicable)

Skip this section for purely online businesses with no physical presence.

- Google Business Profile: claimed, verified, all fields complete
- NAP consistency (Name, Address, Phone) identical across all citations
- LocalBusiness JSON-LD schema with geo coordinates
- Local content: city/region pages if serving multiple areas
- Google reviews: structured review markup, link to review page
- Local citations: industry directories, Chamber of Commerce, Yelp, etc.
- Service area defined if not storefront

---

## Scoring Matrices

### Page-Level SEO Score

| Category | Weight | Criteria | Score 0-5 |
|----------|--------|----------|-----------|
| **Search Intent** | 15% | Intent match, format match, SERP feature alignment | |
| **E-E-A-T** | 15% | Author signals, citations, trust, experience evidence | |
| **Content Quality** | 15% | Originality, depth, readability, multimedia | |
| **Keywords & Relevance** | 10% | Primary in H1/title/URL, semantic cluster, no stuffing | |
| **CTR Elements** | 10% | Title tag, meta description, URL slug, rich results | |
| **Structure & Headings** | 10% | Heading hierarchy, ToC, FAQ, scannable format | |
| **Core Web Vitals** | 10% | LCP, INP, CLS within thresholds | |
| **Technical (per page)** | 10% | Canonical, schema, mobile-friendly, images | |
| **Accessibility** | 5% | Alt text, tap targets, contrast, semantic HTML | |

**Scoring guide:**
- 0 = Missing entirely
- 1 = Present but critically flawed
- 2 = Below standard, major issues
- 3 = Meets minimum standard
- 4 = Good, minor improvements possible
- 5 = Excellent, best-practice implementation

**Compute the weighted score: sum of (score x weight). Max = 5.0**

| Range | Rating | Action |
|-------|--------|--------|
| 4.5-5.0 | Excellent | Minor polish only |
| 3.5-4.4 | Good | Targeted improvements |
| 2.5-3.4 | Needs Work | Significant gaps to address |
| 1.5-2.4 | Poor | Major overhaul needed |
| 0-1.4 | Critical | Fundamental issues |

### Site-Level SEO Score

| Category | Weight | Criteria | Score 0-5 |
|----------|--------|----------|-----------|
| **Crawlability** | 20% | robots.txt, sitemap, canonical, no crawl traps | |
| **Architecture** | 20% | URL structure, internal linking, breadcrumbs, depth | |
| **Performance** | 15% | CWV across sample pages, TTFB, caching, compression | |
| **Security** | 10% | HTTPS, HSTS, CSP, X-Frame-Options | |
| **Structured Data** | 10% | JSON-LD coverage, validation, correct schema types | |
| **International** | 10% | hreflang, localization, canonical coordination | |
| **Accessibility** | 10% | Site-wide a11y patterns, landmark roles, alt text | |
| **Off-Page** | 5% | Backlink quality, brand mentions, citations | |

**Compute both weighted scores, then the combined SEO Rank Score: (SEARCH score + TECH score) / 2**

**Always present the final score prominently at the top of every audit report. This is mandatory.**

---

## Master Checklists

### Page-Level Checklist

#### Content & Intent
- [ ] Primary keyword in H1, title tag, meta description, URL slug, first 100 words
- [ ] Search intent correctly identified and matched (informational/transactional/etc.)
- [ ] Content format matches SERP expectations for target query
- [ ] Single H1 per page
- [ ] H2/H3 hierarchy correct (no skipped levels)
- [ ] Author byline with credentials (E-E-A-T)
- [ ] Published date and last-updated date visible
- [ ] Citations for external claims (links to primary sources)
- [ ] Original insight, data, or perspective (not rehashed)
- [ ] FAQ section with question-format headings (if applicable)
- [ ] Table of contents for content over 1500 words
- [ ] No thin content — page justifies its existence

#### Title & Meta
- [ ] Title tag under 60 characters, includes primary keyword
- [ ] Meta description under 155 characters, action-oriented, includes keyword
- [ ] URL slug: short, lowercase, hyphenated, keyword-rich
- [ ] Open Graph tags (og:title, og:description, og:image, og:url)
- [ ] Twitter Card tags (twitter:card, twitter:title, twitter:description, twitter:image)

#### Technical (Per Page)
- [ ] Canonical URL present (self-referencing or to canonical version)
- [ ] Mobile-friendly layout (responsive, no horizontal scroll)
- [ ] Images: WebP/AVIF, srcset for responsive, width/height attributes, lazy loading below fold
- [ ] Alt text on all images (descriptive, not keyword-stuffed)
- [ ] No render-blocking JS for critical content
- [ ] LCP element loads under 2.5s
- [ ] No CLS-causing elements (images without dimensions, dynamic ads above fold)
- [ ] INP under 200ms (no long JS tasks blocking interaction)

#### Structured Data (Per Page)
- [ ] Appropriate JSON-LD schema for page type (Article, Product, FAQPage, HowTo)
- [ ] BreadcrumbList JSON-LD
- [ ] Schema validates in Google Rich Results Test
- [ ] No schema spam (markup matches visible content)

#### Accessibility (Per Page)
- [ ] All images have alt text
- [ ] Heading hierarchy sequential (no skipping H2 to H4)
- [ ] Links have descriptive anchor text (not "click here")
- [ ] Color contrast ratio >= 4.5:1
- [ ] Tap targets >= 48x48px on mobile
- [ ] Language attribute on `<html>` tag

#### International (If Multi-Language)
- [ ] hreflang tag for each language variant
- [ ] x-default hreflang pointing to default version
- [ ] Canonical URL is self-referencing (not cross-language)
- [ ] Content is localized (not just machine-translated)
- [ ] hreflang return links present (bidirectional)

---

### Site-Level Checklist

#### Crawlability
- [ ] robots.txt exists, is valid, and allows Googlebot/Bingbot on critical paths
- [ ] robots.txt blocks admin, parameter URLs, internal search results
- [ ] sitemap.xml exists, is valid, submitted to Google Search Console
- [ ] sitemap.xml has accurate lastmod dates (not all the same date)
- [ ] sitemap.xml includes all indexable pages, excludes noindex pages
- [ ] No orphan pages (pages not linked from anywhere)
- [ ] No redirect chains longer than 2 hops
- [ ] No soft 404s (200 status on error pages)
- [ ] 404 page returns proper 404 HTTP status code
- [ ] No crawl traps (infinite scroll, faceted navigation generating infinite URLs)

#### Architecture
- [ ] URL structure is logical and hierarchical
- [ ] All pages reachable within 3 clicks from homepage
- [ ] Internal linking: contextual links between related content
- [ ] Breadcrumb navigation on all pages below homepage
- [ ] HTML sitemap page (for deep sites with 50+ pages)
- [ ] Pagination implemented correctly

#### Performance
- [ ] TTFB under 600ms (server response time)
- [ ] HTTP/2 or HTTP/3 enabled
- [ ] Gzip or Brotli compression enabled
- [ ] Browser caching headers set (Cache-Control, ETag)
- [ ] CDN for static assets
- [ ] No unused CSS/JS shipped to client
- [ ] `font-display: swap` on all custom fonts
- [ ] Preconnect to critical third-party origins

#### Security
- [ ] Valid SSL certificate, not expiring within 30 days
- [ ] HSTS header: `max-age=31536000; includeSubDomains`
- [ ] Content-Security-Policy header configured
- [ ] X-Frame-Options: DENY or SAMEORIGIN
- [ ] X-Content-Type-Options: nosniff
- [ ] Referrer-Policy set
- [ ] No mixed content (HTTP resources on HTTPS pages)

#### Structured Data (Site-Wide)
- [ ] Organization JSON-LD on homepage
- [ ] WebSite JSON-LD with SearchAction on homepage
- [ ] BreadcrumbList on all subpages
- [ ] Appropriate schema on every content page
- [ ] No schema validation errors across the site

#### International (Site-Wide)
- [ ] Consistent hreflang implementation across all pages
- [ ] hreflang return links verified (bidirectional)
- [ ] x-default set on all pages
- [ ] Language switcher links match hreflang URLs
- [ ] Google Search Console geotargeting set if applicable

#### Off-Page
- [ ] Google Search Console verified and monitored
- [ ] Bing Webmaster Tools verified
- [ ] Backlink profile reviewed: no toxic/spammy links (disavow if needed)
- [ ] Brand mentions reclaimed (unlinked mentions → linked)
- [ ] Key industry directories and citations claimed
- [ ] Social profiles linked from site (Organization schema sameAs)

---

## CLI Commands Reference

Quick reference for all audit commands Claude Code can run:

### Performance
```bash
# Full Lighthouse audit (all categories)
npx lighthouse <url> --output=json --only-categories=performance,accessibility,seo,best-practices --chrome-flags="--headless"

# CWV only
npx lighthouse <url> --output=json --only-categories=performance --chrome-flags="--headless"

# PageSpeed Insights API (no install needed)
curl -s "https://www.googleapis.com/pagespeedonline/v5/runPagespeed?url=<encoded-url>&strategy=mobile"
```

### Crawlability
```bash
# robots.txt
curl -s <domain>/robots.txt

# sitemap.xml
curl -s <domain>/sitemap.xml | head -100

# Redirect chain
curl -sIL <url> | grep -E 'HTTP/|Location:'

# Canonical tag
curl -s <url> | grep -i 'rel="canonical"'

# Noindex check
curl -s <url> | grep -i 'noindex'
curl -sI <url> | grep -i 'x-robots-tag'

# Hreflang tags
curl -s <url> | grep -i 'hreflang'
```

### Security Headers
```bash
curl -sI <url> | grep -iE 'strict-transport|content-security|x-frame|x-content-type|referrer-policy|permissions-policy'
```

### Structured Data
```bash
# Extract JSON-LD
curl -s <url> | grep -oP '<script type="application/ld\+json">.*?</script>' | sed 's/<[^>]*>//g'
```

### Meta Tags & Content
```bash
# Extract key meta tags
curl -s <url> | grep -iE '<title>|meta name="description"|<h1|og:|twitter:'

# Count headings by level
curl -s <url> | grep -oiE '<h[1-6][^>]*>' | sort | uniq -c | sort -rn

# Images missing alt text
curl -s <url> | grep -oiE '<img [^>]*>' | grep -v 'alt=' | wc -l

# Total images
curl -s <url> | grep -oiE '<img [^>]*>' | wc -l

# Viewport meta tag
curl -s <url> | grep -i 'viewport'
```

### Local Source Analysis (SSG/Astro Sites)
```bash
# Check for missing alt text in source
grep -rn '<img' src/ | grep -v 'alt=' | head -20

# Missing meta descriptions in frontmatter
grep -rL 'description:' src/content/posts/

# Validate heading hierarchy in markdown
grep -n '^#' src/content/posts/<file>.md
```

---

## Workflow

### Phase 1: Gather Context

Ask user for:

1. **Scope**: Single page URL/file, or full site audit?
2. **Target keywords**: 3-10 primary queries to rank for
3. **Content type**: Blog / Landing page / Product / Docs / E-commerce
4. **Competitors**: Top 2-3 competing URLs (optional, for gap analysis)
5. **International**: Multi-language? Which languages?
6. **Local**: Is local SEO relevant? (physical location, service area)
7. **Access**: Can I run CLI commands against the live URL, or local files only?
8. **Known issues**: Any existing penalties, ranking drops, or known problems?

### Phase 2: Technical Audit

Run automated checks first (fast, objective):

1. Fetch and inspect robots.txt and sitemap.xml
2. Run Lighthouse for CWV, performance, accessibility, SEO scores
3. Check security headers via curl
4. Extract structured data and validate
5. Check meta tags, canonical, hreflang
6. Check HTTP status codes and redirect chains

**Output:** TECH Framework scorecard with specific findings per pillar.

### Phase 3: Content Audit

Analyze content quality (requires reading the page):

1. Identify search intent for target keywords
2. Evaluate E-E-A-T signals in content
3. Analyze keyword usage — H1, title, meta description, body, URL
4. Check heading hierarchy and content structure
5. Assess content quality — originality, depth, accuracy
6. Review CTR elements — title tag, meta description, URL slug

**Output:** SEARCH Framework scorecard with specific findings per pillar.

### Phase 4: Generate Recommendations

Prioritize by impact and effort:

#### Quick Wins (fix today)
- Missing meta descriptions
- Broken canonical tags
- Missing alt text
- Schema markup additions
- Security header fixes
- Title tag optimization

#### Medium Effort (this week)
- Content rewriting for intent alignment
- Internal linking improvements
- Image optimization (format, sizing, lazy loading)
- Heading hierarchy fixes
- hreflang corrections

#### Strategic (this month)
- Content gap creation (new pages for uncovered keywords)
- Architecture restructuring
- Performance optimization (code splitting, CDN, caching)
- Backlink outreach
- International SEO implementation

### Phase 5: Implementation

For each recommendation:
1. Show current state (what's wrong)
2. Show target state (what it should be)
3. Provide the exact code/content change
4. For content: produce rewritten text preserving voice (reference `/tone-of-voice` if available)
5. For technical: produce code snippet or config change

### Phase 6: Site-Level Review

After page-level work, assess site-wide:
1. Run Site-Level Checklist
2. Cross-check with `/ai-rank` site-level items (discovery files, AI crawler access)
3. Generate missing structured data templates
4. Identify site architecture improvements
5. Produce sitemap.xml or robots.txt improvements if needed
6. Review off-page signals and recommend actions

---

## Audit Report Template

```markdown
## SEO Audit Report — [URL or Site Name]
**Date:** [date]
**Audited by:** Claude Code (seo-rank skill)

### Score

**You MUST compute and present this score. It is not optional.**

SEO RANK SCORE: X.X / 5.0 (Rating)
├── SEARCH Score: X.X / 5.0 (Content SEO)
└── TECH Score:   X.X / 5.0 (Technical SEO)

### Executive Summary
- Critical issues: [count]
- Quick wins available: [count]
- Estimated impact: [high/medium/low]

### SEARCH Framework Scores (Content SEO)
| Principle | Score 0-5 | Key Issues |
|-----------|-----------|------------|
| S - Search Intent | | |
| E - E-E-A-T | | |
| A - Audience Quality | | |
| R - Relevance & Keywords | | |
| C - CTR Elements | | |
| H - Heading & Structure | | |
| **Weighted Average** | **X.X** | |

### TECH Framework Scores (Technical SEO)
| Pillar | Score 0-5 | Key Issues |
|--------|-----------|------------|
| T - Core Web Vitals | | |
| E - Efficient Crawling | | |
| C - Code & Rendering | | |
| H - HTTPS & Security | | |
| N - Navigation & Architecture | | |
| I - International | | |
| C - Compliance & Accessibility | | |
| A - AI & Structured Data | | |
| L - Local SEO | | |
| **Weighted Average** | **X.X** | |

### Core Web Vitals
| Metric | Value | Threshold | Status |
|--------|-------|-----------|--------|
| LCP | Xs | < 2.5s | PASS/FAIL |
| INP | Xms | < 200ms | PASS/FAIL |
| CLS | X.XX | < 0.1 | PASS/FAIL |

### Security Headers
| Header | Status | Value |
|--------|--------|-------|
| HSTS | PRESENT/MISSING | |
| CSP | PRESENT/MISSING | |
| X-Frame-Options | PRESENT/MISSING | |
| X-Content-Type-Options | PRESENT/MISSING | |
| Referrer-Policy | PRESENT/MISSING | |

### Prioritized Recommendations

#### Quick Wins (fix today)
1. ...

#### Medium Effort (this week)
1. ...

#### Strategic (this month)
1. ...

### Cross-Reference
- Run `/ai-rank audit` for LLM answer engine and AI agent optimization
- Run `/ai-rank discovery` to generate llms.txt, agents.txt
```

---

## Examples

### Example 1: Blog Post SEO Audit (Markdown/Astro)

**Input:** User runs `/seo-rank` on a markdown blog post

**Before (frontmatter):**
```yaml
---
title: "Flag Theory Guide"
description: "A guide about flag theory"
publishDate: 2026-01-15
tags: ["flag-theory"]
---
```

**Issues found:**
- Title: generic, doesn't match search intent, missing qualifier
- Description: too short, not action-oriented, no value proposition
- No updatedDate (E-E-A-T freshness signal)
- Tags too narrow (missing semantic variations)

**After (optimized):**
```yaml
---
title: "Flag Theory for Digital Nomads: The 2026 Practical Guide"
description: "Learn flag theory basics: residency, banking, incorporation across jurisdictions. Step-by-step for online entrepreneurs saving 30-45% on taxes legally."
publishDate: 2026-01-15
updatedDate: 2026-03-30
tags: ["flag-theory", "tax-optimization", "digital-nomad", "international-business"]
---
```

**Why this works:**
- Title matches intent query "flag theory guide" + qualifier "digital nomads" + freshness "2026"
- Description: 155 chars, action-oriented ("Learn"), specific numbers ("30-45%"), audience-targeted
- updatedDate signals freshness to crawlers
- Broader tag coverage for semantic relevance

---

### Example 2: Technical Quick Audit

**Input:** `/seo-rank tech https://example.com`

**Claude runs:**
```bash
curl -sI https://example.com | grep -iE 'strict-transport|content-security|x-frame|x-content-type|referrer-policy'
curl -s https://example.com/robots.txt
curl -s https://example.com/sitemap.xml | head -50
curl -s https://example.com | grep -i 'rel="canonical"'
npx lighthouse https://example.com --output=json --only-categories=performance --chrome-flags="--headless"
```

**Output:** TECH scorecard with CWV numbers, security header status, crawlability findings, and prioritized fixes with exact code.

---

### Example 3: International SEO Audit (Multi-Language Astro Site)

**Input:** `/seo-rank i18n` on an Astro site with `/en/`, `/es/`, `/fr/`, `/it/` routes

**Checks performed:**
1. hreflang tag presence on every page variant
2. hreflang return links (bidirectional verification)
3. x-default set correctly
4. Canonical URLs self-referencing within each language (not cross-language)
5. Content localization quality (not just machine translation)
6. Language attribute on `<html>` tag per route
7. sitemap.xml includes all language variants
8. URL structure consistency across languages

**Common findings:**
- Spanish page canonical pointing to English page (breaks hreflang)
- Missing x-default on some pages
- hreflang tags present in HTML but not in sitemap
- Some pages missing from certain language variants (incomplete translation coverage)

---

### Example 4: Content vs Competitor Gap Analysis

**Input:** `/seo-rank compare https://mysite.com/guide https://competitor.com/guide`

**Analysis:**
1. Extract both pages' H1, H2 structure, word count, schema types
2. Compare keyword coverage (which terms competitor covers that we don't)
3. Compare E-E-A-T signals (author bios, citations, dates)
4. Compare structured data (schema types, completeness)
5. Compare CWV scores (Lighthouse both URLs)
6. Produce gap report with specific additions to close gaps

---

## Safety & Quality Rules

- **Never fabricate metrics** — if Lighthouse can't run, say so; don't invent scores
- **Verify before recommending** — check current state before suggesting changes
- **Don't over-optimize** — keyword stuffing is worse than under-optimization
- **Preserve content voice** — SEO optimization must not flatten the author's style. Reference `/tone-of-voice` if available
- **Flag uncertainty** — if a recommendation depends on server config you can't check, mark with `[NEEDS SERVER ACCESS]`
- **Prioritize by impact** — always lead with highest-impact, lowest-effort changes
- **2026 standards only** — INP not FID, mobile-first as default, no outdated advice (no meta keywords, no keyword density targets)
- **No black hat** — no hidden text, cloaking, link schemes, doorway pages, or manipulation
- **No speculation on algorithm** — state what Google has confirmed; flag unconfirmed signals as "widely believed but unconfirmed"

---

## Quick Commands

- `/seo-rank` — Full workflow (gather context → audit → recommendations → implementation)
- `/seo-rank audit` — Full audit only (SEARCH + TECH scores), no rewriting
- `/seo-rank tech` — Technical audit only (CWV, security, crawlability, structured data)
- `/seo-rank content` — Content audit only (intent, E-E-A-T, keywords, structure)
- `/seo-rank cwv` — Core Web Vitals check only (LCP, INP, CLS)
- `/seo-rank headers` — Security headers check only
- `/seo-rank schema` — Structured data audit + generate missing JSON-LD
- `/seo-rank meta` — Title tag, meta description, OG tags audit + suggestions
- `/seo-rank i18n` — International SEO audit (hreflang, localization)
- `/seo-rank local` — Local SEO audit (GBP, NAP, local schema)
- `/seo-rank checklist` — Output full page + site checklists
- `/seo-rank site` — Site-level audit (architecture, crawlability, sitemap, robots.txt)
- `/seo-rank compare <url1> <url2>` — Compare two pages for the same target keyword
