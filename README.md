# AI Agent Skills Collection

[![Buy me a coffee](https://img.shields.io/badge/Buy%20me%20a%20coffee-FFDD00?style=flat&logo=buymeacoffee&logoColor=black)](https://buymeacoffee.com/gauravtiwari)

A curated collection of 120 reusable skills for AI coding agents — Claude Code, ChatGPT, Cursor, Windsurf, and other AI-powered development tools. I wrote 42 of them; the other 78 come from open-source projects such as impeccable, marketingskills and WordPress's own agent skills, credited in [NOTICE.md](./NOTICE.md).

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
├── design/         31 skills — UI/UX, design systems, SVG, animations
├── marketing/      32 skills — copy, CRO, email, ads, brand, pricing, launch strategy
├── seo/             9 skills — technical SEO, semantic SEO, schema, AI search optimization
├── frontend/        5 skills — HTML components, PDF generation, GenerateBlocks converters
├── tools/          10 skills — docs, changelogs, project planning, product boxes, audio
└── uncategorized/   1 skill  — skills pending categorization

commands/           Custom slash commands for Claude Code
scripts/            Sync and license/personal-data checks
```

## Skill Catalog

I wrote 42 of the 120 skills. The rest come from other open-source projects and keep their original licenses; the Origin column names each source, and [NOTICE.md](./NOTICE.md) has the full attribution.

### WordPress (32 skills)

| Skill | Description | Origin |
|-------|-------------|--------|
| `wp-block` | Scaffold Gutenberg block development with block.json and React | Gaurav Tiwari |
| `wp-block-quick` | Quick custom Gutenberg block builder | Gaurav Tiwari |
| `wp-block-development` | Full WordPress block development guide | WordPress/agent-skills (GPL-2.0+) |
| `wp-block-themes` | Block theme development — theme.json, templates, patterns | WordPress/agent-skills (GPL-2.0+) |
| `wp-theme` | Quick scaffold for block theme development | Gaurav Tiwari |
| `wp-block-patterns` | Create, register, and organize block patterns | Gaurav Tiwari |
| `wp-block-layouts` | Ready-to-use layout patterns using core blocks | Gaurav Tiwari |
| `wp-block-markup` | Block markup syntax, delimiters, and serialization | Gaurav Tiwari |
| `wp-block-styles` | Style blocks with theme.json presets and variations | Gaurav Tiwari |
| `wp-core-blocks` | Reference for all 113+ WordPress core blocks | Gaurav Tiwari |
| `wp-rest-api` | Build and extend WordPress REST API endpoints | WordPress/agent-skills (GPL-2.0+) |
| `wp-plugin` | Scaffold WordPress plugin development | Gaurav Tiwari |
| `wp-plugin-development` | Full plugin development — hooks, admin UI, security | WordPress/agent-skills (GPL-2.0+) |
| `wp-phpstan` | PHPStan static analysis for WordPress projects | WordPress/agent-skills (GPL-2.0+) |
| `wp-wpcli-and-ops` | WP-CLI operations, scripting, and automation | WordPress/agent-skills (GPL-2.0+) |
| `wp-performance` | Backend performance — profiling, caching, queries | WordPress/agent-skills (GPL-2.0+) |
| `wp-playground` | WordPress Playground workflows and blueprints | WordPress/agent-skills (GPL-2.0+) |
| `wp-interactivity-api` | Interactivity API — data-wp-* directives and stores | WordPress/agent-skills (GPL-2.0+) |
| `wp-abilities-api` | WordPress Abilities API for permissions | WordPress/agent-skills (GPL-2.0+) |
| `wordpress-router` | Classify WordPress repos and route to correct workflow | WordPress/agent-skills (GPL-2.0+) |
| `acf-blocks` | ACF custom Gutenberg blocks | Gaurav Tiwari |
| `md-section` | Convert HTML layouts to MD Section blocks | Gaurav Tiwari |
| `md-theme-blocks` | Marketers Delight theme Gutenberg blocks | Gaurav Tiwari |
| `wpds` | WordPress Design System components and tokens | WordPress/agent-skills (GPL-2.0+) |
| `page-block` | Build section-based pages with Page Block | Gaurav Tiwari |
| `greenlight-vibe` | Design with Greenshift/GreenLight WordPress blocks | Greenshift (GPL-2.0+) |
| `wp-project-triage` | Inspect and classify WordPress repositories | WordPress/agent-skills (GPL-2.0+) |
| `bricks` | Bricks Builder — elements, templates, layouts, hooks, forms, queries, WooCommerce | Gaurav Tiwari |
| `etch-layouts` | Etch page builder — blocks, components, dynamic data, JSON authoring, REST API | Gaurav Tiwari |
| `fluent-community` | Push posts, docs, and changelogs to Fluent Community via REST | Gaurav Tiwari |
| `wp-plugin-quick` | Quick WordPress plugin scaffold | Gaurav Tiwari |
| `wp-theme-quick` | Quick block theme scaffold | Gaurav Tiwari |

### Design (31 skills)

| Skill | Description | Origin |
|-------|-------------|--------|
| `design` | Comprehensive design — logos, brand identity, banners, icons | UI UX Pro Max (MIT) |
| `frontend-design` | Production-grade frontend interfaces | impeccable (Apache-2.0) |
| `ui-design-brain` | Production-grade UI from 60+ component patterns | UI Design Brain (MIT) |
| `ui-styling` | Accessible UI with shadcn/ui, Radix, and Tailwind | UI UX Pro Max (MIT) |
| `ui-ux-pro-max` | Full UI/UX design intelligence — 50+ styles, 161 palettes | UI UX Pro Max (MIT) |
| `banner-design` | Social media, ads, hero, and print banners | UI UX Pro Max (MIT) |
| `cinematic-editorial-graphics` | Magazine-quality editorial hero images | Gaurav Tiwari |
| `desktop-app-showcase` | macOS-style desktop application mockups | Gaurav Tiwari |
| `hand-drawn-explainers` | Notebook-style sketch explainer graphics | Gaurav Tiwari |
| `svg-graphics` | SVG data visualizations, illustrations, dashboards | Gaurav Tiwari |
| `monoline-icons` | Apple-style monoline icon illustrations | Gaurav Tiwari |
| `featured-image-creator` | Blog featured images as SVG | Gaurav Tiwari |
| `saas-product-graphics` | SaaS product UI showcase graphics | Gaurav Tiwari |
| `design-system` | Token architecture, component specs, slides | UI UX Pro Max (MIT) |
| `modern-frontend-design` | Premium frontend like high-end SaaS products | Devesh Punjabi (MIT) |
| `extract` | Extract reusable components into design systems | impeccable (Apache-2.0) |
| `distill` | Strip designs to their essence | impeccable (Apache-2.0) |
| `bolder` | Amplify safe designs to be more visually interesting | impeccable (Apache-2.0) |
| `colorize` | Add strategic color to monochromatic interfaces | impeccable (Apache-2.0) |
| `delight` | Add moments of joy and personality | impeccable (Apache-2.0) |
| `animate` | Purposeful animations and micro-interactions | impeccable (Apache-2.0) |
| `adapt` | Responsive design across devices and contexts | impeccable (Apache-2.0) |
| `quieter` | Tone down overly bold designs | impeccable (Apache-2.0) |
| `normalize` | Match designs to your design system | impeccable (Apache-2.0) |
| `polish` | Final quality pass before shipping | impeccable (Apache-2.0) |
| `onboard` | Design onboarding flows and empty states | impeccable (Apache-2.0) |
| `critique` | Evaluate design effectiveness from UX perspective | impeccable (Apache-2.0) |
| `harden` | Improve resilience — error handling, i18n, edge cases | impeccable (Apache-2.0) |
| `audit` | Comprehensive UI audit — a11y, performance, theming | impeccable (Apache-2.0) |
| `teach-impeccable` | One-time setup that saves project design context for the other impeccable skills | impeccable (Apache-2.0) |
| `ui-skills` | Opinionated constraints for building interfaces with agents | ibelick/ui-skills (MIT) |

### Marketing (32 skills)

| Skill | Description | Origin |
|-------|-------------|--------|
| `copywriting` | Marketing copy for any page type | marketingskills (MIT) |
| `copy-editing` | Edit and improve existing marketing copy | marketingskills (MIT) |
| `content-strategy` | Plan content strategy and topic clusters | marketingskills (MIT) |
| `cold-email` | B2B cold emails and follow-up sequences | marketingskills (MIT) |
| `email-sequence` | Automated email flows and drip campaigns | marketingskills (MIT) |
| `social-content` | Social media content for all platforms | marketingskills (MIT) |
| `marketing-ideas` | Marketing strategy and growth ideas | marketingskills (MIT) |
| `marketing-psychology` | Psychological principles for marketing | marketingskills (MIT) |
| `paid-ads` | Paid campaigns — Google, Meta, LinkedIn, X | marketingskills (MIT) |
| `ad-creative` | Generate and iterate ad creative at scale | marketingskills (MIT) |
| `sales-enablement` | Sales decks, one-pagers, objection handling | marketingskills (MIT) |
| `pricing-strategy` | Pricing decisions, packaging, monetization | marketingskills (MIT) |
| `referral-program` | Referral and affiliate programs | marketingskills (MIT) |
| `revops` | Revenue operations and lead lifecycle | marketingskills (MIT) |
| `competitor-alternatives` | Competitor comparison and alternative pages | marketingskills (MIT) |
| `launch-strategy` | Product launch and release strategy | marketingskills (MIT) |
| `free-tool-strategy` | Free marketing tools and calculators | marketingskills (MIT) |
| `churn-prevention` | Reduce churn, cancellation flows, save offers | marketingskills (MIT) |
| `product-marketing-context` | Product marketing context documents | marketingskills (MIT) |
| `page-cro` | Optimize marketing pages for conversions | marketingskills (MIT) |
| `signup-flow-cro` | Optimize signup and registration flows | marketingskills (MIT) |
| `onboarding-cro` | Post-signup onboarding and activation | marketingskills (MIT) |
| `form-cro` | Optimize lead capture and contact forms | marketingskills (MIT) |
| `popup-cro` | Create and optimize popups and modals | marketingskills (MIT) |
| `paywall-upgrade-cro` | In-app paywalls and upgrade screens | marketingskills (MIT) |
| `ab-test-setup` | Plan and implement A/B tests | marketingskills (MIT) |
| `stop-slop` | Remove AI writing patterns without flattening the writer's voice | Hardik Pandya, extended by Gaurav Tiwari (MIT) |
| `clarify` | Improve unclear UX copy and microcopy | impeccable (Apache-2.0) |
| `slides` | Strategic HTML presentations with Chart.js | UI UX Pro Max (MIT) |
| `brand` | Brand voice, visual identity, and messaging frameworks | UI UX Pro Max (MIT) |
| `mkbhd-voice` | Conversational video-script voice | Gaurav Tiwari |
| `omm-style` | Data-driven WordPress performance, hosting, and SEO articles | Gaurav Tiwari |

### SEO (9 skills)

| Skill | Description | Origin |
|-------|-------------|--------|
| `seo-audit` | Technical SEO audit and diagnostics | marketingskills (MIT) |
| `seo-rank` | Comprehensive 2026 SEO optimization | Gaurav Tiwari |
| `ai-rank` | Optimize content for LLM discoverability | Gaurav Tiwari |
| `ai-seo` | Optimize for AI search engines and citations | marketingskills (MIT) |
| `koray` | Semantic SEO using Koray Tugberk methodology | Gaurav Tiwari |
| `schema-markup` | JSON-LD structured data and rich snippets | marketingskills (MIT) |
| `programmatic-seo` | Template-based pages at scale | marketingskills (MIT) |
| `site-architecture` | Site structure, hierarchy, and internal linking | marketingskills (MIT) |
| `analytics-tracking` | GA4, GTM, conversion tracking setup | marketingskills (MIT) |

### Frontend (5 skills)

| Skill | Description | Origin |
|-------|-------------|--------|
| `just-html` | Self-contained HTML components | Gaurav Tiwari |
| `react-pdf` | Generate PDFs with React-PDF | molefrog/skills (MIT) |
| `html-to-generateblocks` | Convert HTML/CSS to GenerateBlocks V2 | Gaurav Tiwari |
| `elementor-to-generateblocks` | Convert Elementor to GenerateBlocks | Gaurav Tiwari |
| `figma-to-generateblocks` | Convert Figma designs to GenerateBlocks | Gaurav Tiwari |

### Tools (10 skills)

| Skill | Description | Origin |
|-------|-------------|--------|
| `docs` | Generate technical documentation | Gaurav Tiwari |
| `readme` | Generate comprehensive README files | Gaurav Tiwari |
| `changelog` | Structured changelogs from git history | Gaurav Tiwari |
| `planning-with-files` | Markdown-based planning and progress tracking | planning-with-files (MIT) |
| `find-skills` | Discover and install new agent skills | vercel-labs/skills (MIT) |
| `product-box-converter` | Convert content to ACF product box blocks | Gaurav Tiwari |
| `product-box-block` | URL to ACF product box block | Gaurav Tiwari |
| `optimize` | Interface performance optimization | impeccable (Apache-2.0) |
| `11labs` | Convert text to ElevenLabs audio scripts | Gaurav Tiwari |
| `TTS` | Text-to-speech with ElevenLabs | Gaurav Tiwari |

### Uncategorized (1 skill)

| Skill | Description | Origin |
|-------|-------------|--------|
| `generateblocks-layouts` | Build layouts with GenerateBlocks V2 elements | Gaurav Tiwari |

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
2. Every `SKILL.md` declares its license in frontmatter (`license: MIT`, `license: Apache-2.0` or `license: GPL-2.0-or-later`).
3. A skill from another project keeps its original license, names its upstream in `metadata.source`, opens with an attribution note, and gets an entry in [NOTICE.md](./NOTICE.md). Skills without a license that allows redistribution are not accepted.
4. Skills must not contain personal data, API keys, or hardcoded domains.
5. Use `yoursite.com` or `example.com` as placeholder domains.
6. Run `./scripts/check-licenses.sh` and `./scripts/check-personal-data.sh` before submitting.

## Syncing from Local Skills

If you maintain skills locally and want to sync them to this repo:

```bash
# From repo root — updates skills written for this repo, excludes personal data
./scripts/sync-skills.sh

# Add a new skill you wrote (new skills are never picked up automatically)
./scripts/sync-skills.sh --add my-new-skill

# Verify licensing and that no personal data leaked
./scripts/check-licenses.sh
./scripts/check-personal-data.sh
```

The sync script only touches skills that carry `license: MIT` and no `metadata.source`. Third-party skills are updated by hand from their upstream so their attribution stays intact.

## Support This Project

This collection gives Claude Code, ChatGPT, Cursor and Windsurf 120 open source skills for WordPress, design, SEO, marketing and frontend work: 42 I wrote, plus 78 I collected from other projects with their authors credited. I keep adding and revising skills here and each one goes through a license and personal-data check before it's published.

If running `/wp-block` or `/seo-audit` gave your agent the context it needed without you explaining the task from scratch, you can buy me a coffee.

<a href="https://buymeacoffee.com/gauravtiwari"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy me a coffee" height="50"></a>

An issue with the prompt you ran and the output that went wrong shows me where a skill misfired, and a star on the repo is welcome too.

## Author

**Gaurav Tiwari** — WordPress developer, designer, and AI tools builder.

- [gauravtiwari.org](https://gauravtiwari.org)
- [GitHub (@wpgaurav)](https://github.com/wpgaurav)
- [X (@wpgaurav)](https://x.com/wpgaurav)
- [LinkedIn](https://linkedin.com/in/wpgaurav)

## License

The skills I wrote and the repository scaffolding are MIT ([LICENSE](./LICENSE)). The 18 skills adapted from impeccable are Apache-2.0 ([LICENSE-APACHE-2.0](./LICENSE-APACHE-2.0)). The 13 skills from WordPress/agent-skills and `greenlight-vibe` are GPL-2.0-or-later ([LICENSE-GPL-2.0](./LICENSE-GPL-2.0)). The remaining third-party skills are MIT under their own authors' copyright. Each `SKILL.md` names its license in frontmatter, and [NOTICE.md](./NOTICE.md) lists every source, copyright holder and change.
