#!/bin/bash
# Syncs skills from ~/.claude/skills/ to this repo, excluding personal data.
# Run from repo root: ./scripts/sync-skills.sh
#
# What it does:
# 1. Copies SKILL.md files from source to categorized directories
# 2. Skips all references/ subdirectories
# 3. Warns about files with personal domain references

set -euo pipefail

SOURCE="$HOME/.claude/skills"
DEST="skills"

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

get_category() {
    case "$1" in
        wp-block|wp-block-quick|wp-block-development|wp-block-themes|wp-theme|wp-theme-quick|\
        wp-block-patterns|wp-block-layouts|wp-block-markup|wp-block-styles|wp-core-blocks|\
        wp-rest-api|wp-plugin|wp-plugin-quick|wp-plugin-development|wp-phpstan|\
        wp-wpcli-and-ops|wp-performance|wp-playground|wp-interactivity-api|wp-abilities-api|\
        wordpress-router|wp-project-triage|wp-site-creator|acf-blocks|md-section|\
        md-theme-blocks|wpds|page-block|greenlight-vibe|fluent-community)
            echo "wordpress" ;;
        design|frontend-design|frontend-design-pro|ui-design-brain|ui-styling|ui-ux-pro-max|\
        banner-design|cinematic-editorial-graphics|desktop-app-showcase|hand-drawn-explainers|\
        svg-graphics|monoline-icons|featured-image-creator|saas-product-graphics|\
        design-system|extract|distill|bolder|colorize|delight|animate|adapt|quieter|\
        normalize|polish|onboard|critique|harden|audit|teach-impeccable|ui-skills|\
        modern-frontend-design|rams)
            echo "design" ;;
        brand|copywriting|copy-editing|content-strategy|cold-email|email-sequence|\
        social-content|marketing-ideas|marketing-psychology|paid-ads|ad-creative|\
        sales-enablement|pricing-strategy|referral-program|revops|competitor-alternatives|\
        launch-strategy|free-tool-strategy|churn-prevention|product-marketing-context|\
        page-cro|signup-flow-cro|onboarding-cro|form-cro|popup-cro|paywall-upgrade-cro|\
        ab-test-setup|stop-slop|omm-style|mkbhd-voice|clarify|slides)
            echo "marketing" ;;
        seo-audit|seo-rank|ai-rank|ai-seo|koray|schema-markup|programmatic-seo|\
        site-architecture|analytics-tracking)
            echo "seo" ;;
        frontend-css-patterns|just-html|semantic-html|react-pdf|etch-layouts|\
        html-to-generateblocks|elementor-to-generateblocks|figma-to-generateblocks|\
        bricks|remotion-best-practices)
            echo "frontend" ;;
        docs|readme|changelog|planning-with-files|find-skills|product-box-converter|\
        product-box-block|optimize|11labs|TTS)
            echo "tools" ;;
        *)
            echo "uncategorized" ;;
    esac
}

# Personal data patterns to flag
PERSONAL_PATTERNS="gauravtiwari\.org|gatilab\.com|@wpgaurav|\+91-|gaurav@"

echo "Syncing skills from $SOURCE to $DEST/"
echo ""

SYNCED=0
SKIPPED=0
WARNED=0

for skill_dir in "$SOURCE"/*/; do
    skill_name=$(basename "$skill_dir")
    skill_file="$skill_dir/SKILL.md"

    # Skip if no SKILL.md
    if [ ! -f "$skill_file" ]; then
        SKIPPED=$((SKIPPED + 1))
        continue
    fi

    # Determine category
    category=$(get_category "$skill_name")

    # Create target directory
    target_dir="$DEST/$category/$skill_name"
    mkdir -p "$target_dir"

    # Copy SKILL.md only (no references/)
    cp "$skill_file" "$target_dir/SKILL.md"

    # Copy any non-reference supporting files (templates, examples)
    for f in "$skill_dir"/*.md; do
        [ -f "$f" ] || continue
        fname=$(basename "$f")
        if [ "$fname" != "SKILL.md" ] && [ "$fname" != "llm.md" ] && \
           [ "$fname" != "about-me.md" ] && [ "$fname" != "business-profile.md" ] && \
           [ "$fname" != "voice-dna.md" ] && [ "$fname" != "affiliate-products.md" ]; then
            cp "$f" "$target_dir/"
        fi
    done

    # Check for personal data in copied files
    if grep -qrE "$PERSONAL_PATTERNS" "$target_dir/" 2>/dev/null; then
        echo -e "${YELLOW}WARNING:${NC} $skill_name contains personal references — review before committing"
        WARNED=$((WARNED + 1))
    fi

    SYNCED=$((SYNCED + 1))
done

echo ""
echo -e "${GREEN}Synced:${NC} $SYNCED skills"
echo -e "${YELLOW}Skipped:${NC} $SKIPPED (no SKILL.md)"
if [ $WARNED -gt 0 ]; then
    echo -e "${RED}Warnings:${NC} $WARNED skills need personal data review"
fi
echo ""
echo "Run ./scripts/check-personal-data.sh to verify before committing."
