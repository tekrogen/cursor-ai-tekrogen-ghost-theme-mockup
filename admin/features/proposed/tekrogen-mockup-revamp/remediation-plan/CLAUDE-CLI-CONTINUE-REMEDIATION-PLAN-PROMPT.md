You are continuing the Tekrogen Flywheel mockup remediation. Read IN FULL first:
- admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/CLAUDE-REMEDIATION-PLAN-FIX.md (incl. Addendum B, 2026-06-18)
- admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/CLAUDE-CLI-EXECUTION-PROMPT.md (incl. the 2026-06-18 Update)
- admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/SPACING-AND-RHYTHM-STANDARD.md
  Also read the root CLAUDE.md and mockups/CLAUDE.md.

Precondition: confirm PR #47 (fix/36-paper-accent-aa) is merged. If it isn't, stop and tell me — do
not branch on unmerged work. Once merged: git fetch && git merge --ff-only origin/main.

Execute exactly ONE work order this run: V8 + V6 (issues #39 + #37). Touch no other work order.

Hard rules (Phase E must not recur):
- Evidence is the rendered surface, never your own assessment. You may NOT call this done, validated,
  or ready. Only the human signs off, on screenshots.
- V8: set the H1 AND the OG + Twitter meta to the locked tagline verbatim — "Real solutions. Built,
  proven, ready to use." If you keep the descriptive line, demote it to a supporting dek. Grep the
  selectors; line numbers may have drifted.
- V6: change <div data-tk-slot="brand"> to <a data-tk-slot="brand" href="#/"> on all nine mastheads.
- Spacing: obey SP-1..SP-7 (var(--tk-space-*), proximity-driven) on anything you touch; do not
  regress rhythm. No layout change is expected in this work order.
- Evidence (upgraded convention): under remediation-plan/screenshots/v8-v6/ commit before/ and after/
  in all four states (Ink+Paper x 1440+390), callouts/ cropped to the H1 and the brand link, and
  REVIEW.md (one line per change: what changed, before->after, callout path). Serve over http.
- Git: branch fix/39-37-tagline-home-link -> assert git diff --cached --name-only -> pathspec commit
  -> PR titled "fix: set locked tagline verbatim and link brand lockup home" with "Closes #39" and
  "Closes #37". Do NOT re-stamp any version or touch v0.15.0.

Sequence: restate V8+V6 Problem/Fix/Acceptance in your own words and list the exact files+selectors
(grep to confirm) -> branch -> make the change -> before/after + callout screenshots + REVIEW.md ->
assert the staged set -> pathspec commit -> open the PR with Closes #39 #37 -> STOP and show me
REVIEW.md and the callouts for sign-off. Do not mark anything done.

If anything is ambiguous, or doing this well would require touching a second work order, stop and ask.