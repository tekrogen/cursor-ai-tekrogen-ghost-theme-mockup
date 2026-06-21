# FEAT-VD-07: Documentation & Distribution

**Status:** Proposed
**Date:** 2026-06-14
**Author:** @tekrogen
**Related ADRs:** ADR-0011 (component model)
**Related screen:** Claude-DT **s7**
**Ghost template:** `channel-documentation.hbs` · **route:** `/docs/` (+ `/docs/{product}/`) · **context:** collection / page · **visibility:** public docs, **portal gated to paid** · **pillar:** `.net`
**Inherits:** [VD-00](FEAT-VD-00-global-chrome-foundations.md)

---

## Overview

The .net distribution layer — where the flywheel closes. Docs hub for a product: a search-led
docs hero, the **distribution pipeline** diagram (Ghost → LemonSqueezy → license → download →
portal), a category grid (install / API / tutorials / release notes / versioning / customer
portal), and a **version timeline** with per-release download links and breaking-change flags.

---

## Problem Statement

A buyer post-purchase (and an evaluator pre-purchase) needs install/API docs, a clear picture of
how delivery works, the release history with update-window implications, and a path to the
customer portal for keys and downloads.

### Current State

Claude-DT s7 renders `tk-flywheel-stepper` (07–08 "here"), `tk-docs-hero` (search + version meta)
beside a `tk-pipeline` (5-node distribution architecture), a `tk-category-card` grid (6), and a
`tk-version-timeline` with download links + non-breaking/breaking `tk-label` chips.

### Desired State

A locked `channel-documentation.hbs` that maps docs to Ghost content (pages or a docs collection),
renders the delivery pipeline as an integration diagram, and gates the customer-portal links to
paid members.

---

## Ghost Mapping

Two viable shapes — recommend **a `/docs/` collection** for per-product doc sets plus Ghost
**pages** for evergreen guides. **Template-hierarchy justification:** the docs hub layout (hero +
pipeline + category grid + version timeline) is a bespoke channel surface, justifying
`channel-documentation.hbs`. **Versioning** maps to release-note posts tagged per product +
version; **distribution** is an external pipeline (LemonSqueezy/portal) rendered as a diagram.
Customer-portal links gate on `{{#if @member.paid}}`. Per-product docs filter by a product tag.

---

## Layout Anatomy (keyed to s7)

1. **Masthead** — util shows **Customer portal** (`data-pillar="net"`).
2. **Flywheel stepper** — `tk-flywheel-stepper`; 01–06 `done`, 07–08 `here` (`.net`).
3. **Docs hero** — `tk-docs-hero`: `body` (badge `.net · distribution`, `h1`, `.lead`, `search`
   slot with `/`-key hint, version `tk-label` row) + `aside` slot holding the pipeline.
4. **Distribution pipeline** — `tk-pipeline[data-pillar="net"]`: `head` + `nodes` of 5
   `node` (Ghost Pro → LemonSqueezy → license key → **Download** `data-state="active"` → customer
   portal), `arrow` separators. The Ghost → checkout → delivery → portal architecture, visualized.
5. **Category grid** — `cat-grid` of 6 `tk-category-card[data-pillar="net"]`: icon + `h4` + desc +
   `links`: Installation · API reference · Tutorials · Release notes · Versioning policy ·
   Customer portal.
6. **Version timeline** — `tk-version-timeline[data-pillar="net"]`: `title` + `row`s (version +
   date, body, `vchips` of `tk-label[data-variant="tag"]` incl. **non-breaking / breaking**, a
   download link). Breaking releases flagged (warning colour `#e0a92c`), MIT demo row marked archive.
7. **Footer** — VD-00 F2 (with Releases link in the .net column).

---

## Registry Components

| Component | Axes used | Role |
|---|---|---|
| `tk-flywheel-stepper` | `data-state="done\|here"` | Position (07–08) |
| `tk-docs-hero` | slots `body`/`search`/`aside` | Search-led hero |
| `tk-pipeline` | `data-pillar`; slots `head`/`nodes`/`node`/`arrow`; `data-state="active"` | Delivery architecture |
| `tk-category-card` | `data-pillar`; slots `icon`/`links` | Doc category overview |
| `tk-version-timeline` | `data-pillar`; slots `title`/`row` | Release history |
| `tk-label` | `data-variant="tag"` | Version chips (non-breaking/breaking) |

---

## Content & Membership

- Pillar `.net` dominant throughout. Public docs (install/API/tutorials/release notes/versioning);
  **customer portal** (keys, download archive, license inventory, update windows) gates on
  `@member.paid`.
- Versioning policy is content: semver-with-caveats, update windows by tier, LTS. Breaking
  changes must be flagged with licensing implications.

## Responsive

- `≤1080px`: docs-hero → 1 col (pipeline below); category grid → 2 col → 1 at ≤640px.

## Accessibility

- Single `<h1>`. Search field has a `<label>`/`aria-label` (s7 includes `aria-label="Search docs"`).
  Pipeline `data-state="active"` reinforced by text. Breaking-change flags use text + icon, not
  colour alone (warning amber must not be the only signal).

## Acceptance Criteria

- [ ] AC-VD07-01: Stepper shows 07–08 "here" in `.net`; closes the flywheel.
- [ ] AC-VD07-02: Distribution pipeline renders the Ghost → LemonSqueezy → license → download → portal flow.
- [ ] AC-VD07-03: Category grid covers install, API, tutorials, release notes, versioning, portal.
- [ ] AC-VD07-04: Version timeline lists releases with dates, download links, and breaking/non-breaking flags (text + colour).
- [ ] AC-VD07-05: Customer-portal access gates on `@member.paid`.
- [ ] AC-VD07-06: `.net` dominant; AA in ink + paper at all breakpoints.

## Out of Scope

- Full doc article reader (could reuse `post.hbs`/`page.hbs`); real portal/repo/version tooling
  (INDEX §9 blocker — net repository/distribution methodology TBD).

## Related Documents

| Type | Reference | Purpose |
|------|-----------|---------|
| Index | [`_planning-specs/INDEX.md`](../_planning-specs/INDEX.md) §2, §5.3 (L6/L7), §9 | Distribution/versioning + blockers |
| Spec | VD-06 (product), VD-09 (portal/confirmation) | Delivery + account |

## Changelog

| Date | Change | Author |
|------|--------|--------|
| 2026-06-14 | Initial draft | @tekrogen |
