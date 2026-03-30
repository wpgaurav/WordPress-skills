#!/bin/bash
# Scans skill files for personal data before committing.
# Run from repo root: ./scripts/check-personal-data.sh

set -euo pipefail

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

FOUND=0

echo "Scanning for personal data in skill files..."
echo ""

# Patterns to search for (add your own as needed)
PATTERNS=(
    '@gmail\.com'
    '@yahoo\.com'
    '@hotmail\.com'
    '@outlook\.com'
    'gauravtiwari\.org'
    'gatilab\.com'
    '@wpgaurav'
    'api[_-]?key'
    'api[_-]?secret'
    'password'
    'token.*='
    '\+91-'
    'phone.*:'
    'whatsapp'
    'revenue'
    'income'
    'commissions'
    'affiliate.*sales.*\$'
)

for pattern in "${PATTERNS[@]}"; do
    results=$(grep -rin --include="*.md" "$pattern" skills/ commands/ 2>/dev/null || true)
    if [ -n "$results" ]; then
        echo -e "${RED}FOUND:${NC} Pattern '${pattern}'"
        echo "$results" | head -5
        echo ""
        FOUND=1
    fi
done

# Check for references/ directories that shouldn't exist
ref_dirs=$(find skills/ commands/ -type d -name "references" 2>/dev/null || true)
if [ -n "$ref_dirs" ]; then
    echo -e "${RED}FOUND:${NC} references/ directories that should not be committed:"
    echo "$ref_dirs"
    echo ""
    FOUND=1
fi

if [ $FOUND -eq 0 ]; then
    echo -e "${GREEN}All clear. No personal data patterns detected.${NC}"
else
    echo -e "${YELLOW}Review the above findings before committing.${NC}"
    exit 1
fi
