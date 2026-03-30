---
name: bricks
description: Route to Bricks Builder sub-skills for elements, hooks, layouts, and templates
---

# Bricks Builder Skills

Route to the appropriate Bricks Builder sub-skill based on the task.

## Sub-Skill Router

| Task | Sub-Skill | Path |
|------|-----------|------|
| Create custom elements with controls and rendering | Elements | `bricks-elements/SKILL.md` |
| Customize with filters and actions | Hooks | `bricks-hooks/SKILL.md` |
| Build layouts, sections, card grids (JSON format) | Layouts | `bricks-layouts/SKILL.md` |
| Create and manage templates programmatically | Templates | `bricks-templates/SKILL.md` |

## Reference Files

| File | Purpose |
|------|---------|
| `assets/core-framework.css` | Utility-first CSS framework classes |
| `references/bricks-overview.md` | Theme architecture, key functions, common filters |

## Styling Priority

When styling Bricks elements, follow this order:

1. **Core Framework classes** (`assets/core-framework.css`) - Use existing utility classes first
2. **Inline settings** - Use element `settings` for element-specific styling
3. **Custom CSS** - Only for patterns not covered by the framework

## Two Layout Formats

**Sections (Copy/Paste)** - For pasting directly into builder:
```json
{
  "content": [...elements...],
  "source": "bricksCopiedElements",
  "sourceUrl": "https://example.com",
  "version": "2.0.1",
  "globalClasses": [...],
  "globalElements": []
}
```

**Templates (Site-Wide)** - For import via Templates system:
```json
{
  "id": 1195,
  "name": "header-new",
  "title": "Header New",
  "type": "header",
  "header": [...elements...],
  "global_classes": [...]
}
```

## Element ID Generation

Element IDs must be 6-character alphanumeric strings:
- Semantic: `sec001`, `hdr001`, `btn001`, `img001`
- Random: `jdhuyf`, `hxbbms`, `towhmc`

## Responsive Breakpoints

Append suffix to any setting for responsive behavior:

| Breakpoint | Suffix | Max Width |
|------------|--------|-----------|
| Desktop | (none) | - |
| Tablet Portrait | `:tablet_portrait` | 991px |
| Mobile Portrait | `:mobile_portrait` | 478px |
