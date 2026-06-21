# Claude CLI Execution Guide — Tekrogen Flywheel Remediation

**File:** `CLAUDE-CLI-EXECUTION-PROMPT.md`
**Date:** 2026-06-17
**Companion to:** `CLAUDE-REMEDIATION-PLAN-FIX.md` (the authoritative remediation spec)
**Purpose:** How to drive the remediation with Claude Code (the Claude CLI) so the **Phase E
tragedy** — declaring work "done" with no rendered proof — is structurally impossible to repeat.

---

## 1. Operating model (the thing that prevents drift)

Three rules. The agent never controls the third one.

1. **One work order per run.** Atomic branch, atomic PR, tractable evidence. Never batch two.
2. **The agent produces evidence and stops.** It may never call a work order done, validated,
   passing, or ready. It captures screenshots and presents them.
3. **You sign off on the rendered screenshots — not on the agent's summary.** This is the human gate
   Phase E skipped.

The guarantee is three-part and the agent owns only the weakest piece: the **prompt** forbids
self-attestation, a **hook** makes shipping a PR without screenshots impossible, and **you** judge
the screenshots. The hook ensures evidence *exists*; your eyes decide whether it *passes*. That
division is exactly what was missing before.

---

## 2. The kickoff prompt

Paste this into Claude Code, **once per work order**, swapping the `<<< … >>>` line each run.

```text
You are executing the Tekrogen Flywheel mockup remediation. The single source of truth is:
admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/CLAUDE-REMEDIATION-PLAN-FIX.md

Read that file IN FULL first, plus the files it references for THIS work order, plus the root
CLAUDE.md and mockups/CLAUDE.md.

Execute exactly ONE work order this run: <<< V2+V7 / #36+#38 >>>. Touch no other work order.

Hard rules — this is the "Phase E tragedy" the plan exists to prevent; do not repeat it:
- Evidence is the rendered surface, never your own assessment. You may NOT call this work order
  done, passing, validated, complete, or ready. Only the human signs off, on screenshots.
- Capture every screen this work order touches in ALL FOUR states — Ink + Paper x 1440 + 390 — into
  remediation-plan/screenshots/<wo>/<screen>-<surface>-<width>.png (plan section C.2). Serve the repo
  over http; never open file://.
- For any accessibility item, also write remediation-plan/contrast-audit.md with MEASURED ratios
  (plan section C.2 template + section J).
- Component fixes go UPSTREAM in the Brand Design System, then re-vendor (plan section C.1). Never
  edit this repo's vendored components/ to fix a component.
- Git discipline (plan section C): issue -> typed branch -> assert `git diff --cached --name-only` ->
  pathspec commit -> PR with a conventional title and "Closes #<n>". Do NOT re-stamp any version or
  touch v0.15.0 (V14 / section I).
- Token-only; both surfaces, both breakpoints (plan section D). Grep the CSS selectors — line numbers
  in the plan may have drifted (plan section C.3).

Run sequence:
1. Restate this work order's Problem / Fix / Acceptance in your own words and list the exact
   files + selectors you will change (grep to confirm anchors).
2. Create the typed branch.
3. Make the change.
4. Serve, capture the four-state screenshots into the convention folder; (a11y) write contrast-audit.md.
5. Assert the staged set, pathspec-commit, open the PR with Closes #.
6. STOP. Show me the screenshot paths and the contrast numbers, and ask me to review the rendered
   result. Do not mark anything done.

If anything is ambiguous, or doing this well would require touching a second work order, stop and ask.
```

---

## 3. Definition of done (per run) — impossible to fake

A work order is **not** done when the agent says so. It is done only when **all** of these are true:

- [ ] Screenshot files exist at `remediation-plan/screenshots/<wo>/<screen>-<surface>-<width>.png`
      for **every** affected screen in **all four** states (Ink + Paper × 1440 + 390).
- [ ] For accessibility work: `remediation-plan/contrast-audit.md` exists with **measured** ratios.
- [ ] The PR is open with a conventional title and `Closes #<n>`.
- [ ] **You** have opened the screenshots and signed off on the rendered result.

No version re-stamp and no "ready for the Ghost theme" claim until the plan's section K gate passes
with that sign-off.

---

## 4. Claude Code setup — hooks vs. permissions (they are different systems)

Two independent layers. Do not conflate them:

- **Permissions / permission mode** = how much Claude Code prompts *you* before each tool call. This
  is your interactivity dial. You do **not** need bypass / `--dangerously-skip-permissions` to run
  anything — `default` runs everything, just asking you to approve each new tool.
- **Hooks** = deterministic shell gates that fire on lifecycle events regardless of permission mode.
  A hook that exits `2` stops the tool call **before** permission rules are even evaluated, so the
  gate holds in any mode.

**Settings precedence (high → low):** managed → CLI flags →
`.claude/settings.local.json` (yours, git-ignored) → `.claude/settings.json` (committed, team) →
`~/.claude/settings.json` (user, all projects).

### 4a. The gate — committed `.claude/settings.json` (Single Project scope, shared)

This carries the hooks and the no-bypass lock. Everyone who clones the repo inherits it.

```json
{
  "permissions": {
    "disableBypassPermissionsMode": "disable"
  },
  "includeCoAuthoredBy": false,
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Edit|Write|MultiEdit",
        "hooks": [{ "type": "command", "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/block-vendored-edit.sh" }]
      },
      {
        "matcher": "Bash",
        "hooks": [{ "type": "command", "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/require-evidence.sh" }]
      }
    ]
  }
}
```

- `disableBypassPermissionsMode` locks out `--dangerously-skip-permissions` for this repo — nobody
  (including future-you) can YOLO the remediation.
- `includeCoAuthoredBy: false` enforces CLAUDE.md Rule #1 (no `Co-Authored-By: Claude`) at the tool
  level instead of trusting the model to remember. (A newer `attribution` object can also set this;
  confirm the exact key shape via `/config` if you prefer it.)

### 4b. Your run comfort — personal `.claude/settings.local.json` (git-ignored, yours only)

This tunes how often you're prompted, without imposing it on the repo. `acceptEdits` lets Claude
edit files freely while still confirming shell commands; the allow-list silences the safe, repeated
commands; `gh pr create` stays on **ask** so you consciously greenlight the "claiming done" moment.

```json
{
  "permissions": {
    "defaultMode": "acceptEdits",
    "allow": [
      "Bash(python3 -m http.server:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git branch:*)",
      "Bash(git checkout:*)",
      "Bash(git switch:*)",
      "Bash(git fetch:*)",
      "Bash(git merge --ff-only:*)",
      "Bash(git push:*)",
      "Bash(npx playwright:*)",
      "Bash(gh issue:*)"
    ],
    "ask": [
      "Bash(gh pr create:*)"
    ]
  }
}
```

Note: even in `acceptEdits`, the `block-vendored-edit.sh` hook still fires — a blocking hook beats an
allow rule — so editing vendored `components/` here is rejected no matter your mode.

### 4c. The two gate scripts — `.claude/hooks/` (committed; `chmod +x`; require `jq`)

`block-vendored-edit.sh` — enforces the section C.1 upstream rule:

```bash
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
```

`require-evidence.sh` — no PR without screenshots (the core anti-drift gate):

```bash
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
```

**Security note:** hooks run with your full user permissions, no sandbox. Review both scripts before
committing them. If you want the gate off the shared repo, move the `hooks` block to
`.claude/settings.local.json` instead — but committing it is the point: the gate should travel with
the repo.

### 4d. How you actually run it and see the rendered result

1. Start Claude Code interactively in the repo root (default or `acceptEdits` mode — **not** bypass).
2. Paste the section 2 prompt with this run's work order.
3. Let it work; approve shell commands as they come (the allow-list keeps this light).
4. When it stops, it will have written screenshots to `remediation-plan/screenshots/<wo>/`. Open
   them — or keep `python3 -m http.server` running and click through Ink/Paper × resize yourself at
   `http://localhost:8000/mockups/Tekrogen-Flywheel/index.html`.
5. Tell it "approved" (it may then squash-merge) or "redo X." You are the gate.

---

## 5. First sprint (one run each, in order)

1. **V2 + V7 / #36 + #38** — Paper-mode AA accent + cyan scope (one fix, closes both issues).
2. **V1 / #35** — Footer colophon.
3. **V6 + V8 / #37 + #39** — Brand home link + locked tagline (one `fix:` PR).

Re-validate in Ink + Paper at 1440 + 390 after each merge. Tackle **V3 / #34** (mobile nav) only
after the section C.1 upstream loop is confirmed, since it needs DS-repo work + re-vendor.

---

*Companion to `CLAUDE-REMEDIATION-PLAN-FIX.md`. This guide governs **how** the remediation is run;
that plan governs **what** is fixed. Neither is evidence that any fix is done — only the section K
gate with your sign-off on screenshots is.*


---

## Update — 2026-06-18 (read this; it overrides §2, §4, §5 where they differ)

Three changes after the V2/#47 review:

**A. Spacing is now a standing standard.** Add to the kickoff prompt's Hard rules:
> - Spacing by relationship, from the scale: all margin/padding/gap = var(--tk-space-*), step chosen
>   by proximity, not by eye. Gap BETWEEN groups >= one step larger than gaps WITHIN a group.
>   Follow the spacing standard: remediation-plan/SPACING-AND-RHYTHM-STANDARD.md (canonical: DS
>   ADR-0013). If the work order changes layout, also write spacing-audit.md.

**B. Upgraded evidence convention (supersedes §4d / §C.2 bare captures).** For each layout/visual work
order, produce under `remediation-plan/screenshots/<wo>/`:
- `before/<screen>-<surface>-<width>.png` (captured from origin/main BEFORE the change)
- `after/<screen>-<surface>-<width>.png` (after) — both, all four states
- `callouts/<element>-<surface>.png` — cropped close-up of each changed element
- `REVIEW.md` — one line per change: what changed, before→after, callout path

The reviewer reads `REVIEW.md` + callouts. Bare full-page shots are backup, not the review surface.
(V2's evidence was correct but unreviewable — this fixes that.)

**C. Re-sequenced sprint (replaces §5).** Run one per session, in this order:
1. V2+V7 / #36+#38 — DONE; merge #47.
2. **V8 + V6 / #39+#37** — locked tagline verbatim + brand→home link (one `fix:` PR). ← do next.
3. V1 / #35 — footer colophon.
4. V4 + V17 — spacing standard (s1 CTA→stats first, then project-wide).
5. V9 — hero balance.
6. V3 / #34 — mobile nav primitive (after the §C.1 upstream loop is confirmed).
7. R2 remainder (V10, V16) → R3 (V11, V12, V13) → governance (V14, V15).
