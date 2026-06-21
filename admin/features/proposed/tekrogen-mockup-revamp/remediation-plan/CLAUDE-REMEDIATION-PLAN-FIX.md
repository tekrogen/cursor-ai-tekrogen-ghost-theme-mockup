# Tekrogen Flywheel Mockup — Remediation & Redesign Plan (Developer Handoff)

**File:** `CLAUDE-REMEDIATION-PLAN-FIX.md`
**Date:** 2026-06-17
**Surface under remediation:** `mockups/Tekrogen-Flywheel/index.html` (self-stamped `Flywheel · v1.0.0`)
**Status of surface:** NOT production-ready. NOT cleared for the custom Ghost theme.
**Authority:** This is the single, complete source of truth for the redesign. It absorbs and
supersedes `REMEDIATION-PLAN.md` (diagnosis of record) and `REMEDIATION-PLAN-ANALYSIS.md` (review of
that diagnosis) **for execution**. Keep those two for history; work from this one.

---

## A. Purpose & how to use this document

This document exists so the entire Flywheel redesign can be executed from **one file**, by a developer
who has not been part of the prior sessions, without needing anything teased out in chat.

Every fix is written as a self-contained **work order** with the same shape:

> **ID · Title** — `severity` · `layer` · `effort` · `branch` · `depends-on`
> **Problem** — what's wrong, in one or two sentences.
> **Evidence** — exact `file:line` anchors, verified on disk 2026-06-17.
> **Fix** — the concrete change, with code where code is possible.
> **Acceptance** — the checklist that must be true to close the item.
> **Validate** — how to prove it, in both surfaces at both breakpoints.

**Layer** tells you where the change lives:
- `consumer` — edit `mockups/Tekrogen-Flywheel/index.html` directly.
- `upstream` — change the Brand Design System component source (canonical `components/*` per
  ADR-0011), then **re-vendor** into the mockup's `components/`. Additive-only: new isolated
  structures; never edit existing component files/schemas in place.
- `governance` — pure disk edits to docs/version markers; never appears in commits or release notes.

Work top-down: **R1 (High) → R2 (Medium) → R3 (Low/port-queue) → Governance alongside.** Do not skip
the per-item *Validate* step — skipping validation is the exact failure that produced Phase E.

---

## B. Why this exists — the Phase E tragedy

The **Phase E lock / `v0.15.0` release was premature and is not authoritative.** It validated a thin
technical slice — horizontal-overflow check, type-token floor, and a few **Ink-only** screenshots —
and declared "all PASS." It did **not**:

- test **Paper** mode at all (where a WCAG failure lives — see V2),
- consult the existing conformance review or its open issues (#34–#42),
- exercise mobile navigation (which is non-functional — see V3),
- catch the paraphrased locked tagline (V8) or the missing footer colophon (V1).

The result was governance theatre: a "locked v1.0.0" stamp on a surface with a live accessibility
failure, an unreachable mobile menu, and a broken-looking footer. **The standing rule for all work
below, and the thing Phase E violated, is:**

> Evidence is the **rendered surface**, in **Ink AND Paper**, at **1440 AND 390**. Status docs, task
> percentages, issue counts, and release tags are **not** evidence. No "ready" claim and no version
> re-stamp until the §K acceptance gate passes with **user sign-off on screenshots**.

`v0.15.0` is a checkpoint tag, not a layout lock. Treat it accordingly.

---

## C. Environment & setup (do this once)

**Repo:** `Tekrogen-Ghost-theme-mockup` (the mockup consumer + vendored DS components).
**DS source (for `upstream` work):** the separate `Tekrogen-Brand-Design-System` repo; components are
extracted to canonical `components/*` per **ADR-0011**, then vendored here as
`components/tk-components.css`.

**Key paths inside the mockup repo:**
- Consumer surface: `mockups/Tekrogen-Flywheel/index.html`
- Layout reference (the issue's named primary reference): root `index.html`
- Foundation tokens + Paper theme: `colors_and_type.css`
- Vendored components: `components/` (e.g. `footer/footer.css`, `content-card/content-card.css`,
  bundle `components/tk-components.css`)
- This plan: `admin/features/proposed/tekrogen-mockup-revamp/remediation-plan/`

**Serve (paths resolve relative to repo root — serve from there, not from the mockup subfolder):**
```bash
cd /Users/martiniquehdolce/dev/tekrogen/Tekrogen-Ghost-theme-mockup
python3 -m http.server 8000
# open http://localhost:8000/mockups/Tekrogen-Flywheel/index.html
```

**Toolchain PATH (required or husky/commitlint hooks silently no-op):**
```bash
export PATH="$HOME/.local/bin:/opt/homebrew/bin:$HOME/Library/pnpm:$PATH" && eval "$(fnm env 2>/dev/null)"
# expect: node v24.16.0, pnpm 11.5.3
```

**Visual re-validation harness (CDP):** `pkill` any existing Chrome instances first, then drive
headless Chrome to screenshot each affected screen at **1440** and **390**, toggling the surface
control to capture **Ink** and **Paper**. Commit the screenshots next to this plan (see §K).

**Git discipline (this repo's established workflow):**
- `git fetch && git merge --ff-only origin/main` (do NOT `git pull` — rebase config fails on a dirty tree).
- One issue → one **typed branch** → conventional commits → PR with a conventional **title**.
- Stage assertion before every commit: `git diff --cached --name-only` must show exactly the expected files.
- **Pathspec commits** to protect the staged set: `git commit -m "type: subject" -- <paths>`.
- CI gates: `claude-review`, `stamp-check`, `font-guard` (static + CPL). Squash-merge — the PR title
  is the only conventional commit release-please sees, so **don't mix change types** in one branch.
- **NEVER** add `Co-Authored-By: Claude` to any commit (CLAUDE.md Rule #1).

---

## C.1 Upstream handoff runbook (DS → mockup) — required for V3, V5, V13

`upstream` items change a component, which lives in the **Brand Design System**, not here. Do not
edit the vendored `components/` in this repo to "fix" a component (repo Rule #2/#3).

**DS source repo:** `Tekrogen-Brand-Design-System`
- local clone (sibling of this repo): `/Users/martiniquehdolce/dev/tekrogen/Tekrogen-Brand-Design-System`
- GitHub: `https://github.com/tekrogen/Tekrogen-Brand-Design-System`

**The loop:**
1. In the DS repo: make the **additive** change (new isolated component dir/structure per ADR-0011;
   never edit an existing component/schema in place). Open a DS issue → typed branch → PR there.
2. Re-vendor into this repo (verified command, run **from the DS repo root** — the two repos are
   siblings):
   ```bash
   cp -R components/. ../Tekrogen-Ghost-theme-mockup/components/
   ```
   Keep `colors_and_type.css` at **DS parity** (it carries DS tokens like `--tk-fg-on-accent`).
3. In this repo: wire the /econsumer (`mockups/Tekrogen-Flywheel/index.html`) to the new component.
   Separate issue → typed branch → PR. **Two repos = two PRs; don't bundle them.**

**Gotcha:** component dir/filenames are **UNPREFIXED** (`components/site-header/site-header.css`)
even though the classes are `tk-*` (`.tk-site-header`). Don't grep for a `tk-` directory.

**Issue status (verified live 2026-06-17 via `gh issue list`):** all nine are **OPEN** and map 1:1 to
the work orders.

| Issue | State | Work order | Priority label |
|-------|-------|------------|----------------|
| #34 | OPEN | V3 — mobile nav primitive | high · accessibility |
| #35 | OPEN | V1 — footer colophon | high |
| #36 | OPEN | V2 — Paper-mode AA accent | high · accessibility |
| #37 | OPEN | V6 — brand → home link | medium |
| #38 | OPEN | V7 — scope cyan to one affordance | medium |
| #39 | OPEN | V8 — locked tagline verbatim | medium |
| #40 | OPEN | V11 — Lucide docs icons | low |
| #41 | OPEN | V14 — version realign (v0.9.0 → v0.11.0) | medium |
| #42 | OPEN | V13 — interactive primitives (epic) | medium |

**Reconciliation notes (from the live list):**
- **V2 and V7 are two issues (#36 + #38) but one fix** (§F1). The `fix/36-paper-accent-aa` branch
  should close **both** — `Closes #36`, `Closes #38` — in the PR body.
- **#43 (CLOSED)** *is* the Phase E lock ("Flywheel v1.0.0 + project v0.15.0") — the premature lock
  V14 unwinds. **#45 (OPEN)** wants to propagate `v0.15.0` into CLAUDE.md version pointers;
  **reconcile #45 with V14/#41 before acting** — do not cement `v0.15.0` while V14 is realigning the
  stamp to the BDS release (v0.11.0).
- **V15 (doc drift) is evidenced by the issue log:** the VD-02…09 build issues
  (#16, #17, #20, #22, #24, #26, #28, #30) are all **CLOSED**, so the `mockups/CLAUDE.md` claim that
  "s2–s9 are stubs" is stale and must be corrected.
- Background: `admin/status/ghost-theme-mockup-validation-handoff-2026-06-14.md`.

---

## C.2 Validation & evidence harness (don't re-run the Phase E failure)

Evidence must be **comparable screenshots on disk**, not a "PASS" claim. Standardize them so every PR
produces the same artifacts.

**Capture (per affected screen):** `pkill` Chrome → serve → headless Chrome → screenshot at **1440**
and **390**, in **Ink** and **Paper** (Paper = click the surface-toggle "Paper" button, which sets
`data-tk-theme="paper"` on the stage).

**Folder + naming convention** (commit beside this plan):
```
remediation-plan/screenshots/<work-order>/<screen>-<surface>-<width>.png
# e.g.  screenshots/v1-footer/s1-paper-390.png ,  screenshots/v2-accent/s7-paper-1440.png
```
Use `before/` + `after/` subfolders where a comparison helps.

**Minimal Playwright starter** (adapt — install Playwright in a scratch dir, don't add it to the repo):
```js
const { chromium } = require('playwright');
const base = 'http://localhost:8000/mockups/Tekrogen-Flywheel/index.html';
const screens = ['s1','s7','s9'];                 // the screens your work order touched
for (const w of [1440, 390]) {
  const b = await chromium.launch();
  const p = await b.newPage({ viewport: { width: w, height: 1200 } });
  await p.goto(base);
  for (const surface of ['ink','paper']) {
    if (surface === 'paper') await p.click('.surface-toggle button[data-surface="paper"]');
    for (const s of screens) {
      await p.click(`.shell-tab[aria-controls="${s}"]`).catch(()=>{}); // select the screen tab
      await p.screenshot({ path: `screenshots/<wo>/${s}-${surface}-${w}.png`, fullPage: true });
    }
    if (surface === 'paper') await p.click('.surface-toggle button[data-surface="ink"]');
  }
  await b.close();
}
```

**`contrast-audit.md` template** (columns match §J; commit at gate time):
```md
| Element | Surface | Token → Color | Measured ratio | AA (>=4.5 text / >=3 UI)? | Screenshot |
|---------|---------|---------------|----------------|---------------------------|------------|
| .eyebrow | Paper | --tk-fg-3 #6b7280 | x.x:1 | yes/no | screenshots/v2-accent/... |
```

**Subjective items close on sign-off, not merge.** V4 (rhythm), V9 (hero), V10 (header variant) are
design judgments: their acceptance artifact is a **screenshot signed off against the reference**
(see C.3), not code-merge alone. Capture the matching reference screen, classify each delta
keep-intentional vs. fix in `layout-delta-vs-reference.md` (V16), and get sign-off before close.

---

## C.3 Reference surfaces & anchor discipline

**Two references, different jobs — don't conflate them:**

- **`mockups/Claude-DT/index.html`** — the original 9-screen Flywheel, and it **links the registry**
  (`colors_and_type.css` + `components/tk-components.css`), so its `tk-*` elements are styled exactly
  like the subject. This is the **registry-styled "known good"** — use it for rhythm (V4), hero (V9),
  and header-variant (V10) comparisons.
- **root `index.html`** — the locked publication mockup and the issue's named **layout** reference,
  but it does **not** link the registry (inline styles). Compare it for **composition/hierarchy**
  (V16), not token fidelity.

**VD acceptance criteria** live in the VD specs at
`admin/features/proposed/tekrogen-mockup-revamp/visual-domains/` (FEAT-VD-00...09). When closing a fix,
map it to its VD AC there (footer -> VD-00; home rhythm -> VD-01; etc.) rather than inventing AC IDs.

**Harness caveat — the "font problem that isn't":** the review harness chrome (`.shell-bar`, surface
toggle, wing swatches) does **not** port to the Ghost theme. On mobile, harness overflow can trigger
Safari shrink-to-fit zoom and read as a false "font" bug. Validate **theme content inside `#stage`**;
treat `.shell-bar` overflow as out of scope (per `mockups/CLAUDE.md`). Confirm
`documentElement.scrollWidth === clientWidth` at 390.

**Anchor discipline:** line numbers here were verified 2026-06-17, but the consumer file drifts as it
is edited (e.g. `.frame-url b` moved from the originally-cited L65 to ~L74). **Grep the cited
selector; don't trust the line number.** Re-verify anchors after any material edit to
`mockups/Tekrogen-Flywheel/index.html`.

---

## D. Global rules every change must satisfy

1. **Token-only.** No new color/spacing/radius/shadow literals. Use `--tk-*` (and the existing
   `--wing-accent` knob only where specified). New value needed → it belongs in the DS, not the consumer.
2. **Theme-aware accents.** Any accent used **as text** must resolve to an AA color on **both**
   surfaces. The DS already provides this via `--tk-accent` (Ink cyan → Paper `#086a6f`) and the
   muted floor `--tk-fg-3`. Raw `--tk-cyan`/`--wing-accent` as text on Paper is forbidden (V2).
3. **One cyan per surface.** Cyan is reserved for the single primary affordance (the CTA fill).
   Decorative accents use the muted mono treatment (V7).
4. **Type & contrast floors.** ≥12px type floor; `--tk-fg-3` text-color floor; no regressions.
5. **Mark tilt is 18° once.** The mark SVG bakes the 18° tilt — never add a second CSS rotate
   (`.stamp` violates this — V12).
6. **Additive-only upstream.** New isolated component structures; never edit existing component
   files/schemas in place. Re-vendor after.
7. **Both surfaces, both breakpoints, every time.** Ink + Paper × 1440 + 390 is the validation unit.
8. **Reachability & keyboard.** Every interactive destination must be reachable, focusable, and
   keyboard-operable, with a visible `:focus-visible` ring.

---

## E. Work-order index

Effort key: **S** ≈ <½ day · **M** ≈ ½–1½ days · **L** ≈ 2–4 days (includes a new DS primitive).

| ID | Title | Sev | Layer | Effort | Depends on | Branch |
|----|-------|-----|-------|--------|-----------|--------|
| **V2+V7** | Paper-mode accent AA + cyan scope | High (a11y) | consumer | S | — | `fix/36-paper-accent-aa` |
| **V1** | Footer colophon (©, RSS, Contact) | High | consumer | S | — | `fix/35-footer-colophon` |
| **V3** | Mobile navigation primitive | High | upstream+consumer | L | — | `feat/34-mobile-nav` |
| **V6** | Brand lockup → home link | Med | consumer | S | — | `fix/37-brand-home-link` |
| **V8** | Locked tagline verbatim | Med (voice) | consumer | S | — | `fix/39-locked-tagline` |
| **V5** | Card interaction affordance | Med | upstream+consumer | M | — | `feat/38-card-affordance` |
| **V4** | Vertical rhythm / section spacing | Med | consumer | M | — | `fix/vd01-section-rhythm` |
| **V9** | Hero composition balance (S1) | Med | consumer | M | V4 | `fix/vd01-hero-balance` |
| **V10** | Production header variant demo | Med | consumer+docs | M | — | `docs/header-variant-map` |
| **V16** | Layout delta vs root `index.html` | Med | docs | M | — | `docs/layout-delta-vs-reference` |
| **V11** | Lucide docs icons (S7) | Low–Med | consumer | S | — | `fix/40-lucide-docs-icons` |
| **V12** | Remove `.stamp` rotate + off-table glyphs | Low | consumer | S | — | `fix/stamp-rotate-glyphs` |
| **V13** | Interactive primitives (port-queue) | Med (port) | upstream | L | — | `feat/42-interactive-primitives` |
| **V14** | Version realignment + un-lock | Gov | governance | S | R1 done | (disk edit) |
| **V15** | Doc-drift reconcile (CLAUDE.md/stubs) | Gov | governance | S | — | (disk edit) |

Suggested PR grouping: ship V6+V8 as one `fix:` PR (both tiny, same type). Everything else is its own
branch/PR so the squashed conventional title maps cleanly to one release note.

---

## F. R1 — High (blocks the Ghost-theme foundation)

### F1 · V2 + V7 — Paper-mode accent AA + cyan scope
`High (a11y)` · `consumer` · `S` · `fix/36-paper-accent-aa` · depends-on: none

**Problem.** Four selectors paint the editorial accent (`--wing-accent`, raw cyan) directly as text.
Paper is applied to the stage only and `--wing-accent` never flips, so on Paper they render cyan
(`#1fd5da`) at ≈ **1.4:1** on `#f3f5f7` — a **WCAG 1.4.3 failure**. The same cyan landing on multiple
elements per screen is also the "cyan inflation" complaint (V7).

**Evidence.**
- `:root{--wing-accent:var(--tk-cyan)}` — `index.html:37`
- `.eyebrow{… color:var(--wing-accent)}` — `index.html:45`
- `.frame-url b{color:var(--wing-accent)}` — `index.html:74`  *(renders inside the paper stage → also fails)*
- `.principle .pn{… color:var(--wing-accent)}` — `index.html:119`
- `.toc a[aria-current]{… color:var(--wing-accent)}` — `index.html:133`
- Paper applied to stage only: `stage.setAttribute('data-tk-theme', …)` — `index.html:1028`
- The correct theme-aware token already exists: `--tk-accent: var(--tk-cyan)` (Ink, `colors_and_type.css:177`)
  → `--tk-accent: #086a6f` (Paper, `colors_and_type.css:310`, annotated **5.8:1 / 6.4:1 — AA**).

**Fix.** Re-point the three *editorial* accents to the theme-aware `--tk-accent`; **demote the
decorative eyebrow** to the muted mono floor `--tk-fg-3` (kills cyan inflation and is AA on both
surfaces). Leave `--wing-accent` driving only the CTA fill (`index.html:80–81`) and the harness wing
ring (`index.html:82`).
```css
/* L45  */  - .eyebrow{ … color:var(--wing-accent); … }
            + .eyebrow{ … color:var(--tk-fg-3); … }
/* L74  */  - .frame-url b{color:var(--wing-accent);font-weight:500}
            + .frame-url b{color:var(--tk-accent);font-weight:500}
/* L119 */  - .principle .pn{ … color:var(--wing-accent); … }
            + .principle .pn{ … color:var(--tk-accent); … }
/* L133 */  - .toc a[aria-current]{ … color:var(--wing-accent); … }
            + .toc a[aria-current]{ … color:var(--tk-accent); … }
```
**Do NOT** touch L37, L80–81, or L82. (Why `--tk-accent`, not flipping `--wing-accent`: `--tk-accent`
already flips inside `[data-tk-theme="paper"]`, the selector on the stage; the targets live inside the
stage so they inherit `#086a6f` automatically. Flipping `--wing-accent` would clobber the runtime
wing selection in Paper and is the wrong lever for text.)

**Acceptance.**
- [ ] On Paper, every former-cyan text accent measures ≥ 4.5:1 (record in `contrast-audit.md`, §J).
- [ ] On Ink, exactly one cyan affordance (the CTA) per screen; eyebrows read muted-mono.
- [ ] No change to Ink legibility of `.principle .pn` / active TOC.

**Validate.** Screenshot S1, S7 (TOC), and any `.principle` screen in Ink + Paper at 1440 + 390.

---

### F2 · V1 — Footer colophon
`High` · `consumer` · `S` · `fix/35-footer-colophon` · depends-on: none

**Problem.** All nine footers end after the pillar columns — no ©, RSS, or Contact. Reads as broken;
RSS is functionally required for a Ghost publication.

**Evidence.** `<footer class="tk-footer" data-style="nav">…</footer>` closes right after
`[data-tk-slot="top"]` — first instance `index.html:366`; no `[data-tk-slot="colophon"]` anywhere.
The colophon slot is **already styled and is not variant-scoped**: `.tk-footer [data-tk-slot="colophon"]`
— `footer/footer.css:67–82`. So this is **markup-only**; do not re-vendor.

**Fix.** Add this row as a sibling **after** `[data-tk-slot="top"]`, inside **each** of the nine
footers:
```html
<div data-tk-slot="colophon">
  <span>&copy; 2026 Tekrogen &middot; Martinique Dolce</span>
  <nav aria-label="Colophon">
    <a href="#">Colophon</a>
    <a href="#/rss">RSS</a>
    <a href="#">Contact</a>
  </nav>
</div>
```

**Acceptance.**
- [ ] Colophon present on all nine footers, its own `border-top` row, mono-uppercase `--tk-fg-4`.
- [ ] Renders correctly Ink + Paper at 1440 + 390 (stacks tidily on mobile).

**Validate.** Screenshot the S1 and S9 footers in all four states.

---

### F3 · V3 — Mobile navigation primitive
`High` · `upstream + consumer` · `L` · `feat/34-mobile-nav` · depends-on: none

**Problem.** At ≤768px the primary nav is hidden with **no** menu toggle, so all seven destinations
are unreachable on a phone. The code comment even concedes the real theme needs a toggle here.

**Evidence.** `.tk-site-header [data-tk-slot="nav"]{display:none}` — `index.html:234` (inside the
`@media(max-width:768px)` block opening at `index.html:222`). Masthead structure:
`brand / nav / util` slots — `index.html:300–306`.

**Fix.** Build a DS **Navigation** primitive (full spec in **Appendix L**), re-vendor, then wire it
into the masthead. Replace the bare `display:none` with the toggle-driven disclosure. Summary:
- Upstream: new `components/navigation/navigation.{css}` extracted per ADR-0011 — a menu-toggle
  button + disclosure panel, token-only, additive.
- Consumer: add the toggle button to each masthead `[data-tk-slot="util"]`; the panel reveals the
  existing nav + Search at ≤768px.

**Acceptance.**
- [ ] At 390, every nav destination **and** Search reachable via a real control.
- [ ] `aria-expanded`/`aria-controls` correct; Enter/Space toggles; Esc closes; focus is managed.
- [ ] Touch target ≥ 44px; visible `:focus-visible` ring; no horizontal overflow introduced.
- [ ] Token-only; obeys the 18°/no-double-tilt rule.

**Validate.** Keyboard-only walkthrough at 390 (open, traverse, close); screenshot open + closed in
Ink + Paper.

---

## G. R2 — Medium (brand + UX conformance)

### G1 · V6 — Brand lockup → home link
`Med` · `consumer` · `S` · `fix/37-brand-home-link` (pair with V8)

**Problem.** The masthead brand is a non-clickable `<div>`, breaking the strongest web convention.
**Evidence.** `<div data-tk-slot="brand">…</div>` — `index.html:301`, repeated on all nine mastheads.
**Fix.** Change the wrapper to an anchor on every screen; keep the inner mark + wordmark unchanged:
```html
- <div data-tk-slot="brand"><img …/><span data-tk-slot="wordmark">Tekrogen</span></div>
+ <a data-tk-slot="brand" href="#/"><img …/><span data-tk-slot="wordmark">Tekrogen</span></a>
```
**Acceptance.** [ ] Brand links home on all nine; focusable; no layout shift; no double underline
(foundation strips `<a>` underlines, components opt back in).
**Validate.** Tab to the brand on S1; confirm focus ring + activation.

### G2 · V8 — Locked tagline verbatim
`Med (voice)` · `consumer` · `S` · `fix/39-locked-tagline` (pair with V6)

**Problem.** The hero H1 paraphrases the locked brand tagline; the paraphrase is also baked into OG/
Twitter meta.
**Evidence.** H1 `We build real solutions to real problems.` — `index.html:322`; meta echoes —
`index.html:23`, `index.html:29`. DS locks: **`Real solutions. Built, proven, ready to use.`**
**Fix.** Replace the H1 and both meta strings with the locked tagline verbatim. If the descriptive
line is wanted, demote it to a supporting dek (`.lead`) beneath the H1 — do not let it stand in for
the tagline.
**Acceptance.** [ ] H1 + OG + Twitter all read the locked tagline verbatim; [ ] no other paraphrase
remains (grep the file for "real problems").
**Validate.** View S1; inspect `<head>` meta.

### G3 · V5 — Card interaction affordance
`Med` · `upstream + consumer` · `M` · `feat/38-card-affordance`

**Problem.** Featured-study cards read as static: border-tint-on-hover only, no lift, no shadow, no
cursor, no focus ring, and the cards aren't links.
**Evidence.** `.tk-content-card{ … transition:border-color … }` — `content-card.css:14`;
`.tk-content-card:hover{ border-color: color-mix(...) }` — `content-card.css:21`; cards not wrapped in
`<a>` (S1/S2 markup). Full spec in **Appendix M**.
**Fix.** Consumer: wrap each card in a whole-card `<a>`. Upstream (`content-card.css`, additive):
extend `transition` beyond `border-color` to `transform` + `box-shadow`; add a subtle
`--tk-shadow-*` lift + `transform: translateY(-2px)` on `:hover`; add a `:focus-visible` ring; keep
the token-driven border-tint as the resting/base treatment. Re-vendor.
**Acceptance.** [ ] Whole card is a link; [ ] hover shows lift + shadow + pointer cursor + border
tint; [ ] keyboard focus shows a visible ring; [ ] motion respects `prefers-reduced-motion`.
**Validate.** Hover + tab through S1/S2 cards in Ink + Paper.

### G4 · V4 — Vertical rhythm / section spacing
`Med` · `consumer` · `M` · `fix/vd01-section-rhythm`

**Problem.** Two tight gaps. (1) In the hero, the CTA row (`.hero-cta`) sits almost flush against the
stats block (`.tk-stats`) — the buttons and the `24 / 52` numbers nearly touch (caught in the V2
review at `screenshots/v2-accent/s1-ink-390.png`; visible at 1440 too). (2) The stats row then butts
against the next section head with too little air; inter-section cadence across the home and channels
is tight and uneven.
**Evidence.** Hero column `.hero-copy` > `.hero-cta` (`index.html:323`) → `.tk-stats`
(`index.html:328`) with no separating space; stats then immediately precede a `.tk-section-head`
(`index.html:357`); section heads recur (`index.html:393, 488–510, 704–747`). CSS hero/section
spacing — `.hero{…}` `index.html:107`.
**Fix.** Introduce a consistent rhythm step on the DS spacing scale: (1) add vertical space between
`.hero-cta` and `.tk-stats` (e.g. `margin-top: var(--tk-space-10)` on `.tk-stats`, or a larger
`.hero-copy` column gap); (2) add top spacing (`--tk-space-16`/`--tk-space-20`) above each
`.tk-section-head`, and even the stats→featured gap. Do the home (S1) first as the rhythm reference,
then propagate to s2–s9. Token-only; no literals.
**Acceptance.** [ ] Even vertical cadence between all home sections; [ ] stats no longer crowd the
next head; [ ] rhythm reads consistent on s2–s9.
**Validate.** Full-page screenshots of S1 (and one channel) at 1440 + 390, Ink + Paper.

### G5 · V9 — Hero composition balance (S1)
`Med` · `consumer` · `M` · `fix/vd01-hero-balance` · depends-on: V4

**Problem.** The flywheel diagram floats in a large dark void; the text column and diagram column read
as disconnected, leaving dead space.
**Evidence.** Hero grid `.hero{…}` — `index.html:107` (responsive at `206`, `239`); flywheel diagram
`.tk-flywheel` — `index.html:335`.
**Fix.** Rebalance the hero: size/position the diagram to hold the right column (scale up, or anchor
to a shared baseline), or reflow the grid proportions so copy + diagram read as one composition. No
new tokens; adjust grid template + diagram scale within the existing scale.
**Acceptance.** [ ] No large dead void on the right at 1440; [ ] columns read as one unit; [ ] mobile
stacks cleanly with the diagram sized for 390.
**Validate.** S1 hero screenshots at 1440 + 390, Ink + Paper, side-by-side with root `index.html`.

### G6 · V10 — Production header variant demo
`Med` · `consumer + docs` · `M` · `docs/header-variant-map`

**Problem.** Every surface uses `data-style="framed"` (the in-frame device mock); the DS **default**
sticky+blur production header is never demonstrated, so the port team can't see the real header.
**Evidence.** Mastheads use `data-style="framed"` — `index.html:299` (and each screen).
**Fix.** For the live-preview templates that ship the production header, render the default
`tk-site-header` (sticky + blur). Keep `framed` only where the in-frame device mock is intentional.
Add a short mapping table (in this repo) of **which header variant maps to which Ghost template**.
**Acceptance.** [ ] At least the home/preview shows the production sticky header; [ ] variant→template
map committed; [ ] sticky/blur behaves at 1440 + 390 without overlap bugs.
**Validate.** Scroll-capture the production header; confirm sticky + blur in Ink + Paper.

### G7 · V16 — Layout delta vs root `index.html`
`Med` · `docs` · `M` · `docs/layout-delta-vs-reference`

**Problem.** The originating issue names root `index.html` as the *primary* layout reference, but no
screen-by-screen composition comparison exists — so "does the rendered layout match the reference" is
unanswered.
**Evidence.** Reference: root `index.html` (the locked publication mockup). Subject: the nine Flywheel
screens.
**Fix.** Produce `layout-delta-vs-reference.md` beside this plan: for each screen, a short table of
hierarchy / grid / spacing-rhythm / typographic deltas vs. the reference, with paired screenshots.
Flag any divergence as keep-intentional or fix-and-fold-into-V4/V9.
**Acceptance.** [ ] All nine screens compared; [ ] each delta classified (intentional vs. defect);
[ ] defects cross-linked to a work order.
**Validate.** Document + paired screenshots committed.

---

## H. R3 — Low / polish & port-queue

### H1 · V11 — Lucide docs icons (S7)
`Low–Med` · `consumer` · `S` · `fix/40-lucide-docs-icons`

**Problem.** S7 docs category tiles use 2-letter monograms (IN/AP/TU/RN/VS/CP), which are neither
Lucide nor an approved glyph set.
**Evidence.** S7 category grid `cat-grid` — markup `index.html:816` (CSS `index.html:191`).
**Fix.** Replace the letter tiles with Lucide outline icons (download, code, graduation-cap,
file-text, git-branch, user), stroke 1.5, `currentColor`, per **ADR-0005**. **Delivery: inline SVG**
(paste each Lucide glyph's SVG markup), consistent with the DS Component Gallery — not a CDN
font/script and not an icon-font dependency. Icons only on product surfaces (S7 qualifies);
brand/marketing stays icon-free.
**Acceptance.** [ ] Each category uses the mapped Lucide glyph; [ ] stroke 1.5 + `currentColor`;
[ ] AA in Ink + Paper.
**Validate.** Screenshot S7 category grid in both surfaces.

### H2 · V12 — Remove `.stamp` rotate + off-table glyphs
`Low` · `consumer` · `S` · `fix/stamp-rotate-glyphs`

**Problem.** `.stamp` adds a decorative `rotate(-3deg)` — a second rotation idiom (only the 18° mark
tilt is sanctioned); a few glyphs (`⊘ ⌕ ●`) sit outside the documented table.
**Evidence.** `.stamp{… rotate …}` — `index.html:147`; stray glyphs in S7/S9.
**Fix.** Remove the `.stamp` rotation. Reconcile the stray glyphs: substitute approved/Lucide glyphs,
or (if they're load-bearing) add them to the DS glyph table via the DS, not the consumer.
**Acceptance.** [ ] No CSS rotate except the baked 18° mark; [ ] every glyph is on the approved table.
**Validate.** Visual diff S7/S9 before/after.

### H3 · V13 — Interactive primitives (port-queue)
`Med (port)` · `upstream` · `L` · `feat/42-interactive-primitives`

**Problem.** The screens imply DS primitives that don't exist yet, so the Ghost port will hit gaps.
**Evidence.** Pagination implied by `.pager` — `index.html:436` (S2); Checkbox/Select in S9 forms;
Tabs/Accordion in S7 docs/TOC; Tooltip/Toast in S9; Alert to formalize from `.tk-callout` —
`index.html:557, 579`. Roadmap detail in **Appendix N**.
**Fix.** Build the missing DS primitives (Pagination, Checkbox, Select, Tabs, Accordion, Tooltip,
Toast, Alert) upstream, additive, token-only, per the component gap-analysis roadmap; re-vendor.
**This does not block the visual layout lock** — it's staged ahead of the Ghost port.
**Acceptance.** [ ] Each primitive built, documented (slots + states), a11y-checked, re-vendored;
[ ] the implying screens consume the real primitive.
**Validate.** Per-primitive specimen in Ink + Paper at 1440 + 390.

---

## I. Governance (runs alongside; pure disk edits)

### I1 · V14 — Version realignment + un-lock
`Gov` · depends-on: R1 merged & validated.
Realign the Flywheel self-stamp to the vendored BDS release; stop treating `v0.15.0` as a lock (it's a
checkpoint). No re-stamp until the §K gate passes with user sign-off. **Acceptance:** version markers
reflect the BDS release; no "locked" claim in any status doc until the gate passes.

### I2 · V15 — Doc-drift reconcile
`Gov`. `mockups/CLAUDE.md` still says only VD-00/VD-01 are built and s2–s9 are stubs, and the inline
comment at `index.html:371` still says "placeholders," but s2–s9 are populated. Reconcile both to the
built state so the "three days produced an incomplete surface" narrative is judged against reality.
**Acceptance:** CLAUDE.md + the inline comment match what's actually built.

---

## J. WCAG contrast — measured

Normal text ≥ 4.5:1; large/UI ≥ 3:1. Paper page bg `--tk-bg-1: #f3f5f7` (cards lift on
`--tk-bg-2:#ffffff`). Fix-side teal ratios are the DS's own annotations (`colors_and_type.css:307–310`).
On completion, commit the re-measured values as `remediation-plan/contrast-audit.md` — the gate is
satisfied by measured numbers on disk, not by this table.

| Element | Surface | Before | Ratio | After | Ratio | Verdict |
|---------|---------|--------|-------|-------|-------|---------|
| `.eyebrow` | Paper | `#1fd5da` | ~1.4:1 ✗ | `--tk-fg-3` `#6b7280` | ~4.7:1 | PASS |
| `.principle .pn` | Paper | `#1fd5da` | ~1.4:1 ✗ | `--tk-accent` `#086a6f` | 5.8:1 | PASS |
| `.toc a[aria-current]` | Paper | `#1fd5da` | ~1.4:1 ✗ | `--tk-accent` `#086a6f` | 5.8:1 | PASS |
| `.frame-url b` | Paper | `#1fd5da` | ~1.4:1 ✗ | `--tk-accent` `#086a6f` | 5.8:1 | PASS |
| same accents | Ink | `#1fd5da` | AA | unchanged via `--tk-accent` | AA | PASS |

---

## K. Master acceptance gate — "ready for the Ghost theme"

All R1 + R2 merged and **re-validated in Ink AND Paper at 1440 AND 390**, with:

- [ ] **Paper a11y:** every accent ≥ AA; no raw cyan text on light; measured ratios committed (`contrast-audit.md`).
- [ ] **Mobile nav:** every destination + Search reachable via a real, keyboard-operable control.
- [ ] **Footer:** colophon (©, RSS, Contact) on every screen.
- [ ] **Cyan scope:** exactly one cyan affordance (the CTA) per surface on Ink.
- [ ] **Cards:** unmistakably interactive (hover lift + focus ring + cursor + link wrap).
- [ ] **Brand + tagline:** logo links home on all nine; locked tagline verbatim in H1 + meta.
- [ ] **Rhythm:** consistent section cadence (V4) and balanced hero (V9).
- [ ] **Layout parity:** screen-by-screen delta vs. root `index.html` shows the same hierarchy,
      spacing rhythm, and typographic language (V16).
- [ ] **Evidence on disk:** re-validation screenshots (Ink+Paper, 1440+390) committed beside this plan.
- [ ] **Governance:** version realigned to BDS (V14); CLAUDE.md doc-drift reconciled (V15).
- [ ] **User sign-off on the screenshots** — not on documentation.

R3 (V11–V13) and the port-queue primitives may trail the gate; they do not block the layout lock but
must close before the Ghost theme ships.

---

## L. Appendix — Navigation primitive spec (V3)

A new, additive DS component. Build in the BDS source per ADR-0011, re-vendor, then consume.

**Slot contract** (extends the masthead, which already has `brand / nav / util`):
```
tk-nav-toggle               # the hamburger <button> (visible ≤768px)
  data-tk-slot="toggle"
tk-nav-panel                # the disclosure container revealed on open
  data-tk-slot="panel"
    [data-tk-slot="nav"]    # the existing primary nav, re-homed into the panel ≤768px
    [data-tk-slot="search"] # Search, brought into the panel ≤768px
```

**Markup (consumer wiring, per masthead).** Add the toggle into `[data-tk-slot="util"]`; give the
existing `<nav data-tk-slot="nav">` an `id` so the toggle can control it:
```html
<button class="tk-nav-toggle" data-tk-slot="toggle"
        aria-label="Menu" aria-expanded="false" aria-controls="site-nav-s1">
  <!-- Lucide "menu" outline, stroke 1.5, currentColor; swaps to "x" when open -->
</button>
<nav id="site-nav-s1" data-tk-slot="nav"> … existing links … </nav>
```
(Use a unique id per screen: `site-nav-s1` … `site-nav-s9`.)

**CSS (upstream, token-only).** Desktop unchanged; ≤768px the toggle appears and the nav collapses
into a panel:
```css
.tk-nav-toggle{ display:none; }                 /* desktop: hidden */
@media(max-width:768px){
  .tk-nav-toggle{
    display:inline-flex; align-items:center; justify-content:center;
    width:44px; height:44px;                      /* ≥44px touch target */
    background:transparent; border:var(--tk-border-1);
    border-radius:var(--tk-radius-md); color:var(--tk-fg-1); cursor:pointer;
  }
  .tk-nav-toggle:focus-visible{ outline:2px solid var(--tk-focus); outline-offset:2px; }
  .tk-site-header [data-tk-slot="nav"]{
    display:none;                                  /* closed state */
    position:absolute; inset-inline:0; top:100%;
    flex-direction:column; gap:var(--tk-space-2);
    padding:var(--tk-space-4) var(--tk-gutter-sm);
    background:var(--tk-bg-1); border-bottom:var(--tk-border-1);
  }
  .tk-site-header[data-nav-open="true"] [data-tk-slot="nav"]{ display:flex; }  /* open */
  .tk-site-header[data-nav-open="true"] [data-tk-slot="search"]{ display:flex; }
}
```
Replaces the bare `[data-tk-slot="nav"]{display:none}` at `index.html:234`.

**Behavior (JS).** Toggle flips `aria-expanded` on the button and `data-nav-open` on the header; Esc
closes and returns focus to the toggle; clicking a link or outside closes. Respect
`prefers-reduced-motion` (no slide animation when reduced).

**Reference implementation (adapt; one block can wire every masthead):**
```js
document.querySelectorAll('.tk-nav-toggle').forEach(function (btn) {
  var header = btn.closest('.tk-site-header');
  function setOpen(open) {
    header.setAttribute('data-nav-open', open ? 'true' : 'false');
    btn.setAttribute('aria-expanded', open ? 'true' : 'false');
  }
  btn.addEventListener('click', function () {
    setOpen(header.getAttribute('data-nav-open') !== 'true');
  });
  // Esc closes and returns focus to the toggle
  header.addEventListener('keydown', function (e) {
    if (e.key === 'Escape' && header.getAttribute('data-nav-open') === 'true') {
      setOpen(false); btn.focus();
    }
  });
  // close on link activation or outside click
  header.querySelectorAll('[data-tk-slot="nav"] a').forEach(function (a) {
    a.addEventListener('click', function () { setOpen(false); });
  });
  document.addEventListener('click', function (e) {
    if (!header.contains(e.target)) setOpen(false);
  });
});
```
This is harness/wiring JS for the mockup; the production Ghost theme re-implements the same contract
in its own template script.

**a11y acceptance:** keyboard open/traverse/close works; focus visible throughout; `aria-controls`
resolves; nothing reachable by mouse is unreachable by keyboard.

---

## M. Appendix — Card affordance spec (V5)

**Consumer** — wrap each featured-study card in a whole-card link (keep the `data-pillar` on the card
for the hover accent):
```html
<a class="tk-content-card" data-pillar="org" href="#/studies/slug"> … head/desc/rel … </a>
```
(If the card must stay a non-anchor element for layout reasons, wrap it in an `<a>` with
`display:block` instead — but the whole card must be the click target.)

**Upstream** (`content-card.css`, additive — extends, doesn't replace, the existing rules at lines
7–21):
```css
.tk-content-card{
  /* was: transition:border-color var(--tk-dur-2) var(--tk-ease); */
  transition:border-color var(--tk-dur-2) var(--tk-ease),
             box-shadow   var(--tk-dur-2) var(--tk-ease),
             transform    var(--tk-dur-2) var(--tk-ease);
  text-decoration:none; color:inherit;            /* when the card itself is the <a> */
}
.tk-content-card:hover{
  /* keep the existing border-color color-mix tint, and add: */
  box-shadow:var(--tk-shadow-2);
  transform:translateY(-2px);
}
.tk-content-card:focus-visible{
  outline:2px solid var(--tk-focus); outline-offset:2px;
}
@media(prefers-reduced-motion:reduce){
  .tk-content-card{ transition:border-color var(--tk-dur-2) var(--tk-ease); }
  .tk-content-card:hover{ transform:none; }
}
```
(If `--tk-shadow-2` isn't in the token set, use the nearest defined `--tk-shadow-*`; do not invent a
literal shadow.)

**Acceptance:** pointer cursor + lift + shadow + border tint on hover; visible focus ring on keyboard;
reduced-motion users get the tint without the lift; the entire card activates the link.

---

## N. Appendix — Interactive primitives roadmap (V13, port-queue)

Build upstream, additive, token-only; document slots + states; re-vendor; then have the implying
screen consume the real primitive. None blocks the layout lock.

| Primitive | Implied by | Min. states / slots | a11y must-haves |
|-----------|-----------|---------------------|-----------------|
| Pagination | S2 `.pager` (`index.html:436`) | prev/next/current/disabled; page links | `aria-current="page"`; disabled not focusable |
| Checkbox | S9 forms | unchecked/checked/indeterminate/disabled/focus | real `<input>`; label association; focus ring |
| Select | S9 forms | closed/open/selected/disabled/focus | keyboard open + arrow nav; `aria-expanded` |
| Tabs | S7 docs | active/inactive/focus | `role="tablist/tab/tabpanel"`; arrow-key nav |
| Accordion | S7 TOC | collapsed/expanded/focus | `aria-expanded`; Enter/Space; heading buttons |
| Tooltip | S9 copy/submit | hidden/visible | hover **and** focus trigger; Esc dismiss; not hover-only |
| Toast | S9 submit | enter/visible/leave | `role="status"`/`aria-live`; auto-dismiss + manual close |
| Alert | formalize `.tk-callout` (`index.html:557,579`) | info/success/warning/danger | `role` per severity; AA on both surfaces |

Each ships with a Component Gallery specimen and passes the Ink+Paper / 1440+390 check before the
Ghost port consumes it.

---

*Prepared 2026-06-17 from the live rendered surface, the vendored components, and `colors_and_type.css`
on disk. Every anchor, token value, and contrast figure is reproducible by serving the repo and
inspecting the cited `file:line` in both surfaces at both breakpoints. This document is authoritative
for **what must be fixed and how**; it is not evidence that any fix is done — that comes only from the
§K gate with user sign-off on screenshots.*


---

## Addendum B — Spacing standard, evidence convention, re-sequencing (2026-06-18)

Added after the V2/#47 review. Cross-references the relevant sections above; nothing earlier is
deleted.

### B1 · Spacing & visual rhythm is now a standing standard (not just V4)

Spacing/rhythm is elevated from a per-screen cleanup to a **project-wide standard**, ratified in the
DS as **ADR-0013** (`Tekrogen-Brand-Design-System/adr/0013-spacing-and-rhythm-standard.md`, Status:
Proposed) and applied here via `remediation-plan/SPACING-AND-RHYTHM-STANDARD.md`. Add to the **§D
global rules**:

> **9. Spacing by relationship, from the scale.** All `margin`/`padding`/`gap` = `var(--tk-space-*)`;
> the step is chosen by the relationship between elements (proximity), not by eye. Gap *between*
> groups ≥ one step larger than gaps *within* a group (SP-2). See ADR-0013 / the spacing standard.

### B2 · New work order — V17 · Apply the spacing standard project-wide

`Med` · `consumer (+ DS scale if a step is missing)` · `M` · `fix/spacing-standard-rollout`

**Problem.** Spacing was applied by feel; equivalent relationships render different gaps across
surfaces. First confirmed instance: home (s1) — the CTA cluster (**Explore Case Studies / View
Demos**) sits too close to the **24/52/11/06** stats row (SP-2 proximity violation).
**Fix.** Apply ADR-0013 SP-1…SP-7 across all nine screens: token-only spacing, proximity-driven group
gaps, one consistent section-gap step, heading bind-down, ≥44px targets. Fix the s1 CTA→stats gap
first as the reference.
**Acceptance.** `spacing-audit.md` committed; SP-2 holds (between-group ≥ within-group + 1 step);
section gaps identical across surfaces (SP-3/SP-6); targets ≥44px at 390 (SP-5).
**Validate.** Full-page screenshots Ink+Paper × 1440+390 + the spacing audit.

(V4 "vertical rhythm" remains the home-first slice of this; V17 is the project-wide rollout. The s1
CTA→stats gap is logged under both.)

### B3 · Evidence convention upgraded — reviews should take 30 seconds, not 20 minutes

Supersedes the bare full-page capture in §C.2. For each layout/visual work order, commit under
`remediation-plan/screenshots/<wo>/`:

- `before/<screen>-<surface>-<width>.png` — captured from `origin/main` **before** the change.
- `after/<screen>-<surface>-<width>.png` — after the change. (Both, all four states.)
- `callouts/<element>-<surface>.png` — a **cropped** close-up of each changed element.
- `REVIEW.md` — a one-line-per-change index: *what changed*, before→after, with the callout path.
  The reviewer reads `REVIEW.md` and the callouts; full-page shots are backup, not the review surface.

Rationale: V2's evidence was correct but unreviewable — twelve full-page shots, no before/after, no
callouts, and the frames still showed unfixed later-work-order items. The work was right; the artifact
made it look like nothing changed.

### B4 · Re-sequenced sprint — front-load the visible wins

V2/#47 (Paper-AA accent + cyan scope) is **done and merge-ready** (audited, AA on both surfaces). New
order, chosen so the surface visibly advances early:

1. **V2 + V7 / #36+#38** — done; merge #47.
2. **V8 + V6 / #39+#37** — locked tagline (verbatim) + brand→home link. One `fix:` PR. Highest visible
   payoff for near-zero effort: the headline stops being wrong.
3. **V1 / #35** — footer colophon (©, RSS, Contact). The footer stops looking broken.
4. **V4 + V17** — spacing standard: s1 CTA→stats first, then the project-wide rollout.
5. **V9** — hero balance (depends on V4).
6. **V3 / #34** — mobile nav primitive (the one true upstream build; do after the §C.1 loop is confirmed).
7. R2 remainder (V10, V16) → R3 (V11, V12, V13) → governance (V14, V15).

### B5 · Acceptance gate (§K) gains a spacing pass

Add to §K: **Spacing** — SP-1…SP-7 hold on every changed surface; `spacing-audit.md` committed;
no equivalent relationship renders different gaps across surfaces.
