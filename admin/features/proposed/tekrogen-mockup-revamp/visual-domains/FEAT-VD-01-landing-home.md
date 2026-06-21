# FEAT-VD-01: Landing / Home

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0006 (trust-state CTA), ADR-0011 (component model)
**Related screen:** Claude-DT **s1**
**Ghost template:** `home.hbs` · **route:** `/` · **context:** `@site` + curated loops · **visibility:** public
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The front door. Its job (per `mockups/README.md`) is to make the **whole four-pillar flywheel
legible at a glance** and route the visitor to the next logical step — not to be a blog index.
It establishes credibility (.org studies), shows proof exists (.studio demos), and previews the
commercial path (.com products, .net docs).

---

## Problem Statement

A first-time visitor must understand, above the fold, that Tekrogen is *Use Case → Recon → Demo
→ Product → Docs* — one system, four pillars — and find an obvious primary action.

### Current State

Claude-DT s1 renders pillar-buttons, a hero with the flywheel SVG + stat strip, and a featured
case-study grid. It is the most registry-dense screen.

### Desired State

A locked `home.hbs` composition where each section is a curated Ghost loop or a static partial,
the flywheel is the hero centerpiece, and the primary CTA ("Explore Case Studies") is the single
cyan action on the surface.

---

## Ghost Mapping

`home.hbs` is Ghost's front-page template (falls back to `index.hbs`). Featured rows are
`{{#get "posts" filter="tag:hash-feature-use-case-study" limit="3"}}…{{/get}}` blocks — curated,
not the default chronological feed. **Template-hierarchy justification:** the home page is a
composed marketing surface, not a post list, so a bespoke `home.hbs` (a standard Ghost file) is
correct; no custom template needed beyond it.

---

## Layout Anatomy (top → bottom, keyed to s1)

1. **Masthead** — VD-00 F1, `aria-current` on Home.
2. **Pillar buttons** — `nav.pillar-buttons` of four `tk-pillar-button[data-pillar]`, slots
   `label` (.org), `name` (Case studies & recon), `count` (24 studies · 52 recon). Browse-by-pillar.
3. **Hero** — two-column:
   - Copy: `.eyebrow` (mono) → `h1.display` "We build real solutions to real problems." →
     `.lead` subhead → `.hero-cta` (primary `tk-button[data-style="cta"]` *Explore Case Studies*
     + secondary *View Demos*) → `tk-stats` strip (4× `tk-stat`: value/label).
   - Visual: `tk-flywheel` (VD-00 F3) — the four-pillar wheel.
4. **Featured case studies** — `tk-section-head` (eyebrow + title + "All studies" CTA) over a
   3-up grid of `tk-content-card[data-pillar="org"]`; each: `head` slot (`tk-badge` + `.meta`
   industry) → `h3` problem headline → `desc` slot → `rel` slot of `tk-label[data-variant="chip"]`
   chips (recon/demo/product) showing the flywheel relationships.
5. *(Build-brief sections folded into the above per the five-category model — Recon hub, demo
   showcase, product preview, docs hub each surface as a curated row reusing the same card
   pattern with the matching `data-pillar`.)* See **Out of Scope** for which are required vs optional.
6. **Footer** — VD-00 F2.

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-pillar-button` | `data-pillar`; slots `label`/`name`/`count` | Browse-by-pillar nav |
| `tk-flywheel` | `data-arc`, `data-node data-pillar`, slot `core` | Hero centerpiece |
| `tk-stats` / `tk-stat` | slots `value`/`label` | Credibility metrics |
| `tk-section-head` | slots `eyebrow`/`title`; CTA | Row headers |
| `tk-content-card` | `data-pillar`; slots `head`/`desc`/`rel` | Featured cards |
| `tk-badge`, `tk-label` | `data-pillar`, `data-variant="chip"` | Pillar id + relationship chips |
| `tk-button` | `data-style="cta"`, `data-variant="secondary"` | Hero CTAs |

---

## Content & Membership

- **Five-category model** drives every row; counts ("24 studies · 52 recon") must stay in sync
  with the listing pages — a stale count is the classic regression. **No scores anywhere.**
- Public surface. No gating on the home page; gating begins at download (VD-05/06).

## Responsive

- `≤1080px`: hero → 1 col; cards → 2 col; pillar-buttons → 2 col; site nav collapses.
- `≤640px`: cards/pillar-buttons → 1 col.

## Accessibility

- Single `<h1>` (hero headline). Flywheel is `role="img"` with an `aria-label`; node text is
  decorative (`aria-hidden`). Primary CTA is the only `--tk-cyan` action (one cyan per surface).

## Acceptance Criteria

- [ ] AC-VD01-01: Above the fold communicates the four-pillar flywheel (pillar-buttons + hero flywheel) without scrolling on desktop.
- [ ] AC-VD01-02: Exactly one primary cyan CTA; secondary actions use `data-variant="secondary"`.
- [ ] AC-VD01-03: Featured cards show flywheel relationships via `rel` chips (recon/demo/product).
- [ ] AC-VD01-04: Stat/category counts match the corresponding listing pages (no drift).
- [ ] AC-VD01-05: No numeric ratings/scores present anywhere on the page.
- [ ] AC-VD01-06: Renders in ink + paper at all three breakpoints with AA contrast.

## Out of Scope

- **Required rows:** hero + flywheel, pillar buttons, featured case studies.
- **Optional rows** (reuse card pattern, defer if needed): recon hub, demo showcase, product
  preview, docs hub, standalone flywheel section.
- Live data wiring (mock counts in the mockup).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Brief | `mockups/README.md` (Home Page) | Section requirements |
| Spec | VD-00 | Chrome + flywheel |
| Spec | VD-02 | Where "Explore Case Studies" leads |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
