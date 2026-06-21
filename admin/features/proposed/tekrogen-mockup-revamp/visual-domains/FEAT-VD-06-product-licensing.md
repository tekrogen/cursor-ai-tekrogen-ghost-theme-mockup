# FEAT-VD-06: Product & Licensing

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0006 (trust-state CTA), ADR-0011 (component model)
**Related screen:** Claude-DT **s6**
**Ghost template:** `custom-product.hbs` · **route:** `/products/{slug}/` · **context:** post · **visibility:** public page, **downloads gated to paid** · **pillar:** `.com`
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The commerce surface — a production template productized from a demo, with the **license matrix
as the centerpiece**. Carries the flywheel stepper (you are at 05–06: Product/License), a product
hero with pricing, a four-tier license grid (MIT free + Standard/Extended/Team), a feature grid,
a tech-stack + checkout-flow aside, and the full pillar trail back to study/demo/docs.

---

## Problem Statement

An operator/buyer evaluating a template needs pricing, license clarity (which tier fits the
deployment), proof of provenance (built from a real study + public demo), and a clear checkout
path — while the system stays honest that Ghost itself doesn't sell one-time licenses.

### Current State

Claude-DT s6 renders `tk-flywheel-stepper` (05–06 "here"), `tk-product-hero` (badge/title/lead/
price/summary + visual), a 4-card `tk-license-grid` (featured "Standard" with ribbon), a
`tk-feature-grid`, a tech-block aside (stack + numbered checkout flow), and a pillar-trail card row.

### Desired State

A locked `custom-product.hbs` where the license matrix and gating are explicit, checkout is shown
as a **LemonSqueezy/Stripe integration seam**, and paid-member download gating is native Ghost.

---

## Ghost Mapping

Per-post custom template. **Template-hierarchy justification:** the product hero + license matrix
+ checkout aside is a commerce layout `post.hbs` can't express. **Membership/commerce reality
(Ghost expert — explain trade-offs):** Ghost native memberships are *subscriptions*, not a
one-time digital-product store. The license tiers are **one-time purchases**, so checkout routes
to **LemonSqueezy/Stripe** (license key + download delivered to email + portal). The theme renders
the matrix and a labelled checkout seam; **paid-member-only artifacts** still gate natively via
`{{#if @member.paid}}`. This split is a documented architecture boundary, not a Ghost feature.

---

## Layout Anatomy (keyed to s6)

1. **Masthead** — util shows **Account** + **Cart · 0** (commerce chrome).
2. **Flywheel stepper** — `tk-flywheel-stepper`; 01–04 `done`, 05–06 `here` (`.com`), 07–08 upcoming.
3. **Product hero** — `tk-product-hero`: `body` (badge `.com · product`, `h1`, `.lead`, `price`
   slot "from $129 · one-time · per developer", `summary` bullets) + `visual` slot (version badge,
   latest-release date).
4. **License matrix (centerpiece)** — `tk-section-head` + `tk-license-grid` of 4
   `tk-license-tier`:
   - MIT · free ($0) — demo source; excluded: production support, commercial deployment.
   - **Standard ($129/dev)** `data-variant="featured"` + `ribbon` "Recommended" — CTA
     `data-variant="buy"`.
   - Extended ($429/dev) — sub-license rights.
   - Team ($1,490) — up to 10 devs.
   - Each: slots `name`/`price`/`desc`/`features` (ul; `li[data-state="excluded"]` flips ✓→✗)/`cta`.
5. **Features + aside** — `tk-feature-grid` (6 `tk-feature`: name/desc) beside a `tech-block`
   aside: stack `tk-label[data-variant="tag"]` + numbered **checkout flow** (01 pick tier → 02
   LemonSqueezy panel → 03 key + link by email/dashboard → 04 updates ship to .net).
6. **Pillar trail** — `tk-section-head` + 3 `tk-content-card` (org study / studio demo / net docs)
   — "where this came from."
7. **Footer** — VD-00 F2.

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-flywheel-stepper` | `data-pillar`, `data-state="done\|here"`; slots `num`/`name` | Position |
| `tk-product-hero` | slots `body`/`price`/`summary`/`visual` | Hero |
| `tk-license-grid` / `tk-license-tier` | `data-variant="featured"`; slots `name`/`price`/`desc`/`features`/`cta`/`ribbon`; `li[data-state="excluded"]` | License matrix |
| `tk-feature-grid` / `tk-feature` | slots `name`/`desc` | What you get |
| `tk-label` | `data-variant="tag"` | Stack chips |
| `tk-content-card` | `data-pillar` | Pillar-trail cards |
| `tk-badge`, `tk-button` | `data-pillar="com"`, `data-variant="buy"` | Id + buy actions |

---

## Content & Membership (the second gate)

| State | Sees | Can do |
|---|---|---|
| Anonymous / free | Full product page, pricing, license matrix | Read; start checkout (external) |
| Paid member | Same + member download links | Download release + source via `{{#if @member.paid}}` |

- Pillar `.com` dominant. License tiers: **MIT (free) · Standard · Extended · Team**. Featured =
  Standard. Buy CTAs route to the external checkout seam.
- Provenance is mandatory: link back to the origin study (.org), demo (.studio), docs (.net).

## Responsive

- `≤1080px`: hero → 1 col; license-grid → 2 col; feature-grid → 2 col; → 1 col at ≤640px.

## Accessibility

- Single `<h1>`. License tiers are `<article>`s; excluded features convey state in text/icon, not
  colour alone. The featured ribbon is decorative — tier remains distinguishable without it. Price
  is real text, not an image.

## Acceptance Criteria

- [ ] AC-VD06-01: License matrix renders four tiers (MIT free + Standard/Extended/Team) with Standard featured + ribbon.
- [ ] AC-VD06-02: Excluded features flip ✓→✗ via `li[data-state="excluded"]`.
- [ ] AC-VD06-03: Stepper shows 05–06 "here" in `.com`.
- [ ] AC-VD06-04: Checkout is shown as a labelled LemonSqueezy/Stripe seam; paid downloads gate on `@member.paid`.
- [ ] AC-VD06-05: Provenance trail links the origin study, demo, and docs (destination-coloured).
- [ ] AC-VD06-06: `.com` dominant; no scores; AA in ink + paper at all breakpoints.

## Out of Scope

- Real checkout/payment, cart, license-key generation (placeholders + integration seam only).
- Refund/chargeback/access-revocation flows (INDEX critical gap; future).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Index | [`_planning-specs/INDEX.md`](../_planning-specs/INDEX.md) §5.3, §7 | L3/L4 + commerce gaps |
| Spec | VD-05 (demo), VD-07 (docs/delivery), VD-09 (purchase confirmation) | Flywheel + checkout |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
