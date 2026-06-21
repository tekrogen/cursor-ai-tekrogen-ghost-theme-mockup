# Spacing & Visual-Rhythm Standard (mockup application)

**Canonical source:** `Tekrogen-Brand-Design-System/adr/0013-spacing-and-rhythm-standard.md`
(ADR-0013). This file is the **mockup-side application** of that standard — the checklist a work order
runs and the audit artifact it produces. The BDS ADR is authoritative; if the two ever disagree, the
ADR wins.

## The seven rules (quick reference)

- **SP-1 Token-only** — all `margin`/`padding`/`gap` = `var(--tk-space-*)`; no literals. Missing step → add it to `colors_and_type.css`, never inline.
- **SP-2 Proximity** — gap *between* groups ≥ one step larger than gaps *within* a group. (The home CTA→stats gap is the first instance to fix.)
- **SP-3 Section rhythm** — one defined section-gap step between every major section, consistent across all surfaces.
- **SP-4 Headings bind downward** — space-above > space-below.
- **SP-5 Interactive minimums** — targets ≥ 44px; ≥ one base step between adjacent controls; check at 390.
- **SP-6 Consistency** — identical relationships use identical tokens everywhere.
- **SP-7 Validate rendered** — Ink + Paper × 1440 + 390; never assert from the stylesheet alone.

## When this standard applies

**Every work order that changes layout or adds/edits a surface** runs an SP check on the screens it
touches — not only the dedicated rhythm work order (V4/V17). Spacing conformance is part of the
acceptance gate (plan §K), the same way Paper-AA is.

## Spacing-audit artifact

For any layout-affecting work order, commit `spacing-audit.md` beside the screenshots, modelled on
`contrast-audit.md`:

```md
# Spacing audit — <work order>
**Surface:** mockups/Tekrogen-Flywheel/index.html · **Method:** measured on the rendered surface.

| Relationship | Within-group gap | Between-group gap | SP-2 (between ≥ within+1 step)? | Token used | Screenshot |
|--------------|------------------|-------------------|--------------------------------|------------|------------|
| CTA cluster → stats row (s1) | … | … | yes/no | var(--tk-space-…) | screenshots/<wo>/after/s1-ink-1440.png |

Section cadence (SP-3/SP-6): list each section gap + token; confirm identical across surfaces.
Targets (SP-5): confirm ≥44px at 390.
```

## First known instance

Home (s1): the primary-action cluster (**Explore Case Studies / View Demos**) sits too close to the
**24 / 52 / 11 / 06** stats row — an SP-2 proximity violation (two distinct groups reading as one).
Tracked under work order **V4** (and the project-wide rollout under **V17**); see plan Addendum B.
