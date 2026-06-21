# FEAT-VD-09: Membership & Account

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0011 (component model)
**Related screen:** Claude-DT **s9**
**Ghost template:** Ghost **Portal** + members context · `account.hbs` / gated partials · **routes:** `/account`, `/portal`, `/forms` · **visibility:** mixed (anonymous → free → paid) · **pillar:** `.com` / `.net`
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The access layer — the one surface that shows all **three membership states on one screen**
(anonymous → free → paid, INDEX L4) and every account flow: sign in, register, member dashboard,
purchase confirmation, and the fallback request form (L5). This is the conversion machinery:
free sign-up + paid upgrade, native Ghost members, with external checkout for one-time licenses.

---

## Problem Statement

The system needs to make access tiers legible (what each state unlocks), provide native auth and
a member dashboard for orders/downloads/keys, confirm purchases, and offer a fallback intake for
non-default requests — without a bespoke membership system.

### Current State

Claude-DT s9 renders a `tk-member-ladder` (3 states), `tk-auth-card` ×2 (sign in / register), a
`tk-dashboard` (avatar + nav + orders `tk-table`), a `tk-confirm` (purchase confirmation with
license key), and a `reqform` (request fallback) — each annotated with the Ghost helper it maps to.

### Desired State

A locked membership surface where auth/dashboard are **native Ghost Portal + members context**,
gating uses `{{#if @member}}` / `{{#if @member.paid}}`, and checkout/confirmation is the external
seam. Free members see a slimmed dashboard; paid see the full portal.

---

## Ghost Mapping

**Native-first (Ghost expert: prefer native memberships/Portal/tiers):**

| Sub-surface | Ghost construct |
|---|---|
| Sign in / Register | **Ghost Portal** (modal) + magic-link; theme `tk-auth-card` mirrors it for mockup |
| Member dashboard | members context on `account.hbs`; `{{#if @member}}` shell, data via Members/Content API |
| Free vs paid view | `{{#if @member.paid}}` (full) `{{else}}` slimmed (favorites + requests) |
| Purchase confirmation | post-checkout return from LemonSqueezy/Stripe (external) |
| Request form | L5 fallback (Formspree/Tally) — **not** the conversion path |

**Template-hierarchy justification:** Portal handles auth natively (no custom login template
needed); a custom `account.hbs` is justified for the dashboard shell. The five sub-screens are one
mockup screen but distinct surfaces in the theme.

---

## Layout Anatomy (keyed to s9)

1. **Masthead** — `aria-current` on Account.
2. **Access ladder** — intro + `tk-member-ladder` of 3 `data-tk-slot="step"`:
   - `.studio` — **anonymous · guest**: read everything; excluded: downloads.
   - `.net` — **free member**: MIT demo source, datasets, saves, submit request; excluded: paid downloads.
   - `.com` — **paid member · subscription**: product downloads + source, license keys, portal,
     updates. Each `step` has `state` + `features` (ul; `li[data-state="excluded"]` flips ✓→✕).
3. **Sign in / Register** — `acct-grid` of 2 `tk-auth-card`: each `head` (label + `state-pill`),
   `h3`, sub, a `tk-form` of `tk-field`/`tk-input`, a `tk-button[data-block]` CTA, and a
   `ghost-note` showing the mapped helper (`ghost portal · members`, `ghost · {{#if @member}}`).
4. **Member dashboard** — `tk-dashboard`: `head` (`tk-avatar` + name + role + "Account settings"),
   `body` (`nav` slot: Overview/Orders/Downloads/License keys/Saved/Requests/Update windows/
   Billing + counts; `main` slot: recent-orders `tk-table` with download links). Note: free members
   see a slimmed view (`{{#if @member.paid}}`).
5. **Purchase confirmation** — `tk-confirm[data-pillar="com"]`: "● payment complete", product +
   tier, order/tier/window grid, **license `keyline`** (copyable key), actions (*Download* + *Open
   customer portal* in `.net`), receipt fineprint.
6. **Request form (L5 fallback)** — `reqform` / `tk-form`: name, work email, topic, "what are you
   building?" textarea, send CTA; `ghost-note` "formspree / tally fallback · not the conversion path".
   Fields per build brief: Problem/Industry/Priority/Budget/Contact.
7. **Footer** — VD-00 F2.

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-member-ladder` | `data-pillar` per step; slots `step`/`state`/`features`; `li[data-state="excluded"]` | Three access states |
| `tk-auth-card` | slot `head` | Sign in / register |
| `tk-form` / `tk-field` / `tk-input` | full-width fill; `tk-field-row` for pairs | Forms |
| `tk-dashboard` | slots `head`/`body`/`nav`/`main` | Member portal shell |
| `tk-table` | order rows + download links | Order history |
| `tk-confirm` | `data-pillar="com"` | Purchase confirmation |
| `tk-avatar` | `data-style="mono"` | Member identity |
| `tk-button` | `data-style="cta"`, `data-block`, `data-pillar` | Actions |

---

## Content & Membership (the model, explicit)

| State | Read | Free downloads (MIT) | Paid downloads + keys + portal |
|---|---|---|---|
| Anonymous | ✓ | ✗ | ✗ |
| Free member | ✓ | ✓ | ✗ |
| Paid member | ✓ | ✓ | ✓ |

- Conversion path = **free sign-up → paid upgrade** (native). Forms are fallback only.
- License key + downloads also live in the dashboard and the .net customer portal (VD-07).
- Data minimization (per About principle): collect only what's needed to deliver a license.

## Responsive

- `≤1080px`: member-ladder, acct-grid, conf-grid → 1 col; dashboard nav stacks above main.

## Accessibility

- Each form field has an associated `<label>` (s9 uses `<label for>` + `tk-input`); native input
  types (`email`, `password`, `search`). Visible focus on all controls. State pills convey tier in
  text. The copyable license `keyline` exposes a real control with accessible name. Single `<h1>`
  per actual rendered surface (the mockup stacks five for review).

## Acceptance Criteria

- [ ] AC-VD09-01: Access ladder shows all three states with included/excluded features (text + ✓/✕).
- [ ] AC-VD09-02: Auth uses native Ghost Portal/members; sub-screens annotate their helper mapping.
- [ ] AC-VD09-03: Dashboard differentiates free (slimmed) vs paid (full) via `{{#if @member.paid}}`.
- [ ] AC-VD09-04: Purchase confirmation shows tier, order, update window, and a copyable license key.
- [ ] AC-VD09-05: Request form is presented as L5 fallback, not the conversion path.
- [ ] AC-VD09-06: All form fields labelled; native input types; AA + visible focus in ink + paper.

## Out of Scope

- Real auth, Stripe/LemonSqueezy wiring, key generation/validation, refund/revocation (placeholders;
  INDEX critical gaps). Billing management UI beyond the nav entry.

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Index | [`_planning-specs/INDEX.md`](../_planning-specs/INDEX.md) §5.3 (L4/L5), §7 | Membership layers + gaps |
| Spec | VD-05 (free gate), VD-06 (paid gate), VD-07 (portal) | Where gating is applied |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
