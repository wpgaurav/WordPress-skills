#!/bin/bash
# Syncs skills written for this repo from ~/.claude/skills/, excluding personal data.
# Run from repo root:
#   ./scripts/sync-skills.sh                  # update existing first-party skills
#   ./scripts/sync-skills.sh --add <name>...  # also add new skills you wrote
#
# What it does:
# 1. Updates only skills already in this repo whose SKILL.md says `license: MIT`
#    and has no `metadata.source` (skills written here). Third-party skills are
#    never overwritten; update those by hand from their upstream.
# 2. Adds a new skill only when named with --add, and never a blocked one.
# 3. Keeps the `license:` frontmatter line, adding `license: MIT` if missing.
# 4. Strips <!-- local-only --> blocks, skips local-* files and references/
#    subdirectories, and warns about personal domains.

set -euo pipefail

SOURCE="${SKILLS_SOURCE:-$HOME/.claude/skills}"
DEST="skills"

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

# Paid skills and third-party skills with no redistribution license.
# Never sync these. Keep in step with scripts/check-licenses.sh.
BLOCKED=" design ui ideas brand-kit componentize canonicalize-tailwind add-dark-mode \
dark-mode-image make-responsive markup-from-image red-pen frontend-design-pro \
frontend-css-patterns remotion-best-practices wp-site-creator accessibility-audit semantic-html "

ADD=()
if [ "${1:-}" = "--add" ]; then
    shift
    ADD=("$@")
fi

get_category() {
    case "$1" in
        wp-block|wp-block-quick|wp-theme|wp-theme-quick|wp-block-patterns|wp-block-layouts|\
        wp-block-markup|wp-block-styles|wp-core-blocks|wp-plugin|wp-plugin-quick|\
        acf-blocks|md-section|md-theme-blocks|page-block|fluent-community|bricks|etch-layouts)
            echo "wordpress" ;;
        cinematic-editorial-graphics|desktop-app-showcase|hand-drawn-explainers|svg-graphics|\
        monoline-icons|featured-image-creator|saas-product-graphics)
            echo "design" ;;
        omm-style|mkbhd-voice)
            echo "marketing" ;;
        seo-rank|ai-rank|koray)
            echo "seo" ;;
        just-html|html-to-generateblocks|elementor-to-generateblocks|figma-to-generateblocks)
            echo "frontend" ;;
        docs|readme|changelog|product-box-converter|product-box-block|11labs|TTS)
            echo "tools" ;;
        *)
            echo "uncategorized" ;;
    esac
}

# Prints the repo path of an existing skill, or nothing.
find_existing() {
    find "$DEST" -mindepth 2 -maxdepth 2 -type d -name "$1" | head -1
}

is_first_party() {
    local file="$1/SKILL.md"
    [ -f "$file" ] || return 1
    grep -qE '^license: *MIT *$' "$file" && ! grep -qE '^  source: ' "$file"
}

ensure_license() {
    local file="$1"
    if ! awk 'NR == 1 { next } /^---$/ { exit } /^license:/ { found = 1 } END { exit !found }' "$file"; then
        awk 'NR > 1 && !done && /^---$/ { print "license: MIT"; done = 1 } { print }' "$file" > "$file.tmp"
        mv "$file.tmp" "$file"
    fi
}

# Removes everything between <!-- local-only:start --> and <!-- local-only:end -->.
strip_local_only() {
    local file="$1"
    awk '/<!-- local-only:start -->/ { skip = 1; next } /<!-- local-only:end -->/ { skip = 0; next } !skip' "$file" > "$file.tmp"
    mv "$file.tmp" "$file"
}

copy_skill() {
    local skill_dir="$1" target_dir="$2"
    mkdir -p "$target_dir"
    cp "$skill_dir/SKILL.md" "$target_dir/SKILL.md"
    strip_local_only "$target_dir/SKILL.md"
    ensure_license "$target_dir/SKILL.md"
    for f in "$skill_dir"/*.md; do
        [ -f "$f" ] || continue
        fname=$(basename "$f")
        case "$fname" in local-*) continue ;; esac
        if [ "$fname" != "SKILL.md" ] && [ "$fname" != "llm.md" ] && \
           [ "$fname" != "about-me.md" ] && [ "$fname" != "business-profile.md" ] && \
           [ "$fname" != "voice-dna.md" ] && [ "$fname" != "affiliate-products.md" ]; then
            cp "$f" "$target_dir/"
        fi
    done
}

PERSONAL_PATTERNS="gauravtiwari\.org|gatilab\.com|@wpgaurav|\+91-|gaurav@"

echo "Syncing first-party skills from $SOURCE to $DEST/"
echo ""

SYNCED=0
SKIPPED=0
WARNED=0

for skill_dir in "$SOURCE"/*/; do
    skill_name=$(basename "$skill_dir")
    [ -f "$skill_dir/SKILL.md" ] || continue

    case "$BLOCKED" in *" $skill_name "*) continue ;; esac

    target_dir=$(find_existing "$skill_name")
    if [ -n "$target_dir" ]; then
        if ! is_first_party "$target_dir"; then
            SKIPPED=$((SKIPPED + 1))
            continue
        fi
    else
        wanted=0
        for name in "${ADD[@]+"${ADD[@]}"}"; do
            [ "$name" = "$skill_name" ] && wanted=1
        done
        [ $wanted -eq 1 ] || continue
        if grep -qE '^  source: |^license: *(Apache|GPL)' "$skill_dir/SKILL.md"; then
            echo -e "${RED}SKIPPED:${NC} $skill_name declares a third-party source; add it by hand with a NOTICE.md entry"
            continue
        fi
        target_dir="$DEST/$(get_category "$skill_name")/$skill_name"
        echo -e "${YELLOW}ADDED:${NC} $skill_name — confirm you wrote it before committing"
    fi

    copy_skill "$skill_dir" "$target_dir"

    if grep -qrE "$PERSONAL_PATTERNS" "$target_dir/" 2>/dev/null; then
        echo -e "${YELLOW}WARNING:${NC} $skill_name contains personal references — review before committing"
        WARNED=$((WARNED + 1))
    fi

    SYNCED=$((SYNCED + 1))
done

for name in "${ADD[@]+"${ADD[@]}"}"; do
    case "$BLOCKED" in *" $name "*) echo -e "${RED}BLOCKED:${NC} $name is on the never-publish list" ;; esac
done

echo ""
echo -e "${GREEN}Synced:${NC} $SYNCED skills"
echo -e "${YELLOW}Skipped:${NC} $SKIPPED third-party skills (update those from upstream)"
if [ $WARNED -gt 0 ]; then
    echo -e "${RED}Warnings:${NC} $WARNED skills need personal data review"
fi
echo ""
echo "Run ./scripts/check-licenses.sh and ./scripts/check-personal-data.sh before committing."
