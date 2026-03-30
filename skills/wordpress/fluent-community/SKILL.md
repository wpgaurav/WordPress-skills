# Fluent Community REST API

Push content (docs, posts, changelogs) to Fluent Community spaces on your-site.com.

## Authentication

Basic Auth using credentials from `~/.env`:

```
GA_WORDPRESS_URL = https://your-site.com
GA_USERNAME = your-username
GA_APPLICATION_PASSWORD = your-app-password
```

With curl: `-u '$GA_USERNAME:$GA_APPLICATION_PASSWORD'`

With Python urllib:
```python
import base64
AUTH = base64.b64encode(b'your-username:your-app-password').decode()
req.add_header('Authorization', f'Basic {AUTH}')
```

## Base URL

```
https://your-site.com/wp-json/fluent-community/v2
```

## Endpoints

### List Spaces

```
GET /spaces?per_page=50
```

Returns `{ "spaces": [ { "id", "title", "slug", "parent_id", "privacy", "status", "settings", ... } ] }`

### Get Space by Slug

```
GET /spaces/{slug}/by-slug
```

Returns `{ "space": { ... }, "permissions": { "can_create_post": true, ... } }`

### Join a Space

```
POST /spaces/{slug}/join
```

The authenticated user must be a member of a space to post in it.

### Create a Feed/Post

```
POST /feeds
```

**Parameters (form-encoded, use `--data-urlencode`):**

- `title` (string) - Post title
- `message` (string, required) - Post content (markdown, HTML, or plain text)
- `space` (string, required) - Space **slug** (NOT space_id)
- `content_type` (string) - `text`, `markdown`, or `html`. Default: `text`
- `privacy` (string) - `public` or `private`. Default: `public`
- `status` (string) - `published` or `draft`. Default: `published`
- `featured_image` (string) - Featured image URL
- `scheduled_at` (datetime) - Schedule publication time

**CRITICAL: Use `space` (slug) not `space_id` (numeric). Using `space_id` returns "Please select a valid space to post in."**

**curl example:**
```bash
curl -s -X POST 'https://your-site.com/wp-json/fluent-community/v2/feeds' \
  -u 'your-username:your-app-password' \
  --data-urlencode 'title=My Post Title' \
  --data-urlencode 'message=Post content in markdown' \
  --data-urlencode 'content_type=markdown' \
  --data-urlencode 'space=core-forms-docs'
```

**Python example (recommended for bulk operations):**
```python
import json, urllib.request, urllib.parse, base64

AUTH = base64.b64encode(b'your-username:your-app-password').decode()
API = 'https://your-site.com/wp-json/fluent-community/v2/feeds'

data = urllib.parse.urlencode({
    'title': 'Post Title',
    'message': content,
    'space': 'space-slug-here',
}).encode()

req = urllib.request.Request(API, data=data, method='POST')
req.add_header('Authorization', f'Basic {AUTH}')
resp = urllib.request.urlopen(req)
result = json.loads(resp.read())
feed_id = result['feed']['id']
```

**For large content files:**
```bash
curl -s -X POST "$API" \
  -u "$AUTH" \
  --data-urlencode "title=Large Doc" \
  --data-urlencode "space=space-slug" \
  --data-urlencode "message@/tmp/content.txt"
```

**Response:**
```json
{
  "feed": {
    "id": 85,
    "title": "My Post",
    "slug": "my-post",
    "message": "...",
    "content_type": "markdown",
    "space_id": "17",
    "status": "published",
    "permalink": "https://your-site.com/circle/space/core-forms-docs/post/my-post"
  },
  "message": "Your post has been published"
}
```

### Update a Feed/Post

```
POST /feeds/{feed_id}
PATCH /feeds/{feed_id}
```

### Delete a Feed/Post

```
DELETE /feeds/{feed_id}
```

Returns `{ "message": "Feed has been deleted successfully" }`

### Create a Space

```
POST /spaces
```

Uses `space[field]` syntax:
```bash
curl -s -X POST "$API/spaces" \
  -u "$AUTH" \
  --data-urlencode 'space[title]=My Space' \
  --data-urlencode 'space[slug]=my-space' \
  --data-urlencode 'space[description]=Description here' \
  --data-urlencode 'space[privacy]=public'
```

### Update a Space

```
PUT /spaces/{slug}/by-slug
PUT /spaces/{id}/by-id
```

Note: Space settings (restricted_post_only, default_post_sort_by, show_sidebar) may need to be updated via the Fluent Community admin panel rather than the API.

## Known Spaces

- **Core Forms** (ID 8, slug: `core-forms`) - Discussion space
- **Core Forms Docs** (ID 17, slug: `core-forms-docs`) - Documentation
- **Functionalities** (ID 9, slug: `functionalities`) - Discussion
- **Functionalities Docs** (ID 18, slug: `functionalities-docs`) - Documentation
- **GT Link Manager** (ID 12, slug: `gt-link-manager`) - Discussion
- **GT Link Manager Docs** (ID 21, slug: `gt-link-manager-docs`) - Documentation
- **GT ACF Blocks Plugin** (ID 10, slug: `gt-acf-blocks-plugin`) - Discussion
- **GT ACF Blocks Plugin Docs** (ID 19, slug: `gt-acf-blocks-plugin-docs`) - Documentation
- **GT Page Blocks Builder** (ID 13, slug: `gt-page-blocks-builder`) - Discussion
- **GT Page Blocks Builder Docs** (ID 22, slug: `gt-page-blocks-builder-docs`) - Documentation
- **GT Extensions for FluentCart** (ID 11, slug: `gt-extensions-for-fluentcart`) - Discussion
- **GT Extensions for FluentCart Docs** (ID 20, slug: `gt-extensions-for-fluentcart-docs`) - Documentation
- **Dynamic Month & Year into Posts** (ID 14, slug: `dynamic-month-year-into-posts`) - Discussion
- **Dynamic Month & Year into Posts Docs** (ID 23, slug: `dynamic-month-year-into-posts-docs`) - Documentation
- **Books** (ID 15, slug: `books`) - Book discussions

## Bulk Push Pattern

When pushing multiple markdown docs to a space:

```python
import json, urllib.request, urllib.parse, base64, os, glob, time, re

AUTH = base64.b64encode(b'your-username:your-app-password').decode()
API = 'https://your-site.com/wp-json/fluent-community/v2/feeds'
SPACE = 'target-space-slug'
DOCS_DIR = '/path/to/docs'

# Convert markdown tables to lists (Fluent Community doesn't render tables)
table_pattern = re.compile(r'^\|[^\n]+\|\n\|[\s:|-]+\|\n(?:\|[^\n]+\|\n?)+', re.MULTILINE)

def md_table_to_list(match):
    block = match.group(0).strip()
    tlines = [l.strip() for l in block.split('\n') if l.strip()]
    headers = [h.strip() for h in tlines[0].strip('|').split('|')]
    rows = []
    for line in tlines[2:]:
        cells = [c.strip() for c in line.strip('|').split('|')]
        rows.append(cells)
    result = []
    for row in rows:
        items = []
        for i, cell in enumerate(row):
            if i < len(headers) and headers[i]:
                items.append(f"**{headers[i]}:** {cell}")
            else:
                items.append(cell)
        result.append("- " + " | ".join(items))
    return '\n'.join(result)

files = sorted(glob.glob(os.path.join(DOCS_DIR, '*.md')))

for filepath in files:
    with open(filepath, 'r') as f:
        content = f.read()

    lines = content.split('\n')
    title = lines[0][2:].strip() if lines[0].startswith('# ') else os.path.basename(filepath)
    content = '\n'.join(lines[1:]).strip()
    content = table_pattern.sub(md_table_to_list, content)

    data = urllib.parse.urlencode({
        'title': title,
        'message': content,
        'space': SPACE,
    }).encode()

    req = urllib.request.Request(API, data=data, method='POST')
    req.add_header('Authorization', f'Basic {AUTH}')
    resp = urllib.request.urlopen(req)
    result = json.loads(resp.read())
    print(f"OK | Feed #{result['feed']['id']} | {title}")
    time.sleep(0.5)
```

## Gotchas

1. **Use `space` (slug), NOT `space_id`** - The numeric ID will silently fail with "Please select a valid space to post in."
2. **Fluent Community doesn't render markdown tables** - Convert tables to lists before pushing.
3. **Use `--data-urlencode`** for content with special characters, markdown, or HTML.
4. **User must be a member** of the space to post (join via `POST /spaces/{slug}/join`).
5. **Rate limit** - Add `time.sleep(0.5)` between requests when pushing in bulk.
6. **Content types**: `text` wraps in `<p>` tags, `markdown` renders markdown, `html` passes through raw HTML.
7. **Space settings** like sort order and restricted posting are best updated via the Fluent Community admin panel, not the API.

## Post-Push Space Settings

After pushing docs, configure these in the Fluent Community admin panel:
- **Restricted Post Only**: Yes (prevents non-admin posts)
- **Show Sidebar**: Yes (shows post navigation)
- **Disable Post Sort By**: Yes (locks sort order)
- **Default Post Sort By**: Oldest (shows docs in chronological/chapter order)
