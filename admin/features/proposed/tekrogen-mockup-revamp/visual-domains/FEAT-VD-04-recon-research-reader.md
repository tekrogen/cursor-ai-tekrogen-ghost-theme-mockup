# FEAT-VD-04: Recon / Research Reader

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0011 (component model)
**Related screen:** Claude-DT **s4**
**Ghost template:** `custom-recon.hbs` (a.k.a. `custom-research.hbs`) · **route:** `/recon/{slug}/` · **context:** post · **visibility:** public · **pillar:** `.org`
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The unified "justify the stack" reader. **Recon** is the single qualitative research category
that absorbed the former *Research Article* and *SaaS Evaluation* types (v0.5.0) — multi-source
comparison done *before* a Demo. Its defining constraint: **qualitative, no ratings, ever.** The
template's centerpiece is a candidate-comparison table whose verdict is "chosen / rejected,"
never a score, and a decision callout that **feeds the demo**.

---

## Problem Statement

Before building, Tekrogen narrows a field of approaches and documents the trade-offs. Readers
need that comparison legibly — but the brand rule forbids numeric scoring; the decision belongs
to constraints and stakeholders.

### Current State

Claude-DT s4 renders a badge + display headline + italic dek, a "qualitative · no scores"
`tk-callout`, a 4-column candidates `tk-table` (Candidate / Strengths / Costs / Fit) with a
`✓ chosen` marker, a numbered sources list, and a `.com`-keyed "Decision → the stack" callout
with a "→ feeds the demo" marker.

### Desired State

A locked `custom-recon.hbs` that connects upstream to its Use Case Study and downstream to the
Demo it feeds, enforces the no-score rule, and reuses the comparison-table pattern.

---

## Ghost Mapping

Per-post custom template (selected in editor). **Template-hierarchy justification:** the fixed
"candidates table + decision callout + feeds-the-demo" scaffold is not expressible in `post.hbs`,
so a custom template is justified. Upstream/downstream links use the pairing tag
(`tag:hash-pair-{topic}`) to surface the related study and the demo. Recon posts live under the
`.org` collection alongside studies but carry the recon tag for their own channel filter.

---

## Layout Anatomy (keyed to s4)

1. **Masthead** — `aria-current` on Recon.
2. **Classbar** — Recon №, ".org · recon", "Qualitative · no scores".
3. **Header block** — `tk-badge[data-pillar="org"]` (.org · recon) → `h1.display` → `.lead.italic-dek`
   → topic `tk-label` row (methods + tools, security).
4. **No-scores callout** — `tk-callout`: "Recon is qualitative … **no ratings, ever**. The final
   stack decision belongs to the stakeholders' skills and the client's constraints." (This is the
   guardrail rendered as content.)
5. **Candidates considered** — `h2` over a `tk-table`: columns Candidate / Strengths / Costs / Fit;
   the chosen row carries a `.chosen` (`✓ chosen`) mono marker; others read "Rejected" / "Weak"
   in prose — never a number.
6. **Sources** — `h2` + numbered `.sources` list (qualitative citations).
7. **Decision callout** — `tk-callout[data-pillar="com"]`: "Decision → the stack: … Feeds the
   banking-panel demo." with a `.feeds` ("→ feeds the demo") marker — the forward link.
8. **Footer** — VD-00 F2.

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-badge` | `data-pillar="org"` | Category id |
| `tk-callout` | default + `data-pillar="com"` | No-scores guardrail + decision/feeds-demo |
| `tk-table` | default; `.chosen` cell marker | Qualitative candidate comparison |
| `tk-label` | default | Topic tags |

> `.sources` and `.feeds` are token-styled layout markup. The candidates table deliberately has
> **no score column / no score-bar** — `.score-mini` / `.score-panel` CSS is dead and must not
> reappear (the classic regression).

---

## Content & Membership

- One Recon category (no sub-types); topics are **tags under Recon**, not separate content types
  (AI, Framework Evaluations, Architecture Reviews, Technical Researches, Developer Tools).
- Pillar `.org`; decision callout `.com`/forward. Links upstream to its Use Case Study (VD-03)
  and downstream to the Demo it feeds (VD-05).
- Public, ungated. **No numeric ratings — verdicts are chosen/rejected/weak/fair in prose.**

## Responsive

- `≤1080px`: table scrolls horizontally within its container; header callouts stack.

## Accessibility

- Single `<h1>`. Table has `<thead>` + scope; the `✓ chosen` state is reinforced by text, not
  colour alone. Callouts are not the only carrier of the decision (also in prose).

## Acceptance Criteria

- [ ] AC-VD04-01: Comparison renders as a qualitative `tk-table` with **no score column and no score bars**.
- [ ] AC-VD04-02: A visible no-scores guardrail callout is present.
- [ ] AC-VD04-03: A decision callout links forward ("feeds the demo") in the destination pillar colour.
- [ ] AC-VD04-04: Links upstream to the related Use Case Study and downstream to the Demo.
- [ ] AC-VD04-05: Topics render as tags under the single Recon category (not separate types).
- [ ] AC-VD04-06: No `.score-mini`/`.score-panel`/`x.x/10` artifacts; AA in ink + paper.

## Out of Scope

- Separate Evaluation/Rating templates (folded into Recon, v0.5.0 — do not recreate).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Content model | `recon-content-model.md` (root) | Recon decision + no-scores rationale |
| Spec | VD-03 (upstream), VD-05 (downstream) | Flywheel neighbours |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
