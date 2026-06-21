# Changelog

All notable changes to the **Tekrogen Ghost Theme Mockup** project are recorded
here. Format follows [Keep a Changelog](https://keepachangelog.com/); this is a design
mockup project, so versions track design milestones rather than shipped software.

> **Note on dates:** earlier milestones predate this changelog and their exact dates were
> not recorded — they are marked *(date not recorded)*. Everything from the
> brand-compliance pass onward is dated accurately.

## [Unreleased]

### Pending (awaiting go-ahead)
- **Polish #8 — tokenize hardcoded hexes.** Map inline pillar hexes and hardcoded
  Paper-mode neutrals (`#e6ebef`, `#f3f5f7`, `#0a0d12`) to their `--tk-*` tokens to
  remove palette-drift risk. Visually invisible.
- **Polish #9 — keyboard accessibility.** Give nav links real `href`s and convert
  search / chips / anchors from `<div>`s to real links/buttons so they are focusable
  and the brand focus ring applies.

---

## [0.15.0] — 2026-06-17

Project milestone: the **VD-spec Flywheel surface** (`mockups/Tekrogen-Flywheel/index.html`) is
complete and locked. All nine screens (s1–s9) are built one spec at a time from the
`visual-domains/` FEAT-VD-00…09 briefs, consuming the vendored design-system registry, and the
surface passes the Phase E acceptance gate (static token audit · responsive render @1440 + @390 ·
brand audit · 3-expert pass). The Flywheel surface is bumped to its own **v1.0.0**.

### Added
- **Flywheel screens s2–s9** — Case Studies (VD-02), Use Case Study reader (VD-03), Recon (VD-04),
  Demo/POC + first membership gate (VD-05), Product & licensing (VD-06), Documentation &
  distribution (VD-07), About (VD-08), Membership & account (VD-09). Each landed via its own
  issue→branch→PR clearing the Rule #4 gate, with an `admin/review/VALIDATION-s*-vd*.md` record.
- **DS asset-pack wired into the Flywheel surface** (#32) — vendored the social/OG cards
  (`og-default/article/author/series`), publication logos, `icon-512` and inverse mark; wired the
  `<head>` with favicon + `mask-icon` + `apple-touch-icon`, Open Graph + Twitter Card meta, and a
  documented Ghost Settings→Design slot map + per-template OG mapping for the theme handoff.

### Fixed
- **Double-tilted harness mark** — the shell-bar `.brand img` re-applied an 18° CSS rotate on top of
  the already-18°-baked `tekrogen-mark.svg` (36° total); removed the redundant rotate.

### Removed
- **Dead `.todo` placeholder CSS** in the Flywheel surface — all nine screens are built, so the stub
  styling is unused.

### Docs
- **CLAUDE.md** documents the Flywheel as the third mockup surface and adds **Rule #4** (the 3-expert
  review + DS validation gate). **recon-content-model.md** corrects the Use Case Study pillar
  (`.studio` → `.org`).

## [0.14.1] — 2026-06-13

Dead-CSS cleanup: removed the now-inert bespoke component CSS in `mockups/Claude-DT/index.html` left behind by the C1–C7 registry migration (issue #9).

### Removed
- **201 fully-dead CSS rules (~21 KB)** across the file's three `<style>` blocks — every rule whose selector roots in a class no longer present in the markup (migrated to `tk-*`): `.card`/`.lcard`/`.tcard`/`.mcard`/`.cat`, `.site-head`/`.site-nav`/`.site-foot`/`.wordmark`, `.sec-head(-sm)`, `.stat(s)`, `.callout`/`.cta-block`, `.flywheel`/`.fw-*`, `.prod-hero2`/`.price-block`/`.tier`/`.license-grid`/`.feat(-grid)`, `.demo-meta`/`.preview`/`.shots`/`.artifacts`/`.arow`, `.docs-hero`/`.dist`/`.dnode`/`.vtl`/`.vrow`, `.member-ladder`/`.mstep`/`.auth-card`/`.dash*`/`.orders`/`.confirm`, plus `.pill-mono`/`.chip`/`.tag`/`.pbtn`/`.field(-row)`/`.form`/`.var-com`/`.var-net`.

### Kept (deliberately)
- Live harness/layout/state CSS and 4 **mixed** responsive rules that still serve live classes (`.hero`/`.prod-features`/`.ucs`, `.cards`/`.manifesto`/`.cat-grid`, `.acct-grid`/`.conf-grid`, `.reqform .tk-input`) — a few inert comma-groups (`.prod-hero2`, `.docs-hero`, …) remain in those, harmless.

### Verified
- No behavior change: every screen renders identically (migrated `tk-*` elements style from the linked registry, not this inline CSS; removed rules had zero markup references). Computed-style + screenshot spot-checks across s1/s6/s9 on both migrated and live-bespoke elements. All three `<style>` blocks brace-balanced.

## [0.14.0] — 2026-06-13

C7 membership migration: the `Claude-DT` mockup's s9 account surface now consumes the **C7 composites** (registry PR #44). This completes the composites batch (C1–C7) — the mockup is fully on the registry.

### Changed
- **Access ladder → `tk-member-ladder`** (`.mstep var-X` → `[data-tk-slot="step"]` + `data-pillar`; `.st` →
  state slot; `<ul>` → features slot; `.no` → `data-state="excluded"`). **Sign-in / register → `tk-auth-card`**
  (`.sub-head` → head slot, scoped to the cards). **Member dashboard → `tk-dashboard`** (`.av` → `tk-avatar`;
  `.tier` → `.role`; `.dash-head/body/side/main` → slots; orders `.orders` table → `tk-table`). **Purchase
  confirmation → `tk-confirm`** (com-keyed).
- Picks up **`--tk-fg-on-accent`** in `colors_and_type.css` (synced from the DS) — the dashboard avatar's
  initials now resolve white from the token (closes the avatar `#fff` crack, DS #19).
- Scoped renames preserved the 3 standalone sub-screen `.sub-head` labels and shared `.sub`/`.k`/`.v`/`.fineprint`.

### Deferred
- Now-inert bespoke membership CSS (`.member-ladder`/`.mstep`/`.auth-card`/`.dash*`/`.confirm`/…) → shared dead-CSS cleanup.

## [0.13.0] — 2026-06-13

C6 distribution migration: the `Claude-DT` mockup's s7 documentation surface now consumes the **C6 composites** (registry PR #42).

### Changed
- **Docs hero (s7) → `tk-docs-hero`** (body + search slot + pipeline aside). **Distribution pipeline →
  `tk-pipeline`** (`.dist`/`.dh`/`.nodes`/`.dnode`/`.darrow` → slots head/nodes/node/arrow; active stage →
  `data-state="active"`; net-keyed). **Version history → `tk-version-timeline`** (`.vtl` → container with
  `data-tk-slot="title"`; `.vrow` → `data-tk-slot="row"`; net-keyed).
- Leaf classes (`.n`/`.nm`/`.sub`/`.vn`/`.date`/`.vbody`/`.vchips`/`.dl`) kept — the registry styles them as
  slot descendants. Verified shared leaves unchanged (`.nm`/`.n`/`.sub`/`.dl`/`.date` counts held).

### Deferred
- Now-inert bespoke distribution CSS (`.docs-hero`/`.dist`/`.dnode`/`.vtl`/`.vrow`/…) → shared dead-CSS cleanup.

## [0.12.0] — 2026-06-13

C5 commerce migration: the `Claude-DT` mockup's product + demo surfaces now consume the **C5 composites** (registry PR #40).

### Changed
- **Product hero (s6) → `tk-product-hero`** (price-block amt/from/term/lic + ✓ summary + striped visual;
  com-keyed). **License matrix (s6) → `tk-license-tier`** (4 tiers in `tk-license-grid`; featured Standard
  → `data-variant="featured"` ribbon + com ring; `.no` items → `data-state="excluded"` ✗; `<ul>` →
  `data-tk-slot="features"`; slots name/price/desc/cta). **Feature grid (s6) → `tk-feature-grid`** (6 cards).
- **Demo (s5): meta strip → `tk-demo-meta`** (k/val → key/val slots, mono via data-mono), **preview →
  `tk-demo-preview`**, **shots → `tk-demo-shots`/`tk-demo-shot`**, **artifact downloads → `tk-artifact-list`**
  (gate header + name/size/dl rows; studio-keyed lock; ADR-0006 trust-state partial).
- Scoped slot renames so shared classes elsewhere are untouched — verified: s9 membership badge
  (`<div class="tier">`, C7), section-head `.desc`, and non-C5 `.nm`/`.k` all preserved.

### Deferred
- Now-inert bespoke commerce CSS (`.prod-hero2`/`.tier`/`.feat-grid`/`.artifacts`/…) left this pass → shared dead-CSS cleanup.

## [0.11.0] — 2026-06-13

C4 flywheel migration: the `Claude-DT` mockup's signature flywheel + position steppers now consume the **C4 composites** (registry PR #38).

### Changed
- **Home flywheel → `tk-flywheel`** (s1). The 8-node SVG drops bespoke inline `stroke="var(--tk-*)"`
  for `data-arc`/`data-node` + `data-pillar`; arc/node colors and the `data-tk-slot="core"` center
  label resolve from `flywheel.css` (token chain CI-clean). **Position steppers → `tk-flywheel-stepper`**
  (s6 Products, s7 Documentation): `.fw-step var-X done|here` → `[data-tk-slot="step"]` + `data-pillar`
  + `data-state`; `.n`/`.nm` → `num`/`name` slots. Verified on-brand (s1 pillar arcs `#446e88`/`#6491ac`,
  core fill fg-1; stepper done-state pillar borders).

### Deferred
- Now-inert bespoke `.flywheel`/`.fw-svg`/`.fw-stepper`/`.fw-step` CSS left this pass → shared dead-CSS cleanup.

## [0.10.0] — 2026-06-13

C3 cards migration: the `Claude-DT` mockup's cards now consume the **C3 composites** (registry PR #36).

### Changed
- **Content cards → `tk-content-card`** (6; head/desc/rel slots, data-pillar). **Listing cards →
  `tk-listing-card`** (4). **Pillar buttons → `tk-pillar-button`** (4). **Category cards →
  `tk-category-card`** (6). **Team cards → `tk-team-card`** (2; avatar → `tk-avatar[data-style="mono"]`,
  sized inline). **Manifesto cards → `tk-manifesto-card`** (4). Per-card scoped slot renames
  (`.row`→head, `.desc`/`.rel`/`.ind`/`.label`/`.name`/`.ic`/`.links`/`.role` → slots). Verified on-brand
  (s1 pillar buttons + content cards; s8 manifesto + team cards w/ mono 44px avatar).

### Deferred
- Now-inert bespoke C3 CSS left this pass → shared dead-CSS cleanup. Dashboard `.av` (s9) stays for C7.

## [0.9.0] — 2026-06-13

C2 data & forms migration: the `Claude-DT` mockup consumes the **C2 composites** (registry PR #34).

### Changed
- **Tables → `tk-table`** (bespoke `.tk-table` core removed; registry applies; `.tk-table .chosen`
  kept as a recon helper). **Forms → `tk-form`/`tk-field`/`tk-field-row`** (10 fields, 3 forms).
  **Callouts → `tk-callout`** (2, `data-pillar` where keyed). **CTA blocks → `tk-cta-block`** (2,
  `.row` → `data-tk-slot="actions"`). **Stats → `tk-stat`/`tk-stats`** (4; value now `--tk-fs-h2`
  ≈ 28px vs the old 34px — a minor scale normalization). Verified on-brand (recon table + callout,
  computed-style checks).

### Deferred
- Now-inert bespoke C2 CSS (`.form`/`.field`/`.callout`/`.cta-block`/`.stat`) left this pass —
  folded into the same dead-CSS cleanup as C1.

## [0.8.0] — 2026-06-13

C1 structural migration: the `Claude-DT` mockup's header, footer, section heads, and mono labels
now consume the design-system **C1 composites** (registry PRs #30/#32).

### Changed
- **Header → `tk-site-header[data-style="framed"]`** across all 9 screens (brand/nav/util slots;
  mark sized inline 28px). **Footer → `tk-footer[data-style="nav"]`** (brand + four pillar link
  columns; mark 40px). **Section heads → `tk-section-head`** (12 instances, incl. `data-size="sm"`).
  **Mono labels → `tk-label`** (51: pill-mono→pill, `.chip`→`data-variant="chip"`+pillar,
  `.tag`→`data-variant="tag"`). Header/footer adopt the canonical `tekrogen-org` design (the chosen
  "canonical default") in their framed/nav variants — a deliberate brand-alignment, verified on-brand.

### Deferred
- The now-inert bespoke CSS (`.site-head`/`.site-foot`/`.sec-head*`/`.pill-mono`/`.chip`/`.tag`,
  etc.) is left in place this pass (no matching elements; harmless) — a follow-up cleanup removes it.

## [0.7.0] — 2026-06-13

Component migration: the `Claude-DT` mockup now **consumes the design-system component
registry** (`components/`) instead of bespoke CSS — the first surface to do so, validating
the mockup→theme bridge (ADR-0012).

### Changed
- **`mockups/Claude-DT/index.html` migrated to `.tk-*` registry classes** (v0.5.0): all
  buttons → `tk-button` with the **editorial `data-style="cta"`** variant (sans, mixed-case —
  look preserved) composing `data-pillar` / `data-variant="secondary"` / `data-tk-slot="hint"`;
  badges → `tk-badge[data-pillar]` (tinted pill + dot); inputs → `tk-input`. Default CTAs keep
  following the harness `--wing-accent` knob and form inputs stay full-width via small local
  consumer overrides. Verified visually equivalent to v0.6.0 (only intended deltas: CTA padding
  snapped to `--tk-space-*` ≤2px; inputs adopt the registry's a11y-correct 16px + `--tk-bg-3`).
- **Re-vendored `components/`** from the design system (pillar-aware primitives + button
  `data-style="cta"` / `hint` slot).

### Removed
- The mockup's bespoke `.btn` / `.badge` / `.inp` / `.btn-block` CSS blocks (now provided by the
  registry). `.av` avatars **deferred** to the composites batch (mono-vs-sans initials).

## [0.6.0] — 2026-06-13

Foundation sync to **Tekrogen Brand Design System** parity, brand-integrity fixes, and the
vendored component registry — the base for the upcoming component migration.

### Added
- **Self-hosted font set (ADR-0008).** Full brand weights — Poppins 400–800 + italic
  400/500/600, Manrope 400–700, JetBrains Mono 400–700 — added to `fonts/` as latin-subset
  woff2 (was Regular-only). No remote font dependency.
- **Component registry vendored** from the design system into `components/` (button, card,
  input, badge, avatar + the `tk-components.css` barrel); linked from
  `mockups/Claude-DT/index.html`.

### Changed
- **`colors_and_type.css` brought to full design-system parity** (478 lines / 128 tokens):
  adopts the ADR-0007 rem-fluid type scale (eyebrow/meta now hold the 12px floor; headings
  fluid) and adds 20 previously-missing tokens (`--tk-focus`, `--tk-success-text`,
  `--tk-mark-*`, `--tk-og-*`, `--tk-shell-max`, `--tk-fs-og-title`). This shifts type
  rendering on both surfaces — intended parity, matching the real theme + WCAG 1.4.4.
- **`mockups/README.md` build brief corrected**: Nunito → Manrope (sans-only, ADR-0001/0008);
  "Research Hub" reframed as the Recon hub; "Ratings" removed (no scores — the v0.5.0 Recon
  model).

### Removed
- **Google Fonts CDN** `<link>`/`@import` from `index.html` and `mockups/Claude-DT/index.html`
  — zero remote font dependencies; all weights self-hosted (ADR-0008).

---

## [0.5.0] — 2026-06-05

Content-model overhaul: collapsed the seven content **types** into five top-level
**categories**, introduced **Recon**, and removed scored **Tech Rating**. Rationale and
per-screen plan in `recon-content-model.md`.

### Added
- **Recon** — a new category that unifies the former Research Article + SaaS Evaluation work
  into one qualitative, multi-source "justify the stack" category. Includes a unified Post
  Details reader template (research framing → candidate comparison → sources → chosen stack,
  no scores) and a Recon lane on the Topic page.
- `recon-content-model.md` — decision record for the move to Recon.

### Changed
- **Seven types → five categories** across every screen: Use Case Study · Recon · Product ·
  Demo / POC · Documentation. Reworked the Home feed, Topics dropdown, Topic page, Library
  (now "Index of Five"), and Post Details accordingly.
- Library grid rebalanced to a clean 6-cell 3×2 layout (5 category cards + 1 merged CTA).

### Removed
- **Tech Rating** and all numeric scoring (six-axis rubric, `x.x/10` scores, score bars) —
  Tekrogen does not rate evaluated resources; the stack decision belongs to stakeholders.
- Standalone **Research Article** and **SaaS Evaluation** types — folded into Recon.

### Notes
- `.score-mini` / `.score-panel` CSS is now unused; retained for a later cleanup pass.

---

## [0.4.2] — 2026-06-03

### Changed
- Generalized `CLAUDE.md` Rule 1 to ban any `Co-Authored-By: Claude Opus …`
  co-author trailer (previously named only the `4.7 (1M context)` variant).
- Bumped the `index.html` version meta to `v0.4.2`.

---

## [0.4.1] — 2026-06-03

Repository restructure — flattened the project layout and added standard project
metadata. No design changes.

### Changed
- Retired the `tekrogen/` working directory and flattened its contents into
  top-level folders: foundations CSS to the repo root (`colors_and_type.css`),
  web fonts to `fonts/`, runtime scripts to `scripts/` (`image-slot.js`,
  `palette.js`), and brand marks to `assets/` (`tekrogen-icon-256.svg`,
  `tekrogen-mark.svg`).

### Added
- `LICENSE` — MIT License (© 2025 Tekrogen).
- `.gitignore` — OS, editor, and tooling ignore rules.
- `.gitattributes` — `* text=auto` for cross-platform LF normalization.
- `CLAUDE.md` — repository guide for Claude Code (architecture, conventions, brand rules).

### Removed
- Duplicate `tekrogen/favicon.svg` — the canonical copy lives at
  `assets/favicon.svg`.

---

## [0.4.0] — 2026-06-03

Housekeeping + canonical entry point.

### Changed
- Promoted the corrected mockup to **`index.html`** as the canonical Ghost-theme entry
  point (formerly `Ghost Theme Mockup v03.html`); cleared the version suffix from
  `<title>`.
- Renamed the four review screens to plain, prefix-free labels — **Home Page**,
  **Topic Page**, **Library Page**, **Post Details Page** — across the tab bar and the
  `data-screen-label` attributes. Internal `data-dir` routing keys (A–D) and the LOCKED
  badge on Home Page were preserved.

### Added
- `CHANGELOG.md` (this file).

### Moved
- Archived `Ghost Theme Mockup v02.html` (pre-compliance baseline) to `archive/`.
- Archived `Ghost Theme Wireframes.html` (low-fi homepage-layout sketch) to `archive/`.

---

## [0.3.0] — 2026-06-03

Brand-compliance pass against the Tekrogen Brand Design System. Produced from v02;
shipped as v03 (now `index.html`). Full audit in `Brand Compliance Checklist.md`.

### Fixed
- **Wordmark** — publication header and footer now use the mixed-case **Tekrogen**
  wordmark (Poppins 600, `-0.01em`), not the locked all-caps `TEKROGEN` (which the brand
  reserves for marketing surfaces).
- **Iconography** — removed off-vocabulary glyphs `★ ✱ ▶`; spotlight tags now read as
  words (*Featured / Product / Live demo*) and the comparison table uses the approved
  `✓` glyph.
- **Elevation** — the Topics dropdown now uses the sanctioned `var(--tk-shadow-2)`
  recipe instead of an ad-hoc `0 20px 50px` shadow.
- **Radii** — off-scale `14px` corners (browser frame, hero image, post cards) snapped
  to `var(--tk-radius-xl)` (12px).

### Changed
- **Default surface → Ink.** The mockup now opens in Ink (the brand's primary surface);
  Paper remains one click away via the header toggle and Tweaks panel.
- **Default author → M. Dolce** across all bylines, the `MD` avatar, the citation block,
  and the copyright line.

### Added
- `Brand Compliance Checklist.md` — the full audit with per-item status.

### Confirmed (no change)
- **One cyan per surface** is satisfied by design: `--wing-accent` is swapped to each
  entity's pillar color per surface; House cyan is the `.org`/default lead, demonstrated
  via the Tweaks panel.
- Token layer matches the canonical Tekrogen palette value-for-value (no drift).

---

## [0.2.0] — *(date not recorded)*

### Added
- `Ghost Theme Mockup v02.html` — the high-fidelity mockup: four IA directions
  (Home / Topic / Library / Post Details), the seven content types, the Ink/Paper
  surface toggle, and the Tweaks panel (wing accent · surface · density). Built on the
  Tekrogen design tokens (`tekrogen/colors_and_type.css`).
- `README.md` — project overview.

---

## [0.1.0] — *(date not recorded)*

### Added
- `Ghost Theme Wireframes.html` — low-fidelity wireframes used to define the homepage
  layout and compare the candidate directions before the hi-fi pass.
