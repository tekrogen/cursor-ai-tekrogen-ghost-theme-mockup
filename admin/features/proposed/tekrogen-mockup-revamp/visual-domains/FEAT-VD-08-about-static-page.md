# FEAT-VD-08: About / Static Page

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0001 (typography), ADR-0011 (component model)
**Related screen:** Claude-DT **s8**
**Ghost template:** `page.hbs` · **route:** `/about/` · **context:** page · **visibility:** public · **pillar:** `.org` (neutral)
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The narrative spine — who Tekrogen is and why the four-pillar system exists. The reference
implementation for any **static Ghost page** (`page.hbs`): a prose hero, the four-pillar
manifesto, the working principles (incl. "no scores"), and the team. Establishes the editorial
voice the rest of the site inherits.

---

## Problem Statement

Visitors need a plain-language explanation of the flywheel philosophy ("build it, prove it, write
down what we learned") and the four pillars, plus enough team credibility to trust the studies —
on a simple, durable page editors can maintain in Koenig.

### Current State

Claude-DT s8 renders an `.eyebrow` + `display` hero + `.lead`, a four-card `manifesto`
(`tk-manifesto-card` per pillar), a two-column `principles` list, and a `team` grid
(`tk-team-card` + `tk-avatar`).

### Desired State

A locked `page.hbs` whose chrome is template-supplied and whose body is portable page content,
reusable for other static pages (Contact, Terms, Privacy).

---

## Ghost Mapping

Ghost renders pages with `page.hbs` (falls back to `post.hbs`). **Template-hierarchy
justification:** About is genuinely a page, so `page.hbs` is the correct native construct — **no
custom template needed**. The manifesto/principles/team blocks can be Koenig content or, for
fixed brand structure, template partials. Contact (INDEX nav) is a sibling page reusing this
shell with a form (see VD-09 request form).

---

## Layout Anatomy (keyed to s8)

1. **Masthead** — `aria-current` on About.
2. **Prose hero** — `.eyebrow` "about · tekrogen" → `h1.display` "Four wings, one pursuit." →
   `.lead` mission statement ("Build it, prove it, write down what we learned. … published
   because it works.").
3. **Four pillars (manifesto)** — eyebrow/`h2` "The four pillars" + `manifesto` grid of 4
   `tk-manifesto-card[data-pillar]`: `label` (.org/.studio/.com/.net), `h4` (Knowledge /
   Demonstration / Commerce / Distribution), one-line purpose.
4. **Principles** — eyebrow/`h2` + `principles` grid (numbered `principle` items): Honest
   trade-offs · Real use cases only · **No scores** (Recon is qualitative) · Data minimization.
5. **Team** — eyebrow/`h2` + `team` grid of `tk-team-card` (`tk-avatar[data-style="mono"]` +
   name + `role` slot + bio); includes a "Joining soon" placeholder card.
6. **Footer** — VD-00 F2.

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-manifesto-card` | `data-pillar`; slot `label` | Four-pillar statement cards |
| `tk-team-card` | default; slot `role` | Team member |
| `tk-avatar` | `data-style="mono"` | Initials on pillar gradient |

> `manifesto`, `principles`, `team`, `.principle` grids are token-styled layout. The hero
> `.eyebrow`/`.display`/`.lead` are foundation type classes, not components.

---

## Content & Membership

- Neutral/`.org`-leaning; the manifesto cards each carry their own `data-pillar` (this is the one
  place all four colours appear together by design — the system explained).
- The "No scores" principle restates the brand rule as narrative (reinforces VD-04).
- Public, ungated, no commerce.

## Responsive

- `≤1080px`: manifesto → 2 col; principles/team → 1 col. → manifesto 1 col at ≤640px.

## Accessibility

- Single `<h1>` (hero). Section `<h2>`s in order. Avatar initials are decorative; team name is
  real text. Pillar colour on manifesto cards is reinforced by the `.org`/`.studio`/etc. label.

## Acceptance Criteria

- [ ] AC-VD08-01: Maps to native `page.hbs` (no custom template) and reads as portable page content.
- [ ] AC-VD08-02: Four-pillar manifesto shows all four pillars, each `data-pillar`-keyed with its purpose.
- [ ] AC-VD08-03: Principles include the "No scores" rule.
- [ ] AC-VD08-04: Team grid uses `tk-team-card` + `tk-avatar`; supports a placeholder member.
- [ ] AC-VD08-05: Shell is reusable for Contact/Terms/Privacy; AA in ink + paper.

## Out of Scope

- Contact form (reuse the VD-09 request form on a Contact page).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Spec | VD-00 | Voice + chrome |
| Spec | VD-04 | "No scores" rule origin |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
