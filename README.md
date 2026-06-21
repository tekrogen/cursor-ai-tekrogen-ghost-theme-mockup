# Tekrogen — Ghost Theme Mockup (v0.15.0)

High-fidelity design mockups for a custom **Ghost** publishing theme for **Tekrogen**, a
four-entity practice ("four wings, one pursuit") publishing under a single mark across
`.org`, `.studio`, `.com`, and `.net`. The theme is organized around **seven content
types**: Use Case Study, SaaS Evaluation, Tech Rating, Product Page, Demo / POC,
Documentation, and Research Article.

**Author:** @tekrogen
**Inputs:**
- Github: `https://github.com/tekrogen/Tekrogen-Ghost-Theme-Mockup`
- Claude Design Files: `https://claude.ai/design/p/833e0a82-84e5-46f8-b26f-a8a57f308a23`
- Tekrogen Design System: `https://github.com/tekrogen/Tekrogen-Brand-Design-System`

## Purpose

These files explore and lock the information architecture and visual design for the
theme's key templates *before* implementation. Each mockup presents several candidate
**directions** as tabs so they can be compared side by side, with one direction marked
**LOCKED** as the chosen path.

## Screens explored (the four directions)

The review harness presents four candidate directions as tabs, in this order. One is
marked **LOCKED** as the chosen path. (Internally these still route via `data-dir`
keys A–D; the user-facing labels carry no prefix.)

| Screen | Template | Route | Notes |
|--------|----------|-------|-------|
| **Home Page** | Editorial Feed | `/` | **LOCKED.** Chronological river: a featured note on top, the rest in a numbered list; the 7 types live in a *Topics* dropdown. |
| **Topic Page** | Library Hub | `/topics/:slug` | Landing page after picking a topic; featured note + curated lanes of related work. |
| **Library Page** | Index of Seven | `/library` | Full library: a uniform grid of the 7 content types, each a doorway to its recent items. |
| **Post Details Page** | Post templates | `/:slug` | Per-type article templates (scored ratings, comparison tables, product CTAs, etc.). |

A built-in **Ink / Paper** surface toggle previews each direction in dark and light
modes; the mockup ships in **Ink** (the brand's primary surface) by default.

## Files

- **`index.html`** — the current high-fidelity mockup (all four directions + Ink/Paper toggle, defaults to Ink). *Main deliverable* (formerly `Ghost Theme Mockup v03.html`). Brand-compliance pass applied — see `Brand Compliance Checklist.md`.
- **`archive/Ghost Theme Mockup v02.html`** — prior version, kept for reference (pre-compliance pass).
- **`Brand Compliance Checklist.md`** — audit of the mockup against the Tekrogen Brand System, with each item's status.
- **`archive/Ghost Theme Wireframes.html`** — low-fidelity wireframes used to define the homepage layout. Archived; not an active deliverable.
- **`colors_and_type.css`** — brand design tokens consumed by the mockup (palette + type scale).
- **`fonts/`** — self-hosted brand web fonts (Poppins, Manrope, JetBrains Mono).
- **`scripts/`** — runtime scripts (`palette.js`, `image-slot.js`).
- **`assets/`** — brand marks, icon, and favicon SVGs plus other supporting assets.
- **`uploads/`** — user-supplied source material.

> Change history lives in [`CHANGELOG.md`](CHANGELOG.md).

## Design system

Built on the Tekrogen tokens in `colors_and_type.css`:

- **Type:** Poppins (display/sans), Manrope (body), JetBrains Mono (meta/labels).
- **Color:** cyan accent (`--tk-cyan`) over ink/paper neutrals, with per-pillar accent
  colors. Paper-mode muted tokens are darkened in the mockup so small mono meta text
  clears WCAG-AA contrast.

> The app chrome (top bar, tabs, direction headers, surface toggle) is a presentation
> harness for reviewing options — it is **not** part of the Ghost theme itself.
