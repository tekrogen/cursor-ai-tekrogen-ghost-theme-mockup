# Recommendations — `CLAUDE-REMEDIATION-PLAN-FIX.md` Developer Handoff

**Date:** 2026-06-17  
**Subject:** Independent review of `CLAUDE-REMEDIATION-PLAN-FIX.md` as a cold-start developer handoff.  
**Parent spec:** `CLAUDE-REMEDIATION-PLAN-FIX.md` (authoritative for execution).  
**Prior reviews:** `REMEDIATION-PLAN.md` (diagnosis of record) · `REMEDIATION-PLAN-ANALYSIS.md` (review of that diagnosis).

---

## Executive verdict

**Yes — with caveats.** `CLAUDE-REMEDIATION-PLAN-FIX.md` is a credible developer handoff for this remediation. It is a clear upgrade over `REMEDIATION-PLAN.md` and addresses most gaps called out in `REMEDIATION-PLAN-ANALYSIS.md`.

A developer who has not been in prior sessions can start work from that file alone for **R1 consumer fixes** (V1, V2/V7, V6, V8) and most **R2 consumer items**. The largest remaining risk is **upstream/DS work** (V3, V5, V13), where the spec is strong on *what* but thinner on *how to ship* from the DS repo back into the mockup.

**Handoff readiness:** A− for R1/R2 consumer work · B for upstream/DS work · **B+ overall**

---

## Where it is still thin for a cold handoff

These are the gaps that remain after the fix document absorbed the prior remediation plan and its analysis. Each item below is actionable — closing them would move the handoff from **B+** to a full **A**.

### 1. Upstream workflow is underspecified

For `upstream` items (**V3**, **V5**, **V13**), the plan says:

- build in `Tekrogen-Brand-Design-System`
- follow ADR-0011
- re-vendor into `components/`

It does **not** include:

- DS repo URL or clone path
- the exact re-vendor command (e.g. `cp -R components/. ../Tekrogen-Ghost-theme-mockup/components/` per `CLAUDE.md`)
- whether issues **#34–#42** already exist and are assigned, or must be opened first per branch-naming convention
- PR/review expectations in the DS repo vs the mockup repo

**Impact:** A developer can execute V1, V2, V6, and V8 without touching the DS repo. **V3 and V5 will stall** without an upstream playbook.

**Recommendation:** Add a short **Upstream handoff** subsection (or companion `HANDOFF-UPSTREAM.md`) with clone path, re-vendor steps, and a checklist confirming issue/branch status for #34–#42 before `upstream` work begins.

---

### 2. Validation harness is described, not packaged

Section C mentions CDP/headless Chrome screenshots but provides no script, folder naming convention, or example output layout. A developer will know *what* to capture (Ink + Paper × 1440 + 390) but must invent *how*.

Similarly, `contrast-audit.md` is required at gate time (§J, §K) but no template is included.

**Impact:** Inconsistent evidence artifacts across PRs; risk of re-running the same Phase E failure mode (claiming PASS without comparable screenshots on disk).

**Recommendation:** Commit beside the plan:

- `remediation-plan/screenshots/` with a naming convention (e.g. `s1-ink-1440.png`, `s1-paper-390.png`)
- a minimal CDP or Playwright script, or step-by-step manual capture checklist
- `contrast-audit.md` template with columns matching §J

---

### 3. Subjective items lack measurable targets

These work orders are directionally clear but not pixel-precise:

| ID | Gap |
|----|-----|
| **V4** | “Generous separation”, `--tk-space-16/20` — which sections, which token, no before/after reference |
| **V9** | “No large dead void”, “columns read as one unit” — design judgment; “side-by-side with root `index.html`” helps but is not a spec |
| **V10** | “At least the home/preview” — which screens keep `data-style="framed"` vs production sticky header is partly open |

**Impact:** Developer and reviewer may disagree on “done” without an extra design-review loop.

**Recommendation:** Pair V4/V9/V10 with reference screenshots (root `index.html` + Claude-DT where applicable) and classify outcomes as **keep-intentional** vs **fix** in `layout-delta-vs-reference.md` (V16). Treat screenshot sign-off as the acceptance artifact for these items, not code merge alone.

---

### 4. Minor line-reference drift

One anchor in the parent spec is off: `.frame-url b` is cited at `index.html:65` but lives around **line 75** in the current file. Evidence is still correct; line numbers may have shifted as the consumer file evolves.

**Impact:** Low — grep resolves it — but erodes trust if a cold developer treats line numbers as gospel.

**Recommendation:** Add a one-line note in §C or §F1: *“Line anchors verified 2026-06-17; grep selectors if the consumer file has moved.”* Re-verify anchors when `mockups/Tekrogen-Flywheel/index.html` changes materially.

---

### 5. Still missing from a complete handoff packet

| Item | Status in parent spec |
|------|------------------------|
| VD spec AC IDs (e.g. AC-VD00-03 for footer) | Not mapped — V16 covers layout delta, not VD acceptance matrix |
| `mockups/Claude-DT/` as structural reference | Not mentioned — useful for V4, V9, V10 comparisons |
| Harness `.shell-bar` mobile caveat | Not mentioned — can confuse 390px review (`mockups/CLAUDE.md` warns harness chrome is not theme code) |
| Lucide inclusion method (V11) | Icon names given; no CDN vs inline SVG vs DS package guidance |
| V3 JavaScript | Behavior described in Appendix L; no reference implementation snippet |

**Impact:** None of these block R1 consumer work. They matter for polish, for avoiding false failures during mobile review, and for upstream V3 implementation speed.

**Recommendation:** Optional **Handoff appendix** bullets:

1. Map V1/V3/V6 to VD-00 AC IDs where they exist  
2. Name Claude-DT as the “known good” Flywheel reference for rhythm/header variants  
3. Footnote in §K: validate theme content inside `#stage`; harness `.shell-bar` overflow is out of scope  
4. Specify Lucide delivery (inline SVG per ADR-0005, consistent with DS gallery)  
5. Add a minimal nav-toggle JS snippet to Appendix L

---

### 6. Intentionally not a 3-expert review deliverable

The parent spec does not include scored categories, letter grades, or competitive framing from the Design-System-UIUX-Review prompt. That is **appropriate** for a remediation execution doc, not a gap for implementation — provided §K validation is run before any “ready” claim.

**Recommendation:** No change required unless stakeholders also want a formal `admin/review/VALIDATION.md` artifact after R1+R2; that would be a separate deliverable from this handoff.

---

## Developer readiness by phase (summary)

| Phase | Items | Ready to start? | Notes |
|-------|-------|-----------------|-------|
| **R1** | V2+V7, V1 | **Yes — immediately** | Consumer-only; code diffs in parent spec |
| **R1** | V3 | **Partially** | Appendix L solid; needs DS access + JS + re-vendor runbook |
| **R2** | V6, V8 | **Yes** | Trivial; can ship as one PR |
| **R2** | V5 | **Partially** | Appendix M clear; upstream `content-card.css` change required |
| **R2** | V4, V9, V10 | **Yes, with design judgment** | Screenshot-driven iteration |
| **R2** | V16 | **Yes** | Documentation task; deliverable shape is clear |
| **R3** | V11–V13 | **Roadmap-ready, not sprint-ready** | V13 is multi-week DS work; correctly deprioritized |
| **Gov** | V14, V15 | **Yes** | Explicit disk-edit scope |

---

## Recommended additions before assigning a cold developer

Add a short companion (or extend §C) with:

1. **DS repo clone + re-vendor steps**  
2. **Issue/branch checklist** (#34–#42 status)  
3. **Screenshot / contrast-audit folder convention** (+ optional CDP script)  
4. **Explicit note** that V4, V9, V10 need visual sign-off, not just code merge  

With those four additions, the handoff moves from **B+** to a full **A**. Without them, a competent developer can still execute **R1 minus V3** and most of **R2** from `CLAUDE-REMEDIATION-PLAN-FIX.md` alone.

---

## Suggested first sprint

Per the parent spec, in order:

1. **V2+V7** → **V1** → **V6+V8** (all consumer, low risk)  
2. Re-validate in Ink + Paper at 1440 + 390 after each merge  
3. Tackle **V3** only after upstream access and re-vendor runbook are confirmed  

---

*Prepared 2026-06-17. This document supplements `CLAUDE-REMEDIATION-PLAN-FIX.md`; it does not supersede it for execution.*
