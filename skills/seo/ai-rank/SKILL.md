---
name: ai-rank
description: Optimize content for LLM discoverability AND AI agent consumption. Use when user runs `/ai-rank`, asks to "optimize for AI", "optimize for LLMs", "optimize for agents", "make content AI-readable", or needs to write/proofread landing pages, docs, blog posts for answer engines and autonomous AI agents.
---

# AI Rank Optimizer (LLM + AGENT Frameworks)

Rewrite or proofread content so it is easy for:
1. **LLM answer engines** (ChatGPT, Claude, Perplexity) to extract, cite, and recommend
2. **Autonomous AI agents** to parse, compare, and take action

## Two Audiences, Different Needs

### LLM Answer Engines (Human-in-the-loop)
- Humans ask questions, AI provides answers citing your content
- Optimize for: extraction, citation, featured snippets
- Key: Answer-first, quotable content, trust signals

### Autonomous AI Agents (No human)
- Agents browse, compare products, make decisions, execute tasks
- Optimize for: machine parsing, structured data, actionable endpoints
- Key: Structured facts, API access, decision-ready data

---

## LLM Framework (for Answer Engines)

### 1. Answer-first
- First sentence gives the direct answer
- Include: definition + who it's for + when it's NOT for
- Write quotable 2-5 sentence summaries LLMs will extract

### 2. Intent-matched headings
- H2/H3 titles match target queries verbatim
- Correct heading hierarchy (no skipping levels)
- Use question-format headings for FAQ sections

### 3. Clear structure
- Lists, tables, steps, FAQs over paragraphs
- "Quick summary" and "Key takeaways" sections
- Comparison tables for vs-queries

### 4. Schema markup
- FAQPage JSON-LD for Q&A content
- HowTo schema for tutorials/guides
- Product/SoftwareApplication for products
- Article schema with author/date for blog posts

### 5. Trusted sources
- Cite quantitative claims or label "internal data"
- Link to primary sources
- Include dates, version numbers, last-updated timestamps

### 6. Unique perspective
- Unique frameworks, decision trees, checklists
- Original benchmarks, comparisons, data
- Proprietary methodology or rubrics

---

## AGENT Framework (for Autonomous AI Agents)

### A - Accessible structured data
- JSON-LD schema on every page
- Machine-readable pricing tables (not images)
- Structured product specs, limits, requirements
- RSS/Atom feeds for updates
- Comprehensive sitemap.xml

### G - Grounded facts for decisions
- Explicit pricing with currency and billing cycle
- Hard limits and quotas (not "unlimited*")
- Compatibility matrices (platforms, versions, integrations)
- SLAs, uptime guarantees, support tiers
- Comparison tables vs alternatives

### E - Endpoints for action
- API documentation with examples
- Webhook/integration setup guides
- Direct links to signup, trial, purchase
- Contact/support endpoints
- Status page URLs

### N - Navigable hierarchy
- Consistent URL structure
- Breadcrumbs in markup
- Clear content taxonomy
- robots.txt allowing AI crawlers
- Discovery files (llms.txt, agents.txt)

### T - Trust markers for machines
- Security certifications (SOC2, GDPR, etc.)
- Published changelog/release notes
- Public roadmap or feature status
- Customer logos/testimonials with verifiable details
- Third-party reviews with links

---

## Discovery Standards & Protocols

### For LLM Answer Engines

#### llms.txt
- **Location:** `/llms.txt`
- **Purpose:** Help LLMs understand site content at inference time
- **Format:** Markdown with H1 (site name), summary, key page links
- **Spec:** https://llmstxt.org/

```markdown
# Your Company Name

> One-line description of what you do.

## Docs
- [Getting Started](https://docs.example.com/start)
- [API Reference](https://docs.example.com/api)

## Products
- [Product Name](https://example.com/product): Description

## Pricing
- [Pricing](https://example.com/pricing)
```

### For Autonomous Agents

#### agents.txt
- **Location:** `/agents.txt`
- **Purpose:** B2A (Business to Agent) service discovery
- **Spec:** https://agentstxt.dev/

```yaml
# agents.txt
name: Your Company
description: What agents can do with your service
api_endpoint: https://api.example.com
auth_type: api_key
documentation: https://docs.example.com/api
mcp_server: https://mcp.example.com
capabilities:
  - read_data
  - write_data
  - transactions
```

#### /.well-known/api-catalog (RFC 9727)
- **Location:** `/.well-known/api-catalog`
- **Purpose:** API endpoint discovery (like robots.txt for APIs)
- **Format:** JSON

```json
{
  "apis": [
    {
      "name": "Your API",
      "description": "What it does",
      "url": "https://api.example.com",
      "documentation": "https://docs.example.com/api",
      "type": "REST"
    }
  ]
}
```

#### Agent Card (A2A Protocol)
- **Purpose:** Agent-to-Agent protocol capabilities
- **Format:** JSON endpoint
- **Spec:** https://a2a-protocol.org/

```json
{
  "name": "Your Agent",
  "description": "What this agent does",
  "capabilities": ["task1", "task2"],
  "endpoint": "https://agent.example.com",
  "auth": {"type": "oauth2"}
}
```

#### MCP Registry
- **Purpose:** Make your MCP server discoverable
- **Registry:** https://registry.modelcontextprotocol.io/
- **Submit:** https://github.com/modelcontextprotocol/registry

---

## Master Checklists

### Page-Level Checklist

Run this for every content page:

#### Landing Pages
- [ ] First sentence directly answers "what is this?"
- [ ] H1 matches primary target query
- [ ] H2s match secondary target queries
- [ ] Comparison table vs competitors (if applicable)
- [ ] "Who it's for" and "Who it's NOT for" sections
- [ ] Pricing in a table with explicit numbers
- [ ] Hard limits/quotas stated (not "unlimited*")
- [ ] FAQ section with question-format headings
- [ ] Customer quote with attribution
- [ ] Clear CTA with direct signup link
- [ ] FAQPage JSON-LD schema
- [ ] Product/SoftwareApplication JSON-LD schema
- [ ] Last-updated date visible

#### Documentation Pages
- [ ] Problem/solution stated in first paragraph
- [ ] Prerequisites listed upfront
- [ ] Step-by-step instructions (numbered)
- [ ] Code examples with language tags
- [ ] Expected output shown
- [ ] Common errors and solutions
- [ ] Links to related docs
- [ ] HowTo JSON-LD schema
- [ ] Last-updated date visible

#### Blog Posts
- [ ] Answer/thesis in first paragraph
- [ ] Key takeaways section (top or bottom)
- [ ] Specific numbers and data points
- [ ] Citations for external claims (links)
- [ ] "Internal data" label for proprietary stats
- [ ] Author name and date
- [ ] Internal links to product/docs
- [ ] Article JSON-LD schema

#### Pricing Pages
- [ ] All plans in a comparison table
- [ ] Explicit prices with currency
- [ ] Billing cycle stated (monthly/annual)
- [ ] Feature limits per plan (numbers, not checkmarks)
- [ ] API rate limits
- [ ] Support response times
- [ ] SLA/uptime guarantee
- [ ] Enterprise contact method
- [ ] Free trial/plan details
- [ ] Product JSON-LD with Offer schema

#### API/Developer Docs
- [ ] Authentication methods documented
- [ ] Base URL clearly stated
- [ ] All endpoints listed with methods
- [ ] Request/response examples
- [ ] Rate limits documented
- [ ] Error codes explained
- [ ] SDK/client library links
- [ ] Webhook payload examples
- [ ] Changelog/versioning info

#### Integration Pages
- [ ] All integrations in tables (not prose)
- [ ] Status per integration (native/plugin/beta)
- [ ] Setup method per integration
- [ ] Data sync frequency
- [ ] What data is sent/received
- [ ] Link to setup docs per integration

---

### Site-Level Checklist

Run this once for the entire site:

#### Discovery Files (Create These)
- [ ] `/robots.txt` - allows AI crawlers (GPTBot, ClaudeBot, PerplexityBot, Googlebot)
- [ ] `/llms.txt` - site summary for LLM inference
- [ ] `/agents.txt` - agent service discovery
- [ ] `/.well-known/api-catalog` - API discovery (RFC 9727)
- [ ] `/sitemap.xml` - comprehensive, up-to-date
- [ ] `/feed.xml` or `/rss.xml` - blog/changelog feed

#### robots.txt Template
```
User-agent: GPTBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Google-Extended
Allow: /

User-agent: *
Allow: /

Sitemap: https://example.com/sitemap.xml
```

#### AI Crawler Access
- [ ] GPTBot allowed (OpenAI)
- [ ] ClaudeBot allowed (Anthropic)
- [ ] PerplexityBot allowed
- [ ] Google-Extended allowed (Gemini)
- [ ] CCBot allowed (Common Crawl)
- [ ] No blanket bot blocks that catch AI crawlers

#### API & Programmatic Access
- [ ] Public API documented
- [ ] API authentication documented
- [ ] Rate limits published
- [ ] OpenAPI/Swagger spec available
- [ ] SDK/client libraries available
- [ ] Webhook documentation
- [ ] JSON schema for data structures
- [ ] Content negotiation support (Accept: text/markdown) to serve clean markdown without duplicate URLs

#### MCP Server (if applicable)
- [ ] MCP server implemented
- [ ] MCP server documented
- [ ] Submitted to MCP Registry
- [ ] Listed in GitHub MCP Registry

#### Structured Data (Site-wide)
- [ ] Organization JSON-LD on homepage
- [ ] BreadcrumbList on all pages
- [ ] Product/SoftwareApplication on product pages
- [ ] FAQPage on FAQ/support pages
- [ ] HowTo on tutorial pages
- [ ] Article on blog posts
- [ ] WebSite with SearchAction (for site search)

#### Trust & Verification
- [ ] Status page URL published
- [ ] Changelog/release notes public
- [ ] Security certifications listed (SOC2, GDPR, etc.)
- [ ] Privacy policy accessible
- [ ] Terms of service accessible
- [ ] Contact information verifiable
- [ ] Third-party review links (G2, Capterra, etc.)

#### Feeds & Updates
- [ ] RSS/Atom feed for blog
- [ ] RSS/Atom feed for changelog
- [ ] RSS/Atom feed for docs updates (optional)

---

## Workflow

### Phase 1: Gather Context

Ask user for:

1. **Content**: File path(s) or pasted content
2. **Content type**: Landing page / Docs / Blog / Product page
3. **Target intents**: 3-10 queries to rank for (answer engines)
4. **Agent use cases**: What should an agent be able to do with this? (compare products, get pricing, integrate, etc.)
5. **Audience**: Human readers + agent sophistication
6. **Product/context**: What you're selling/explaining
7. **Constraints**: Tone, compliance, forbidden claims

### Phase 2: Dual Audit

Score content against both frameworks. **You MUST compute and present the final weighted scores.**

#### LLM Audit (Answer Engines)
| Principle | Weight | Score 0-5 | Issues |
|-----------|--------|-----------|--------|
| 1. Answer-first | 20% | | |
| 2. Intent headings | 15% | | |
| 3. Clear structure | 20% | | |
| 4. Schema markup | 15% | | |
| 5. Trusted sources | 15% | | |
| 6. Unique perspective | 15% | | |

#### AGENT Audit (Autonomous Agents)
| Pillar | Weight | Score 0-5 | Issues |
|--------|--------|-----------|--------|
| A - Accessible data | 25% | | |
| G - Grounded facts | 20% | | |
| E - Endpoints | 20% | | |
| N - Navigable | 15% | | |
| T - Trust markers | 20% | | |

**Scoring guide:**
- 0 = Missing entirely
- 1 = Present but critically flawed
- 2 = Below standard, major issues
- 3 = Meets minimum standard
- 4 = Good, minor improvements possible
- 5 = Excellent, best-practice implementation

**Compute the weighted score for each framework: sum of (score x weight). Max = 5.0**
**Then compute the combined AI Rank Score: (LLM score + AGENT score) / 2**

| Range | Rating | Action |
|-------|--------|--------|
| 4.5-5.0 | Excellent | Minor polish only |
| 3.5-4.4 | Good | Targeted improvements |
| 2.5-3.4 | Needs Work | Significant gaps to address |
| 1.5-2.4 | Poor | Major overhaul needed |
| 0-1.4 | Critical | Fundamental issues |

**Always present the final score prominently at the top of the audit report:**
```
AI RANK SCORE: X.X / 5.0 (Rating)
├── LLM Score:   X.X / 5.0
└── AGENT Score: X.X / 5.0
```

### Phase 3: Rewrite Content

Apply both frameworks:

**For Answer Engines:**
- Answer-first intro with quotable summary
- Intent-matched H2/H3 headings
- Scannable lists, tables, FAQs
- Proof blocks with citations

**For Agents:**
- Structured data blocks (specs, pricing, limits)
- Machine-readable tables (not prose)
- Clear action links
- Explicit facts over marketing language

### Phase 4: Generate Outputs

#### 1. Optimized Content
- Same format as input
- Both LLM and AGENT optimizations applied

#### 2. Dual Audit Report
```markdown
## LLM + AGENT Audit Report

AI RANK SCORE: X.X / 5.0 (Rating)
├── LLM Score:   X.X / 5.0
└── AGENT Score: X.X / 5.0

### LLM Scores (Answer Engines)
| Principle | Weight | Score | Weighted | Notes |
|-----------|--------|-------|----------|-------|
| Answer-first | 20% | X | X.XX | |
| Intent headings | 15% | X | X.XX | |
| Clear structure | 20% | X | X.XX | |
| Schema markup | 15% | X | X.XX | |
| Trusted sources | 15% | X | X.XX | |
| Unique perspective | 15% | X | X.XX | |
| **LLM Total** | | | **X.X** | |

### AGENT Scores (Autonomous Agents)
| Pillar | Weight | Score | Weighted | Notes |
|--------|--------|-------|----------|-------|
| Accessible data | 25% | X | X.XX | |
| Grounded facts | 20% | X | X.XX | |
| Endpoints | 20% | X | X.XX | |
| Navigable | 15% | X | X.XX | |
| Trust markers | 20% | X | X.XX | |
| **AGENT Total** | | | **X.X** | |

### Changes Made
- [Before/after for each change]

### Remaining Gaps
- [Missing sources, unclear facts, etc.]
```

#### 3. Schema Suggestions
```json
// FAQPage, HowTo, Product, Article, SoftwareApplication, etc.
```

#### 4. Extraction Preview (Answer Engines)
```markdown
### Answer LLMs Should Quote
[2-5 sentence quotable answer]

### Key Facts to Extract
1. ...
2. ...
```

#### 5. Agent Decision Data (Autonomous Agents)
```markdown
### Structured Facts for Agents
- Product: [name]
- Category: [type]
- Pricing: [structured]
- Limits: [explicit]
- Integrations: [list]
- Action URL: [link]
```

### Phase 5: Site-Level Recommendations

After auditing pages, check site-level items:

- Run Site-Level Checklist
- Generate missing discovery files (llms.txt, agents.txt, etc.)
- Recommend MCP Registry submission if applicable
- Identify missing schemas site-wide

---

## Examples

### Example 1: LLM Answer Engine Optimization

**Target query:** "best quiz app for Shopify"

**Bad (unmarketable to LLMs):**
```
RevenueHunt helps you create beautiful product recommendation
quizzes that increase conversions and grow your email list.
```

**Good (LLM-quotable):**
```markdown
# Best Quiz App for Shopify

RevenueHunt is the leading product recommendation quiz app for
Shopify, used by over 4,000 stores to increase conversions by
an average of 30% (internal data, 2024).

## Why RevenueHunt is the Best Shopify Quiz App

| Feature | RevenueHunt | Competitor A | Competitor B |
|---------|-------------|--------------|--------------|
| Shopify native | Yes | No (embed only) | Yes |
| Conditional logic | Unlimited | 5 rules | 10 rules |
| Product sync | Real-time | Manual | Daily |
| Starting price | $39/mo | $49/mo | $29/mo |
| Free plan | Yes (100 views) | No | Yes (50 views) |

## Who Should Use RevenueHunt?

**Best for:**
- Shopify stores with 50+ products needing personalized recommendations
- Brands wanting to collect zero-party data for email marketing
- Stores selling configurable products (skincare, supplements, fashion)

**Not ideal for:**
- Single-product stores
- Stores under 100 visitors/month
- Businesses needing survey-only (no product recommendations)

## How RevenueHunt Compares

RevenueHunt ranks #1 on the Shopify App Store for "product quiz"
with a 4.9/5 rating from 500+ reviews. Unlike competitors, it offers:

1. **Unlimited conditional logic** - no artificial caps on quiz complexity
2. **Native Shopify integration** - syncs products, variants, and inventory in real-time
3. **Built-in analytics** - conversion tracking without third-party tools

> "RevenueHunt increased our email capture rate by 45% and average
> order value by 22%." — [Store Name], Shopify Plus merchant

## FAQ

### Is RevenueHunt the best quiz app for Shopify?
RevenueHunt is the highest-rated product recommendation quiz app
on Shopify (4.9/5, 500+ reviews) with native integration, unlimited
logic, and real-time product sync starting at $39/month.

### How much does RevenueHunt cost?
Plans start at $39/month for 1,000 quiz views. A free plan with
100 views/month is available for testing.
```

**Why this works for LLMs:**
- H1 matches the exact query "Best Quiz App for Shopify"
- First sentence directly answers the question with a claim
- Comparison table gives LLMs extractable data
- "Who should use" and "not ideal for" prevents bad recommendations
- FAQ section uses question-format headings
- Quotable customer testimonial with attribution
- Specific numbers throughout (4.9/5, 500+ reviews, $39/mo)

---

### Example 2: Agent-Friendly SaaS (RevenueHunt)

**Bad (human-only):**
```
RevenueHunt helps you create beautiful product recommendation
quizzes that increase conversions and grow your email list.
```

**Good (agent-friendly):**
```markdown
## What is RevenueHunt?

RevenueHunt is a product recommendation quiz builder for e-commerce
stores. Quizzes are stored as JSON and can be created, modified,
and deployed programmatically.

## Agent Integration Options

| Method | Use Case | Documentation |
|--------|----------|---------------|
| MCP Server | AI agents can create/edit quizzes directly | [MCP Docs](https://docs.revenuehunt.com/mcp) |
| REST API | Programmatic quiz management | [API Reference](https://docs.revenuehunt.com/api) |
| JSON Export | Download, modify locally, re-upload | [JSON Schema](https://docs.revenuehunt.com/schema) |

## Quiz JSON Schema

Quizzes are fully defined in JSON. An agent can:
- Create a quiz from scratch using the schema
- Download an existing quiz, modify it, and upload changes
- Access quiz results and analytics via API

**Schema location:** `https://docs.revenuehunt.com/schema/quiz.json`

## Quick Start for Agents

1. Authenticate via API key or MCP
2. GET /quizzes to list existing quizzes
3. POST /quizzes with JSON body to create
4. PUT /quizzes/{id} to update

[Get API Key →](https://admin.revenuehunt.com/settings/api)
```

**Why this works for agents:**
- Explicit integration methods in a table
- Direct links to schemas and documentation
- Step-by-step programmatic workflow
- Machine-readable endpoints listed

---

### Example 3: llms.txt File

```markdown
# RevenueHunt

> Product recommendation quiz builder for Shopify, WooCommerce, and BigCommerce.

RevenueHunt helps e-commerce stores create personalized product recommendation
quizzes that increase conversions and collect zero-party data. Used by 4,000+
stores with a 4.9/5 rating on Shopify App Store.

## Key Pages

- [Homepage](https://revenuehunt.com): Product overview and features
- [Pricing](https://revenuehunt.com/pricing): Plans from $0-$299/mo
- [How It Works](https://revenuehunt.com/how-it-works): Quiz builder walkthrough

## Documentation

- [Getting Started](https://docs.revenuehunt.com/start): Quick start guide
- [API Reference](https://docs.revenuehunt.com/api): REST API documentation
- [MCP Server](https://docs.revenuehunt.com/mcp): AI agent integration
- [JSON Schema](https://docs.revenuehunt.com/schema): Quiz data structure

## Integrations

- [Shopify](https://docs.revenuehunt.com/shopify): Native app integration
- [Klaviyo](https://docs.revenuehunt.com/klaviyo): Email marketing sync
- [All Integrations](https://revenuehunt.com/integrations): Full list

## Support

- [Help Center](https://help.revenuehunt.com)
- [Contact](https://revenuehunt.com/contact)
```

---

### Example 4: agents.txt File

```yaml
# RevenueHunt agents.txt

name: RevenueHunt
description: Product recommendation quiz builder for e-commerce. Agents can create, modify, and deploy quizzes programmatically.
website: https://revenuehunt.com
documentation: https://docs.revenuehunt.com

# API Access
api:
  base_url: https://api.revenuehunt.com/v1
  auth_type: api_key
  auth_header: X-API-Key
  documentation: https://docs.revenuehunt.com/api
  rate_limit: 1000/min

# MCP Server
mcp:
  endpoint: https://mcp.revenuehunt.com
  registry: https://registry.modelcontextprotocol.io/servers/revenuehunt
  documentation: https://docs.revenuehunt.com/mcp

# Agent Capabilities
capabilities:
  - list_quizzes
  - create_quiz
  - update_quiz
  - delete_quiz
  - get_quiz_results
  - export_quiz_json
  - import_quiz_json

# Data Formats
schemas:
  quiz: https://docs.revenuehunt.com/schema/quiz.json
  results: https://docs.revenuehunt.com/schema/results.json

# Contact
support: support@revenuehunt.com
```

---

## Safety & Honesty Rules

- **Never invent** stats, customers, or results
- **Mark uncertain claims** with `[NEEDS SOURCE]`
- **Be explicit** - agents can't infer, state facts directly
- **No dark patterns** - agents will learn to distrust
- **Preserve accuracy** - optimization does not mean distortion

---

## Quick Commands

- `/ai-rank` - Full workflow (gather context, audit, rewrite)
- `/ai-rank audit` - Dual audit only, no rewrite
- `/ai-rank rewrite` - Rewrite with both frameworks
- `/ai-rank schema` - Generate all schema suggestions
- `/ai-rank agent` - Focus on autonomous agent readiness only
- `/ai-rank answer` - Focus on answer engines only
- `/ai-rank checklist` - Output full page + site checklists
- `/ai-rank discovery` - Generate discovery files (llms.txt, agents.txt, etc.)
