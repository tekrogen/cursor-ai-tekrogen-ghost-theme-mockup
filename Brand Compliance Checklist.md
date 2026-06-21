# Brand Compliance Checklist — Ghost Theme Mockup v0.15.0

Audit of the mockup files against the **Tekrogen Brand Design System**
(`README.md`, `CLAUDE.md`, ADR-0001–0006, `colors_and_type.css`).

- **Audited:** `archive/Ghost Theme Mockup v02.html` (hi-fi). Fixes applied to **`index.html`** (formerly `Ghost Theme Mockup v03.html`); v02 archived as the pre-pass reference.
- **Date:** June 3, 2026
- **Status:** Items 1–7 **resolved** in v03. Items 8–9 (Polish) **awaiting go-ahead**. Token layer is clean (no palette drift).

---

## ✅ What already complies

- **Tokens loaded correctly** — `tekrogen/colors_and_type.css` is linked; its `--tk-*` palette block matches the canonical source value-for-value (no drift).
- **Sans-only (ADR-0001)** — no serif face anywhere in the hi-fi mockup. Editorial slots use Poppins italic, as specified.
- **Voice & copy** — tagline "Real solutions. Built, proven, ready to use." used verbatim; pillar descriptions match (`.studio` = "Proof of concept and demos", etc.); entity names are lowercase-with-dot (`.org`, `.studio`).
- **Casing** — headlines are sentence case with periods; eyebrows/meta are uppercase mono with correct tracking.
- **The mark** — appears only at brand entry points (header, footer), tilted 18° via an inner `<g transform="rotate(18 …)">`. Not used inline or as bullets.
- **Depth via hairlines** — 1px borders carry elevation; no rogue diffuse-shadow system on content.
- **Paper-mode contrast lift** — small mono meta tokens are deliberately darkened on Paper to clear WCAG-AA. Good, documented call.

---

## 🔴 Fix — clear brand-rule deviations

- [x] **1. Publication wordmark is UPPERCASE; should be mixed-case.** ✓ Fixed in v03 — header + footer `.wm` now Poppins 600, mixed-case, `-0.01em` tracking.
  Header and footer `.wm` render `TEKROGEN` (`text-transform:uppercase`, `letter-spacing:0.18em`, Poppins 700). `CLAUDE.md` is explicit: *"The publication header uses the SANS wordmark 'Tekrogen' (Poppins 600, mixed-case), not the locked UPPERCASE TEKROGEN wordmark. The locked one is reserved for marketing surfaces."*
  → Change `.site-mark .wm` and `.site-foot .wm` to mixed-case, weight 600, normal tracking. (Lines ~165, ~1290 region.)

- [x] **2. Off-vocabulary symbols (★ ✱ ▶) used as UI glyphs.** ✓ Fixed in v03 — spotlight tags now read as words (Featured / Product / Live demo); comparison-table stars replaced with the approved ✓ glyph.
  Spotlight tags use `★ Featured`, `✱ Product`, `▶ Live demo` / `▶ Realtime`; the comparison table uses `★ ★ ★` ratings. The brand's sanctioned glyph set is **only** `↓ ↗ ✓ ✗ ⧉ × · …`, and the symbol policy says *"find a Unicode glyph above or write the word."*
  → Replace with words or approved glyphs: e.g. `Featured`, `Product`, `Live ↗`, and a `✓`-based or numeric scale in the table. (Lines 1829, 2202, 2409, 2536, 2559, 2584, 2773–2778, 2939.)

- [x] **3. Dropdown shadow is off-system.** ✓ Fixed in v03 — `.topics-menu` (both surfaces) now uses `var(--tk-shadow-2)`.
  `.topics-menu` uses `box-shadow: 0 20px 50px …` (and a paper variant). The brand allows **only two** shadow recipes: `--tk-shadow-2` (`0 14px 40px rgba(0,0,0,0.5)`) for floating docks/menus, and `--tk-shadow-glow` for the one primary CTA.
  → Swap the dropdown to `var(--tk-shadow-2)`. (Lines 726, 730.)

- [x] **4. Off-scale corner radius on post cards.** ✓ Fixed in v03 — `.frame`, `.A-hero .hero-img`, and `.post-mock` now use `var(--tk-radius-xl)` (12px).
  `.post-mock` cards use `border-radius:14px`. The radius scale has no 14px (it goes `--tk-radius-xl:12px` → `--tk-radius-2xl:16px`); 12px is the default card radius and the brand explicitly forbids drifting off-scale.
  → Use `var(--tk-radius-xl)` (12px). Same for the `.frame` bezel if you want strict consistency (lower priority — it's review chrome). (Lines 133, 1413.)

---

## 🟠 Review — needs a decision (possibly intentional)

- [x] **5. Author name conflict.** ✓ Resolved — default author is now **M. Dolce** across all bylines, the avatar (MD), the citation, and the copyright line.
  Every byline, the `RD` avatar, and the copyright line read **Robert Dolce**. The brand `README.md` names the founder **Martinique Dolce**. (The project's GitHub history under `R-Dolce-Group` and the `rdolcegroup.com` domain suggest "Robert Dolce" may be correct.)
  → **Confirm the canonical author name** and make the mockup and the brand README agree. This is a single source-of-truth question, not a styling one.

- [x] **6. "One cyan per surface".** ✓ Confirmed as by-design — `--wing-accent` is swapped to each entity's pillar color per surface (the Tweaks panel demonstrates this; House cyan is the `.org`/default lead). No code change needed.
  On the `.org` default, `--wing-accent` (cyan) simultaneously drives the primary CTA, the active-nav underline, eyebrows, card arrows, featured tags, score-bar fills, and stat rules. The brand reserves cyan for *one* affordance per surface so the primary action stays unambiguous (*"a second cyan element diffuses the affordance"*). Eyebrows-in-cyan is itself brand-sanctioned, so the issue is the **decorative** cyan competing with the CTA.
  → Keep cyan for the single primary CTA (+ links/eyebrows), and demote decorative cyan (featured tags, arrows, score bars, stat borders) to a pillar or neutral. *Note:* if the intent is that `--wing-accent` gets swapped to each entity's pillar color on the sub-publications, that resolves most of this — **confirm that mechanism.**

- [x] **7. Default surface → Ink.** ✓ Fixed in v03 — ships in Ink (brand primary); `<html>` attribute, stage class, header toggles, and Tweaks panel all default to Ink. Paper remains one click away.
  The file ships `data-tk-theme="paper"` with Paper pre-pressed. The brand calls **Ink the primary mode** (*"most surfaces start here"*).
  → Default to Ink, or confirm Paper-first is a deliberate choice for this review.

---

## 🟡 Polish — maintainability & accessibility

- [ ] **8. Hardcoded hexes bypass the token layer.**
  Pillar colors (`#446e88` / `#6491ac` / `#0db4b9` / `#7edba5`) are inlined on dozens of byline dots and `--pillar` styles, and paper neutrals (`#e6ebef`, `#f3f5f7`, `#0a0d12`, `#ffffff`) are hardcoded across the `.theme-paper` overrides — even though the Paper theme already redefines `--tk-border`, `--tk-bg-2`, `--tk-bg-3`. The values are *correct*, but bypassing tokens defeats the single-source palette (ADR-0002) and will drift if a hex changes.
  → Map to `var(--tk-org/studio/com/net)` and `var(--tk-border)` / `var(--tk-bg-*)`.

- [ ] **9. Interactive elements aren't keyboard-operable.**
  Nav items are `<a>` with no `href` (not focusable/activatable); `.search-mini` is a `<div>`; chips and anchors are non-button elements. The brand ships a `:focus-visible` ring, but only focusable elements can use it.
  → Give nav links real `href`s (or make them `<button>`), turn search into a `<button>`/`<input>`, and ensure chips/anchors are buttons or links. (Lines 1807–1810, 1816, 2170–2171, 2391–2394, etc.)

---

## Note on the wireframes file

`Ghost Theme Wireframes.html` has been **archived** to `archive/` — it was a deliberately low-fidelity sketch (Patrick Hand font, its own grayscale vars, no brand tokens) used to define the homepage layout. It is exempt from brand-fidelity rules and is no longer an active deliverable.

---

### Remaining work
**Items 8–9 (Polish)** are awaiting your go-ahead — see the two entries above. Both are low-risk and confined to v03.
