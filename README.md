# AI Agent Skills Collection

A curated collection of 125+ reusable skills for AI coding agents — Claude Code, ChatGPT, Cursor, Windsurf, and other AI-powered development tools.

These skills turn general-purpose AI assistants into specialized experts for WordPress development, UI/UX design, SEO, marketing, frontend engineering, and more.

## What Are Skills?

Skills are structured prompt files that give AI agents domain expertise. Instead of explaining what you need from scratch every time, you invoke a skill and the agent instantly becomes an expert in that domain.

```
/wp-block        → Scaffold a Gutenberg block with block.json, PHP, and React
/seo-audit       → Run a comprehensive technical SEO audit
/frontend-design → Build a production-grade UI component
/page-cro        → Optimize a landing page for conversions
```

## Repository Structure

```
skills/
├── wordpress/      32 skills — blocks, themes, plugins, REST API, WP-CLI, Bricks, Etch
├── design/         32 skills — UI/UX, design systems, accessibility, SVG, animations
├── marketing/      32 skills — copy, CRO, email, ads, brand, pricing, launch strategy
├── seo/             9 skills — technical SEO, semantic SEO, schema, AI search optimization
├── frontend/        8 skills — CSS patterns, HTML components, framework converters
├── tools/          10 skills — docs, changelogs, PDF generation, project planning
└── uncategorized/   — Skills pending categorization

commands/           Custom slash commands for Claude Code
scripts/            Sync and validation utilities
```

## Skill Catalog

### WordPress (32 skills)

| Skill | Description |
|-------|-------------|
| `wp-block` | Scaffold Gutenberg block development with block.json and React |
| `wp-block-quick` | Quick custom Gutenberg block builder |
| `wp-block-development` | Full WordPress block development guide |
| `wp-block-themes` | Block theme development — theme.json, templates, patterns |
| `wp-theme` | Quick scaffold for block theme development |
| `wp-block-patterns` | Create, register, and organize block patterns |
| `wp-block-layouts` | Ready-to-use layout patterns using core blocks |
| `wp-block-markup` | Block markup syntax, delimiters, and serialization |
| `wp-block-styles` | Style blocks with theme.json presets and variations |
| `wp-core-blocks` | Reference for all 113+ WordPress core blocks |
| `wp-rest-api` | Build and extend WordPress REST API endpoints |
| `wp-plugin` | Scaffold WordPress plugin development |
| `wp-plugin-development` | Full plugin development — hooks, admin UI, security |
| `wp-phpstan` | PHPStan static analysis for WordPress projects |
| `wp-wpcli-and-ops` | WP-CLI operations, scripting, and automation |
| `wp-performance` | Backend performance — profiling, caching, queries |
| `wp-playground` | WordPress Playground workflows and blueprints |
| `wp-interactivity-api` | Interactivity API — data-wp-* directives and stores |
| `wp-abilities-api` | WordPress Abilities API for permissions |
| `wordpress-router` | Classify WordPress repos and route to correct workflow |
| `acf-blocks` | ACF custom Gutenberg blocks |
| `md-section` | Convert HTML layouts to MD Section blocks |
| `md-theme-blocks` | Marketers Delight theme Gutenberg blocks |
| `wpds` | WordPress Design System components and tokens |
| `page-block` | Build section-based pages with Page Block |
| `greenlight-vibe` | Design with Greenshift/GreenLight WordPress blocks |
| `wp-project-triage` | Inspect and classify WordPress repositories |
| `bricks` | Bricks Builder — elements, templates, layouts, hooks, forms, queries, WooCommerce |
| `etch-layouts` | Etch page builder — blocks, components, dynamic data, JSON authoring, REST API |

### Design (32 skills)

| Skill | Description |
|-------|-------------|
| `design` | Comprehensive design — logos, brand identity, banners, icons |
| `frontend-design` | Production-grade frontend interfaces |
| `frontend-design-pro` | High-quality frontend with matched real photos |
| `ui-design-brain` | Production-grade UI from 60+ component patterns |
| `ui-styling` | Accessible UI with shadcn/ui, Radix, and Tailwind |
| `ui-ux-pro-max` | Full UI/UX design intelligence — 50+ styles, 161 palettes |
| `banner-design` | Social media, ads, hero, and print banners |
| `cinematic-editorial-graphics` | Magazine-quality editorial hero images |
| `desktop-app-showcase` | macOS-style desktop application mockups |
| `hand-drawn-explainers` | Notebook-style sketch explainer graphics |
| `svg-graphics` | SVG data visualizations, illustrations, dashboards |
| `monoline-icons` | Apple-style monoline icon illustrations |
| `featured-image-creator` | Blog featured images as SVG |
| `saas-product-graphics` | SaaS product UI showcase graphics |
| `design-system` | Token architecture, component specs, slides |
| `modern-frontend-design` | Premium frontend like high-end SaaS products |
| `extract` | Extract reusable components into design systems |
| `distill` | Strip designs to their essence |
| `bolder` | Amplify safe designs to be more visually interesting |
| `colorize` | Add strategic color to monochromatic interfaces |
| `delight` | Add moments of joy and personality |
| `animate` | Purposeful animations and micro-interactions |
| `adapt` | Responsive design across devices and contexts |
| `quieter` | Tone down overly bold designs |
| `normalize` | Match designs to your design system |
| `polish` | Final quality pass before shipping |
| `onboard` | Design onboarding flows and empty states |
| `critique` | Evaluate design effectiveness from UX perspective |
| `harden` | Improve resilience — error handling, i18n, edge cases |
| `audit` | Comprehensive UI audit — a11y, performance, theming |

### Marketing (32 skills)

| Skill | Description |
|-------|-------------|
| `copywriting` | Marketing copy for any page type |
| `copy-editing` | Edit and improve existing marketing copy |
| `content-strategy` | Plan content strategy and topic clusters |
| `cold-email` | B2B cold emails and follow-up sequences |
| `email-sequence` | Automated email flows and drip campaigns |
| `social-content` | Social media content for all platforms |
| `marketing-ideas` | Marketing strategy and growth ideas |
| `marketing-psychology` | Psychological principles for marketing |
| `paid-ads` | Paid campaigns — Google, Meta, LinkedIn, X |
| `ad-creative` | Generate and iterate ad creative at scale |
| `sales-enablement` | Sales decks, one-pagers, objection handling |
| `pricing-strategy` | Pricing decisions, packaging, monetization |
| `referral-program` | Referral and affiliate programs |
| `revops` | Revenue operations and lead lifecycle |
| `competitor-alternatives` | Competitor comparison and alternative pages |
| `launch-strategy` | Product launch and release strategy |
| `free-tool-strategy` | Free marketing tools and calculators |
| `churn-prevention` | Reduce churn, cancellation flows, save offers |
| `product-marketing-context` | Product marketing context documents |
| `page-cro` | Optimize marketing pages for conversions |
| `signup-flow-cro` | Optimize signup and registration flows |
| `onboarding-cro` | Post-signup onboarding and activation |
| `form-cro` | Optimize lead capture and contact forms |
| `popup-cro` | Create and optimize popups and modals |
| `paywall-upgrade-cro` | In-app paywalls and upgrade screens |
| `ab-test-setup` | Plan and implement A/B tests |
| `stop-slop` | Remove AI writing patterns from prose |
| `clarify` | Improve unclear UX copy and microcopy |
| `slides` | Strategic HTML presentations with Chart.js |

### SEO (9 skills)

| Skill | Description |
|-------|-------------|
| `seo-audit` | Technical SEO audit and diagnostics |
| `seo-rank` | Comprehensive 2026 SEO optimization |
| `ai-rank` | Optimize content for LLM discoverability |
| `ai-seo` | Optimize for AI search engines and citations |
| `koray` | Semantic SEO using Koray Tugberk methodology |
| `schema-markup` | JSON-LD structured data and rich snippets |
| `programmatic-seo` | Template-based pages at scale |
| `site-architecture` | Site structure, hierarchy, and internal linking |
| `analytics-tracking` | GA4, GTM, conversion tracking setup |

### Frontend (8 skills)

| Skill | Description |
|-------|-------------|
| `frontend-css-patterns` | Framework-agnostic CSS patterns |
| `just-html` | Self-contained HTML components |
| `semantic-html` | Semantic, accessible HTML structure |
| `react-pdf` | Generate PDFs with React-PDF |
| `html-to-generateblocks` | Convert HTML/CSS to GenerateBlocks V2 |
| `elementor-to-generateblocks` | Convert Elementor to GenerateBlocks |
| `figma-to-generateblocks` | Convert Figma designs to GenerateBlocks |
| `remotion-best-practices` | Remotion video creation in React |

### Tools (10 skills)

| Skill | Description |
|-------|-------------|
| `docs` | Generate technical documentation |
| `readme` | Generate comprehensive README files |
| `changelog` | Structured changelogs from git history |
| `planning-with-files` | Markdown-based planning and progress tracking |
| `find-skills` | Discover and install new agent skills |
| `product-box-converter` | Convert content to ACF product box blocks |
| `product-box-block` | URL to ACF product box block |
| `optimize` | Interface performance optimization |
| `11labs` | Convert text to ElevenLabs audio scripts |
| `TTS` | Text-to-speech with ElevenLabs |

## Usage

### With Claude Code

Skills are loaded as slash commands. Place skill directories in `~/.claude/skills/` and invoke them:

```bash
# In any Claude Code conversation
/wp-block          # Start building a Gutenberg block
/seo-audit         # Audit a site for SEO issues
/frontend-design   # Build a UI component
```

### With Other AI Tools

Copy the content of any `SKILL.md` file into your AI tool's system prompt, custom instructions, or project context. The skills are tool-agnostic — they work with any LLM that supports system prompts.

## Installation

```bash
# Clone the repository
git clone https://github.com/wpgaurav/WordPress-skills.git

# For Claude Code — symlink skills to your config
ln -s $(pwd)/WordPress-skills/skills ~/.claude/skills

# Or copy individual skills
cp -r WordPress-skills/skills/wordpress/wp-block ~/.claude/skills/
```

## Contributing

1. Each skill lives in its own directory with a `SKILL.md` file.
2. Skills must not contain personal data, API keys, or hardcoded domains.
3. Use `yoursite.com` or `example.com` as placeholder domains.
4. Run `./scripts/check-personal-data.sh` before submitting.

## Syncing from Local Skills

If you maintain skills locally and want to sync them to this repo:

```bash
# From repo root — copies SKILL.md files, excludes personal data
./scripts/sync-skills.sh

# Verify no personal data leaked
./scripts/check-personal-data.sh
```

## Author

**Gaurav Tiwari** — WordPress developer, designer, and AI tools builder.

- [gauravtiwari.org](https://gauravtiwari.org)
- [GitHub (@wpgaurav)](https://github.com/wpgaurav)
- [X (@wpgaurav)](https://x.com/wpgaurav)
- [LinkedIn](https://linkedin.com/in/wpgaurav)

## License

MIT
