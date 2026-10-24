# AI Skills Collection

Public repository of reusable AI agent skills for Claude Code, ChatGPT, and other AI tools.

## Repository Structure

```
skills/           — Individual skill directories, each with a SKILL.md
commands/         — Claude Code custom slash commands
scripts/          — Maintenance and sync utilities
```

## Rules

- **No personal data.** Never commit files from `references/` subdirectories. The `.gitignore` blocks them, but verify before committing.
- **No hardcoded domains.** Use `example.com` or `yoursite.com` as placeholders. If a SKILL.md references a specific personal domain, replace it before committing.
- **No credentials.** No API keys, tokens, passwords, emails, phone numbers, or revenue figures.
- **Skill-only commits.** Each skill directory should contain only `SKILL.md` and any non-personal supporting files (templates, examples with placeholder data).
- **Provenance before publishing.** Before adding a skill, check whether it came from another project. Third-party skills keep their upstream license, name the upstream in `metadata.source`, open with a one-line attribution note, and get an entry in `NOTICE.md`. Never add a skill whose upstream has no license, a non-commercial license, or a paid license. `scripts/check-licenses.sh` enforces this and holds the never-publish list.

## Adding Skills

1. Confirm who wrote the skill. If it came from elsewhere, find the upstream repository and its license first.
2. Copy the skill directory into the appropriate category folder under `skills/` (or run `scripts/sync-skills.sh --add <name>` for a skill you wrote).
3. Remove or exclude the `references/` subdirectory entirely.
4. Review `SKILL.md` for hardcoded personal references and replace them.
5. Run `scripts/check-licenses.sh` and `scripts/check-personal-data.sh` before committing.

## Skill File Format

Each skill lives in its own directory with a `SKILL.md` file that follows this structure:

```markdown
---
name: skill-name
description: One-line description of what the skill does
license: MIT
---

# Skill Name

[Skill instructions and prompts]
```

## Categories

- **wordpress/** — Block development, themes, plugins, REST API, WP-CLI, performance
- **design/** — UI/UX, design systems, accessibility, animations, SVG graphics
- **marketing/** — Copywriting, SEO, CRO, email, ads, brand, launch strategy
- **frontend/** — CSS patterns, component libraries, responsive design, frameworks
- **ai/** — LLM optimization, AI SEO, content quality, prompt engineering
- **tools/** — PDF generation, changelogs, documentation, project planning
