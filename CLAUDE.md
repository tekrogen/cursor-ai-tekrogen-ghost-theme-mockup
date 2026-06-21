# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

High-fidelity design mockups for a custom **Ghost** publishing theme for **Tekrogen** (a
four-entity practice publishing under one mark across `.org`, `.studio`, `.com`, `.net`).
The deliverable is self-contained HTML used to **review and lock** information architecture and
visual design *before* the theme is implemented in Ghost. The mockups are not a runnable
application and have no build/test/lint of their own (static HTML).

There are now **three mockup surfaces** in this repo — know which one you're touching:

1. **Root `index.html`** (~3038 lines, carries the **project version**, currently `v0.14.1`) —
   the original **locked publication mockup**: four reader directions — **Home / Topic /
   Library / Post Details Page** (`data-dir` A–D) — plus the review harness. It predates the
   design-system registry and styles itself from `colors_and_type.css` directly (no `tk-*`).
2. **`mockups/Claude-DT/index.html`** (~707 lines, own version, currently `v0.12.1`) — the
   **next-gen Flywheel surface**: nine screens (`data-screen` s1–s9) spanning the full
   **Tekrogen Flywheel** (Use Case → Recon → Demo/POC → Registration → Product → License →
   Download → Documentation → Versioning). This surface **consumes the design-system component
   registry** (`tk-*`); it was built and migrated onto the registry across the C1–C7 batches,
   and its now-inert bespoke CSS was swept (v0.14.1). It is the **rehearsal for the real Ghost
   theme**. Build brief: `mockups/README.md`; validation/handoff: `admin/status/`.
3. **`mockups/Tekrogen-Flywheel/index.html`** (own version, started `v0.1.0`) — the **VD-spec
   build**: the same nine-screen Flywheel structure (`data-screen` s1–s9), but built one spec at
   a time from `admin/features/proposed/tekrogen-mockup-revamp/visual-domains/` (FEAT-VD-00…09).
   So far **VD-00 (chrome/foundations) + VD-01 (Home)** are built; the other screens are
   placeholders that name their VD spec. See **`mockups/CLAUDE.md`** for surface + registry-
   consumption notes.

## Relationship to the Design System (source of truth)

Upstream is **`Tekrogen-Brand-Design-System`** (DS) — the canonical token + component source
(a 34-component, token-only `tk-*` registry governed by ADRs).

- The DS registry is **vendored** into this repo's [`components/`](components/) (34 dirs, each
  `<name>/<name>.{css,html,hbs}`) plus the barrel [`components/tk-components.css`](components/tk-components.css),
  via `cp -R components/. ../Tekrogen-Ghost-theme-mockup/components/`. `colors_and_type.css` is
  kept at **DS parity** (e.g. it carries the DS token `--tk-fg-on-accent`).
  Note: the **dir/filenames are UNPREFIXED** (`components/site-header/site-header.css`) even
  though the classes they define are `tk-*` (`.tk-site-header`) — don't grep for a `tk-` dir.
- `mockups/Claude-DT/` links `colors_and_type.css` **and** `components/tk-components.css`, so its
  `tk-*` elements are styled by the registry — **not** by inline `<style>`. (Root `index.html`
  does not link the registry.)
- This mockup is the rehearsal; the real deliverable is a **custom Ghost theme** built from the
  registry's `.hbs` partials. Don't edit vendored `components/` here to "fix" a component —
  fix it upstream in the DS and re-vendor. See `admin/status/ghost-theme-mockup-validation-handoff-2026-06-14.md`.

## Working in this repo

- **Preview:** serve the repo (`python3 -m http.server`) and open root `index.html` or
  `mockups/Claude-DT/index.html`. The Claude-DT surface links external CSS, so **serve it —
  don't open `file://`** (the stylesheet won't load reliably).
- **Host-runtime features are inert locally** (root `index.html`). The Tweaks panel and
  `<image-slot>` persistence only function inside the Claude design host ("omelette" runtime)
  that serves these files. The Tweaks panel is shown/hidden by `postMessage`
  (`__activate_edit_mode` / `__deactivate_edit_mode`) from the parent frame; image-slot drops
  persist via a sidecar the host bridge only allows at the project root. Opening from disk shows
  the default state with these dormant — expected, not a bug.
- **Versioning — bump every marker together.** Format `vX.Y.Z` (matching tags/releases),
  duplicated across surfaces. On release, update **all** in one commit so they never drift:
  1. `index.html` `<meta name="version" content="vX.Y.Z"/>` — canonical **project** marker.
  2. `index.html` harness badge — `.shell-bar .ver` (`vX.Y.Z · HI-FI`).
  3. `README.md` H1 — `(vX.Y.Z)`.
  4. `Brand Compliance Checklist.md` H1 — `vX.Y.Z`.
  5. New `CHANGELOG.md` entry (Keep a Changelog), then `git tag vX.Y.Z` + GitHub release.
  6. **The Claude-DT surface has its OWN version line** — `mockups/Claude-DT/index.html`
     `<meta name="version">` + its `.ver` badge (`Claude-DT · vX.Y.Z · HI-FI`); bump it when
     that surface changes. (Project is currently v0.14.1; Claude-DT v0.12.1 — they diverge.)
  Don't touch fictional in-content product versions (e.g. "Spine v0.4") — deliberate mock data.
  Leave `archive/*` frozen. Versions track design milestones, not shipped software.

## Architecture

### Two surfaces, one harness pattern

Both surfaces use the same harness idiom: `.shell-tab` buttons switch views via
`aria-selected` / `aria-current`; an ink/paper surface toggle scoped to the stage; comment
banners separate **APP CHROME (the review harness — NOT theme code to port into Ghost)** from
the **GHOST THEME** markup.

- **Root `index.html`** — four `.direction` blocks tagged `data-dir` A–D (Home / Topic /
  Library / Post Details). Plus the Tweaks panel, density control, and `<image-slot>`. Harness
  JS is the single inline `<script>` at the bottom.
- **`mockups/Claude-DT/index.html`** — nine `.screen` blocks (`data-screen` s1–s9); only one
  screen is shown at a time (click `[data-screen="sN"]` to switch). Consumes the registry.

### The vendored component registry — `components/`

The 34 DS components (`tk-*`), token-only, with `data-tk-slot` / `data-variant` / `data-pillar`
/ `data-style` axes; the `tk-components.css` barrel `@import url()`s them all (the `url()` form
matters for the DS's font-guard). `mockups/Claude-DT/` is the consumer. The Claude-DT migration
maps every bespoke block onto `tk-*` (e.g. `.card`→`tk-card`, `.tier`→`tk-license-tier`); the
remaining inline `<style>` in Claude-DT is harness/layout only (bespoke component CSS was
removed in v0.14.1). When migrating markup, leaf classes the registry targets as slot
descendants (`.l`/`.token`/etc.) stay; only the container/slot classes change.

### Content model: five categories (the "Recon" model)

Content is organized into **five top-level categories**, applied consistently across the Home
feed, Topics dropdown, Topic page, Library ("Index of Five"), and Post Details:

> **Use Case Study · Recon · Product · Demo / POC · Documentation**

- **Recon** is the unified "justify the stack" category — qualitative, multi-source research +
  side-by-side comparison done *before* a Demo. It absorbed the former *Research Article* and
  *SaaS Evaluation* types (v0.5.0).
- **No numeric ratings, ever.** The old *Tech Rating* type and all scoring (six-axis rubric,
  `x.x/10`, score bars) were removed — Tekrogen does not rate resources; the stack decision
  belongs to stakeholders. Don't re-introduce scores. `.score-mini` / `.score-panel` CSS is
  **dead/unused**.
- **Watch for stale counts/labels** — "Index of Five", "5 categories", per-category counts must
  stay in sync. (A drift like "seven types" or a stray score is the classic regression.)

Full rationale: `recon-content-model.md` (root). The Claude-DT flywheel surface extends this
into the full commerce/membership/distribution flow per `mockups/README.md`.

### `--wing-accent` is the theme's one accent knob

The theme keys its accent off the single CSS variable `--wing-accent` (default `var(--tk-cyan)`).
The Tweaks "Wings" swatches override it inline on `documentElement`, implementing the brand's
**"one cyan per surface / per-pillar accent"** rule. Color themed UI via `--wing-accent`, not a
hardcoded hex. (The registry's components key off `--tk-cyan` / `data-pillar` directly.)

### Token layer: `colors_and_type.css` + `scripts/palette.js`

`colors_and_type.css` (root, loaded by both surfaces) holds the `--tk-*` tokens — palette, type
scale, spacing — and is kept at **DS parity**. The palette values inside
`/* TK-PALETTE-BEGIN */ … /* TK-PALETTE-END */` mirror `scripts/palette.js` (the JS source that
also populates `window.TK_TOKENS`); keep the two in parity by hand if you change a pillar/surface
hex. `@font-face` `src:` paths are relative to repo root (`fonts/…`).

### `scripts/image-slot.js`

Defines the `<image-slot>` web component — a drag/drop image placeholder. Each slot needs a
distinct `id` to persist; persistence requires the host runtime and the HTML at project root
(see "Host-runtime features" above).

## Brand compliance

`Brand Compliance Checklist.md` is the authority for brand rules and records each item's status.
Locked rules: mixed-case **Tekrogen** wordmark in Poppins 600 (all-caps `TEKROGEN` is marketing-
only); approved glyph vocabulary (`✓`, mono unicode — no `★ ✱ ▶`); sanctioned
`var(--tk-shadow-*)` / `var(--tk-radius-*)` tokens, not ad-hoc values; one cyan per surface;
hairlines not shadows; the 18° dragonfly tilt (baked into the SVG — don't double-rotate).

## Governance & workflow

This repo follows the cross-project policy in `/Volumes/SERV01-DTMAC/_Code_Library/GIT-Workflows`
(and the DS repo's rules):

- **Branch naming is mandatory:** `<type>/<issue#>-<slug>` (e.g. `refactor/9-dead-css-cleanup`).
  Open an issue first; PR title = a conventional commit; PR body says `Closes #N`. This repo
  adopted the issue→branch→PR chain as of issue #9 / PR #10 — use it from here on.
- **commitlint is active** (husky `commit-msg`): subject must **start lowercase** (no `C5`/`Add`/
  capital — fails `subject-case`); header ≤100 chars, body lines ≤100. Put batch labels in the body.
- **Release engine:** today releases are **manual git tags** (no committed CI; `gh release create`).
  release-please tooling is being added (`release-please-config.json`, `commitlint.config.cjs`,
  `package.json` are present but **untracked**); once committed with a CI workflow, switch to the
  release-please flow (Rule #4: release-please is the default for non-NPM repos).
- **Reference PRs/issues with the repo named** ("mockup PR #10" vs "DS PR #47") — independent numbering.

## Files & layout

- **`index.html`** (root) — the locked publication mockup (4 directions; project version).
- **`mockups/Claude-DT/index.html`** — the built Flywheel surface (9 screens; consumes the registry).
  **`mockups/README.md`** — the Flywheel build brief (the spec Claude-DT implements).
- **`components/`** — the vendored DS registry (34 dirs + `tk-components.css`). Vendored, not authored here.
- **`colors_and_type.css`**, **`scripts/`**, **`fonts/`**, **`assets/`** — token layer (DS parity),
  runtime JS (`palette.js`, `image-slot.js`), self-hosted fonts, brand marks/favicon (all at root).
- **`recon-content-model.md`** — decision record for the five-category / Recon model.
- **`CHANGELOG.md`** — Keep a Changelog history (see the versioning ritual above).
- **`Brand Compliance Checklist.md`** — brand-rule audit.
- **`archive/`** — frozen prior snapshots; do not modify (gitignored; already-tracked copies remain).
- **`admin/`** — internal working area, **mostly gitignored** (`/admin/*` except `!/admin/features/`).
  `admin/status/` holds the Ghost-theme validation/handoff notes (gitignored); `admin/features/`
  is tracked (feature briefs/specs); `admin/internal/` + `admin/issues/` stay local-only.
- **`uploads/`** — user-supplied source material (gitignored).

## Rules

These must be followed with no exceptions:

1. Do not ever include a `Co-Authored-By: Claude …` trailer in commits in this code base.
2. **Check files first, assume nothing.** When there is any confusion, contradiction, or ambiguity — especially about what this project *is*, what it references, or how it relates to other projects (the DS repo, the two surfaces, vendored vs authored code) — verify against the documents, the data, and the codebase (README, CLAUDE.md, `git remote -v`, `git log`, `grep`) *before* answering or acting. Treat the repository's own files as authoritative over anything stated in chat, including loosely-worded inputs and your own prior statements. Report what the files say, then reason. Never carry an unverified claim from conversation forward as fact.
3. **Follow the branch-naming convention** (see Governance): `<type>/<issue#>-<slug>`, issue first, PR body `Closes #N`. Don't fix vendored `components/` here — fix upstream in the DS repo and re-vendor.
4. **Review and validate every UI/UX artifact before declaring it done.** Any UI/UX you author or change here (a mockup surface, a screen, an `admin/review/` artifact, any HTML/CSS) must be (a) **designed to the 3-expert review method** and (b) **validated against the Tekrogen Brand Design System** — *before* hand-off, not after the user reports a defect. The two operating briefs live in **`/Volumes/SERV01-DTMAC-1/_Code_Library/AI prompts/`** — read them when doing this work:
   - **`Design-System-UIUX-Review-Prompt.md`** — the **3-expert panel** (Senior Product Designer · Design Systems Architect · Front-End Engineering Lead): visual hierarchy/legibility, token/scale/spacing discipline, and rem/AA/focus/maintainability. Apply all three lenses; be evidence-based.
   - **`GHOST-CRM-AND-THEME-EXPERT.md`** — the Ghost CMS architecture lens (native routing/memberships/templates, GScan, accessibility) for anything theme-shaped.

   **Validation gate (run before saying "done"):** (1) **static token audit** — every `font-size` is a DS type-scale token (no hardcoded px); **nothing below the 12px legibility floor** (`--tk-fs-eyebrow`/`--tk-fs-meta` = `0.75rem`); lowest text colour is `--tk-fg-3` (AA) — never `fg-4`/`fg-5` for text. (2) **Render and check** at **1440px + 390px**: zero horizontal overflow (`documentElement.scrollWidth === clientWidth` at 390px); **serve, don't `file://`**. (3) **3-expert pass** with a short evidence-backed verdict. This is the same Phase-E acceptance bar used for the s2–s9 builds; record results in an `admin/review/VALIDATION.md`-style note for review artifacts.
