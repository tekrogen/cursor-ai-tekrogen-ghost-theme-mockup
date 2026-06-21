# Contrast audit — V2 + V7 (Paper-mode accent AA + cyan scope)

**Work order:** V2 + V7 · issues #36 + #38 · branch `fix/36-paper-accent-aa`
**Surface:** `mockups/Tekrogen-Flywheel/index.html`
**Method:** measured on the **rendered** surface (served over http on `localhost:8000`), headless
Chromium via Playwright. Each element's `getComputedStyle().color` was read against its effective
(first non-transparent ancestor) `background-color`, and the WCAG 2.x contrast ratio computed with the
standard sRGB relative-luminance formula. Ratios are the *as-rendered* values, not token annotations.

**WCAG bar:** normal text ≥ 4.5:1; large/UI ≥ 3:1. The eyebrow is `--tk-fs-eyebrow` (0.75rem / 12px),
weight 500 — **normal text**, so 4.5:1 applies (it is not large-text-exempt).

**Screens measured:** s1 (`.eyebrow`, `.frame-url b`), s3 (`.toc a[aria-current]`), s8 (`.principle .pn`).
Paper page background `--tk-bg-1` = `#f3f5f7`; white cards lift on `--tk-bg-2` = `#ffffff`.

## Measured ratios (final — eyebrow resolved to `--tk-fg-2`)

| Element                | Surface | Token → Color           | On bg     | Measured ratio | AA (≥4.5 text)? | Screenshot                              |
|------------------------|---------|-------------------------|-----------|----------------|-----------------|-----------------------------------------|
| `.eyebrow`             | Ink     | `--tk-fg-2` `#cbd5e1`   | `#0e1116` | **12.74:1**    | yes             | screenshots/v2-accent/s1-ink-1440.png   |
| `.eyebrow`             | Paper   | `--tk-fg-2` `#475561`   | `#f3f5f7` | **7.01:1**     | yes             | screenshots/v2-accent/s1-paper-1440.png |
| `.frame-url b`         | Ink     | `--tk-accent` `#1fd5da` | `#171c24` | **9.44:1**     | yes             | screenshots/v2-accent/s1-ink-1440.png   |
| `.frame-url b`         | Paper   | `--tk-accent` `#086a6f` | `#ffffff` | **6.36:1**     | yes             | screenshots/v2-accent/s1-paper-1440.png |
| `.toc a[aria-current]` | Ink     | `--tk-accent` `#1fd5da` | `#0e1116` | **10.44:1**    | yes             | screenshots/v2-accent/s3-ink-1440.png   |
| `.toc a[aria-current]` | Paper   | `--tk-accent` `#086a6f` | `#f3f5f7` | **5.82:1**     | yes             | screenshots/v2-accent/s3-paper-1440.png |
| `.principle .pn`       | Ink     | `--tk-accent` `#1fd5da` | `#0e1116` | **10.44:1**    | yes             | screenshots/v2-accent/s8-ink-1440.png   |
| `.principle .pn`       | Paper   | `--tk-accent` `#086a6f` | `#f3f5f7` | **5.82:1**     | yes             | screenshots/v2-accent/s8-paper-1440.png |

### Before (for reference) — raw cyan as text
All four selectors previously painted `--wing-accent` = `--tk-cyan` `#1fd5da`. `--wing-accent` never
flips for Paper (it is set on `documentElement`, while Paper is applied only to `#stage`), so on the
Paper page bg `#f3f5f7` these rendered at ≈ **1.4:1** — the WCAG 1.4.3 failure V2 tracks.

## Verdict — all four accents PASS AA on both surfaces

- **3 editorial accents → theme-aware `--tk-accent`.** `.frame-url b`, `.toc a[aria-current]`, and
  `.principle .pn` measure **5.82–6.36:1** on Paper (Ink unchanged at 9.44–10.44:1).
- **Decorative `.eyebrow` → muted-mono.** Initially demoted to `--tk-fg-3`, which measured **4.42:1**
  on the Paper *page* bg `#f3f5f7` — 0.08 under the 4.5:1 line (the plan's §J ~4.7:1 figure holds
  against white cards/`#fbfcfd`, not the decoupled page bg). On reviewer sign-off this was promoted one
  step to **`--tk-fg-2`** (`#475561` Paper), which measures **7.01:1** — clears AA with margin while
  staying muted-mono and killing the cyan inflation. (Trail of the `--tk-fg-3` 4.42:1 reading kept
  above for the record; the shipped value is `--tk-fg-2`.)
- **Cyan scope (V7):** on Ink, the only cyan affordance per screen is now the CTA fill — confirmed
  visually across s1/s3/s8 in the committed screenshots.
- **No horizontal overflow** at 390 (`documentElement.scrollWidth === clientWidth`), Ink and Paper.

Evidence is the 12 four-state screenshots in `screenshots/v2-accent/` + the ratios above. No version
re-stamp and no "ready/PASS" claim is asserted by this file — sign-off is the reviewer's, on the
rendered screenshots.
