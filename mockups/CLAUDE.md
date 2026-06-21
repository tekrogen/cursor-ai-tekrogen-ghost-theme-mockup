# CLAUDE.md — `mockups/` working context

Working notes for building/maintaining the mockup **surfaces** here. Read alongside the root
`CLAUDE.md` and `mockups/README.md` (the Flywheel build brief). Surfaces link the vendored
registry via external CSS, so **serve the repo — never open `file://`** (the stylesheet won't
load reliably).

## Surfaces in this directory

- **`Claude-DT/index.html`** — the original 9-screen Flywheel surface (own version, e.g. `v0.12.1`).
  The structural reference the VD specs were derived from.
- **`Tekrogen-Flywheel/index.html`** — the **VD-spec build** (own version, started `v0.1.0`).
  Implements `admin/features/proposed/tekrogen-mockup-revamp/visual-domains/` (FEAT-VD-00…09) one
  spec at a time; screens not yet built are placeholders that name their VD spec. As of this note:
  VD-00 (chrome/foundations) + VD-01 (Home) are built; s2–s9 are stubs.

Each surface carries its **own** `<meta name="version">` + `.ver` badge — bump independently of
the root project version.

## Consuming the vendored registry — gotchas

- **`tk-site-header` has NO responsive rule.** Its `[data-tk-slot="nav"]` overflows on phones; the
  **consumer** must collapse it, e.g. `@media(max-width:768px){.tk-site-header [data-tk-slot="nav"]{display:none}}`.
  A real Ghost theme needs a menu/hamburger affordance here — open VD-00 gap.
- **`tk-footer` self-collapses at `≤760px`** (`components/footer/footer.css`). For
  `data-style="nav"` the brand cell does **not** span — add
  `.tk-footer[data-style="nav"] [data-tk-slot="brand"]{grid-column:1 / -1}` at your small
  breakpoint so the brand sits above a 2-up column stack.
- **Fix component problems UPSTREAM in the DS, then re-vendor** (repo Rule #2/#3). The rules above
  are *consumer overrides* placed in the surface's own `<style>`, never edits to `components/`.

## Mobile gotcha — the "font problem" that isn't

Horizontal **page overflow** triggers mobile Safari's shrink-to-fit zoom, which makes all type
look small/wrong and is easily misread as a font or font-loading bug. **Diagnose, don't assume:**

1. Confirm fonts: `document.fonts.check('700 40px Poppins')` — they're self-hosted (ADR-0008) and
   almost always fine.
2. Find the real cause: scan for elements whose `getBoundingClientRect().right > clientWidth`.
   Common culprits here are the **harness `.shell-bar`** (a non-shrinking `flex:1` spacer + the
   wing swatches) and the **uncollapsed masthead nav** — not the type.
3. Goal: `documentElement.scrollWidth === clientWidth` at 390px (zero horizontal overflow).

The harness chrome (`.shell-bar`, surface toggle, wing swatches) does **not** port to the Ghost
theme — but it must still behave on mobile so reviews aren't derailed by a false "font" report.
