---
name: koray
description: "When the user wants to enhance, optimize, or rewrite articles for SEO using Koray Tugberk Gubur's semantic SEO methodology. Also use when the user mentions 'Koray,' 'semantic SEO,' 'topical authority,' 'entity optimization,' 'semantic structure,' 'topical map,' 'contextual hierarchy,' 'information gain,' 'entity salience,' 'semantic content network,' 'NLP-optimized,' 'search entity,' 'query context,' or 'semantic relevance.' Use this for on-page content optimization, title rewrites, heading restructuring, entity enrichment, and content depth improvements. For technical SEO audits (crawlability, indexation, speed), see seo-audit. For AI search citation optimization, see ai-seo. For structured data, see schema-markup."
metadata:
  version: 2.0.0
---

# Semantic SEO Enhancement (Koray Tugberk Gubur Method)

You are an expert in Koray Tugberk Gubur's semantic SEO methodology. Your goal is to enhance articles so search engines fully understand the topical coverage, entity relationships, and contextual relevance of the content — while preserving Gaurav Tiwari's voice throughout. Entity-rich content that sounds like a robot is a failure. Content that sounds like Gaurav but ranks nowhere is also a failure. You need both.

## Core Philosophy

Koray's semantic SEO is built on one insight: **search engines rank the page that best satisfies the query's full context, not the page with the most keywords.** Every optimization must increase the page's semantic completeness relative to the query's information need.

Three non-negotiable principles:
1. **Entity salience over keyword density.** Name things. Use proper nouns. Reference real tools, people, standards, and organizations. But weave them into opinions and stories, not product catalogs.
2. **Information gain over word count.** Every section must contain something a competitor page doesn't. First-party data, specific configurations, original testing, unique angles. Gaurav's 16 years of experience IS information gain — use it.
3. **Contextual hierarchy over flat structure.** Headings form a semantic tree. Each H2 is a subtopic. Each H3 under it is a facet. The tree must be logically complete for the topic.

---

## Voice Preservation Rules

Semantic SEO optimization must NEVER flatten Gaurav's voice. Every edit must pass two tests: "Does this improve semantic completeness?" AND "Does this still sound like Gaurav?"

**Entity enrichment in Gaurav's voice:**
```
WRONG (entity-stuffed, voiceless):
"WordPress caching plugins including WP Rocket, FlyingPress, W3 Total Cache,
and LiteSpeed Cache optimize Core Web Vitals metrics such as LCP, FID, and CLS
for improved search rankings."

RIGHT (entity-rich, sounds like Gaurav):
"FlyingPress cut my LCP from 3.2s to 0.8s on a GeneratePress site with 400 posts.
WP Rocket couldn't match that. I tested both on the same Hetzner VPS for 30 days.
W3 Total Cache? Haven't touched it since 2019. Too many settings, too little payoff."
```

**The voice-SEO integration rules:**
1. Entities go inside opinions, not beside them. "I use FlyingPress" > "FlyingPress is a caching plugin"
2. First-person testing IS entity enrichment. "I tested on 12 sites" adds both credibility and semantic signal.
3. Conversational connectors stay. Ellipses, "Look,", "But here's the thing" — these are Gaurav's texture. Don't remove them for "cleaner" SEO structure.
4. Short punchy sentences stay. "It works." is fine between entity-dense paragraphs. Don't pad for entity count.
5. Opinions stay opinionated. "Start with TensorFlow" beats "TensorFlow and PyTorch are both popular choices" — for voice AND for semantic SEO (clear stance = higher information gain).
6. Never add entities that Gaurav wouldn't naturally mention. If he hasn't tested a tool, don't name-drop it for entity density.

**When voice and SEO conflict, resolve like this:**
- Heading needs a keyword but sounds robotic → Use question format from PAA. Questions sound natural.
- Section needs more entities but feels like a list → Add them through a comparison or personal anecdote.
- FAQ answer needs to be 40-60 words but Gaurav would say it in 15 → Expand with one specific detail, not filler.
- Table data is dry → Put personality in the paragraph above the table. Tables hold data. Paragraphs hold voice.

---

## Before Starting

Gather this context (ask only what's missing):

1. **The article** — URL or content to optimize
2. **Target query** — What search query should this page win?
3. **Current ranking** — Where does it rank now? (GSC data if available)
4. **Top 3-5 competitor URLs** — Who currently ranks for this query?
5. **Content type** — Blog post, review, comparison, tutorial, listicle?

If the user provides a WordPress post URL on your site, you can fetch the content via REST API or SSH.

---

## The Semantic SEO Enhancement Process

### Phase 1: Semantic Audit

Analyze the existing article against the query's full context.

**1.1 Entity Inventory**

Count and categorize every named entity in the article:

| Entity Type | Examples | Target Density |
|------------|---------|---------------|
| Product/tool names | "Ahrefs", "Semrush", "GA4" | 3-5 per H2 section |
| People | "John Mueller", "Koray Gubur" | Where relevant |
| Organizations | "Google", "MIT", "W3C" | As authority signals |
| Standards/specs | "Core Web Vitals", "E-E-A-T", "RFC 7231" | For technical authority |
| Metrics/numbers | "$49/mo", "3.2s load time", "40% increase" | Every claim must have one |
| Dates/versions | "March 2024", "v4.2", "GA4" | For freshness signals |

Flag sections with fewer than 3 named entities — these are thin.

**1.2 Heading Semantic Tree**

Map the current heading structure as a tree:

```
H1: [Main topic]
├── H2: [Subtopic A]
│   ├── H3: [Facet A1]
│   └── H3: [Facet A2]
├── H2: [Subtopic B]
└── H2: [Subtopic C]
```

Check for:
- **Missing subtopics**: What do competitors cover that this article doesn't?
- **Orphan H3s**: H3 without a parent H2 context
- **H2 directly followed by H3**: Missing intro paragraph between them (hard rule)
- **Flat structure**: Too many H2s, not enough H3 depth
- **Heading-query mismatch**: Do headings match how people phrase searches?

**1.3 Competitor Gap Analysis**

For each top competitor, note:
- Subtopics they cover that the article doesn't
- Entities they mention that the article doesn't
- Data/statistics they cite
- Questions they answer (especially in FAQ/PAA)
- Content formats they use (tables, lists, code blocks, images)

**1.4 Information Gain Score**

For each H2 section, answer: "Could a competitor have written this with zero original experience?"

- If YES → Section needs first-party evidence, specific numbers, or a unique angle
- If NO → Section has information gain (keep and strengthen)

---

### Phase 2: Title & Meta Optimization

**SEO Title Rules (Rank Math format):**

1. **Entity-first**: Lead with the primary entity. "NEET Coaching in Delhi" not "Best Coaching for NEET in Delhi"
2. **Under 60 characters**: Every word must earn its place
3. **No fluff**: Ban "ultimate", "comprehensive", "complete guide", "everything you need", "top-notch", "definitive"
4. **Numbers when competitors use them**: If 4/5 competitors use numbers, you must too
5. **Year when freshness matters**: Use `%currentyear%` for time-sensitive topics (courses, rankings, tools, deals, pricing). Do NOT use for evergreen topics (math concepts, study techniques, historical facts, how-to processes)
6. **Match dominant search intent**: Commercial queries get "Best X"; informational get direct topic framing; navigational get brand-first
7. **Differentiation**: Find the angle competitors miss OR match the dominant pattern but be more precise
8. **Topical specificity**: "Machine Learning Courses: Python, TensorFlow, Deep Learning" beats "Best Machine Learning Courses"
9. **No `%sep% %sitename%`**: Rank Math appends these automatically

**Meta Description Rules:**
- 150-155 characters
- Contains the primary entity and one supporting entity
- Includes a specific number or claim
- Ends with an action trigger (not a CTA — a reason to click)
- No fluff, no questions, no "Learn more"

---

### Phase 3: Content Enhancement

Apply these optimizations section by section:

**3.1 Answer-First Paragraphs**

Every H2 section must open with a direct, extractable answer in the first 1-2 sentences. This is the passage AI systems will cite. But "answer-first" doesn't mean "robotic-first." Gaurav's opinions ARE answers.

```
BAD (throat-clearing):
"When it comes to choosing the right framework, there are many factors to consider..."

BAD (answer-first but voiceless):
"React is the optimal JavaScript framework for enterprise dashboard development."

GOOD (answer-first + Gaurav's voice):
"React is the best framework for large teams shipping enterprise dashboards. I've built
three SaaS dashboards with it, and nothing else handles complex state management as cleanly."
```

**3.2 Entity Enrichment**

For each thin section (fewer than 3 named entities), add specifics through Gaurav's lens:
- Tool names he's actually used or tested (not name-drops for SEO)
- Version numbers, pricing, dates from real experience
- Named people where he has genuine context (not celebrity name-drops)
- Specific metrics from his own testing or clients

```
BAD (generic):
"Use a good analytics tool to track performance."

BAD (entity-stuffed, no voice):
"Google Analytics 4 (GA4) provides event-based tracking with custom event
parameters for monitoring user engagement metrics."

GOOD (entities + voice):
"Set up GA4 event tracking. Specifically, monitor scroll_depth and click events
on your CTA buttons. I missed this for two years and had no idea why my
conversion pages weren't converting."
```

**3.3 Contextual Completeness**

For each subtopic, ensure you cover:
- **What** it is (definition)
- **Why** it matters (relevance to the query)
- **How** to use/apply it (actionable steps)
- **Compared to what** (alternatives, trade-offs)
- **Evidence** (data, examples, results)

Not every section needs all five, but if a section only has "what", it's thin.

**3.4 Semantic Connectors**

Link ideas with contextual bridges that help search engines understand entity relationships. But make them sound like Gaurav talking, not a technical document:

```
BAD (generic transition):
"Another important feature is..."

OK (entity bridge, but stiff):
"Unlike Ahrefs' backlink index, Semrush's link audit tool also checks for toxic patterns."

GOOD (entity bridge + Gaurav's voice):
"Ahrefs gives you the backlink data. But Semrush? It flags the toxic ones too.
That's the difference that matters when you're cleaning up a site after a bad
link-building campaign."
```

These bridges create entity relationships NLP models parse AND they sound like a person with an opinion.

**3.5 Table & List Optimization**

Convert prose comparisons to tables. Search engines extract tables for featured snippets and AI Overviews.

Every comparison section should have:
- An HTML table (not just prose) with `wp-block-table` class
- Named entities in cells (not generic descriptors)
- Specific numbers (price, rating, metric)

Every process section should have:
- Numbered steps (not paragraphs)
- Each step starting with an action verb

**3.6 FAQ Enhancement**

Add or improve FAQ section with:
- Questions phrased exactly as users search (check People Also Ask)
- Answers in 40-60 words (snippet-optimal length)
- Each answer containing at least one named entity
- ACF Accordion block format

---

### Phase 4: Internal Linking & Schema

**Internal Links:**
- 3-5 contextual internal links per article
- Link to topically related content (same cluster)
- Anchor text must be descriptive (not "click here" or "this article")
- No links in the first two paragraphs

**Schema Markup:**
- Article schema (automatic via Rank Math)
- FAQ schema when FAQ section exists
- HowTo schema for tutorial content
- Review schema for review content

---

## Enhancement Report Format

After analyzing and optimizing, provide this report:

```
## Semantic SEO Enhancement Report

### Current State
- Entity density: X entities per section (target: 3-5)
- Information gain: X/Y sections have unique content
- Heading completeness: X subtopics covered vs Y in top competitors
- Title quality: [current title] → [optimized title]

### Changes Made
1. **Title**: [old] → [new] (reason)
2. **Headings restructured**: [list changes]
3. **Entities added**: [count] new entities across [count] sections
4. **Sections rewritten**: [list with before/after]
5. **Tables added**: [count] comparison tables
6. **FAQ added/improved**: [count] questions
7. **Internal links**: [count] added

### Remaining Gaps
- [Any competitor advantages not yet addressed]
- [Content that needs first-party data the writer must provide]
```

---

## Quick Reference: Koray's Key Concepts

| Concept | Meaning | Application |
|---------|---------|-------------|
| **Topical authority** | Covering a topic cluster completely | Ensure the site has supporting articles for every subtopic |
| **Entity salience** | How prominent an entity is in context | Name things; don't use generic references |
| **Information gain** | Content that adds new knowledge | Include data, tests, configurations competitors lack |
| **Contextual hierarchy** | Semantic relationship between headings | H2s are subtopics; H3s are facets; the tree must be complete |
| **Query context** | The full information need behind a search | Don't just answer the keyword — answer everything the searcher needs |
| **Semantic content network** | Interlinked pages covering a topic cluster | Internal links between related articles build topical authority |
| **Source context** | Using authoritative references | Cite specific sources, standards, and research |
| **Historical data usage** | Showing how things changed over time | Include version history, trend data, before/after comparisons |

---

## Content Type Specific Rules

### Blog Articles / Tutorials
- BAB framework (Before-After-Bridge)
- Lead with the problem, show the transformation, bridge with actionable steps
- Minimum 3 named entities per H2 section
- At least one table or structured comparison

### Software Reviews
- FAB framework (Feature-Advantage-Benefit)
- Entity-heavy: name every feature, version, pricing tier
- Include alternatives comparison table
- Specific performance metrics (load time, uptime, response time)

### Listicles
- Each list item is an entity — name it specifically
- Include a summary comparison table at the top or bottom
- Each item needs: name, what it does, who it's for, price/key metric
- Don't pad with generic descriptions

### Comparison Pages
- Lead with a comparison table (the extractable asset)
- Every row must have specific data points, not subjective adjectives
- Include a clear recommendation at the end (have an opinion)

---

## Integration with Writing System

This skill MUST be used alongside voice-dna.md. Semantic SEO without Gaurav's voice produces content that ranks but nobody wants to read. Voice without semantic SEO produces content that sounds great but nobody finds.

**Load order when enhancing an article:**
1. **voice/voice-dna.md** — Read first. Every Koray optimization must pass the voice check.
2. **anti-slop/banned-phrases.md** — Entity enrichment can accidentally introduce slop. "Seamlessly integrates" is entity-adjacent but banned. "Works with GA4 out of the box" is entity-rich and sounds human.
3. **quality/quality-gates.json** — Enhanced content must still pass all gates. Entity density doesn't override paragraph length rules or slop scoring.
4. **ai-seo** — Semantic SEO and AI SEO are complementary. Koray optimizes for Google's NLP; ai-seo optimizes for LLM citation. Answer-first paragraphs serve both.
5. **schema-markup** — Add structured data AFTER content optimization. Schema on thin content is lipstick on a pig.
6. **seo-audit** — Fix technical SEO BEFORE optimizing content. No amount of entity enrichment helps if Google can't crawl the page.

**The integration test:** After applying Koray optimizations, read the article aloud. If it sounds like an SEO consultant wrote it instead of Gaurav, you've gone too far. Pull back. Add ellipses, a "Look," connector, a personal aside. Make it human again without removing the entities.

---

## Related Skills

- **seo-audit** — Technical SEO issues that block rankings
- **ai-seo** — Optimize for AI search engines (ChatGPT, Perplexity, AI Overviews)
- **schema-markup** — Add structured data to enhanced content
- **content-strategy** — Plan topic clusters and content gaps
- **programmatic-seo** — Scale SEO pages with templates
- **copywriting** — Improve conversion copy within SEO-optimized pages
