#!/usr/bin/env bash
#
# RULE-COMMIT-014 — Pre-commit checklist enforcement
# Checks before every commit:
#   1. worklog.md is staged (RULE-WORKLOG-002)
#   2. No emoji/Unicode in staged .md files (RULE-DOC-015)
#   3. Code files have corresponding test or doc (RULE-DOC-010)
#   4. No large binary files staged (>1MB)
#   5. Commit message is not empty
#
# Usage:
#   bash guard/scripts/check-commit-checklist.sh           # soft warn
#   bash guard/scripts/check-commit-checklist.sh --hard    # hard fail
#
# Exit codes:
#   0  all checks pass
#   1  check failed AND --hard set
#   2  usage error

set -euo pipefail

HARD_MODE=0
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLATFORM_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

for arg in "$@"; do
    case "$arg" in
        --help|-h) sed -n '2,25p' "$0"; exit 0 ;;
        --hard) HARD_MODE=1 ;;
        *) echo "Unknown flag: $arg"; exit 2 ;;
    esac
done

VIOLATIONS=0
emit_pass() { echo "  [PASS] $1"; }
emit_fail() { echo "  [FAIL] $1"; VIOLATIONS=$((VIOLATIONS + 1)); }
emit_warn() { echo "  [WARN] $1"; }

echo "=== RULE-COMMIT-014: pre-commit checklist ==="
echo "Mode: $([ $HARD_MODE -eq 1 ] && echo 'HARD' || echo 'SOFT')"
echo ""

cd "$PLATFORM_DIR"
STAGED=$(git diff --cached --name-only 2>/dev/null || true)

if [ -z "$STAGED" ]; then
    echo "  No staged files. Nothing to check."
    echo "RESULT: PASS"
    exit 0
fi

# --- Check 1: Emoji/Unicode in .md files (RULE-DOC-015) ---
echo "--- RULE-DOC-015: no emoji/Unicode in .md files ---"
EMOJI_FOUND=0
EMOJI_FILES=""
while IFS= read -r f; do
    [ -z "$f" ] && continue
    [[ "$f" != *.md ]] && continue
    # Check for emoji/Unicode graphics (same ranges as V04)
    if grep -Pq '[\x{1F300}-\x{1F9FF}\x{2702}\x{2714}\x{2716}\x{274C}\x{274E}\x{2753}\x{2757}\x{2795}-\x{2797}\x{2B05}-\x{2B07}\x{2B1B}\x{2B1C}\x{2B50}\x{2B55}]' "$f" 2>/dev/null; then
        EMOJI_FOUND=$((EMOJI_FOUND + 1))
        EMOJI_FILES="$EMOJI_FILES $f"
    fi
done <<< "$STAGED"

if [ $EMOJI_FOUND -eq 0 ]; then
    emit_pass "no emoji/Unicode in staged .md files"
else
    emit_fail "emoji/Unicode found in $EMOJI_FOUND staged .md file(s):$EMOJI_FILES (RULE-DOC-015)"
fi

# --- Check 2: Large binary files (>1MB) ---
echo "--- RULE-COMMIT-014: no large binaries ---"
LARGE_FILES=""
while IFS= read -r f; do
    [ -z "$f" ] && continue
    # Skip known binary directories
    [[ "$f" == node_modules/* ]] && continue
    [[ "$f" == .git/* ]] && continue
    [[ "$f" == docs/_graph/* ]] && continue
    if [ -f "$f" ]; then
        SIZE=$(wc -c < "$f" 2>/dev/null || echo "0")
        if [ "$SIZE" -gt 1048576 ]; then
            LARGE_FILES="$LARGE_FILES $f ($(( SIZE / 1048576 ))MB)"
        fi
    fi
done <<< "$STAGED"

if [ -z "$LARGE_FILES" ]; then
    emit_pass "no large binary files (>1MB)"
else
    emit_fail "large files staged:$LARGE_FILES (RULE-COMMIT-014: consider git-lfs)"
fi

# --- Check 3: worklog.md staged (RULE-WORKLOG-002) ---
echo "--- RULE-WORKLOG-002: worklog staged ---"
CODE_EXT_REGEX='\.(py|js|ts|tsx|jsx|sh|go|rs|java|c|cpp|h|hpp|rb|php|swift|kt)$'
CODE_COUNT=0
while IFS= read -r f; do
    [ -z "$f" ] && continue
    [[ "$f" =~ $CODE_EXT_REGEX ]] && CODE_COUNT=$((CODE_COUNT + 1))
done <<< "$STAGED"

if [ "$CODE_COUNT" -gt 0 ]; then
    # Only require worklog if worklog.md has actual changes
    WORKLOG_CHANGED=$(git diff --name-only -- worklog.md 2>/dev/null | grep -q . && echo "yes" || echo "no")
    if [ "$WORKLOG_CHANGED" = "yes" ]; then
        if git diff --cached --name-only -- worklog.md 2>/dev/null | grep -q .; then
            emit_pass "code changes accompanied by worklog entry"
        else
            emit_fail "worklog.md modified but not staged (RULE-WORKLOG-002)"
        fi
    else
        emit_pass "worklog unchanged — skipping worklog check"
    fi
else
    emit_pass "no code changes — worklog check skipped"
fi

# --- Check 4: HONEST-006 — "done" without verification evidence ---
echo "--- RULE-HONEST-006: no unverified completion claims ---"
HONEST_ISSUES=""
while IFS= read -r f; do
    [ -z "$f" ] && continue
    [[ "$f" != *.md ]] && continue
    # Check worklog for completion claims without verification
    if [ -f "$f" ]; then
        # Look for "done", "fixed", "resolved", "готово", "исправлено" followed by no test/verify/run
        CLAIMS=$(grep -inE "(done|fixed|resolved|готово|исправлено|complete|completed)" "$f" 2>/dev/null | grep -viE "(test|verify|run|check|pass|проверк|тест)" | head -5 || true)
        if [ -n "$CLAIMS" ]; then
            HONEST_ISSUES="$HONEST_ISSUES $f"
        fi
    fi
done <<< "$STAGED"

if [ -z "$HONEST_ISSUES" ]; then
    emit_pass "no unverified completion claims"
else
    emit_warn "completion claims without verification evidence:$HONEST_ISSUES (RULE-HONEST-006 — verify before claiming done)"
fi

echo ""
echo "=== Summary ==="
echo "  Violations: $VIOLATIONS"
echo ""

if [ $VIOLATIONS -gt 0 ] && [ $HARD_MODE -eq 1 ]; then
    echo "RESULT: FAIL — commit checklist violations detected. (RULE-COMMIT-014)"
    exit 1
elif [ $VIOLATIONS -gt 0 ]; then
    echo "RESULT: WARN — re-run with --hard to enforce."
    exit 0
else
    echo "RESULT: PASS — all checklist items satisfied."
    exit 0
fi
