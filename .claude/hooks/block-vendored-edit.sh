#!/usr/bin/env bash
# PreToolUse (Edit|Write|MultiEdit) gate.
# Forbid editing the vendored DS components inside the mockup repo.
# Component fixes belong UPSTREAM in the Brand Design System, then re-vendor
# (see remediation-plan section C.1). Editing the DS source itself is allowed.
input=$(cat)
path=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')
[ -z "$path" ] && exit 0
case "$path" in
  *Tekrogen-Brand-Design-System/components/*)
    exit 0 ;;                                  # DS source — editing here is correct
  */components/*|components/*)
    echo "Blocked: don't edit vendored components/ in the mockup. Fix it upstream in the Brand Design System repo, then re-vendor (remediation-plan section C.1)." >&2
    exit 2 ;;
esac
exit 0
