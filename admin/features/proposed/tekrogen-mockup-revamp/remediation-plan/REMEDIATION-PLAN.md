# Tekrogen Flywheel Mockup — Visual Gap Analysis & Remediation Plan

**Date:** 2026-06-17
**Subject:** `mockups/Tekrogen-Flywheel/index.html` (stamped `Flywheel · v1.0.0`)
**Method:** Independent **rendered** visual audit — NOT documentation review. Served over
`http.server`, rendered in headless Chrome at **1440 + 390**, in **both Ink and Paper**, compared
against:
- the **Brand Design System** reference (`admin/issues/tekrogen-brand-system-guide.png`, the DS
  `Tekrogen-Brand-Design-System/index.html`, `Component Gallery.html` specimens),
- the **original layout reference** (root `index.html`, the locked publication mockup),
- the user's **annotated screenshot** (`admin/issues/tekrogen-ghost-theme-mockup.png`),
- the prior **conformance review** (`admin/issues/2026-06-15-brand-system-conformance-review.md`,
  filed as issues **#34–#42**).

---

## 0. Honest status correction

**The Phase E lock / `v0.15.0` release was premature and should not be treated as authoritative.**
Phase E validated a thin technical slice (overflow + token floor + a few Ink-only screenshots) and
declared "all PASS." It did **not** test Paper mode, did **not** consult the existing conformance
review or its 9 open issues, and **mislabeled known gaps as passing** (mobile nav, the paraphrased
tagline). This rendered audit confirms the visual defects are real and unresolved. The status doc
`admin/status/phase-e-lock-release-v0.15.0-status-2026-06-17.md` overstates completeness.

**Recommendation:** do not begin the custom Ghost theme until the **High** items below are corrected
and re-validated against the DS in **both surfaces** at **both breakpoints**. Treat `v0.15.0` as a
checkpoint tag, not a "locked layout."

---

## 1. Gap analysis

Severity: **High** = blocks "production-quality foundation" / a11y failure / functional gap ·
**Medium** = clear brand or UX deviation · **Low** = polish.

| ID | Current state | Desired state | Sev | Recommended fix | Affected files | Issue |
|----|---------------|---------------|-----|-----------------|----------------|-------|
| **V1** | **Footer** ships `data-style="nav"` only — cramped columns hard against the brand block, and **no colophon** (©, RSS, Contact) on any screen. Looks broken (per your annotation "what is going on with the footer"). | Use the DS **default footer** (pillar cards + `data-tk-slot="colophon"`: © 2026 Tekrogen · Martinique Dolce · Colophon · RSS · Contact), or add the colophon row to the nav variant. Proper top padding + column rhythm. RSS is functionally required for a Ghost publication. | High | Switch s1–s9 footers to the default variant **or** add the colophon slot; fix the brand-cell span + vertical spacing. | `mockups/Tekrogen-Flywheel/index.html` (all 9 footers); `components/footer/footer.{html,css}` (variant — fix upstream + re-vendor if the nav variant must carry colophon) | #35 |
| **V2** | **Paper-mode AA failure.** `:root{--wing-accent:var(--tk-cyan)}` is raw cyan and never flips under `data-tk-theme="paper"`. Eyebrows, `.principle .pn`, and active TOC paint raw `#1fd5da` on white → fails WCAG 1.4.3. **Confirmed in the Paper render.** | `--wing-accent` is theme-aware: cyan on Ink, the paper-AA teal (`#086a6f`) on Paper — or route `.eyebrow`/`.pn`/TOC through the DS's theme-aware `--tk-accent` (already used for `.chosen`/`.feeds`). | High (a11y) | Make `--wing-accent` flip in the Paper block, or switch the three selectors to `--tk-accent`. | `mockups/Tekrogen-Flywheel/index.html` CSS (`:root` line ~37; `.eyebrow` ~45, `.principle .pn` ~119, `.toc a[aria-current]` ~133) | #36 |
| **V3** | **No mobile navigation.** At ≤768px the masthead nav is `display:none` with **no menu toggle** — Case Studies/Recon/Demos/Products/Documentation/About are unreachable on a phone. (Confirmed in the 390px render.) The mobile screenshot also shows nav **overflow** in intermediate widths. | A real mobile nav primitive: hamburger/menu-toggle that opens the full nav (and Search). Reachable, focusable, keyboard-operable. | High | Build the Navigation primitive (DS "Navigation Menu", not yet built) and wire it into the consumer; stop hiding nav with no fallback. | `mockups/Tekrogen-Flywheel/index.html` (masthead + `@media` rule ~line 219); DS `components/` (new `navigation` component) | #34 |
| **V4** | **Cramped vertical rhythm.** Stats row (24/52/11/06) butts against ".org · use case studies / Featured studies." with too little air (your "there should be more space here"). General home rhythm is tight; hero→stats→featured spacing is inconsistent. | Consistent section rhythm on the DS spacing scale (`--tk-space-*`): generous separation between stats and the next section-head; even vertical cadence between all home sections. | Medium | Add section spacing (e.g. `--tk-space-16/20`) above `.tk-section-head`/between home blocks; audit all inter-section gaps. | `mockups/Tekrogen-Flywheel/index.html` CSS (home/section spacing; `.tk-stats` block ~line 328) | new |
| **V5** | **Cards read as non-interactive.** Featured-study cards have only a faint border-tint on `:hover` (`content-card.css:21`) — no cursor change, elevation, or transition — and the cards aren't wrapped in links. Reads as static (your "cards do not have hover enabled"). | Cards are obvious affordances: whole-card link, visible hover (border + subtle lift/transition per DS shadow tokens), `:focus-visible` ring, pointer cursor. | Medium | Wrap cards in `<a>`; strengthen the hover (transition + `--tk-shadow-*`); ensure focus ring. Keep the border-tint as the token-driven base. | `mockups/Tekrogen-Flywheel/index.html` (card markup, s1/s2); `components/content-card/content-card.css` (hover strength — upstream) | #38-adjacent / new |
| **V6** | **Logo is not a home link.** Masthead brand is `<div data-tk-slot="brand">`; DS specimen is `<a data-tk-slot="brand" href="/">`. Breaks the strongest web convention. | Brand lockup is an anchor to `/` on every screen. | Medium | Change `<div data-tk-slot="brand">` → `<a … href="#/">` per the specimen. | `mockups/Tekrogen-Flywheel/index.html` (9 mastheads) | #37 |
| **V7** | **Cyan inflation.** On S1 cyan lands on the hero eyebrow, both featured eyebrows, the primary CTA, and stat affordances at once — against "one cyan per surface." | Cyan reserved for the single primary action per screen; eyebrows carried on the muted mono treatment the DS pairs them with (or theme-aware accent at AA). | Medium | Scope cyan to one CTA; demote decorative cyan; ties into V2. | `mockups/Tekrogen-Flywheel/index.html` CSS (eyebrow/accent usage) | #38 |
| **V8** | **Hero paraphrases the locked tagline.** H1 = "We build real solutions to real problems." The DS locks "Real solutions. Built, proven, ready to use." (use verbatim, don't paraphrase). | Use the locked tagline verbatim; demote the current line to a supporting dek if wanted. | Medium (voice) | Edit S1 `<h1>` (and any other paraphrase). | `mockups/Tekrogen-Flywheel/index.html` (s1 hero, line ~307) | #39 |
| **V9** | **Hero right side is unbalanced** — the flywheel diagram floats in a large dark void; hero text column vs. diagram column feel disconnected, leaving dead space. | Balanced hero: diagram sized/placed to hold the right column, or layout reflowed so the composition reads as one unit. | Medium | Rework S1 hero grid proportions / diagram scale. | `mockups/Tekrogen-Flywheel/index.html` (s1 hero + `tk-flywheel`) | new |
| **V10** | **Production header variant not exercised.** Surface uses `data-style="framed"` (static, in-frame mock) everywhere; the DS **default** sticky+blur production header is never shown. | Demonstrate the production sticky header for the templates that ship it; keep `framed` only where the in-frame device mock is intended. | Medium (port-time) | Use default `tk-site-header` for the live preview; document which variant maps to which Ghost template. | `mockups/Tekrogen-Flywheel/index.html` (mastheads) | #57 (BDS) / B2 |
| **V11** | **Docs category "icons" are 2-letter monograms** (IN/AP/TU/RN/VS/CP), neither Lucide nor the approved glyph set. | Lucide outline icons (download, code, graduation-cap, file-text, git-branch, user), stroke 1.5, `currentColor`, per ADR-0005. | Low–Med | Swap letter tiles for Lucide in S7 category cards. | `mockups/Tekrogen-Flywheel/index.html` (s7) | #40 |
| **V12** | **Off-signature/off-table glyphs.** `.stamp` adds a decorative `rotate(-3deg)` (only the 18° mark tilt is sanctioned); a few glyphs (`⊘ ⌕ ●`) sit outside the documented table. | Remove the second rotation idiom; substitute approved/Lucide glyphs or add them to the DS table. | Low | Drop `.stamp` rotate; reconcile glyphs. | `mockups/Tekrogen-Flywheel/index.html` CSS (`.stamp` ~147); s7/s9 glyphs | watch items |
| **V13** | **Interactive primitives implied but absent** — Pagination (S2 `.pager`), Checkbox/Select (S9 forms), Tabs/Accordion (S7 docs/TOC), Tooltip/Toast (S9 copy/submit), Alert (formalize `.tk-callout`). | Build the DS primitives the screens already imply, ahead of the Ghost port. | Medium (port-queue) | Build per the gap-analysis roadmap; not blocking the visual layout lock. | DS `components/`; `mockups/Tekrogen-Flywheel/index.html` | #42 |
| **V14** | **Governance: premature lock + version skew.** Surface stamped a release while defects + 9 open issues stand; mockup version trailed the vendored BDS release. | Version reflects the vendored BDS release; no "locked" claim until the High items pass re-validation. | Gov | Re-validate before re-stamping; realign version to BDS. | version markers; status docs | #41 |

---

## 2. What the mockup still gets right (so this isn't one-sided)

- Real DS consumption: loads `colors_and_type.css` + vendored `components/tk-components.css`; uses
  **33/34** `tk-*` components with the correct `--tk-*` tokens and `data-tk-slot` contract.
- Respects the ≥12px type floor and the `--tk-fg-3` text-color floor (except V2's accent lapse).
- Flat, hairline, Ink-primary aesthetic; pillar colors as accents, never page backgrounds.
- Cross-pillar relations use a colored **pip + the word** (WCAG 1.4.1) — above and beyond.
- No layout *overflow*: `scrollWidth === clientWidth` at 390 on all 9 (the one thing Phase E did
  verify holds).

The problem is not "wrong colors" or "missing components." It is **organism conformance, visual
rhythm, interaction affordance, and accessibility in Paper** — the layer that makes it a credible
foundation for a production theme.

---

## 3. Prioritized remediation plan

Each item: own issue → typed branch → PR → **re-validate in Ink + Paper at 1440 + 390** before
close. Re-validation is mandatory (this is the discipline Phase E skipped).

### Phase R1 — High (blocks the theme foundation)
1. **V2 / #36 — Paper-mode AA accent.** Smallest, highest-leverage a11y fix; unblocks honest
   Paper validation. (token change)
2. **V1 / #35 — Footer colophon + layout.** Most visible "broken" element; fix the variant/spacing.
3. **V3 / #34 — Mobile navigation primitive.** Functional gap; needs the new DS Navigation component
   (largest effort — may span DS + consumer).

### Phase R2 — Medium (brand + UX conformance)
4. **V4 — Vertical rhythm / section spacing** (home first, then s2–s9).
5. **V5 — Card interaction affordance** (link-wrap + hover/focus).
6. **V6 / #37 — Logo → home link.**
7. **V8 / #39 — Locked tagline verbatim.**
8. **V7 / #38 — Cyan scoped to one affordance** (do alongside V2/V4).
9. **V9 — Hero balance.**
10. **V10 / B2 — Production header variant** (decide per template).

### Phase R3 — Low / polish & port-queue
11. **V11 / #40 — Lucide docs icons.**
12. **V12 — `.stamp` rotate + off-table glyphs.**
13. **V13 / #42 — Interactive primitives** (Pagination, Checkbox/Select, Tabs/Accordion, Tooltip,
    Toast, Alert) — staged for the Ghost port.

### Governance (runs alongside)
14. **V14 / #41 — version realignment**, and treat `v0.15.0` as a checkpoint, not a lock.

### Acceptance gate to declare the layout "ready for the Ghost theme"
- [ ] All R1 + R2 items merged and **re-validated in Ink AND Paper at 1440 AND 390**.
- [ ] Paper mode: every accent passes AA (no raw cyan text on white).
- [ ] Mobile: every nav destination reachable via a real control.
- [ ] Footer carries colophon (©, RSS, Contact) on every screen.
- [ ] Cards are unmistakably interactive (hover + focus + cursor).
- [ ] Side-by-side with the DS reference + root `index.html`: hierarchy, spacing rhythm, and
      typography read as the same design language.
- [ ] User sign-off on the rendered result — not on documentation.

---

*Prepared from the live rendered files on disk; every conclusion is reproducible by serving the repo
and rendering the surface in both surfaces at both breakpoints.*
