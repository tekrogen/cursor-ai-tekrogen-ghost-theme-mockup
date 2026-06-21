# FEAT-VD-02: Case-Study Channel (Listing)

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0011 (component model)
**Related screen:** Claude-DT **s2**
**Ghost template:** `channel-use-case-studies.hbs` · **route:** `/use-case-studies/` (collection) · **context:** collection loop · **visibility:** public · **pillar:** `.org`
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The index of the .org credibility layer — every use-case study, listed honestly. A pattern
template: the same anatomy (classbar + section-head + listing grid) is reused for the other
category channels (Recon, Demos, Products) by swapping the pillar and tag filter.

---

## Problem Statement

Visitors arriving from "Explore Case Studies" (VD-01) need a scannable index that signals
pillar, count, and the flywheel relationships each study spawns — without scores.

### Current State

Claude-DT s2 renders a `.classbar` (count + pillar + sort) over a 2-up grid of
`tk-listing-card[data-pillar="org"]`, each exposing related Recon/Demo/Product links.

### Desired State

A locked collection template that maps to a Ghost `routes.yaml` collection, paginates natively,
and is reused (by parameter) for all five category channels.

---

## Ghost Mapping

Defined as a **collection** in `routes.yaml` (not a hardcoded list — Ghost expert: prefer
collection architecture):

```yaml
collections:
  /use-case-studies/:
    permalink: /articles/{slug}/
    filter: tag:hash-feature-use-case-study
    template: channel-use-case-studies
```

Body is `{{#foreach posts}}…{{/foreach}}` over the collection; pagination via `{{pagination}}`.
**Template-hierarchy justification:** a channel/collection index is a native Ghost construct; a
custom `channel-*.hbs` is justified because the listing-card layout and classbar differ from the
default `index.hbs` feed. The same template shape parameterizes to `channel-recon`,
`channel-pocs`, `channel-products`, `channel-documentation`.

---

## Layout Anatomy (keyed to s2)

1. **Masthead** — `aria-current` on Case Studies.
2. **Classbar** — `.classbar.var-org`: "Case Studies **24**" · "**.org** · knowledge base" ·
   "Newest first". Mono caps; count `<b>` keyed to pillar. (Maps to a sort/filter row.)
3. **Section head** — `tk-section-head`: eyebrow ".org · use case studies" + title "Every build,
   documented honestly."
4. **Listing grid** — 2-up `tk-listing-card[data-pillar="org"]`; each: `ind` slot (industry ·
   domain) → `h3` headline → `desc` slot → `rel` slot of relationship rows (Recon / Demo /
   Product → linked title). The `rel` rows are the flywheel made visible per card.
5. **Pagination** — native `{{pagination}}` (older/newer).
6. **Footer** — VD-00 F2.

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-section-head` | slots `eyebrow`/`title` | Channel header |
| `tk-listing-card` | `data-pillar`; slots `ind`/`desc`/`rel` | Dense, text-first index row |
| (classbar) | `.var-org` sets `--pillar` | Count + pillar + sort strip |

> The classbar is harness/layout markup (mono caps strip), not a registry component; keep it
> minimal and token-styled. If it recurs across all five channels, propose a `tk-channel-bar`
> upstream in the DS rather than authoring it here (Rule #2 / #3).

---

## Content & Membership

- Pillar-locked to `.org` (org colour dominant). Cross-pillar links inside `rel` carry the
  **destination** colour (a Demo link is `.studio`, a Product link is `.com`).
- Count in the classbar must equal the actual study count and the home-page stat (no drift).
- Public. No gating. **No scores.**

## Responsive

- `≤1080px`: listing → 1 col. Classbar wraps.

## Accessibility

- Single `<h1>` = section-head title (the channel name); card headlines are `<h3>`. Each card is
  an `<article>`; `rel` links have discernible text (not "read more").

## Acceptance Criteria

- [ ] AC-VD02-01: Listing maps to a `routes.yaml` collection filtered by the use-case-study tag.
- [ ] AC-VD02-02: Each card exposes its flywheel relationships (Recon/Demo/Product) with destination-coloured links.
- [ ] AC-VD02-03: Classbar count matches the real post count and the home-page stat.
- [ ] AC-VD02-04: Template shape is reusable for recon/pocs/products/documentation channels by swapping pillar + filter.
- [ ] AC-VD02-05: No scores; pillar colour dominant; AA in ink + paper.

## Out of Scope

- Faceted filtering / search (native pagination only in the mockup).
- The other four channel renders (this is the reference pattern; Recon/Docs detailed in VD-04/07).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Index | [`_planning-specs/INDEX.md`](../_planning-specs/INDEX.md) §5.1 | Pillar → Ghost construct table |
| Spec | VD-03 | The reader each card opens |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
