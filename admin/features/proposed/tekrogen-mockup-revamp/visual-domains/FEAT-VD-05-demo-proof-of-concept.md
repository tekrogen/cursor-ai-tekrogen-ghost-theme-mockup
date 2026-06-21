# FEAT-VD-05: Demo / Proof of Concept

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0006 (trust-state CTA), ADR-0011 (component model)
**Related screen:** Claude-DT **s5**
**Ghost template:** `custom-proof-of-concept.hbs` · **route:** `/poc/{slug}/` · **context:** post · **visibility:** public, **download gated to free members** · **pillar:** `.studio`
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The proof layer — a working demo that shows the case study is real, and the **first membership
gate** in the flywheel. Anyone can read and run the demo; **downloading the starter requires a
free account** (INDEX L2/L4). This is where anonymous → free conversion happens.

---

## Problem Statement

A visitor who read the study (or arrived cold) needs to *see it work*, understand the stack, and
be offered the artifact — with a clear, honest gate that asks only for a free sign-up.

### Current State

Claude-DT s5 renders a live/version status row, a launch CTA, a `tk-demo-meta` strip, a
`tk-demo-preview` (iframe placeholder), `tk-demo-shots` (3-up), stack tags, technical notes, and
a full-width `tk-artifact-list[data-pillar="studio"]` with a registration `gate` over download
rows, closing on a `.studio` paired-CTA.

### Desired State

A locked `custom-proof-of-concept.hbs` where the artifact list is gated with native Ghost
membership (`{{#unless @member}}` shows the gate; members see live download links).

---

## Ghost Mapping

Per-post custom template. **Template-hierarchy justification:** the demo scaffold (preview embed,
meta strip, shots, gated artifact list) isn't a `post.hbs` shape. Gating is **native** —
`{{#unless @member}}`…gate…`{{else}}`…download rows…`{{/unless}}` (no third-party membership;
Ghost expert: prefer native memberships/Portal). Demo bodies remain `{{content}}`.
**Per-post download visibility:** free-tier artifacts gate on `@member` (any signed-in member);
paid artifacts (rare here) would gate on `@member.paid`.

---

## Layout Anatomy (keyed to s5)

1. **Masthead** — `aria-current` on Demos; util may show Sign in.
2. **Hero row** — badge (`.studio · demo`) + status `tk-label` (● Live, border `--tk-net`) +
   version label → `h1` → `.lead.italic-dek` ("Read it freely; downloading the starter needs a
   free account.") → `.demo-cta`: primary `data-pillar="studio"` *Launch full demo* + secondary
   *Read the Case Study*.
3. **Demo meta** — `tk-demo-meta`: Status / Version / Default license (MIT) / Time to try
   (key/val slots).
4. **Live preview** — `tk-demo-preview` (the `<iframe>` embed placeholder).
5. **Screenshots** — `tk-demo-shots` (3 `tk-demo-shot`).
6. **Stack** — `h2` + `tk-label[data-variant="tag"]` row.
7. **Technical notes** — `h2` + prose (demo-grade path; hardened build ships in the template).
8. **Artifact downloads (gated)** — `tk-artifact-list[data-pillar="studio"]`:
   - `data-tk-slot="gate"`: lock line ("⊘ Registration required · free tier"), headline,
     description, actions (*Create free account* + *Sign in*).
   - `data-tk-slot="row"` ×N: filename · size · "Sign in to download" (becomes a live link for
     members).
9. **Paired CTA** — `tk-cta-block[data-pillar="studio"]`: "This demo came from a study — and
   becomes a product." → secondary *Read the Case Study* (↗ org) + `data-pillar="com"`
   *View Product* (↗ com).
10. **Footer** — VD-00 F2.

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-demo-meta` | slots `key`/`val`, `data-mono` | Status/version/license/time strip |
| `tk-demo-preview` | default | Live embed placeholder |
| `tk-demo-shots` / `tk-demo-shot` | default | Screenshot trio |
| `tk-artifact-list` | `data-pillar`; slots `gate`/`row` | Gated downloads |
| `tk-label` | `data-variant="tag"`; status border | Stack tags + live status |
| `tk-cta-block` | `data-pillar="studio"`; slot `actions` | Cross-pillar next step |
| `tk-badge`, `tk-button` | `data-pillar`, `data-style="cta"` | Id + actions |

---

## Content & Membership (the gate)

| State | Sees | Can download |
|---|---|---|
| Anonymous | Full read + live demo + screenshots + stack | ✗ — sees the gate |
| Free member | Same + unlocked rows | ✓ MIT demo source, dataset, diagram |
| Paid member | Same | ✓ (plus paid artifacts where present) |

- Pillar `.studio`; forward CTA to `.com` product, back-link to `.org` study.
- Gate copy must be honest: free account, no card. Default license is **MIT** (demo source).

## Responsive

- `≤1080px`: demo-meta → 2 col; shots → 1 col at ≤640px; hero CTAs wrap.

## Accessibility

- Single `<h1>`. Gate is real interactive controls (buttons/links), not decorative. Locked rows
  communicate state in text ("Sign in to download"), not colour alone. Live `<iframe>` (real
  theme) needs a `title`.

## Acceptance Criteria

- [ ] AC-VD05-01: Demo is fully readable/runnable anonymously; only downloads are gated.
- [ ] AC-VD05-02: Gate maps to native `{{#unless @member}}` … `{{/unless}}`; members see live links.
- [ ] AC-VD05-03: Default artifact license shown as MIT (free tier).
- [ ] AC-VD05-04: Paired CTA links back to the study (.org) and forward to the product (.com), destination-coloured.
- [ ] AC-VD05-05: `.studio` pillar dominant; AA in ink + paper at all breakpoints.

## Out of Scope

- Real auth / file delivery (placeholders).
- Comment/feedback capture for POC→Product conversion (INDEX L7 gap; future).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Index | [`_planning-specs/INDEX.md`](../_planning-specs/INDEX.md) §5.3 | L2/L4 gating |
| Spec | VD-03 (origin study), VD-06 (product), VD-09 (membership) | Flywheel + gate |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
