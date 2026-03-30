# Etch Dynamic Data & Expressions Skill

Complete reference for the Etch dynamic expression system: context types, expression syntax, modifiers, and the context stack architecture.

## Expression Syntax

Dynamic expressions use curly braces: `{context.path}`

Expressions can include modifiers chained with pipes or dots:
- Dot notation: `{this.date.dateFormat("F j, Y")}`
- Pipe notation: `{this.title | toUpperCase()}`

Expressions can be mixed with static text:
- `"Hello {user.displayName}, welcome to {site.name}!"`

## Context Types

### Global Context (Cached Per Request)

Built once per request by `DynamicContextProvider::build_global_context()`:

| Key | Access | Source | Description |
|-----|--------|--------|-------------|
| `this` | `{this.*}` | `get_post()` + `DynamicData` trait | Current post/page data |
| `site` | `{site.*}` | `get_dynamic_site_data()` | Site-wide data |
| `user` | `{user.*}` | `wp_get_current_user()` | Current user data |
| `url` | `{url.*}` | `get_dynamic_url_data()` | Current URL data |
| `options` | `{options.*}` | ACF option pages | ACF options data |
| `archive` | `{archive.*}` | Archive context | Archive page data |
| `term` | `{term.*}` | Queried term (tax/cat/tag pages) | Term data |
| `taxonomy` | `{taxonomy.*}` | Queried taxonomy | Taxonomy data |
| `environment` | `{environment.current}` | Hardcoded | Always `"frontend"` |

### Component Context

Pushed when entering a component render:

| Key | Access | Source | Description |
|-----|--------|--------|-------------|
| `props` | `{props.*}` | Component attributes | Resolved component properties |
| `slots` | `{slots.*}` | Slot content analysis | Slot metadata (e.g., `{slots.footer.empty}`) |

### Loop Context

Pushed for each iteration:

| Key | Access | Source | Description |
|-----|--------|--------|-------------|
| Custom `itemId` | `{item.*}` (default) | Loop data | Current iteration item |
| Custom `indexId` | `{idx}` (example) | Loop counter | Current iteration index (0-based) |

### Common `this` Properties

| Path | Description |
|------|-------------|
| `{this.title}` | Post title |
| `{this.excerpt}` | Post excerpt |
| `{this.content}` | Post content |
| `{this.permalink}` | Post URL |
| `{this.date}` | Post date |
| `{this.modified}` | Modified date |
| `{this.author.name}` | Author display name |
| `{this.author.email}` | Author email |
| `{this.author.avatar}` | Author avatar URL |
| `{this.featuredImage.url}` | Featured image URL |
| `{this.featuredImage.id}` | Featured image attachment ID |
| `{this.featuredImage.alt}` | Featured image alt text |
| `{this.status}` | Post status |
| `{this.type}` | Post type |
| `{this.id}` | Post ID |
| `{this.slug}` | Post slug |
| `{this.meta.field_name}` | Custom field value |
| `{this.categories}` | Post categories (array) |
| `{this.tags}` | Post tags (array) |

### Common `site` Properties

| Path | Description |
|------|-------------|
| `{site.name}` | Site title |
| `{site.description}` | Site tagline |
| `{site.url}` | Site URL |
| `{site.logo}` | Site logo URL |

### Common Loop Item Properties (Posts)

| Path | Description |
|------|-------------|
| `{post.title}` | Post title (when itemId is "post") |
| `{post.permalink}` | Post URL |
| `{post.excerpt}` | Post excerpt |
| `{post.featuredImage.url}` | Featured image URL |
| `{post.featuredImage.id}` | Featured image ID |
| `{post.date}` | Post date |
| `{post.author.name}` | Author name |
| `{post.meta.field}` | Custom field |
| `{post.categories}` | Categories (array) |
| `{post.tags}` | Tags (array) |

### Navigation Item Properties (nav loop)

| Path | Description |
|------|-------------|
| `{item.label}` | Menu item label |
| `{item.url}` | Menu item URL |
| `{item.class}` | Menu item CSS classes |
| `{item.target}` | Link target |
| `{item.children}` | Child menu items (array) |
| `{item.hasChildren}` | Boolean, has children |

## Context Stack Architecture

The `DynamicContextProvider` manages a stack-based context system:

```
┌─────────────────────────────────────┐
│ Preview entries (highest priority)   │  ← DynamicPreviewRegistry
├─────────────────────────────────────┤
│ Local entries (loop, component)      │  ← push()/pop() calls
├─────────────────────────────────────┤
│ Global registry entries              │  ← DynamicContentRegistry
├─────────────────────────────────────┤
│ Global context (this, site, user...) │  ← build_global_context()
└─────────────────────────────────────┘
```

Resolution order: **last pushed wins** (reverse iteration for specificity).

### Reset Policies

When computing sources for a block, three reset modes are available:

| Mode | Behavior |
|------|----------|
| `none` | Keep parent context + append new entries |
| `keepGlobal` | Keep only global entries, then append new |
| `all` | Ignore parent, use only new entries |

Components use `clear()` + `keepGlobal` logic to isolate their scope.

## Expression Processing

### DynamicContentProcessor

Two main methods:

1. **`apply($value, $options)`** — Process a single value. If the value is entirely a dynamic expression, returns the resolved value (preserving type). If mixed with static text, only processes embedded expressions.

2. **`replace_templates($template, $options)`** — Process a template string, replacing all `{expression}` patterns with resolved values. Always returns a string.

### Resolution Process

```
Input: "{this.title.toUpperCase()}"

1. Extract expression: "this.title.toUpperCase()"
2. Split by ExpressionPath: ["this", "title", "toUpperCase()"]
3. Resolve "this" from sources → post object
4. Access "title" property → "Hello World"
5. Apply modifier "toUpperCase()" → "HELLO WORLD"
6. Return: "HELLO WORLD"
```

## Modifiers Reference

### String Modifiers

| Modifier | Description | Example |
|----------|-------------|---------|
| `toUpperCase()` | Convert to uppercase | `{this.title.toUpperCase()}` |
| `toLowerCase()` | Convert to lowercase | `{this.title.toLowerCase()}` |
| `trim()` | Trim whitespace | `{this.excerpt.trim()}` |
| `ltrim()` | Trim left whitespace | |
| `rtrim()` | Trim right whitespace | |
| `truncateChars(n, suffix)` | Truncate to N chars | `{this.excerpt.truncateChars(100, "...")}` |
| `truncateWords(n, suffix)` | Truncate to N words | `{this.excerpt.truncateWords(20, "...")}` |
| `concat(str)` | Append string | `{this.title.concat(" | My Site")}` |
| `split(delim)` | Split into array | `{this.meta.tags.split(",")}` |
| `join(delim)` | Join array to string | `{post.categories.pluck("name").join(", ")}` |
| `toSlug()` | Convert to URL slug | `{this.title.toSlug()}` |
| `stripTags()` | Remove HTML tags | `{this.content.stripTags()}` |
| `urlEncode()` | URL encode | `{this.title.urlEncode()}` |
| `urlDecode()` | URL decode | |
| `toString()` | Convert to string | `{this.id.toString()}` |
| `replace(search, replace)` | String replacement | `{this.title.replace("old", "new")}` |

### Number Modifiers

| Modifier | Description | Example |
|----------|-------------|---------|
| `numberFormat(decimals, dec_point, thousands)` | Format number | `{item.price.numberFormat(2, ".", ",")}` |
| `toInt()` | Convert to integer | `{this.meta.count.toInt()}` |
| `ceil()` | Round up | |
| `floor()` | Round down | |
| `round(precision)` | Round | `{item.rating.round(1)}` |

### Date Modifiers

| Modifier | Description | Example |
|----------|-------------|---------|
| `dateFormat(format)` | Format date (PHP format) | `{this.date.dateFormat("F j, Y")}` |

Common PHP date formats:
- `"F j, Y"` → "January 1, 2026"
- `"Y-m-d"` → "2026-01-01"
- `"M j, Y"` → "Jan 1, 2026"
- `"d/m/Y"` → "01/01/2026"

### Array/Collection Modifiers

| Modifier | Description | Example |
|----------|-------------|---------|
| `at(index)` | Get item at index | `{post.categories.at(0)}` |
| `slice(start, end)` | Get subset | `{items.slice(0, 5)}` |
| `length()` | Get count | `{post.categories.length()}` |
| `reverse()` | Reverse order | |
| `pluck(property)` | Extract property from objects | `{post.categories.pluck("name")}` |
| `indexOf(value)` | Find index of value | |
| `flatten()` | Flatten nested arrays | |
| `unique()` | Remove duplicates | |

### Comparison Modifiers

These return custom values based on comparison:

| Modifier | Signature | Example |
|----------|-----------|---------|
| `includes(search, true, false)` | Check if contains | `{this.meta.roles.includes("admin", "yes", "no")}` |
| `startsWith(prefix, true, false)` | Check prefix | |
| `endsWith(suffix, true, false)` | Check suffix | |
| `equal(value, true, false)` | Equality check | `{this.status.equal("publish", "live", "draft")}` |
| `less(n, true, false)` | Less than | |
| `lessOrEqual(n, true, false)` | Less or equal | |
| `greater(n, true, false)` | Greater than | `{this.meta.count.greater(0, "visible", "hidden")}` |
| `greaterOrEqual(n, true, false)` | Greater or equal | |

### Type Conversion Modifiers

| Modifier | Description | Example |
|----------|-------------|---------|
| `toBool()` | Convert to boolean | `{this.meta.featured.toBool()}` |
| `toString()` | Convert to string | |
| `toInt()` | Convert to integer | |

### Special Modifiers

| Modifier | Description |
|----------|-------------|
| `applyData()` | Apply data transformation |
| `fallback(value)` | Return fallback if value is empty |
| `default(value)` | Alias for fallback |

## Expression Examples

```
// Basic property access
{this.title}
{site.name}
{user.displayName}

// Nested property access
{this.author.name}
{this.featuredImage.url}
{post.meta.custom_field}

// With modifiers
{this.title.toUpperCase()}
{this.date.dateFormat("M j, Y")}
{this.excerpt.truncateWords(20, "...")}
{post.categories.pluck("name").join(", ")}

// Comparison modifiers for conditional classes
{item.children.length().greater(0, "has-dropdown", "")}
{this.meta.featured.equal("yes", "is-featured", "")}

// Mixed with static text
Published on {this.date.dateFormat("F j, Y")} by {this.author.name}

// In element attributes
"class": "post-card {this.meta.featured.equal('yes', 'is-featured', '')}"
"href": "{post.permalink}"
"src": "{post.featuredImage.url}"
```

## Best Practices

1. **Use specific context keys** — `{post.title}` instead of `{item.title}` for clarity in loops
2. **Chain modifiers** — `{this.excerpt.truncateWords(20, "...").stripTags()}` 
3. **Use comparison modifiers for conditional classes** — Avoids extra condition blocks for simple class toggling
4. **Remember context isolation** — Components clear the context stack; slots render in caller's scope
5. **Loop itemId naming** — Use descriptive names (`post`, `product`, `child`) not generic `item`
6. **String params in loops** — Must be double-escaped: `"\"post\""`
