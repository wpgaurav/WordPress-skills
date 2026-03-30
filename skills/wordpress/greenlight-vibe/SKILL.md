---
name: greenlight-vibe
description: Generate or edit design for WordPress Gutenberg blocks using Greenshift/GreenLight plugin. Convert any data to wordpress blocks or convert greenshift blocks back to html + css + js. Use when user asks to create design with Greenshift or Greenlight blocks for wordpress site, convert anything to wordpress blocks or build charts in content. Triggers on keywords: wordpress, gutenberg, greenshift, greenlight, convert to wordpress, convert greenshift blocks to vanilla html, build chart.
---

# Greenshift/Greenlight Block Generator and Data Convertor to WordPress blocks

## Purpose

Create production-ready WordPress Gutenberg blocks using Greenshift/GreenLight Element block system. All output is HTML with JSON parameters in block comments - ready to paste directly into WordPress Gutenberg code editor or send code via mcp, rest api to site.

## Workflow to build design and convert it to blocks

### Step 1: Create Clean HTML, CSS, JS first

Always build html first and use there best standards. But keep important rules

1. Make vanilla HTML + JS + CSS
2. Do not use React or Typescript. 
3. Put everything in a single HTML. 
4. Do not use Tailwind or any other CSS frameworks. 
5. Use unique class and id names with prefix, minimum 4 letter for prefix
6. Do not use :root variables, if you need variables, put them in class of parent block.
7. Do not add styles to body tag, add general styles to class of parent block
8. Do not add styles to *{…}
9. Do not generate initial content for design via scripts, it must be added in DOM
10. If you use headings tags or paragraphs, it's required to add margin top and bottom. If you use lists, it's required to disable left margin and spacing
11. Do not use js inline parameters like "onclick"
12. Important!!! All styles add in section `<style data-wp-block-html="css">...</style>`. All scripts add in section `<script data-wp-block-html="js">...</script>`

***Important*** When you have centered content inside full width section, use next code for such sections. They must be most parent blocks on page

```html
<section class="wp-section alignfull" data-type="section-component">
    <div class="wp-content-wrap" data-type="content-area-component">
        Your Centered Content
    </div>
</section>
```

Use next styles for sections

```css
.wp-section{display:flex;justify-content:center;flex-direction:column;align-items:center;padding-right:var(--wp--spacing--side, min(3vw, 20px));padding-left:var(--wp--spacing--side, min(3vw, 20px));padding-top:var(--wp--spacing--top, 0px);padding-bottom:var(--wp--spacing--bottom, 0px);margin-top:0px;margin-bottom:0px;position:relative;}
.wp-content-wrap{max-width:100%;width:var(--wp--style--global--wide-size, 1200px);}
```

You can add background and other styles to each section, you can change padding top and bottom, but always keep alignfull class, --wp--style--global--wide-size variable and --wp--spacing--side variables.

When user asks to add dynamic content, read and follow `instructions/dynamic-placeholders.md`.

When user asks to build query loops, dynamic loops, archives, or other query-driven layouts, read and follow both:

- `instructions/dynamic-loops.md`
- `instructions/dynamic-placeholders.md`

Important!!! Add dynamic placeholders ONLY if user asked to make dynamic content or query loops


### Step 2: Convert HTML to Blocks

Save the HTML from Step 1 to a temporary `.html` file, then run the converter script located alongside this skill:

```bash
node "${CLAUDE_PLUGIN_ROOT}/skills/greenlight-vibe/scripts/convert.js" /path/to/input.html -o /path/to/output.txt
```

If `CLAUDE_PLUGIN_ROOT` is not set (standalone/local install), use the path relative to the skill directory:

```bash
node scripts/convert.js /path/to/input.html -o /path/to/output.txt
```

The script is zero-dependency (pure JS, no npm install). It accepts a full HTML page or snippet and outputs ready-to-paste Greenshift block code.

**What the script does:**
- Parses all `<style>` tags and converts CSS into a Style Manager block with `dynamicGClasses` (local classes), `styleAttributes`, hover/focus states, selectors, media queries, and keyframes
- Parses all `<script>` tags and adds them as `customJs` with `customJsEnabled: true`
- Converts every HTML element into `greenshift-blocks/element` blocks with correct `type` (`inner`, `text`, `no`), proper nesting, and mapped attributes (`href`, `src`, `alt`, `formAttributes`, `dynamicAttributes`, `icon`, `isVariation`, etc.)

**Usage options:**
```bash
node scripts/convert.js input.html                # output to stdout
node scripts/convert.js input.html -o output.txt  # output to file
cat input.html | node scripts/convert.js          # pipe from stdin
```

### Step 3: Fit to inner variable system

Check if we have some values in styles that matches or close to one of our existed variables. If yes, replace value with variable and fallback

**See `instructions/variables.md` for complete list of variables.**

### Step 4: Validate frontend styles and scripts

If you add code as content and save it in wordpress site, read and follow `instructions/validate-styles.md` for CSS rendering and `instructions/validate-scripts.md` if you have custom scripts in blocks.

---

## Output Requirements

- Return **only** the generated block code
- No explanations or surrounding text
- **No HTML comments** - WordPress strips them; use `metadata:{"name":"..."}` for adding relevant titles to blocks.
- Ready to paste directly into WordPress Gutenberg code editor


## Workflow to edit existing design of page that is made with greenshift-blocks

If user asked for minimal changes, like color change, try to edit blocks code directly and save updated code

If user asked to make bigger changes, you need to make next steps.

### Step 1: Prepare code

Take raw content of page and check if it has greenshift-blocks/element blocks

### Step 2: Convert Block code back to HTML

Save the blocks code to a temporary `.html` file, then run the deconverter script located alongside this skill:

```bash
node "${CLAUDE_PLUGIN_ROOT}/skills/greenlight-vibe/scripts/deconvert.js" /path/to/input.html -o /path/to/output.txt
```

If `CLAUDE_PLUGIN_ROOT` is not set (standalone/local install), use the path relative to the skill directory:

```bash
node scripts/deconvert.js /path/to/input.html -o /path/to/output.txt
```

### Step 3: Edit the converted code and convert it back to blocks

Make the requested changes in the HTML/CSS/JS produced by the deconverter. After editing, run the normal HTML-to-block conversion workflow again and validate the final Greenshift block code.

### Step 4: Replace the full original block content

Return the full updated Greenshift block code and use it as a complete replacement for the original block content. Do not return only a diff or partial fragment. Keep unchanged blocks and attributes as they were unless they must change to support the requested update.