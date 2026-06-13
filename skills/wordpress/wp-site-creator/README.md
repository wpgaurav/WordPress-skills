# WordPress Site Creator Skills

A set of skills for creating WordPress block themes from simple descriptions.

**Source:** [Automattic/wordpress-agent-skills](https://github.com/Automattic/wordpress-agent-skills/tree/trunk/claude-cowork/wp-site-creator)

## Skills

| Skill | Description |
|-------|-------------|
| `design-systems` | Bold aesthetic direction guidance, typography, color theory, and avoiding generic "AI slop" |
| `site-specification` | Extract comprehensive site specs from simple descriptions |
| `wordpress-block-theming` | WordPress FSE theme architecture, theme.json, block templates, template parts, and patterns |

## Usage

These skills work together:

1. **site-specification**: Analyze user request → extract site brief, layout notes, typography
2. **design-systems**: Create distinctive aesthetic direction → typography, color, motion, composition
3. **wordpress-block-theming**: Generate theme files → theme.json, templates, parts, patterns, style.css, functions.php

## Note

The original plugin includes Cowork commands (`/create-site`, `/preview-designs`) that require WordPress Studio MCP server. These skills work standalone without that integration.
