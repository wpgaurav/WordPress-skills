# Etch Condition Logic Skill

Complete reference for conditional rendering in Etch using `etch/condition` blocks.

## Overview

The `etch/condition` block conditionally renders its inner blocks based on evaluated conditions. If the condition evaluates to truthy, inner blocks render. If falsy, nothing renders (empty string returned).

## Condition Formats

### 1. Structured Condition Object (Preferred)

The `condition` attribute takes a JSON object:

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "===",
      "leftHand": "this.meta.featured",
      "rightHand": "yes"
    }
  },
  "innerBlocks": [...]
}
```

### 2. Condition String (Legacy)

The `conditionString` attribute takes a plain string:

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "conditionString": "item.children"
  },
  "innerBlocks": [...]
}
```

### 3. No Condition (Always Render)

If neither `condition` nor `conditionString` is provided, inner blocks always render.

## Operators

### Comparison Operators

| Operator | Name | Example |
|----------|------|---------|
| `==` | Loose equality | `{ "operator": "==", "leftHand": "this.status", "rightHand": "publish" }` |
| `===` | Strict equality | `{ "operator": "===", "leftHand": "this.type", "rightHand": "post" }` |
| `!=` | Loose inequality | `{ "operator": "!=", "leftHand": "this.status", "rightHand": "draft" }` |
| `!==` | Strict inequality | `{ "operator": "!==", "leftHand": "idx", "rightHand": "0" }` |
| `>` | Greater than | `{ "operator": ">", "leftHand": "this.meta.count", "rightHand": "5" }` |
| `<` | Less than | `{ "operator": "<", "leftHand": "idx", "rightHand": "3" }` |
| `>=` | Greater or equal | `{ "operator": ">=", "leftHand": "this.meta.rating", "rightHand": "4" }` |
| `<=` | Less or equal | `{ "operator": "<=", "leftHand": "idx", "rightHand": "5" }` |

### Truthiness Operators

| Operator | Name | Example |
|----------|------|---------|
| `isTruthy` | Value is truthy | `{ "operator": "isTruthy", "leftHand": "this.featuredImage" }` |
| `isFalsy` | Value is falsy | `{ "operator": "isFalsy", "leftHand": "slots.footer.empty" }` |

### Logical Operators

| Operator | Name | Example |
|----------|------|---------|
| `&&` | Logical AND | `{ "operator": "&&", "leftHand": ..., "rightHand": ... }` |
| `\|\|` | Logical OR | `{ "operator": "\|\|", "leftHand": ..., "rightHand": ... }` |

**Note:** Operators may be Unicode-encoded in the block data:
- `&&` encoded as `u0026u0026`
- `||` encoded as `u007cu007c`
- `>` encoded as `u003e`
- `<` encoded as `u003c`

The `ConditionEvaluator::decode_operator()` handles decoding automatically.

## Truthiness Rules

Values are truthy/falsy according to these rules:

| Value | Truthiness |
|-------|------------|
| `""` (empty string) | Falsy |
| `0` | Falsy |
| `null` | Falsy |
| `false` | Falsy |
| `[]` (empty array) | Falsy |
| `"false"` (string) | Falsy (special case) |
| Any non-empty value | Truthy |

## Nested Conditions

Operands can be nested condition objects for complex boolean logic:

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "&&",
      "leftHand": {
        "operator": "isTruthy",
        "leftHand": "this.meta.show_badge"
      },
      "rightHand": {
        "operator": "===",
        "leftHand": "this.status",
        "rightHand": "publish"
      }
    }
  }
}
```

### Complex OR Example

```json
{
  "condition": {
    "operator": "||",
    "leftHand": {
      "operator": "===",
      "leftHand": "this.type",
      "rightHand": "post"
    },
    "rightHand": {
      "operator": "===",
      "leftHand": "this.type",
      "rightHand": "page"
    }
  }
}
```

### Triple-Nesting (AND + OR)

```json
{
  "condition": {
    "operator": "&&",
    "leftHand": {
      "operator": "isTruthy",
      "leftHand": "user.isLoggedIn"
    },
    "rightHand": {
      "operator": "||",
      "leftHand": {
        "operator": "===",
        "leftHand": "user.role",
        "rightHand": "administrator"
      },
      "rightHand": {
        "operator": "===",
        "leftHand": "user.role",
        "rightHand": "editor"
      }
    }
  }
}
```

## Operand Resolution

Operands (leftHand, rightHand) are resolved through `DynamicContentProcessor::process_expression()`:

1. String operands are normalized (Unicode quotes decoded, apostrophes standardized)
2. Dynamic expressions are resolved against current context sources
3. The resolved value preserves its type (not forced to string)

## Common Patterns

### Show If Has Featured Image

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "isTruthy",
      "leftHand": "this.featuredImage"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/dynamic-image",
      "attrs": {
        "tag": "img",
        "attributes": {
          "mediaId": "{this.featuredImage.id}",
          "alt": "{this.title}"
        }
      },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ]
}
```

### Show If Has Children (Navigation)

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "conditionString": "item.children"
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": { "tag": "ul", "attributes": { "class": "dropdown" } },
      "innerBlocks": [...]
    }
  ]
}
```

### First Item Only

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "===",
      "leftHand": "idx",
      "rightHand": "0"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "span",
        "attributes": { "class": "badge badge--first" }
      },
      "innerBlocks": [
        {
          "blockName": "etch/text",
          "attrs": { "content": "First!" },
          "innerBlocks": [], "innerHTML": "", "innerContent": []
        }
      ],
      "innerHTML": "", "innerContent": []
    }
  ]
}
```

### Custom Meta Field Check

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "===",
      "leftHand": "post.meta.is_featured",
      "rightHand": "yes"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "span",
        "attributes": { "class": "badge badge--featured" }
      },
      "innerBlocks": [
        {
          "blockName": "etch/text",
          "attrs": { "content": "Featured" },
          "innerBlocks": [], "innerHTML": "", "innerContent": []
        }
      ],
      "innerHTML": "", "innerContent": []
    }
  ]
}
```

### Logged-In User Content

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "isTruthy",
      "leftHand": "user.isLoggedIn"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/text",
      "attrs": { "content": "Welcome back, {user.displayName}!" },
      "innerBlocks": [], "innerHTML": "", "innerContent": []
    }
  ]
}
```

### Conditional Slot Rendering

```json
{
  "blockName": "etch/condition",
  "attrs": {
    "condition": {
      "operator": "isFalsy",
      "leftHand": "slots.actions.empty"
    }
  },
  "innerBlocks": [
    {
      "blockName": "etch/element",
      "attrs": {
        "tag": "div",
        "attributes": { "class": "card__actions" }
      },
      "innerBlocks": [
        {
          "blockName": "etch/slot-placeholder",
          "attrs": { "name": "actions" },
          "innerBlocks": [], "innerHTML": "", "innerContent": []
        }
      ],
      "innerHTML": "", "innerContent": []
    }
  ]
}
```

## Tips

1. **Use `isTruthy`/`isFalsy` for existence checks** — simpler than comparing to empty string
2. **Nested conditions for complex logic** — avoids multiple wrapper condition blocks
3. **conditionString is legacy** — prefer the structured `condition` object format
4. **Remember index is 0-based** — first item in a loop is `idx === "0"` (string comparison due to expression resolution)
5. **Condition block renders nothing when false** — no else/fallback mechanism; use two conditions with inverse logic for if/else patterns
