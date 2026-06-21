# Visual-Domain Feature Specs — Tekrogen Ghost Custom Theme Mockup

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen (scoped via `/workflow:ultrathink`)
**Builds on:** [`_planning-specs/INDEX.md`](../_planning-specs/INDEX.md) (Publishing System scope), `mockups/README.md` (Flywheel build brief)
**Structure model:** [`mockups/Claude-DT/index.html`](../../../../../mockups/Claude-DT/index.html) (9 screens, s1–s9)
**Upstream source of truth:** `Tekrogen-Brand-Design-System` (the `tk-*` registry + `colors_and_type.css` + ADRs)

---

## What this directory is

One **feature spec per visual domain** of the Tekrogen custom Ghost Pro theme. Each spec
takes a screen from the **Claude-DT flywheel surface** (the rehearsal mockup), names the
**Ghost template** it becomes, and pins down the **layout anatomy, registry components, content
model, membership gating, responsive behaviour, and acceptance criteria** needed to lock the
design *before* the theme is implemented in Ghost.

These are **design/IA specs for the mockup**, not Ghost implementation tickets. The mockup is
the artifact that gets reviewed and locked; the `.hbs` theme is built from the locked mockup
plus the DS's vendored `.hbs` partials (ADR-0012).

> **Scope boundary.** Per repo Rule #2 and CLAUDE.md: this surface **consumes** the vendored
> `tk-*` registry — it does not author or "fix" components here. Component gaps are fixed
> upstream in the DS and re-vendored. Every spec references real registry components by name.

---

## The spec set

| Spec | Visual domain | Claude-DT screen | Ghost template | Pillar | Layer (INDEX §5.3) |
|------|---------------|------------------|----------------|--------|---------------------|
| [VD-00](FEAT-VD-00-global-chrome-foundations.md) | Global chrome & foundations | header/footer/flywheel (all) | `default.hbs` + partials | all | cross-cutting |
| [VD-01](FEAT-VD-01-landing-home.md) | Landing / Home | s1 | `home.hbs` | all | L1–L7 surface |
| [VD-02](FEAT-VD-02-case-study-channel.md) | Case-study channel (listing) | s2 | `channel-use-case-studies.hbs` | org | L1 |
| [VD-03](FEAT-VD-03-use-case-study-reader.md) | Use Case Study reader | s3 | `custom-use-case-study.hbs` | org | L1 |
| [VD-04](FEAT-VD-04-recon-research-reader.md) | Recon / Research reader | s4 | `custom-recon.hbs` | org | L1 |
| [VD-05](FEAT-VD-05-demo-proof-of-concept.md) | Demo / Proof of Concept | s5 | `custom-proof-of-concept.hbs` | studio | L2 |
| [VD-06](FEAT-VD-06-product-licensing.md) | Product & licensing | s6 | `custom-product.hbs` | com | L3–L4 |
| [VD-07](FEAT-VD-07-documentation-distribution.md) | Documentation & distribution | s7 | `channel-documentation.hbs` | net | L6–L7 |
| [VD-08](FEAT-VD-08-about-static-page.md) | About / static page | s8 | `page.hbs` | org | — |
| [VD-09](FEAT-VD-09-membership-account.md) | Membership & account | s9 | members + `account.hbs` | com/net | L4–L5 |

Read **VD-00 first** — it defines the chrome, tokens, flywheel, pillar rule, and accessibility
baseline that every other domain inherits.

---

## Best practices for building this Ghost theme mockup

Synthesized from the **Ghost CMS Architect** brief, the **DS / UI-UX review** brief, the DS
ADRs, and the existing Claude-DT surface. These are the guardrails every VD spec is written to.

### 1. Design to the Ghost template hierarchy, not to pages

Each visual domain must map to a **real Ghost construct** — a context the platform already
renders — so the mockup ports without routing hacks (Ghost expert: *prefer native routing,
avoid theme-based workarounds*).

| Mockup need | Ghost construct | File |
|---|---|---|
| Front page | `@site` + curated loops | `home.hbs` |
| A content reader (study/recon/demo/product) | post with a **custom template** selected per-post | `custom-*.hbs` |
| A category index | a **collection/channel** defined in `routes.yaml` | `channel-*.hbs` / `tag.hbs` |
| A static page (About) | a Ghost **page** | `page.hbs` |
| Account / login / dashboard | Ghost **Portal** + members context | `{{#if @member}}`, `account.hbs` |

Custom templates are justified only where the default `post.hbs` cannot carry the structure
(Ghost expert decision rule). The four readers each carry a fixed multi-section format that
`post.hbs` cannot encode — that justifies `custom-use-case-study.hbs`, `custom-recon.hbs`,
`custom-proof-of-concept.hbs`, `custom-product.hbs`.

### 2. Channels come from `routes.yaml` collections, not hardcoded lists

The five-category model (Use Case Study · Recon · Product · Demo/POC · Documentation) is
expressed as **internal tags** (`#feature-use-case-study`, `#feature-proof-of-concept`,
`#feature-product`, `#feature-product-detail`) mapped to **collections** with custom
`channel-*.hbs` templates. URL strategy (recommend the INDEX routes): `/use-case-studies/`,
`/recon/`, `/poc/`, `/products/`, `/docs/`. The mockup's listing screens (s2, s7) stand in for
these collection templates.

### 3. The four-pillar colour rule is the structural contribution

Per INDEX §4.1 and ADR-0011's one-cyan-per-surface rule: **every content type renders one
dominant pillar colour** (`data-pillar="org|studio|com|net"`), and **cross-pillar CTAs carry
the *destination's* colour** to signal forward motion through the flywheel (e.g. a study's
"Get the template" button is `.com` teal). `--wing-accent` is the single editorial accent knob;
components key off `data-pillar` / `--tk-cyan` directly. Never hardcode a pillar hex.

### 4. Membership is native Ghost, three states

Anonymous → free member → paid member (INDEX L4). Use **native Portal, native tiers, native
gating** (`{{#unless @member}}` to hide downloads; `{{#if @member.paid}}` for product
artifacts) — not a third-party membership system. The mockup shows all three states on one
surface (s9) and the gate component (`tk-artifact-list[data-tk-slot="gate"]`) on demos/products.

### 5. Commerce is the one honest gap — show it as an integration boundary

Ghost memberships are **subscriptions**, not a one-time digital-product store. One-time license
sales (MIT/Standard/Extended/Team) route through **LemonSqueezy/Stripe** checkout, with license
key + download delivered to email and the customer portal (s7 pipeline, s9 confirmation). The
mockup renders these as **UI placeholders at a labelled integration seam** — it does not imply
Ghost natively sells licenses. This matches the INDEX "Knowledge & Process Gap" list.

### 6. Server-rendered, minimal JS, accessible by default

Ghost is server-rendered; **avoid client frameworks inside the theme** (Ghost expert
performance standard). The mockup's only JS is harness chrome (tab routing, surface toggle,
wing swatches) — **none of it ports to the theme**. Theme markup is semantic HTML with proper
heading hierarchy, keyboard-operable controls, visible focus (`--tk-focus`), and WCAG AA
contrast (the DS fg-scale is annotated for AA; `fg-4`/`fg-5` are decorative-only). Accessibility
is non-negotiable in both expert briefs.

### 7. Typography & assets follow the locked ADRs

Sans-only — Poppins + Manrope fallback + JetBrains Mono for technical labels (ADR-0001);
fluid rem type scale (ADR-0007); **self-hosted woff2, no font CDN** (ADR-0008); Lucide icons in
product UI, mono Unicode glyphs on brand surfaces (ADR-0005); the approved glyph vocabulary only
(`✓`, mono unicode — no `★ ✱ ▶`). Mixed-case **Tekrogen** wordmark in Poppins 600.

### 8. The flywheel is the navigational spine

Every domain answers "where am I in the flywheel, and what's next." The hero flywheel
(`tk-flywheel`), the per-page stepper (`tk-flywheel-stepper` with `data-state="done|here"`), and
the cross-pillar paired CTA (`tk-cta-block`, the ADR-0006 trust-state primitive) make the
Use Case → Recon → Demo → Register → Product → License → Download → Docs loop legible on a
single Ghost site.

### 9. SEO & content portability

Semantic structure, one `<h1>` per page, canonical URLs (`tekrogen.org/articles/{slug}/`),
metadata/social tags via Ghost's `{{ghost_head}}`. No structure that traps content in the theme
— readers map to Koenig-authored post content plus a custom template shell.

---

## How to read a VD spec

Each spec follows the repo's [`FEAT-TEMPLATE.md`](../../_templates/FEAT-TEMPLATE.md), tuned for a
visual domain:

- **Ghost mapping** — template, route, context, visibility, template-hierarchy justification.
- **Layout anatomy** — the section stack, top-to-bottom, keyed to the Claude-DT screen.
- **Registry components** — every `tk-*` used, with the exact `data-tk-slot` / `data-variant` /
  `data-pillar` / `data-state` axes (the real vocabulary, from the vendored registry).
- **Content & membership** — five-category model, gating state, `{{#foreach}}`/`{{#if @member}}`.
- **Responsive + accessibility** — breakpoints and AA obligations.
- **Acceptance criteria** — checkable, prefixed `AC-VDxx-…`.

---

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial spec-set scope: best-practices guardrails + 10 visual-domain specs | @tekrogen |
