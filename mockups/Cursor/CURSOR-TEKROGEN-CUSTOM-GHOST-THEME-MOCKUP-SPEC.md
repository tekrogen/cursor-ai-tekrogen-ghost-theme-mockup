# Cursor — Tekrogen Custom Ghost Theme Mockup Spec

**Status:** Draft — team review  
**Date:** 2026-06-21  
**Author:** Cursor agent (initial scope acknowledgment)  
**Working directory:** `/Users/martiniquehdolce/dev/cursor/Tekrogen-Ghost-theme-mockup`  
**Cursor Mockup Theme Directory:** `/Users/martiniquehdolce/dev/cursor/Tekrogen-Ghost-theme-mockup/mockups/Cursor`
**Original (Reference Only) Project Main Repo:** [tekrogen/Tekrogen-Ghost-Theme-Mockup](https://github.com/tekrogen/Tekrogen-Ghost-Theme-Mockup)  
**Original (Reference Only) Project Main Issues:** [GitHub Issues](https://github.com/tekrogen/Tekrogen-Ghost-Theme-Mockup/issues)
**This Project Repo:** [Cursor Tekrogen Mockup Repo](https://github.com/tekrogen/cursor-ai-tekrogen-ghost-theme-mockup)  
**This Project Issues:** [GitHub Issues](https://github.com/tekrogen/cursor-ai-tekrogen-ghost-theme-mockup/issues) 


---

## 1. Purpose of this document

This spec captures the **scope, reading tasks, success criteria, and execution discipline** for delivering a production-quality **Tekrogen Flywheel mockup** in the Cursor worktree. The mockup is the design artifact that must be reviewed and locked **before** building the custom Ghost Pro theme.

This document is intended for **team review**. Once reviewed and any adjustments are incorporated, work proceeds with the first remediation work order (V8 + V6).

---

## 2. What this project is

A **high-fidelity HTML mockup** — primarily `mockups/Cursor/Tekrogen-Flywheel` — that rehearses a **custom Ghost Pro theme** for Tekrogen's four-pillar publishing flywheel.

| Aspect                   | Detail                                                                                 |
|--------------------------|----------------------------------------------------------------------------------------|
| **Deliverable**          | Self-contained HTML used to review and lock information architecture and visual design |
| **Not in scope (yet)**   | A runnable Ghost theme, build pipeline, or CMS integration                             |
| **Design system source** | `Tekrogen-Brand-Design-System` — vendored as `components/` + `colors_and_type.css`     |
| **Component contract**   | 34 `tk-*` registry components; token-only styling; Ink + Paper surfaces                |
| **Downstream use**       | Locked mockup + AI prompt parameters → custom Ghost theme in Handlebars                |

The eventual Ghost theme build will be guided by prompt parameters in:

`/Users/martiniquehdolce/dev/cursor/Tekrogen-Ghost-theme-mockup/admin/AI prompts`

- `GHOST-CRM-AND-THEME-EXPERT.md` — Ghost CMS architecture, templates, routing, memberships
- `Design-System-UIUX-Review-Prompt.md` — 3-expert UI/UX review method

---

## 3. Why this worktree exists

The mockup was **removed from the Original Project Main repo** into this separate Cursor worktree because current progress did not meet the bar for a credible Ghost theme foundation. The Phase E lock (`v0.15.0`) was **premature** — it validated a thin technical slice (overflow + token floor + Ink-only screenshots) and declared "all PASS" without testing Paper mode, mobile navigation, footer colophon, or the locked tagline.

**Standing rule:** Treat `v0.15.0` as a checkpoint tag, not a layout lock. No "ready for Ghost theme" claim until the §K acceptance gate passes with **human sign-off on rendered screenshots**.

---

## 4. Reading tasks (authoritative sources)

These documents must be read and followed during remediation and mockup delivery.

| Source                         | Path (relative to mockup repo)                                                                                   | Role                                                                     |
|--------------------------------|------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| Gap analysis (diagnosis)       | `admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/REMEDIATION-PLAN.md`                            | 14 visual gaps (V1–V14), severity, affected files                        |
| **Execution spec (authority)** | `admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/CLAUDE-REMEDIATION-PLAN-FIX.md`                 | Work orders: Problem / Fix / Acceptance / Validate                       |
| Execution guide                | `admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/CLAUDE-CLI-EXECUTION-PROMPT.md`                 | How to run remediation — one work order per session, evidence discipline |
| Continue prompt                | `admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/CLAUDE-CLI-CONTINUE-REMEDIATION-PLAN-PROMPT.md` | Current sprint sequence and active work order                            |
| Spacing standard               | `admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/SPACING-AND-RHYTHM-STANDARD.md`                 | SP-1..SP-7 — standing rules on any layout touch                          |
| Publishing scope               | `admin/features/proposed/tekrogen-mockup-revamp/_planning-specs/INDEX.md`                                        | Flywheel workflow, content types, Ghost template mapping                 |
| Workflow diagram               | `admin/features/proposed/tekrogen-mockup-revamp/_planning-specs/01.workflow-publishing-system-planning.png`      | Visual model of the publishing system                                    |
| Visual domain specs            | `admin/features/proposed/tekrogen-mockup-revamp/visual-domains/FEAT-VD-00…09`                                    | Per-screen acceptance criteria → Ghost templates                         |
| Repo rules                     | `CLAUDE.md`, `mockups/CLAUDE.md`                                                                                 | Surface map, upstream/re-vendor policy, versioning                       |
| GitHub issues (operational)    | [Cursor #3–#11](https://github.com/tekrogen/cursor-ai-tekrogen-ghost-theme-mockup/issues)                         | Operational tracking + `Closes` targets for remediation work orders      |
| GitHub issues (traceability)   | [original #34–#42](https://github.com/tekrogen/Tekrogen-Ghost-Theme-Mockup/issues)                               | Source references only — **not** `Closes` targets from this repo         |

---

## 4a. Issue mapping (Cursor repo)

The 9 open source issues were mirrored into this repo on 2026-06-21. **Cursor numbers are the
operational key** (use them in branches and `Closes`); original numbers are **traceability only**
(GitHub will not close issues in another repo). V-IDs remain the stable label across both.

| V-ID      | Original (ref only) | **Cursor** | Title                                   | Sprint step |
|-----------|---------------------|------------|------------------------------------------|-------------|
| **V8**    | #39                 | **#8**     | Locked tagline verbatim in hero          | 2 (next)    |
| **V6**    | #37                 | **#7**     | Brand lockup → homepage link             | 2 (next)    |
| **V1**    | #35                 | **#6**     | Footer colophon on all screens           | 3           |
| **V3**    | #34                 | **#5**     | Mobile navigation / menu-toggle          | 6           |
| **V11**   | #40                 | **#9**     | Lucide outline icons (docs categories)   | 8           |
| **V13**   | #42                 | **#11**    | Interactive-primitives epic              | 8           |
| **V14**   | #41                 | **#10**    | Version realignment                      | 9           |
| —         | #14                 | **#3**     | Remove redundant `index-bak.html`        | cleanup     |
| —         | #15                 | **#4**     | gitignore `.analysis/` (done in copy)    | cleanup     |
| **V2+V7** | #36, #38            | —          | Paper-mode AA + cyan scope               | inherited¹  |
| **V5**    | #38-adj             | —          | Card interactivity                       | inherited¹  |
| **V10**   | ~~#57~~ (invalid)   | —          | Production sticky header variant         | untracked²  |

¹ Closed upstream (shipped via merged source PR #47); not mirrored. Treated as inherited
baseline in the Cursor surface — **verify**, no dependency on original-repo PRs.
² Original `#57` does not exist; V4/V9/V16/V17 are likewise unticketed ("new"). Create a Cursor
issue if/when these enter a sprint.

> **Reference syntax:** link original issues as `Tekrogen-Ghost-Theme-Mockup#39` for traceability;
> only `cursor-ai-tekrogen-ghost-theme-mockup` numbers may be used as `Closes #<n>` targets.

---

## 5. Publishing workflow the mockup must express

From the planning spec and workflow diagram, the mockup must make the **Tekrogen Publishing Flywheel** visible on a single Ghost site — all four BNR pillars without requiring separate domains to be live.

### 5.1 Flywheel stages

```
Use Case Study (.org / L1)
    → POC / Demo (.studio / L2)
    → User Registration (Lead Gen + Stripe)
    → Product Licensing (Subscription gate)
    → Products (.com / L3)
    → Distribution / Docs / Versioning (.net / L6–L7)
```

### 5.2 Four pillars

| Pillar     | Domain          | Role                                                      |
|------------|-----------------|-----------------------------------------------------------|
| **org**    | tekrogen.org    | Use case studies, research, credibility (L1)              |
| **studio** | tekrogen.studio | POCs, demos, free artifacts (L2)                          |
| **com**    | tekrogen.com    | Products, licensing, paid access (L3–L4)                  |
| **net**    | tekrogen.net    | Distribution, documentation, versioning, tracking (L6–L7) |

### 5.3 Nine screens → Ghost templates

| Screen | Visual domain                | Ghost template                 | Pillar  |
|--------|------------------------------|--------------------------------|---------|
| s1     | Home / flywheel overview     | `home.hbs`                     | all     |
| s2     | Case-study channel (listing) | `channel-use-case-studies.hbs` | org     |
| s3     | Use case study reader        | `custom-use-case-study.hbs`    | org     |
| s4     | Recon / research reader      | `custom-recon.hbs`             | org     |
| s5     | Demo / proof of concept      | `custom-proof-of-concept.hbs`  | studio  |
| s6     | Product + licensing          | `custom-product.hbs`           | com     |
| s7     | Documentation / distribution | `channel-documentation.hbs`    | net     |
| s8     | About / static page          | `page.hbs`                     | org     |
| s9     | Membership / account         | `account.hbs`                  | com/net |

### 5.4 Design system constraints (from planning spec)

- **One dominant pillar color per content type** — signals what kind of content the visitor is on.
- **Cross-pillar CTAs** carry the *destination's* color — signals forward motion through the flywheel.
- **BNR §5.2 eight-section use-case structure** — Problem, Acceptance Criteria, Stack Decision, Trade-offs, Build, What We'd Do Differently, Outcome, CTA.
- **Membership gating** — Ghost-native `{{#if @member}}` / `{{#if @member.paid}}` patterns in product/access partials.
- **License tiers** — Standard / Extended / Team commercial + MIT free.
- **Paired content** — `#pair-{topic}` tags for cross-pillar relationship chaining.
- **Content type tags** — e.g. `#feature-use-case-study`, `#feature-proof-of-concept`, `#feature-product`, `#feature-product-detail`.

---

## 6. Remediation plan summary

The rendered audit identified **14 gaps (V1–V14)** between the current Flywheel surface and a production-quality foundation. Severity and priority:

### 6.1 High — blocks Ghost theme foundation (R1)

| ID        | Original ref | Cursor | Problem (summary)                                                              |
|-----------|--------------|--------|--------------------------------------------------------------------------------|
| **V2+V7** | #36, #38     | —      | Paper-mode AA failure — raw cyan text on white; cyan inflation across surfaces |
| **V1**    | #35          | #6     | Footer missing colophon (©, RSS, Contact) on all nine screens                  |
| **V3**    | #34          | #5     | No mobile navigation — nav hidden at ≤768px with no menu toggle                |

### 6.2 Medium — brand + UX conformance (R2)

| ID      | Original ref      | Cursor | Problem (summary)                                            |
|---------|-------------------|--------|--------------------------------------------------------------|
| **V4**  | new               | —      | Cramped vertical rhythm between home sections                 |
| **V5**  | #38-adj           | —      | Cards read as non-interactive — no link wrap, weak hover      |
| **V6**  | #37               | #7     | Logo is `<div>`, not a home link                              |
| **V7**  | #38               | —      | Cyan on too many elements per screen                          |
| **V8**  | #39               | #8     | Hero paraphrases locked tagline instead of using it verbatim  |
| **V9**  | new               | —      | Hero right column unbalanced — flywheel diagram in dead space |
| **V10** | ~~#57~~ (invalid) | —      | Production sticky header variant never demonstrated           |

### 6.3 Low / port-queue (R3) + governance

| ID      | Original ref | Cursor | Problem (summary)                                                    |
|---------|--------------|--------|---------------------------------------------------------------------|
| **V11** | #40          | #9     | Docs category icons are 2-letter monograms, not Lucide                |
| **V12** | watch        | —      | Off-signature `.stamp` rotate and off-table glyphs                    |
| **V13** | #42          | #11    | Interactive primitives implied but not built (pagination, tabs, etc.) |
| **V14** | #41          | #10    | Version realignment; un-lock premature v0.15.0 claim                  |
| **V15** | doc          | —      | Stale docs (e.g. "s2–s9 are stubs" — now built)                       |

### 6.4 What the mockup already gets right

- Real DS consumption: `colors_and_type.css` + vendored `tk-components.css`; 33/34 `tk-*` components with correct tokens and `data-tk-slot` contract.
- Respects ≥12px type floor and `--tk-fg-3` text-color floor (except V2 accent lapse).
- Flat, hairline, Ink-primary aesthetic; pillar colors as accents, never page backgrounds.
- Cross-pillar relations use colored pip + word (WCAG 1.4.1).
- No horizontal overflow at 390px on all nine screens.

The problem is **organism conformance, visual rhythm, interaction affordance, and Paper accessibility** — not wrong colors or missing components.

---

## 7. Remediation sprint order

Re-sequenced per `CLAUDE-CLI-EXECUTION-PROMPT.md` (2026-06-18 update). **One work order per session.**

Issue numbers below are **Cursor-repo** numbers (operational); originals are kept for reference
in §4a. Cells marked `—` have no Cursor issue yet (inherited baseline or unticketed "new").

| Step | Work order                                     | Cursor issues | Status                                                          |
|------|------------------------------------------------|---------------|-----------------------------------------------------------------|
| 1    | V2 + V7 — Paper-mode AA accent + cyan scope    | — (orig #36/#38) | Inherited from source (PR #47); **verify in Cursor surface — no dependency on original-repo PRs** |
| 2    | **V8 + V6 — Locked tagline + brand home link** | #8, #7        | **Next (first work order after team sign-off)**                 |
| 3    | V1 — Footer colophon                           | #6            | Pending                                                         |
| 4    | V4 + V17 — Section spacing standard            | — (new)       | Pending — create Cursor issue at sprint start                   |
| 5    | V9 — Hero balance                              | — (new)       | Pending — create Cursor issue at sprint start                   |
| 6    | V3 — Mobile nav primitive                      | #5            | Pending (upstream DS component)                                 |
| 7    | R2 remainder (V5, V10, V16)                    | — (none)      | Pending — V5/V10 untracked (V10 orig #57 invalid)              |
| 8    | R3 (V11, V12, V13)                             | #9, #11       | Pending                                                         |
| 9    | Governance (V14, V15)                          | #10           | Pending                                                         |

---

## 8. Success criteria (§K acceptance gate)

The mockup is **ready for Ghost theme implementation** only when **all** of the following are true:

- [ ] All R1 + R2 remediation items merged and re-validated in **Ink AND Paper at 1440 AND 390**.
- [ ] Paper mode: every accent passes WCAG AA (no raw cyan text on white).
- [ ] Mobile: every nav destination reachable via a real control (hamburger/menu toggle).
- [ ] Footer carries colophon (©, RSS, Contact) on every screen.
- [ ] Cards are unmistakably interactive (hover + focus + cursor + link wrap).
- [ ] Locked tagline used verbatim: *"Real solutions. Built, proven, ready to use."*
- [ ] Brand lockup links home on all nine mastheads.
- [ ] Side-by-side with DS reference + root `index.html`: hierarchy, spacing rhythm, and typography read as the same design language.
- [ ] All nine VD specs (FEAT-VD-00…09) acceptance criteria met on rendered surface.
- [ ] Publishing flywheel visually expressed: four pillars, cross-pillar CTAs, content-type signals.
- [ ] **Human sign-off on rendered screenshots** — not on agent summaries or status docs.

---

## 9. Execution discipline

These rules apply to every remediation session and mockup change.

### 9.1 One work order per run

- Atomic branch → pathspec commit → PR with conventional title and `Closes #<n>`.
- Never batch two work orders in one PR (except explicitly paired items like V8+V6).
- `Closes #<n>` must reference **cursor-ai-tekrogen-ghost-theme-mockup** issues only. Original
  issues (`Tekrogen-Ghost-Theme-Mockup#<n>`) are traceability links — they will **not** auto-close
  from this repo. See the §4a mapping.

### 9.2 Evidence is the rendered surface

- Capture **before/** and **after/** screenshots in all four states: Ink + Paper × 1440 + 390.
- Add **callouts/** — cropped close-ups of each changed element.
- Write **REVIEW.md** — one line per change: what changed, before→after, callout path.
- Serve over HTTP (`python3 -m http.server`) — never open `file://`.
- For accessibility work: measured ratios in `contrast-audit.md`.

### 9.3 Agent may not self-attest

The agent produces evidence and **stops**. It may not call any work order "done," "validated," "passing," or "ready." Only the human signs off on screenshots.

### 9.4 Component fixes go upstream

- Edit `Tekrogen-Brand-Design-System` → PR in DS repo → re-vendor into mockup → wire consumer.
- **Never** edit vendored `components/` in the mockup repo to fix a component.
- Two repos = two PRs; do not bundle.

### 9.5 Global design rules (every change)

1. **Token-only** — no new color/spacing/radius/shadow literals; use `--tk-*`.
2. **Theme-aware accents** — text accents must pass AA on both Ink and Paper.
3. **One cyan per surface** — cyan reserved for the single primary CTA.
4. **Type & contrast floors** — ≥12px type; `--tk-fg-3` text-color floor.
5. **Mark tilt is 18° once** — no second CSS rotate (`.stamp` violates this).
6. **Both surfaces, both breakpoints, every time** — Ink + Paper × 1440 + 390.
7. **Reachability & keyboard** — focusable, keyboard-operable, visible `:focus-visible` ring.
8. **Spacing by relationship** — `var(--tk-space-*)` per SP-1..SP-7; gaps between groups ≥ one step larger than gaps within groups.

### 9.6 Review before hand-off

Any UI/UX artifact must pass the **3-expert review method** (`Design-System-UIUX-Review-Prompt.md`) and validate against the Tekrogen Brand Design System before hand-off.

---

## 10. Key paths

| Resource                      | Path                                                                                |
|-------------------------------|-------------------------------------------------------------------------------------|
| Cursor worktree (mockup repo) | `/Users/martiniquehdolce/dev/cursor/Tekrogen-Ghost-theme-mockup`                    |
| Primary consumer surface      | `mockups/Cursor/Tekrogen-Flywheel/index.html`                                              |
| Structural reference surface  | `mockups/Claude-DT/index.html`                                                      |
| Layout reference              | root `index.html`                                                                   |
| DS source (upstream)          | `/Users/martiniquehdolce/dev/tekrogen/Tekrogen-Brand-Design-System`                 |
| AI prompts (Ghost theme)      | `/Users/martiniquehdolce/dev/tekrogen/Tekrogen-Ghost-theme-mockup/admin/AI prompts` |
| Remediation plan              | `admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/`                  |
| Visual domain specs           | `admin/features/proposed/tekrogen-mockup-revamp/visual-domains/`                    |
| Publishing planning spec      | `admin/features/proposed/tekrogen-mockup-revamp/_planning-specs/INDEX.md`           |

**Preview:**

```bash
cd /Users/martiniquehdolce/dev/cursor/Tekrogen-Ghost-theme-mockup
python3 -m http.server 8000
# open http://localhost:8000/mockups/Cursor/Tekrogen-Flywheel/index.html [**Note: Changed path to Cursor/Tekrogen-Flywheel/index.html**]
```

---

## 11. First work order (after team sign-off)

**V8 + V6** — Locked tagline verbatim + brand home link (Cursor issues #8, #7)

| Item             | Requirement                                                                                                                            |
|------------------|----------------------------------------------------------------------------------------------------------------------------------------|
| **V8**           | Set H1 and OG + Twitter meta to: *"Real solutions. Built, proven, ready to use."* Demote current paraphrase to supporting dek if kept. |
| **V6**           | Change `<div data-tk-slot="brand">` → `<a data-tk-slot="brand" href="#/">` on all nine mastheads.                                      |
| **Branch**       | `fix/7-8-tagline-home-link`                                                                                                            |
| **PR title**     | `fix: set locked tagline verbatim and link brand lockup home`                                                                          |
| **Closes**       | #8, #7 (Cursor)                                                                                                                        |
| **Original ref** | `Tekrogen-Ghost-Theme-Mockup#39, #37` (traceability only — not a `Closes` target)                                                      |
| **Precondition** | Confirm V2+V7 accent fixes are present in the Cursor surface (inherited from source PR #47); `git fetch && git merge --ff-only origin/main`. No dependency on original-repo PRs. |
| **Evidence**     | `remediation-plan/screenshots/v8-v6/` — before/, after/, callouts/, REVIEW.md                                                          |

**Explicitly out of scope for this work order:** footer, spacing, mobile nav, hero balance, version re-stamp.

---

## 12. Team review checklist

Use this section during review. Mark each item and note adjustments in comments or a follow-up edit to this spec.

| #  | Review item                                                             | Agree? | Notes / adjustment |
|----|-------------------------------------------------------------------------|--------|--------------------|
| 1  | Scope: mockup first, Ghost theme second — correct sequencing?           | ☐      |                    |
| 2  | Working directory and worktree separation — acceptable?                 | ☐      |                    |
| 3  | Publishing flywheel + nine-screen mapping — complete and accurate?      | ☐      |                    |
| 4  | Remediation gap list (V1–V14) — anything missing or mis-prioritized?    | ☐      |                    |
| 5  | Sprint order — agree V8+V6 is the correct first work order?             | ☐      |                    |
| 6  | §K acceptance gate — sufficient bar before Ghost theme work?            | ☐      |                    |
| 7  | Evidence discipline (screenshots, human sign-off) — acceptable process? | ☐      |                    |
| 8  | Upstream DS → re-vendor workflow — correct for component fixes?         | ☐      |                    |
| 9  | AI prompt paths for downstream Ghost theme — correct references?        | ☐      |                    |
| 10 | Any scope to add, remove, or defer before starting remediation?         | ☐      |                    |

---

## 13. Changelog

| Date       | Change                                                                                         | Author                    |
|------------|------------------------------------------------------------------------------------------------|---------------------------|
| 2026-06-21 | Initial spec — scope acknowledgment for team review                                            | Cursor agent              | 
| 2026-06-21 | Project Guidance AI Prompts + Review sign-off (`Tekrogen-Ghost-theme-mockup/admin/AI prompts`) | Marti Dolce, Tekrogen CEO |
| 2026-06-21 | Mirrored 9 open source issues into Cursor repo (#3–#11); renumbered spec refs to Cursor operational IDs, added §4a mapping, dropped original-repo PR #47 precondition | Cursor agent |

---

**End of spec.** After team review and any adjustments, proceed with work order **V8 + V6** per §11.
