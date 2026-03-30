---
name: omm-style
description: Write WordPress performance, hosting, plugin, and SEO articles using OnlineMediaMasters methodology blended with Gaurav Tiwari's voice DNA. Data-driven, opinionated, setting-by-setting tutorials with real benchmarks.
---

# OMM-Style Writing Skill

Write articles that combine OnlineMediaMasters' ruthless data-driven approach with Gaurav Tiwari's conversational voice DNA. The result: content that feels like a practitioner who's tested everything talking to a smart friend — backed by spreadsheets, benchmarks, and years of evidence.

## Before You Start

1. Read `voice-dna.md` — every OMM technique must pass the voice check
2. Read `anti-slop/banned-phrases.md` — data-driven writing can still slip into AI patterns
3. Read `_acf-blocks-for-writing.md` — all WordPress block syntax lives there
4. Check `knowledge/affiliate-products.md` — for affiliate link URLs (`yoursite.com/go/product/`)
5. Check `knowledge/published-blog-articles.md` — for internal link targets
6. Identify the article type (settings tutorial, review, comparison, speed guide, checklist) — each has a specific template below

---

## Core Philosophy: The OMM Difference

OMM articles rank because they do what nobody else does:

1. **Test everything yourself.** No secondhand claims. No "experts say." You tested it, you measured it, you show the receipts.
2. **Name names.** Don't say "some hosting providers." Say "SiteGround, Bluehost, and Hostinger." Specificity is both voice and SEO.
3. **Have a strong opinion and state it in the first paragraph.** "Don't use either." "This is the only plugin you need." "I was dumbfounded at how slow this was." Hedge later if needed. Lead with conviction.
4. **Show the data, then explain what it means.** Screenshots, spreadsheets, benchmark results — then tell the reader why they should care.
5. **Cross-reference obsessively.** Every article links to your other tests, guides, and settings tutorials. The site is a web of evidence, not isolated posts.

### What Makes This Different From Generic "Best X" Content

| Generic Content | OMM-Style Content |
|----------------|-------------------|
| "WP Rocket is a popular caching plugin" | "WP Rocket scored 2.1s LCP on my test site. FlyingPress hit 0.8s. Same server, same theme, same content." |
| "Consider your hosting needs" | "Here's my spreadsheet comparing 62 hosting plans across 15 metrics. Specs don't lie." |
| "There are many good options" | "Use FlyingPress. Stop looking. I've tested every major cache plugin for 10+ years." |
| Lists features from the product page | Shows screenshots of actual dashboard, config, and results |
| "It depends on your situation" | "For blogs under 50k monthly visits, use X. For WooCommerce, use Y. Here's why." |

---

## Voice Blend: OMM Methodology × Gaurav's DNA

### What to take from OMM (Tom Dupuis)
- Spreadsheet-level evidence for every claim
- Setting-by-setting tutorial format with toggle states
- Anti-recommendation honesty ("Don't use X" is a valid recommendation)
- Facebook group polls and community evidence as social proof
- Affiliate transparency woven naturally into content
- Performance screenshots as opening credibility markers
- Numbered step formats with anchor-linked table of contents
- Heavy bold on setting names, product names, and key claims

### What to take from Gaurav's voice-dna
- Mentor-over-coffee tone (not internet-warrior tone)
- Ellipses for trailing thoughts, "Look," / "OK," / "Well," connectors
- Technical terms explained in the same paragraph
- Contractions mandatory (don't, won't, can't — never "do not")
- Opinions backed by technical evidence, not just frustration
- Empathy for beginners without condescension
- Short-long-short sentence rhythm
- Work-personal anecdotes (business mistakes, project failures)

### Conversational Texture Targets

OMM articles are shorter-paragraphed and faster-paced than standard blog articles, but they still need Gaurav's conversational texture. Targets per 2,000 words of OMM-style content:

| Technique | Target Count | Where It Fits Best |
|-----------|-------------|-------------------|
| Ellipses (...) | 3-4 | Setting explanations, trailing thoughts in reviews |
| Connectors (Look, OK, Well, honestly) | 2-3 | Before direct opinions, gear-shifts between sections |
| Casual asides | 3-4 | After a data point ("Yeah — that's not a typo.") |
| Rhetorical question pivots | 2-3 | Transitioning between comparison dimensions |
| End-of-thought additions | 2-3 | After verdicts ("...and I don't say that lightly.") |

Total: ~12-17 informal touches per 2,000 words. Slightly fewer than standard blog articles (16-24) because OMM's settings-heavy format leaves less room for texture — settings lines are functional, not conversational. Put the texture in the intro paragraphs, section openers, and verdict sections.

### Where OMM and Gaurav diverge — always pick Gaurav

| OMM Tendency | Gaurav Override |
|-------------|----------------|
| Profanity-adjacent ("look at the damn specs") | Keep it clean but direct ("look at the actual specs") |
| Aggressive competitor bashing | Constructive criticism with technical evidence |
| ALL CAPS for emphasis | Bold text only; caps for acronyms |
| Cease-and-desist bragging | Skip legal drama; focus on the data |
| "Cheers, Tom" sign-off | Natural ending without signature |
| "K?" and internet slang | Conversational but not slangy |
| Facebook group screenshots as evidence | Reference community data but don't screenshot-dump |

### The Blended Voice in Action

```
WRONG (pure OMM — too aggressive):
"SiteGround is garbage. I got a cease-and-desist from them for saying this.
Look at the damn specs. Shared vCPUs, limited storage, and they charge
$35.99/mo for what Cloudways gives you at $14/mo. Stop throwing your
money down the toilet."

WRONG (pure Gaurav — too soft):
"I've found SiteGround's performance doesn't quite match its reputation.
After testing several alternatives, I'd suggest looking at cloud hosting
options that might give you better value..."

RIGHT (blended):
"SiteGround's specs don't justify the price. At $35.99/month for their
GrowBig plan, you're getting shared vCPUs and 20GB storage. Cloudways
gives you dedicated resources at $14/month. I ran both for 6 months on
identical test sites. The TTFB difference was consistent: 180ms vs 420ms.

Look, SiteGround was good in 2018. The managed WordPress market has
moved on. If you're still on SiteGround, it's not a disaster — but
you're paying premium for mid-tier performance."
```

---

## Article Type Templates

### Type 1: Plugin Settings Tutorial

**The flagship OMM format.** Setting-by-setting walkthrough with toggle states, rationale, and conflict warnings.

**Title format:** `The Ideal [Plugin] Settings [Year] (With [Complementary Plugin/Context])`

**Structure:**

```
H1: The Ideal [Plugin] Settings [Year] (With [Context])

[Opening: 2-3 sentences. State what the plugin does well AND where it falls short.
Link to the complementary plugins needed for a complete setup.]

[Performance proof: Screenshot or metric showing the result of these settings.]

[Legend — only if needed:]
**ON** = Enable  |  **OFF** = Disable  |  **DEPENDS** = Read the explanation  |  **⚠️ RESOURCES** = May slow your server

## Table of Contents
[Anchor-linked numbered list of all sections]

## 1. [Section/Tab Name]

[1-2 sentence context for this section]

**[Setting Name]: [ON/OFF/Value]** — [Why. What it does in plain English. When to change it.]

**[Setting Name]: [OFF]** — [Why off. What breaks if you turn it on. What plugin handles this better.]

**[Setting Name]: [DEPENDS]** — [The condition. "If you're using Cloudflare Enterprise, turn this OFF. Otherwise, ON."]

[Repeat for all settings in this section]

## 2. [Next Section]
...

## What This Plugin Doesn't Handle
[List the gaps. Link to other plugins/settings guides that fill them.]

## My Test Results
[Before/after metrics. Screenshots. Specific numbers.]
```

**Setting format rules:**
- Bold the setting name and the value: `**Minify CSS: ON**`
- Dash separator before explanation: `— removes unused CSS...`
- One setting per line. Never paragraph-dump multiple settings.
- If a setting conflicts with another plugin, say so explicitly: `"Turn this OFF if you're using Perfmatters — they both do the same thing, and running both wastes server resources."`
- Group settings by tab/section as they appear in the plugin UI

**Example setting block:**
```markdown
**Minify CSS: ON** — Strips whitespace and comments from CSS files. Safe for most sites. If your layout breaks, check for CSS that depends on comments (rare but it happens).

**Combine CSS: OFF** — This made sense with HTTP/1.1. With HTTP/2 and HTTP/3, combining files actually hurts performance because browsers can't cache individual files. Leave it off.

**Delay JavaScript: DEPENDS** — If you're using FlyingPress or Perfmatters, they handle this better. If this is your only optimization plugin, turn it ON and add exclusions for:
- jQuery (if your theme needs it on load)
- Analytics scripts (they need to fire early)
- Any script that affects above-the-fold content
```

---

### Type 2: Hosting/Product Review

**Title format:** `[Product] Review [Year]: [Strong Opinion That Sets Expectations]`

Examples:
- `Cloudways Review: High CPU Usage and Why I Switched to ScalaHosting`
- `GeneratePress Review: Why I Redesigned My Blog (With a List of Problems It Fixed)`

**Structure:**

```
H1: [Product] Review [Year]: [Strong Take]

[Opening: 1 paragraph. Your verdict FIRST. Not "in this review we'll look at..."
State what you think, then spend the rest of the article proving it.]

[Key metric or screenshot that supports your opening claim]

## The Good
[2-4 specific things that work, with evidence]

## The Problems
[Numbered list of issues, each with:]
### 1. [Problem Name]
[What the problem is → Evidence (screenshot, benchmark, community complaints) → Impact on the reader → What the alternative does better]

## Who Should Use [Product]
[Specific use cases where it makes sense despite the problems]

## Who Should NOT Use [Product]
[Specific use cases where alternatives are clearly better]

## Setup Guide (If You Decide to Use It)
[Step-by-step with screenshots — because even a negative review should be useful]

## My Recommendation
[1 paragraph. Clear. "Use X instead, unless Y, in which case Z."]
```

**Review voice rules:**
- Lead with your verdict. Don't build suspense in a review.
- Separate "works for me" from "works for most people"
- Every criticism needs a specific alternative: "Don't just say Cloudways has high CPU. Say what host doesn't."
- Include pricing with real numbers, not "check their website"
- Acknowledge what's good even in negative reviews. Credibility comes from fairness.

---

### Type 3: Comparison Article

**Title format:** `[Product A] vs [Product B] [Year]: [Clear Winner or Surprising Take]`

Examples:
- `SiteGround vs Bluehost 2026: Why You Should Avoid Both`
- `WP Rocket vs FlyingPress: The Cache Plugin Showdown (With Real Numbers)`

**Structure:**

```
H1: [A] vs [B] [Year]: [Take]

[Opening: State the winner immediately. "If you're choosing between A and B, go with A.
Here's the 30-second version, then the evidence."]

## Quick Verdict
[Table: 5-7 key metrics, A vs B, with a winner column]

| Metric | [Product A] | [Product B] | Winner |
|--------|------------|------------|--------|
| TTFB | 180ms | 420ms | A |
| Price/month | $14 | $35.99 | A |
| ... | ... | ... | ... |

## Detailed Comparison

### [Metric 1: e.g., Performance]
[Your test setup → Results → What the numbers mean]

### [Metric 2: e.g., Pricing]
[Real prices, not "starting at" marketing prices. Include renewal rates.]

### [Metric 3: e.g., Support]
[Your actual support experiences. Response times. Resolution quality.]

[Continue for all comparison dimensions]

## When [B] Actually Makes Sense
[Be fair. There's usually a niche where the "loser" wins.]

## My Pick
[Final recommendation with specific use-case context]
```

**Comparison rules:**
- Never "both are great options." Someone is better. Say who.
- Test on identical setups when comparing performance
- Include the spreadsheet or raw data if you have it
- Comparison tables at the TOP, not buried at the bottom
- Renewal pricing, not introductory pricing

---

### Type 4: Speed Optimization / How-To Guide

**Title format:** `[Action] in [Number] Steps: [Proof of Results or Year]`

Examples:
- `Speed Up Your Slow WordPress Site in 21 Steps: The Only Tutorial You Need`
- `Reduce Largest Contentful Paint in WordPress: Advanced Guide to Improving LCP`

**Structure:**

```
H1: [Title]

[Opening: State the problem → State your result → Promise the path]
"WordPress speed optimization has become a joke, littered with paid blogs
who recommend bad hosting. I'll show you how I got my sites to sub-1-second
load times. No affiliate-driven recommendations. Just what works."

[Proof: Performance screenshot showing the result these steps produce]

## Table of Contents
[Numbered, anchor-linked list of all steps]

## 1. [Most Impactful Step First]
[Context → Why this matters most → How to do it → Expected result]

## 2. [Second Step]
...

## [N]. [Final Step]

## My Test Results
[Before/after comparison. Specific metrics. Screenshots.]

## What I'd Do Differently
[Honest retrospective — adds credibility and information gain]
```

**Speed guide rules:**
- Order steps by impact, not by difficulty
- Every step needs an expected result: "This alone should cut your LCP by 0.3-0.5 seconds."
- Link to your settings tutorials for specific plugin configuration
- Include "what to test after each step" — don't make readers wait until the end
- Acknowledge that not every step applies to every site

---

### Type 5: "Best X" Listicle

**Title format:** `The Best [Category] of [Year]: [Number] [Items], [Evidence Type]`

Example: `The Best WordPress Hosting of 2026: 62 Plans, 4 Sheets, and 10+ Years of Research`

**Structure:**

```
H1: The Best [Category] [Year]

[Opening: Why most "best X" lists are garbage → What makes yours different →
Your methodology]

## How I Tested
[Specific methodology. Tools used. Time period. Sample size.]

## Quick Picks
[Table with top 3-5 recommendations and the specific use case for each]

| Use Case | Recommendation | Why |
|----------|---------------|-----|
| Small blogs | X | Cheapest with decent performance |
| WooCommerce | Y | Best dynamic page handling |
| High traffic | Z | Scales without CPU spikes |

## [Item 1]: Best for [Specific Use Case]
[What it is → Your test results → Pros → Cons → Who it's for → Pricing]

## [Item 2]: Best for [Different Use Case]
...

## What I Tested But Don't Recommend
[Important section. Shows you're not just listing sponsors.]

## Methodology
[Detailed breakdown for readers who want to verify]
```

**Listicle rules:**
- "Best" must mean "best for a specific use case," not "best overall"
- Every item needs: specific test data, real pricing, clear use case
- Include items you tested and rejected — this is information gain
- No filler items. If you only tested 5, list 5. Don't pad to 10.
- Update year in title AND in the actual data

---

## Formatting Conventions

### Bold Usage (Heavy but Strategic)

Bold these always:
- **Plugin/product names** on first mention in a section
- **Setting names and their values**: `**Minify CSS: ON**`
- **Key claims**: `**0.8 seconds faster**`
- **Warnings**: `**Don't enable this if...**`
- **The verdict**: `**Use FlyingPress**`

Never bold:
- Entire sentences (use a callout or blockquote instead)
- Generic words ("**important**", "**note**")
- Transition phrases

### Paragraph Length

- 2-4 sentences per paragraph (OMM standard)
- 1-sentence paragraphs for punch: "The difference is dramatic."
- Never more than 5 sentences. If it's longer, split it.
- Settings explanations: 1-2 sentences each. Brevity is respect.

### Tables

Use tables for:
- Comparisons (always)
- Pricing (with real numbers and renewal rates)
- Test results (before/after, A vs B)
- Feature matrices (has/doesn't have)

Table rules:
- Headers must be specific ("TTFB (ms)" not "Speed")
- Include a "Winner" or "Verdict" column in comparisons
- Numbers > adjectives ("0.8s" not "fast")
- Bold the winning value in each row

### Screenshots and Evidence

Use the standard image placeholder syntax from `_common-patterns.md`:

```markdown
[IMAGE: Description of what the image shows]
Alt: Descriptive alt text for accessibility
```

**Placement rules for OMM-style articles:**

| Position | What to Show | Why |
|----------|-------------|-----|
| After opening (first 300 words) | PageSpeed/GTmetrix result proving your claim | Credibility before the tutorial begins |
| Next to each settings section | Screenshot of the plugin UI tab | Reader can match their screen to yours |
| After "before" claim | Before screenshot | Establishes baseline |
| After "after" claim | After screenshot | Proves the improvement |
| In comparison sections | Side-by-side benchmark results | Visual proof of winner |
| In review "Problems" sections | Dashboard showing the issue (CPU spikes, slow TTFB) | Evidence, not just opinion |

**Evidence hierarchy** (strongest to weakest):
1. Your own benchmark screenshots with dates and test conditions
2. Community data (Facebook polls, Reddit threads, TrustPilot review counts)
3. Third-party benchmarks (Kevin Ohashi, dnsperf.com, Backlinko studies)
4. Official documentation or changelogs

Never use stock images. Every image should be a screenshot you took or a data visualization you created.

### Internal Linking

Check `knowledge/published-blog-articles.md` for available link targets.

- Link to your settings tutorial whenever you mention a plugin
- Link to your comparison when you mention alternatives
- Link to your speed guide from plugin reviews
- 5-8 internal links per 2,000 words
- Anchor text = the article's actual topic, not "click here" or "this guide"

**Link placement by section:**
1. **Opening:** 0-1 links max (don't distract)
2. **Body sections:** 3-5 links naturally woven in
3. **"What This Plugin Doesn't Handle" / Closing:** 1-2 links to complementary guides

### Affiliate Links

Check `knowledge/affiliate-products.md` for available affiliate URLs.

**Format:**
```markdown
I recommend [FlyingPress](https://yoursite.com/go/flyingpress/) for caching.
```

**OMM-style affiliate rules:**
- Disclose early and naturally: "The links below support the site. I only recommend what I actually use."
- One recommendation per category — don't hedge with three options
- If the best option has no affiliate program, recommend it anyway and say so: "No affiliate link for this one, but it's still the best option."
- Never let commissions change the recommendation
- Include coupon codes when available: "Use code **GT20** for 20% off"

---

## Opening Patterns (The First 3 Sentences)

The opening determines whether someone reads or bounces. OMM articles open with one of these patterns:

### Pattern 1: Strong Opinion First
> FlyingPress is the fastest cache plugin I've tested. After 10 years of benchmarking every major option, nothing else comes close on LCP. Here's the setup that gets my sites to sub-50ms TTFB.

### Pattern 2: Problem + Frustration
> WordPress speed optimization has become a joke. Every "guide" recommends the same hosting companies that pay the highest commissions. I'm going to show you what actually works — no affiliate-driven recommendations.

### Pattern 3: Anti-Recommendation
> Don't use SiteGround or Bluehost. I know that contradicts every "best hosting" list on the internet. But those lists are written by people who've never tested a server in their life.

### Pattern 4: Data Lead
> I tested 62 hosting plans across 15 metrics. The results surprised me. The most expensive option wasn't the fastest, and the cheapest option outperformed hosts charging 3x more.

### Pattern 5: Before/After Transformation
> My site loaded in 4.2 seconds. After applying these 21 changes, it loads in 0.8 seconds. Same hosting. Same theme. Same content. Here's every step I took.

**What NEVER to open with:**
- "In this article, we'll explore..."
- "Are you looking for the best..."
- "WordPress is the most popular CMS..."
- Any throat-clearing or context-setting that delays the point

---

## Closing Patterns

### Pattern 1: Action + Offer to Help
> That's the complete setup. If something breaks or you're not seeing the improvements, drop a comment with your site URL and I'll take a look.

### Pattern 2: Cross-Reference
> If you're using this with WP Rocket, check my WP Rocket settings guide — a few settings overlap and running both will waste server resources.

### Pattern 3: Quick Summary
> To recap: switch to cloud hosting, use FlyingPress for caching, Cloudflare for CDN, and Perfmatters for script management. That's the stack. It works on blogs, WooCommerce stores, and membership sites.

**What NEVER to close with:**
- "I hope this article was helpful"
- "What do you think? Let me know in the comments"
- "If you enjoyed this, please share"
- Any generic engagement-bait CTA

---

## Data Presentation Rules

### Benchmarks
- Always state: what you tested, the tool you used, the date, and the server/hosting
- Include the raw number, not just "faster" or "slower"
- Show the testing methodology so readers can replicate

### Pricing
- Current price, not "starting at"
- Renewal price (if different from introductory)
- Currency and billing cycle (monthly vs. annual)
- Date checked: "Pricing as of March 2026"

### Performance Claims
- Specific metric: LCP, TTFB, CLS — not "page speed"
- Tool used: PageSpeed Insights, GTmetrix, WebPageTest, KeyCDN
- Test conditions: location, connection speed, cache state
- Sample size: "Tested 5 times, averaged" or "Measured over 30 days"

---

## Affiliate Transparency

If the article includes affiliate links:
- Acknowledge it early and naturally: "The links below support the site. I only recommend what I actually use."
- Never let affiliate relationships change your recommendation. If the best option doesn't have an affiliate program, recommend it anyway.
- Call out when you're NOT affiliated: "I don't have an affiliate link for this one, but it's still the best option."

---

## ACF Blocks for OMM-Style Articles

Full block syntax is in `_acf-blocks-for-writing.md`. Here's when to use each block in OMM-style content:

### Block Placement by Article Type

**Settings Tutorial:**

| Position | Block | Purpose |
|----------|-------|---------|
| After opening verdict | **Callout** (info) | "Quick Answer" — the one-line recommendation for scanners |
| After settings walkthrough | **Pros & Cons** | What the plugin handles well vs. what it doesn't |
| After "What This Plugin Doesn't Handle" | **CTA** | Link to the recommended plugin |
| End of article (if applicable) | **Accordion** | Only if there are genuine standalone FAQs |

**Review:**

| Position | Block | Purpose |
|----------|-------|---------|
| After "The Good" / "The Problems" | **Pros & Cons** | Visual summary of strengths and weaknesses |
| After verdict text | **Product Review** | Star ratings, feature scores, pricing, JSON-LD schema |
| After Product Review | **CTA** | Primary action button |
| End of article (if applicable) | **Accordion** | FAQs |

**Comparison:**

| Position | Block | Purpose |
|----------|-------|---------|
| After "Quick Verdict" table | **Compare** | Side-by-side column comparison |
| After "My Pick" | **CTA** | Link to recommended product |
| End of article (if applicable) | **Accordion** | FAQs |

**Speed Guide / How-To:**

| Position | Block | Purpose |
|----------|-------|---------|
| Prerequisites (if any) | **Checklist** | What readers need before starting |
| Before numbered steps | **Callout** (info) | Quick answer for scanners |
| At critical warnings | **Callout** (warning) | "Don't enable this if..." |
| End of article (if applicable) | **Accordion** | FAQs |

### Example: Callout Block for Quick Answer

```html
<!-- wp:acf/callout {"name":"acf/callout","data":{"callout_type":"info","callout_title":"Quick Answer","callout_content":"<p>Use FlyingPress for caching, Perfmatters for script management, Cloudflare for CDN. That's the stack. Details below.</p>"}} /-->
```

### Example: Pros & Cons for Plugin Review

```html
<!-- wp:acf/pros-cons {"name":"acf/pros-cons","data":{"pc_show_first":"positive","pc_pros_title":"What Works","pc_pros_list":"<ul>\n<li>Fastest LCP in my tests (0.8s vs 2.1s WP Rocket)</li>\n<li>Automatic critical CSS that actually works</li>\n<li>Clean UI — no bloat settings</li>\n</ul>","pc_cons_title":"What Doesn't","pc_cons_list":"<ul>\n<li>Smaller community than WP Rocket</li>\n<li>Documentation could be better</li>\n</ul>"}} /-->
```

---

## FAQ Policy for OMM-Style Articles

OMM-style articles handle Q&A differently than standard blog posts. Most questions are answered inline as problem-solution pairs within the article body, not quarantined at the bottom.

**When to include an FAQ section:**
- The article has 3+ genuine standalone questions that don't fit naturally into any section
- The questions are things people search for independently (check People Also Ask)
- The FAQ adds information gain — it answers something the article body doesn't cover

**When to skip the FAQ:**
- Settings tutorials where every "question" is already a setting explanation
- Speed guides where every "question" is already a numbered step
- The only FAQs you can think of are restatements of content already in the article

**If you include FAQs:**
- Use ACF Accordion with FAQ schema enabled
- 3-5 questions (not the standard 5-8 — OMM articles are already long)
- Each answer: 40-60 words, contains at least one named entity
- Questions phrased exactly as users search them

---

## GEO + AI Search Readiness

OMM-style articles are naturally entity-dense and answer-first, which works well for both Google and AI search engines (Perplexity, ChatGPT, Claude, Gemini). But make these explicit:

### Answer-First Paragraphs

Every H2 section must open with a direct, extractable answer in the first 1-2 sentences. This is the passage AI systems will cite.

```
BAD (context-first):
"When choosing a caching plugin, there are many factors to consider
including compatibility, features, and performance..."

GOOD (answer-first + voice):
"FlyingPress is the fastest caching plugin I've tested. After benchmarking
every major option on identical test sites, it consistently beats WP Rocket
on LCP by 0.3-0.5 seconds."
```

### Entity Density

OMM articles are already entity-heavy by nature (plugin names, hosting brands, metrics, prices). Verify these targets:

- **3-5 named entities per H2 section** (tool names, version numbers, prices, metrics, proper nouns)
- **Every claim has a specific number** — this is both OMM methodology and entity enrichment
- **Named alternatives for every recommendation** — "Use X instead of Y" gives two entities in one sentence

### Information Gain

For each H2 section, ask: "Could a competitor have written this without testing anything?"

- If YES → Add first-party benchmark data, a specific configuration, or a real-world result
- If NO → The section has information gain. Strengthen it.

### Schema Markup

- **Article schema:** Automatic via Rank Math (no action needed)
- **FAQ schema:** Only when FAQ Accordion block is present — enable via `acf_accord_enable_faq_schema`
- **HowTo schema:** For speed guides and settings tutorials with numbered steps — enable via Rank Math
- **Product/Review schema:** When Product Review ACF block is used — automatic via the block

### Syntactic Burstiness

Mix sentence lengths aggressively. OMM's short-paragraph style makes this easier:

```
Good: "FlyingPress loads pages in 0.8 seconds. That's fast. Faster than
anything else I've tested on identical hardware over 6 months of monitoring.
WP Rocket? 2.1 seconds. Same server, same theme, same content."

Word counts: 7, 2, 14, 2, 7.
```

Monotonous rhythm = AI-sounding. Burst rhythm = human-sounding. This matters for both readability and AI detection avoidance.

---

## The Gaurav Test (Voice Final Check)

Before submitting OMM-style content, run this 6-point gut check:

1. Did I use "I" and "you" naturally throughout?
2. Is there a specific number backing every claim?
3. Did I recommend ONE thing per category (not hedge with three)?
4. Is there something I clearly love or clearly don't recommend?
5. Would a generic AI write this? If yes → rewrite until it sounds like someone with 16 years of experience.
6. Read the opening aloud — does it sound like a person who actually tested this?

---

## Quality Checklist

Before publishing, verify:

**Content & Data:**
- [ ] Opening states the opinion/verdict in the first 3 sentences
- [ ] Every claim has a specific number, benchmark, or screenshot
- [ ] Settings use the `**Name: Value** — explanation` format
- [ ] At least one comparison table with real data
- [ ] Pricing includes renewal rates and date checked
- [ ] Year is current in both title and body

**Structure & Formatting:**
- [ ] Every paragraph is 4 sentences or fewer
- [ ] Bold is on setting names, product names, key claims — not on filler
- [ ] Image placeholders placed per evidence hierarchy (after opening, per settings section, before/after)
- [ ] No throat-clearing, no "in this article," no passive openings

**Links & Blocks:**
- [ ] 5-8 internal links to related content (checked against `published-blog-articles.md`)
- [ ] Affiliate links use `yoursite.com/go/` format (checked against `affiliate-products.md`)
- [ ] ACF blocks placed per article type (Callout for quick answer, Pros/Cons, Product Review, CTA, Accordion)
- [ ] FAQ Accordion only if genuine standalone questions exist (not restated body content)

**Voice & SEO:**
- [ ] Voice check: read the opening aloud — does it sound like a person who tested this?
- [ ] Slop check: no banned phrases from anti-slop list
- [ ] Conversational texture: 12-17 informal touches per 2,000 words (ellipses, connectors, asides)
- [ ] Competitor mentions are constructive (what to use instead, not just bashing)
- [ ] Closing offers help or cross-references related content
- [ ] **GEO ready:** answer-first paragraphs, 3-5 entities per H2, first-party evidence
- [ ] **High entropy:** varied sentence lengths (burstiness), emotional variance, no monotonous rhythm
- [ ] **Schema:** HowTo for step guides, FAQ for accordion, Product Review for reviews

---

## Integration With Other Skills

| Skill | When to Use Together |
|-------|---------------------|
| `koray` | Entity enrichment — OMM articles are already entity-dense, but verify 3-5 named entities per H2 |
| `stop-slop` | Run the banned phrases check on every draft |
| `voice-dna` | Final pass — every OMM technique must still sound like Gaurav |
| `ai-seo` | Answer-first paragraphs serve both Google and LLM citation |
| `schema-markup` | Add FAQ schema only if the article has genuine FAQ content (most OMM-style articles don't) |

---

## Quick Reference: OMM Patterns by Article Type

| Pattern | Settings Tutorial | Review | Comparison | Speed Guide | Listicle |
|---------|------------------|--------|------------|-------------|----------|
| Opening | What it does + limitations | Verdict first | Winner first | Problem + your result | Why other lists fail |
| Core format | Setting: Value — why | Pros/Cons with evidence | Head-to-head tables | Numbered steps by impact | Items by use case |
| Data type | Screenshots of UI + results | Benchmarks + community data | Side-by-side metrics | Before/after metrics | Test results per item |
| Bold focus | Setting names + values | Key claims + verdicts | Winners in each row | Step numbers + expected results | Item names + key differentiators |
| Tables | Conflict resolution (which plugin handles what) | Feature/pricing matrix | Main comparison + subcategories | Results summary | Quick picks + full comparison |
| Internal links | To complementary plugin settings | To comparison articles | To individual reviews | To settings tutorials | To detailed reviews |
| Closing | What this plugin doesn't handle + what to pair it with | Clear recommendation + alternative | Final pick with use-case nuance | Summary stack + offer to help | Top 3 recap by use case |
