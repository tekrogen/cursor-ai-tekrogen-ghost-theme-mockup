# FEAT-VD-00: Global Chrome & Design Foundations

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0001 (sans typography), ADR-0005 (icon system), ADR-0006 (trust-state CTA), ADR-0007 (fluid type), ADR-0008 (self-hosted fonts), ADR-0011 (component model), ADR-0012 (.hbs bridge)
**Related screens:** all (s1–s9) — the masthead, footer, flywheel, pillar system, surface theming
**Ghost template:** `default.hbs` + `partials/` (navigation, footer, flywheel, pillar-badge)

---

## Overview

The chrome and foundations every visual domain inherits: the sticky **site header**, the
four-pillar **footer**, the **flywheel** visualization + per-page **stepper**, the **pillar
colour system**, the **ink/paper** surface theming, and the typographic + accessibility
baseline. Locking these once keeps VD-01…VD-09 consistent and ports cleanly to Ghost's
`default.hbs` wrapper plus shared partials.

---

## Problem Statement

A nine-screen flywheel surface only reads as *one system* if the masthead, footer, accent
rule, and flywheel language are identical across every screen. Without a locked foundation,
each domain drifts (a classic regression: a stray pillar hex, a second cyan, an all-caps
wordmark). This spec freezes the shared shell.

### Current State

Claude-DT already renders the chrome consistently across s1–s9 (`tk-site-header[data-style="framed"]`,
`tk-footer[data-style="nav"]`, `tk-flywheel`, `tk-flywheel-stepper`) and links the vendored
registry. Harness chrome (shell-bar tabs, surface toggle, wing swatches) wraps the themed stage.

### Desired State

A documented, locked foundation: the exact header/footer slot structure, the flywheel + stepper
state model, the pillar→colour map, the surface-theming contract, and the AA baseline — each
mapped to a Ghost partial in `default.hbs`, so the theme build is a transcription, not a redesign.

---

## Ghost Mapping

| Concern | Ghost construct | Notes |
|---|---|---|
| Page wrapper | `default.hbs` | `{{ghost_head}}` / `{{ghost_foot}}`, `<html lang>`, links `colors_and_type.css` + `tk-components.css` |
| Primary nav | `{{navigation}}` in `partials/navigation.hbs` | editor-managed; current item via `{{#if current}}aria-current="page"` |
| Footer | `partials/footer.hbs` | four pillar columns + colophon |
| Pillar identity | `partials/pillar-badge.hbs` | `data-pillar` from post's primary tag |
| Flywheel / stepper | `partials/flywheel.hbs`, `partials/flywheel-stepper.hbs` | stepper `data-state` set by current pillar |

**Harness vs theme:** the shell-bar tablist, ink/paper toggle, and wing swatches are **review
harness only** — they do **not** port to `default.hbs`. The `<!-- APP CHROME -->` /
`<!-- GHOST THEME -->` comment banners mark the boundary.

---

## Core Features

### F1: Site header (masthead)

**Component:** `tk-site-header` `data-style="framed"`
**Slots:** `inner` › `brand` (mark + `wordmark`), `nav`, `util`.

- Brand: `assets/tekrogen-mark.svg` (18° tilt baked into SVG — never double-rotate) + mixed-case
  **Tekrogen** wordmark (Poppins 600). All-caps `TEKROGEN` is marketing-only.
- Primary nav (INDEX §1): Home · Case Studies · Recon · Demos · Products · Documentation · About.
- Utility slot: Search label + `tk-button[data-style="cta"][data-variant="secondary"]` (Sign in);
  commerce contexts swap to **Account** + **Cart** (s6), docs to **Customer portal** (s7).

**AC:**
- [ ] AC-VD00-01: Header renders identically across all nine domains; only `aria-current` and the util slot vary by context.
- [ ] AC-VD00-02: Wordmark is mixed-case Poppins 600; mark uses the single baked-in 18° tilt.

### F2: Footer

**Component:** `tk-footer` `data-style="nav"`
**Slots:** `top` › `brand` (mark + `wordmark` + `tagline`), `pillars` › four `col[data-pillar]`.

- Four columns: `.org` (Use Case Studies, Recon) · `.studio` (Demos) · `.com` (Products) ·
  `.net` (Documentation). Tagline: "Documenting the build — research, decisions, and the
  templates that come out the other side."

**AC:**
- [ ] AC-VD00-03: Footer carries all four pillars on every page, each column `data-pillar`-keyed.

### F3: Flywheel visualization + stepper

**Components:** `tk-flywheel` (hero, s1), `tk-flywheel-stepper` (per-page, s6/s7).

- **Hero flywheel** (`tk-flywheel`): 8-node SVG ring, `data-arc="org|studio|com|net"` arcs +
  `data-node data-pillar` nodes, `data-tk-slot="core"` center text ("build → prove → package").
  Node labels: 01 use case · 02 recon · 03 demo · 04 register · 05 product · 06 license ·
  07 download · 08 docs.
- **Stepper** (`tk-flywheel-stepper`): 8 `data-tk-slot="step"` items, each `data-pillar` +
  `data-state="done|here"` (omit for upcoming). Shows the visitor's position; "here" = current
  pillar. Renders on product (s6: 05–06 here) and docs (s7: 07–08 here).

**AC:**
- [ ] AC-VD00-04: Flywheel labels and order match the canonical loop (Use Case → … → Docs/Version).
- [ ] AC-VD00-05: Stepper `data-state="here"` corresponds to the page's flywheel stage on every domain that uses it.

### F4: Pillar colour system + `--wing-accent`

**Tokens:** `--tk-org #446e88` · `--tk-studio #6491ac` · `--tk-com #0db4b9` · `--tk-net #7edba5`;
accent `--tk-cyan #1fd5da`.

- One dominant pillar per content type via `data-pillar`. **Cross-pillar CTAs carry the
  destination's pillar colour** (forward motion). `--wing-accent` is the single editorial accent
  knob (default `var(--tk-cyan)`); the harness wing swatches override it on `documentElement`.
- One cyan per surface (ADR-0011). Never hardcode a pillar hex — use the token / `data-pillar`.

**AC:**
- [ ] AC-VD00-06: No raw pillar/cyan hex in domain markup; colour comes from tokens / `data-pillar` / `--wing-accent`.
- [ ] AC-VD00-07: A cross-pillar "next step" CTA uses the destination pillar's colour, not the source's.

### F5: Surface theming (ink / paper)

- `[data-tk-theme="ink"]` (default) and `[data-tk-theme="paper"]`, scoped to the themed stage.
  Paper overrides the fg/bg scale and remaps link/focus/accent to AA-safe dark teal (`#086a6f`).
- In Ghost this is a site-level/`default.hbs` theme choice, not a per-visitor toggle (the toggle
  is harness-only).

**AC:**
- [ ] AC-VD00-08: Every domain is legible in both ink and paper (AA contrast holds in both).

### F6: Typography, icons, spacing baseline

- Sans-only: `--tk-font-sans` (Poppins/Manrope), `--tk-font-mono` (JetBrains Mono) for eyebrows,
  meta, labels, technical chrome (ADR-0001). Fluid rem scale `--tk-fs-*` (ADR-0007). Self-hosted
  woff2, no CDN (ADR-0008).
- Icons: Lucide (1.5px stroke) in product UI; mono Unicode glyphs (`✓` etc.) on brand surfaces
  (ADR-0005). No `★ ✱ ▶`.
- Spacing: 4-pt grid `--tk-space-*`; radii `--tk-radius-*`; hairlines (`--tk-border-1`) over
  shadows; sanctioned `--tk-shadow-*` / `--tk-radius-*` only.

**AC:**
- [ ] AC-VD00-09: All type/space/radius/shadow values reference `--tk-*` tokens; no ad-hoc px on page text.

### F7: Accessibility baseline (applies to all domains)

- One `<h1>` per page; logical heading order; landmarks (`<header>/<nav>/<main>/<footer>`).
- Visible keyboard focus via `--tk-focus` (10.44:1 on ink). Touch targets ≥ 44px.
- Body/secondary text uses `--tk-fg-1/2/3` (AA); `--tk-fg-4/5` are **decorative only** (fail AA) —
  never load-bearing text.
- Form controls use native elements with associated `<label>` (see VD-09).

**AC:**
- [ ] AC-VD00-10: Each domain passes a heading-order + focus-visibility + AA-contrast check in ink and paper.

---

## Integration Points

- **Every VD spec (01–09)** imports this chrome; they specify only what changes inside `<main>`.
- **DS registry** — `tk-site-header`, `tk-footer`, `tk-flywheel`, `tk-flywheel-stepper`,
  `tk-badge`, `tk-label`, `tk-button` are vendored; consumed, not authored here.

## Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Stale pillar count / nav drift between domains | Med | Single source: nav + footer authored once as partials; AC-VD00-01/03 |
| Second cyan or hardcoded pillar hex creeps in | Med | AC-VD00-06; lint for hex in domain markup |
| Harness JS mistaken for theme code | High | `<!-- APP CHROME -->` banners; VD specs mark harness-only controls |

## Out of Scope

- Per-domain `<main>` content (covered by VD-01…VD-09).
- Real Portal/Stripe wiring (placeholders only; see VD-09).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Index | [`_planning-specs/INDEX.md`](../_planning-specs/INDEX.md) | Pillars, layers, four-pillar visual rule |
| ADR | ADR-0011, ADR-0012 | Component model + `.hbs` bridge |
| Mockup | Claude-DT s1–s9 | Reference chrome render |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
