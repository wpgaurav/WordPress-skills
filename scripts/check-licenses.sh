#!/bin/bash
# Checks license metadata and attribution for every skill.
# Run from repo root: ./scripts/check-licenses.sh
#
# Every SKILL.md must declare `license:` in frontmatter. Third-party skills
# (any non-MIT license, or any skill with `metadata.source`) must name their
# upstream, open with an attribution note, and be listed in NOTICE.md.

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Paid skills and third-party skills with no redistribution license.
# Never publish these, even under a different category.
BLOCKED_DIRS="ui ideas brand-kit componentize canonicalize-tailwind add-dark-mode \
dark-mode-image make-responsive markup-from-image red-pen frontend-design-pro \
frontend-css-patterns remotion-best-practices wp-site-creator accessibility-audit semantic-html"

FOUND=0
fail() {
    echo -e "${RED}FAIL:${NC} $1"
    FOUND=1
}

for f in LICENSE LICENSE-APACHE-2.0 LICENSE-GPL-2.0 NOTICE.md; do
    [ -f "$f" ] || fail "missing $f"
done

for name in $BLOCKED_DIRS; do
    hits=$(find skills -type d -name "$name" 2>/dev/null || true)
    [ -z "$hits" ] || fail "blocked skill present: $hits"
done

if grep -rqiE 'ui\.sh([^a-z0-9]|$)|uidotsh' skills/ 2>/dev/null; then
    fail "skills mention a paid skill source: $(grep -rliE 'ui\.sh([^a-z0-9]|$)|uidotsh' skills/ | tr '\n' ' ')"
fi

local_files=$(find skills -name 'local-*' 2>/dev/null || true)
[ -z "$local_files" ] || fail "local-only files present: $(echo "$local_files" | tr '\n' ' ')"

private=$(grep -rlE 'local-only:(start|end)|/Users/[a-z]|Mobile Documents|claude-sync' skills/ 2>/dev/null || true)
[ -z "$private" ] || fail "private markers or paths in: $(echo "$private" | tr '\n' ' ')"

while IFS= read -r file; do
    if [ "$(head -1 "$file")" != "---" ]; then
        fail "$file has no frontmatter"
        continue
    fi
    fm=$(awk 'NR == 1 { next } /^---$/ { exit } { print }' "$file")
    body=$(awk 'NR == 1 { next } !done && /^---$/ { done = 1; next } done && NF { print; exit }' "$file")

    if echo "$fm" | grep -qE '^name: *design *$'; then
        fail "$file uses the blocked skill name 'design'"
    fi

    license=$(echo "$fm" | sed -n 's/^license: *//p' | head -1)
    case "$license" in
        MIT|Apache-2.0|GPL-2.0-or-later) ;;
        "") fail "$file has no license: field"; continue ;;
        *) fail "$file has unexpected license '$license'"; continue ;;
    esac

    source=$(echo "$fm" | sed -n 's/^  source: *//p' | head -1)
    if [ "$license" != "MIT" ] && [ -z "$source" ]; then
        fail "$file is $license but has no metadata.source"
    fi
    if [ -n "$source" ]; then
        case "$body" in
            "> "*) ;;
            *) fail "$file is third-party but does not open with an attribution note" ;;
        esac
        grep -qF "$source" NOTICE.md || fail "$file source $source is not listed in NOTICE.md"
    fi
done < <(find skills -name SKILL.md | sort)

if [ $FOUND -eq 0 ]; then
    echo -e "${GREEN}All clear. $(find skills -name SKILL.md | wc -l | tr -d ' ') skills carry valid license metadata.${NC}"
else
    exit 1
fi
