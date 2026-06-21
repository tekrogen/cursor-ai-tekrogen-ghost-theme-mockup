# FEAT-VD-03: Use Case Study Reader

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0006 (trust-state CTA), ADR-0007 (fluid type), ADR-0011 (component model)
**Related screen:** Claude-DT **s3**
**Ghost template:** `custom-use-case-study.hbs` · **route:** `/articles/{slug}/` · **context:** post · **visibility:** public · **pillar:** `.org`
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The flagship reader and the credibility engine of the whole system. A full-width long-form
template carrying the **fixed 8-section BNR §5.2 format** (Problem → Acceptance Criteria → Stack
Decision → Trade-offs → Build → What We'd Do Differently → Outcome → CTA) with a sticky TOC rail
and a cross-pillar "next step" CTA that pushes the reader toward the demo and the product.

---

## Problem Statement

Builders and technical decision-makers need a deep, honest, navigable read that earns trust and
then routes forward in the flywheel — structured so editors can author it consistently.

### Current State

Claude-DT s3 renders a 236px sticky TOC + full-width body of eight `tk-section-head[data-size="sm"]`
sections, a trade-offs `tk-table`, an `ac-list`, and a `.com`-keyed `tk-cta-block` ("Run the
demo / Get the template").

### Desired State

A locked `custom-use-case-study.hbs` whose section order is fixed by the BNR format, whose prose
is Koenig-authored post content, and whose chrome (TOC, classbar, CTA) is template-supplied.

---

## Ghost Mapping

Ghost renders a post; the **custom template** is selected per-post (Ghost shows
`custom-use-case-study` in the editor's template dropdown when the file exists).
**Template-hierarchy justification (Ghost expert decision rule):** the default `post.hbs` cannot
encode the fixed 8-section scaffold, the sticky TOC, or the trade-offs table chrome — so a custom
template *is* justified, while the body itself stays portable `{{content}}`. The TOC anchors map
to the section headings; the related-content rail uses
`{{#get "posts" filter="tag:hash-pair-{topic}"}}` for paired Recon/Demo/Product.

---

## Layout Anatomy (keyed to s3)

1. **Masthead** — `aria-current` on Case Studies.
2. **Classbar** — Case Study №, ".org · use case study", status (Shipped), date.
3. **Two-column body** (`.ucs`, 236px + fluid):
   - **Sticky TOC rail** (`toc-rail` / `.toc`): numbered anchors 01–08 (Problem … Next), active
     item `.on` in `--wing-accent`; plus a reading-time `rt-card`.
   - **Article body** (`ucs-body`): `.eyebrow` → `h1` → `.lead.italic-dek` (the editorial dek,
     Poppins italic per ADR-0001) → tech-tag `tk-label` row → **8 sections**, each a
     `tk-section-head[data-size="sm"]` (eyebrow + meta number) over prose. Section 02 uses
     `ac-list` (✓ items); section 04 uses `tk-table` (We chose / We gave up).
4. **Trust-state CTA** — `tk-cta-block[data-pillar="com"]`: "Try it, then take the template."
   actions: secondary *Run the demo* (↗ studio) + `data-pillar="com"` *Get the template* (↗ com).
   This is the ADR-0006 paired CTA — destination-coloured.
5. **End matter** — `.stamp` ("End of file · C07") + `.endfile` colophon.
6. **Footer** — VD-00 F2.

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-section-head` | `data-size="sm"`; slots `eyebrow`/`meta` | The 8 section headers |
| `tk-table` | default | Trade-offs (chose / gave up) |
| `tk-label` | default | Tech stack tags |
| `tk-cta-block` | `data-pillar="com"`; slot `actions` | Cross-pillar next-step (trust-state) |
| `tk-button` | `data-style="cta"`, `data-variant="secondary"`, `data-pillar="com"`; slot `hint` | CTA actions |
| `tk-callout` | (optional) | Inline notes |

> `ac-list`, `toc`, `rt-card`, `stamp`, `endfile` are reader-layout markup (token-styled), not
> registry components. The TOC is a candidate for a `tk-toc` upstream if it recurs (VD-04).

---

## Content & Membership

- **Fixed section order** (BNR §5.2) — editors fill the eight sections; the template enforces the
  scaffold and numbering. Honest "What We'd Do Differently" is mandatory (trust).
- Pillar `.org`; the CTA block is `.com` (forward to product). Related rail surfaces the paired
  Recon (VD-04), Demo (VD-05), Product (VD-06).
- Public, ungated. **No scores** — the stack decision belongs to constraints, not a number.

## Responsive

- `≤1080px`: `.ucs` → 1 col; TOC rail becomes static (non-sticky), moves above body.

## Accessibility

- Single `<h1>` (study title). Section headings are real `<h2>`/`<h3>` in order (SEO + a11y). TOC
  is a `<nav>` with in-page anchors; active state not conveyed by colour alone. Reading width
  capped (~72ch) for legibility.

## Acceptance Criteria

- [ ] AC-VD03-01: Renders all 8 BNR §5.2 sections in fixed order with numbered section heads.
- [ ] AC-VD03-02: Sticky TOC tracks sections; collapses to static above the body at ≤1080px.
- [ ] AC-VD03-03: Trade-offs render as a two-column `tk-table` (chose / gave up).
- [ ] AC-VD03-04: Closing CTA is a `tk-cta-block` with destination-coloured (.com) primary action.
- [ ] AC-VD03-05: Related rail links the paired Recon, Demo, and Product.
- [ ] AC-VD03-06: No scores; one `<h1>`; AA contrast in ink + paper.

## Out of Scope

- Comments / lead-gen capture on the article (INDEX gap; future).
- The paired demo/product pages themselves (VD-05/06).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Index | [`_planning-specs/INDEX.md`](../_planning-specs/INDEX.md) §5.5 | BNR §5.2 article structure |
| Content model | `recon-content-model.md` (root) | Five-category / no-scores rule |
| Spec | VD-04, VD-05, VD-06 | The paired flywheel destinations |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
