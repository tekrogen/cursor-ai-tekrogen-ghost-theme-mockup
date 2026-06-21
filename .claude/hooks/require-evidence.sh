#!/usr/bin/env bash
# PreToolUse (Bash) gate.
# Block 'gh pr create' when the branch CHANGED THE RENDERED SURFACE but produced no
# screenshot evidence. Non-visual branches (docs-only, chore, config) are NOT gated.
# Evidence convention: remediation-plan/screenshots/<wo>/<screen>-<surface>-<width>.png
input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
echo "$cmd" | grep -q 'gh pr create' || exit 0

# Did this branch touch the rendered surface, vendored components, or the token sheet?
touched=$(git diff --name-only origin/main...HEAD 2>/dev/null \
  | grep -Ec 'mockups/Tekrogen-Flywheel/index\.html|^components/|colors_and_type\.css')
[ "${touched:-0}" -eq 0 ] && exit 0          # non-visual change — no evidence required

# Visual change: require screenshots, committed on the branch OR present untracked.
committed=$(git diff --name-only origin/main...HEAD 2>/dev/null | grep -c 'remediation-plan/screenshots/')
untracked=$(git ls-files --others --exclude-standard 2>/dev/null | grep -c 'remediation-plan/screenshots/')
if [ "${committed:-0}" -eq 0 ] && [ "${untracked:-0}" -eq 0 ]; then
  echo "Blocked: this branch changed the rendered surface but has no screenshots under remediation-plan/screenshots/. Capture Ink+Paper x 1440+390 first (remediation-plan section C.2)." >&2
  exit 2
fi
exit 0
