# Notices and attribution

This repository collects 120 agent skills (124 `SKILL.md` files, counting the four Bricks sub-skills). Gaurav Tiwari wrote 42 of them. The other 78 come from 12 open-source projects and keep their original licenses.

Every `SKILL.md` names its license in frontmatter as an SPDX identifier (`license: MIT`, `license: Apache-2.0` or `license: GPL-2.0-or-later`). Every third-party skill also names its upstream repository in `metadata.source` and opens with a one-line attribution note. This file records where each skill came from and what changed.

The MIT license in [LICENSE](./LICENSE) covers only the skills written for this collection and the repository scaffolding (`scripts/`, `README.md`, `CLAUDE.md`, this file). It does not cover the third-party skills below.

## Summary

| Source | Copyright holder | License | Skills |
|---|---|---|---|
| This repository | Gaurav Tiwari | MIT | 42 |
| [marketingskills](https://github.com/coreyhaines31/marketingskills) | Corey Haines | MIT | 32 |
| [impeccable](https://github.com/pbakaus/impeccable) | Paul Bakaus | Apache-2.0 | 18 |
| [Agent Skills for WordPress](https://github.com/WordPress/agent-skills) | WordPress Contributors | GPL-2.0-or-later | 13 |
| [UI UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) (ClaudeKit) | Next Level Builder | MIT | 7 |
| [GreenLight Vibe](https://github.com/wpsoul/greenlight-vibe), via the Greenshift plugin | Wpsoul | GPL-2.0-or-later | 1 |
| [stop-slop](https://github.com/hardikpandya/stop-slop) | Hardik Pandya | MIT | 1 |
| [ui-skills](https://github.com/ibelick/ui-skills) | Julien Thibeaut | MIT | 1 |
| [UI Design Brain](https://github.com/carmahhawwari/ui-design-brain) | UI Design Brain Contributors | MIT | 1 |
| [modern-frontend-skill](https://github.com/deveshpunjabi/modern-frontend-skill) | Devesh Punjabi | MIT | 1 |
| [molefrog/skills](https://github.com/molefrog/skills) | molefrog | MIT | 1 |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | Vercel, Inc. | MIT | 1 |
| [planning-with-files](https://github.com/OthmanAdi/planning-with-files) | Ahmad Adi | MIT | 1 |

Provenance was checked on 2026-10-24 by comparing every file in `skills/` against the full git history of each upstream repository. 68 third-party files are byte-identical to a file in their upstream history. The rest differ only in the ways listed below.

## Written for this collection (MIT)

Covered by [LICENSE](./LICENSE). Copyright (c) 2026 Gaurav Tiwari.

- `design/`: `cinematic-editorial-graphics`, `desktop-app-showcase`, `featured-image-creator`, `hand-drawn-explainers`, `monoline-icons`, `saas-product-graphics`, `svg-graphics`
- `frontend/`: `elementor-to-generateblocks`, `figma-to-generateblocks`, `html-to-generateblocks`, `just-html`
- `marketing/`: `mkbhd-voice`, `omm-style`
- `seo/`: `ai-rank`, `koray`, `seo-rank`
- `tools/`: `11labs`, `TTS`, `changelog`, `docs`, `product-box-block`, `product-box-converter`, `readme`
- `uncategorized/`: `generateblocks-layouts`
- `wordpress/`: `acf-blocks`, `bricks` (with `bricks-elements`, `bricks-hooks`, `bricks-layouts`, `bricks-templates`), `etch-layouts`, `fluent-community`, `md-section`, `md-theme-blocks`, `page-block`, `wp-block`, `wp-block-layouts`, `wp-block-markup`, `wp-block-patterns`, `wp-block-quick`, `wp-block-styles`, `wp-core-blocks`, `wp-plugin`, `wp-plugin-quick`, `wp-theme`, `wp-theme-quick`

The Bricks and GenerateBlocks skills are also maintained in their own repositories, [wpgaurav/bricks-skills](https://github.com/wpgaurav/bricks-skills) and [wpgaurav/generateblocks-skills](https://github.com/wpgaurav/generateblocks-skills). `mkbhd-voice` had no frontmatter; a name and description were added on 2026-10-24 so the license field has somewhere to live.

## marketingskills by Corey Haines (MIT)

Copyright (c) 2025 Corey Haines. Upstream: <https://github.com/coreyhaines31/marketingskills>.

- `marketing/`: `ab-test-setup`, `ad-creative`, `churn-prevention`, `cold-email`, `competitor-alternatives`, `content-strategy`, `copy-editing`, `copywriting`, `email-sequence`, `form-cro`, `free-tool-strategy`, `launch-strategy`, `marketing-ideas`, `marketing-psychology`, `onboarding-cro`, `page-cro`, `paid-ads`, `paywall-upgrade-cro`, `popup-cro`, `pricing-strategy`, `product-marketing-context`, `referral-program`, `revops`, `sales-enablement`, `signup-flow-cro`, `social-content`
- `seo/`: `ai-seo`, `analytics-tracking`, `programmatic-seo`, `schema-markup`, `seo-audit`, `site-architecture`

Each `SKILL.md` is byte-identical to the upstream `skills/<name>/SKILL.md` as it stood in March 2026 (upstream commits from 2026-03-04 to 2026-03-27). The only changes, made on 2026-10-24, are the `license: MIT` frontmatter, the `metadata.source` link and the attribution note. The skills mention companion skills and `references/` files that live upstream and are not included here.

## impeccable by Paul Bakaus (Apache License 2.0)

Copyright 2025 Paul Bakaus. Upstream: <https://github.com/pbakaus/impeccable>. A copy of the license is in [LICENSE-APACHE-2.0](./LICENSE-APACHE-2.0).

- `design/`: `adapt`, `animate`, `audit`, `bolder`, `colorize`, `critique`, `delight`, `distill`, `extract`, `frontend-design`, `harden`, `normalize`, `onboard`, `polish`, `quieter`, `teach-impeccable`
- `marketing/`: `clarify`
- `tools/`: `optimize`

Each `SKILL.md` is byte-identical to the matching file in impeccable's `.claude/skills/` folder as it stood on 2026-03-04 or 2026-03-05 (`frontend-design`: 2026-01-08). The method, checklists and examples are Paul Bakaus's work. Changes made in this repository, all on 2026-10-24: `license: Apache-2.0` frontmatter, a `metadata.source` link, and an attribution note under the frontmatter that marks each file as modified. In `frontend-design`, the frontmatter license text "Apache 2.0. Based on Anthropic's frontend-design skill. See NOTICE.md for attribution." became the SPDX identifier `Apache-2.0`; the attribution it pointed to is reproduced below. These folders stay under Apache-2.0. The MIT license of this repository does not cover them.

impeccable's own NOTICE file, as it read when these files were copied:

> Impeccable
> Copyright 2025 Paul Bakaus
>
> The `frontend-design` skill in this project builds on Anthropic's original frontend-design skill.
>
> Original work: https://github.com/anthropics/skills/tree/main/skills/frontend-design
> Original license: Apache License 2.0
> Copyright: 2025 Anthropic, PBC

## Agent Skills for WordPress (GPL-2.0-or-later)

Copyright (C) 2026 WordPress Contributors. Upstream: <https://github.com/WordPress/agent-skills>. A copy of the license is in [LICENSE-GPL-2.0](./LICENSE-GPL-2.0).

- `wordpress/`: `wordpress-router`, `wp-abilities-api`, `wp-block-development`, `wp-block-themes`, `wp-interactivity-api`, `wp-performance`, `wp-phpstan`, `wp-playground`, `wp-plugin-development`, `wp-project-triage`, `wp-rest-api`, `wp-wpcli-and-ops`, `wpds`

These are copies of the upstream `skills/<name>/SKILL.md` files as published between 2025-12-28 and 2026-01-27. Changes, as GPL-2.0 section 2(a) requires us to state: when the copies were made on 2026-03-30, the upstream `compatibility:` frontmatter line was dropped from each file; on 2026-10-24, `license: GPL-2.0-or-later` frontmatter, a `metadata.source` link and an attribution note were added. The skill text is otherwise unchanged. The helper scripts and `references/` files these skills call live in the upstream repository and are not included. You may copy, modify and redistribute these files under the terms of GPL-2.0-or-later.

## UI UX Pro Max by Next Level Builder (MIT)

Copyright (c) 2024 Next Level Builder. Upstream: <https://github.com/nextlevelbuilder/ui-ux-pro-max-skill>. The skills' own metadata names ClaudeKit as author.

- `design/`: `banner-design`, `design`, `design-system`, `ui-styling`, `ui-ux-pro-max`
- `marketing/`: `brand`, `slides`

Each `SKILL.md` is byte-identical to the upstream `.claude/skills/<name>/SKILL.md` as it stood on 2026-03-10. Changes made on 2026-10-24: `metadata.source` link and attribution note. Four files already declared `license: MIT`; `ui-ux-pro-max`, `brand` and `slides` gained that line. The scripts, data files and references these skills call live upstream and are not included.

## Single skills from other projects

**`wordpress/greenlight-vibe`** by Wpsoul (GPL-2.0-or-later). Byte-identical to [wpsoul/greenlight-vibe](https://github.com/wpsoul/greenlight-vibe) as of 2026-04-16 and to the copy shipped in the [Greenshift](https://wordpress.org/plugins/greenshift-animation-and-page-builder-blocks/) WordPress plugin at SVN revision r3510090 (2026-04-19). The standalone GitHub repository has no license file; this collection relies on the Greenshift plugin's "GPLv2 or later" license, under which the same file is distributed on WordPress.org. Changes made on 2026-10-24: `license: GPL-2.0-or-later` frontmatter, `metadata.source` link and attribution note. The upstream `description` contains an unquoted colon that strict YAML parsers reject; it is left as the author wrote it.

**`marketing/stop-slop`** by Hardik Pandya, extended by Gaurav Tiwari (MIT). Based on the January 2026 version of [hardikpandya/stop-slop](https://github.com/hardikpandya/stop-slop), Copyright (c) 2025 Hardik Pandya. Version 2.0.0 (2026-10-24) is Gaurav Tiwari's edition. Hardik's parts are the five core rules, the first four quick checks, the five-dimension scoring grid, the original sections of `phrases.md` (throat-clearing openers, emphasis crutches, business jargon, filler adverbs, meta-commentary) and `structures.md` (binary contrasts, dramatic fragmentation, rhetorical setups, formulaic constructions, rhythm patterns), and examples 1 to 5. Gaurav's additions are the severity model, rules 6 to 9, "What I Keep," the self-audit, the scored pass, "What It Won't Do," the remaining quick checks, the other sections of both lists and examples 6 to 13. Example 4's em dash became a colon. The reference files sit next to `SKILL.md` here, because this repository does not publish `references/` folders. The folder's `LICENSE` carries both copyright lines.

**`design/ui-skills`** by Julien Thibeaut (MIT, Copyright (c) 2026 Julien Thibeaut). Byte-identical to `src/SKILL.md` in [ibelick/ui-skills](https://github.com/ibelick/ui-skills) as of 2026-01-14. Upstream has since split it into several skills.

**`design/ui-design-brain`** by UI Design Brain Contributors (MIT, Copyright (c) 2026). `SKILL.md`, `components.md` and `README.md` are byte-identical to [carmahhawwari/ui-design-brain](https://github.com/carmahhawwari/ui-design-brain) as of February 2026. The frontmatter pointed to a `LICENSE.txt` that was never copied here; it now reads `license: MIT`, and this file carries the notice.

**`design/modern-frontend-design`** by Devesh Punjabi (MIT, Copyright (c) 2026 Devesh Punjabi). Byte-identical to [deveshpunjabi/modern-frontend-skill](https://github.com/deveshpunjabi/modern-frontend-skill) as of 2026-03-06.

**`frontend/react-pdf`** by molefrog (MIT, Copyright (c) 2025). Byte-identical to `skills/react-pdf/SKILL.md` in [molefrog/skills](https://github.com/molefrog/skills).

**`tools/find-skills`** by Vercel, Inc. (MIT, Copyright (c) 2026 Vercel, Inc.). Byte-identical to `skills/find-skills/SKILL.md` in [vercel-labs/skills](https://github.com/vercel-labs/skills) as of 2026-01-26.

**`tools/planning-with-files`** by Ahmad Adi (MIT, Copyright (c) 2026 Ahmad Adi). `SKILL.md` and `reference.md` are byte-identical to [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) as of 2026-01-03; `examples.md` matches a later upstream copy from February 2026.

For each of these, the 2026-10-24 changes are the `license:` frontmatter, the `metadata.source` link and the attribution note, plus the edits named above.

## MIT License terms for the third-party MIT works

The MIT-licensed works listed above are distributed under the following terms, with the copyright line given for each:

> Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

If you copy a single skill folder out of this repository, keep its attribution note and the matching license text with it.

## Removed on 2026-10-24

These skills were in earlier versions of this repository. None of them comes with a license that allows redistribution, so they are no longer included. Install them from their authors.

| Skill | Author | Reason | Source |
|---|---|---|---|
| `design/frontend-design-pro` | ClaudeKit | Upstream repository publishes no license | <https://github.com/claudekit/frontend-design-pro-demo> |
| `frontend/frontend-css-patterns` | Majestic Labs LLC | PolyForm Noncommercial 1.0.0: personal, non-commercial use only | <https://github.com/majesticlabs-dev/majestic-marketplace> |
| `frontend/remotion-best-practices` | Remotion | Upstream repository publishes no license | <https://github.com/remotion-dev/skills> |
| `wordpress/wp-site-creator` (`design-systems`, `site-specification`, `wordpress-block-theming`) | Automattic | Upstream repository publishes no license | <https://github.com/Automattic/wordpress-agent-skills> |
| `uncategorized/accessibility-audit`, `frontend/semantic-html` | Builderius | Builderius ships its own accessibility and semantic-HTML skills with its plugin; no public source or license was found | <https://builderius.io> |
