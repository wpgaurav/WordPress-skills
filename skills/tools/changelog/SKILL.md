---
name: changelog
description: "Generate structured changelogs from git history and commit messages"
---

# Changelog Generation

Generate or update CHANGELOG.md based on git history:

1. Read existing CHANGELOG.md if present
2. Analyze git commits since last version tag
3. Group changes by type: Added, Changed, Fixed, Removed
4. Follow Keep a Changelog format (https://keepachangelog.com)
5. Include version number and date
6. Link to relevant commits or PRs when available
7. Output in Markdown format
