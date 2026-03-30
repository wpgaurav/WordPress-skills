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

## Adding Skills

1. Copy the skill directory into the appropriate category folder under `skills/`.
2. Remove or exclude the `references/` subdirectory entirely.
3. Review `SKILL.md` for hardcoded personal references and replace them.
4. Run `scripts/check-personal-data.sh` before committing.

## Skill File Format

Each skill lives in its own directory with a `SKILL.md` file that follows this structure:

```markdown
---
description: One-line description of what the skill does
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
