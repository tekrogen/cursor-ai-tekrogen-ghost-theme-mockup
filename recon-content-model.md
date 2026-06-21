# Feature: "Recon" — collapsing the content model from seven types to five categories

- **Status:** All four screens swept — pending visual sign-off, then version bump + release
- **Date:** 2026-06-03
- **Owner:** M. Dolce (@tekrogen)
- **Affects:** `index.html` — Home (Direction B), Topic Page (Direction C), Library (Direction A), Post Details (Direction D)

---

## 1. Why we moved to Recon

### The theme's underlying workflow

The Tekrogen theme isn't just a list of post types — it models a **delivery pipeline**:

> **Use Case Study** (the engagement) → **Recon** (research/justify the stack) → **Demo / POC**
> (build the proof) → *if validated* → **Product** (paid subscription, full app) →
> **Documentation** (operate it; the whole study is archived into the production package).

The **Research** phase of that pipeline is where we review frameworks, tools, and
applications and **justify the "Stack"** we then use to build the Demo. That research is
the thing the old content model fragmented across three separate types.

### The problem with the old model

The original "Index of Seven" treated these as three sibling content types:

| Old type | What it was | Reality |
|----------|-------------|---------|
| **Research Article** | Long-form, citation-grade, multi-source | The *survey* — landscape / "why" |
| **SaaS Evaluation** | Side-by-side teardown of candidate tools | The *comparison* — "which" |
| **Tech Rating** | Scored against a fixed six-axis rubric | The *verdict* — a number |

In practice these are **not three destinations — they are the same activity** at different
altitudes: scouting the field and the candidate tools so we can choose a stack for the
Demo. Splitting them buried "where the stack research lives" across three menu entries.

### Two decisions that shaped the result

1. **Unify the research/evaluation work under one category: "Recon."** Reconnaissance =
   scouting the landscape (research), scouting the tools (evaluation), and choosing what to
   build on — *before* the Demo. It fits the brand voice (terse, engineering-native, in the
   same family as our product marks **Spine** and **Facet**) and reads naturally as a
   pipeline phase: *"we ran recon, then built the demo."*

2. **Remove "Tech Rating" entirely.** We will **never assign a numeric tech rating** to a
   resource we've evaluated. Recon is **qualitative**: it narrows the field and documents
   tradeoffs, but the **final stack decision belongs to the stakeholders** — their existing
   skills and the client's constraints decide it, not a score. So the six-axis rubric, the
   `x.x/10` scores, and the score bars are gone.

### What Recon *is* and *isn't*

- **Is:** multi-source research + side-by-side comparison of tools/frameworks/methods, ending
  in a *chosen stack for the demo* and the reasoning behind it. Spans both ends of the old
  range — e.g. *"what are the common ways to embed video in a PDF/presentation?"* (methods
  research) and *"Python vs. Next.js for this API?"* (tool comparison).
- **Isn't:** a scored rubric, a ranking, or a final verdict. No ratings, ever.

---

## 2. The new content model

Seven content **types** → five top-level **categories / tags**:

| #  | Category           | Absorbs                                                    | Pillar                       |
|----|--------------------|------------------------------------------------------------|------------------------------|
| 01 | **Use Case Study** | —                                                          | `.org`                       |
| 02 | **Recon**          | Research Article  (Saas Evaluations, Tech Rating, removed) | `.org` (research, open work) |
| 03 | **Product**        | —                                                          | `.com`                       |
| 04 | **Demo / POC**     | —                                                          | `.studio`                    |
| 05 | **Documentation**  | —                                                          | `.net`                       |

> Note: "type" (a post's *layout*) and "category/tag" (how you *browse*) used to be the same
> axis. They still collapse 1:1 here — five categories, five reader layouts.

---

## 3. Implementation plan & status (by screen)

### ✅ Home (Direction B) — DONE
- **Topics dropdown:** merged `SaaS evaluations` + `Tech ratings` + `Research` into a single
  **Recon** entry.
- **Feed list:** three rows folded into Recon (the SaaS Evaluation, Research Article, and
  Tech Rating rows). Scores (`8.4/10`) and "six-axis re-rating" language removed.
- **Known cosmetic side-effect:** the 7-row sample feed now shows three "Recon" rows. Truthful
  (Recon absorbed three types) but possibly repetitive — may diversify the sample later.

### ✅ Topic Page (Direction C) — DONE
- **Lane 2 → "Recon"** (`§ 02 · 03 · 07 · Recon`): now leads with the featured citation-grade
  research card, followed by the candidate-comparison cards. All four cards relabeled `Recon`,
  **score bars removed**, reframed as stack-choice recons.
- **Lane 4 → "Documentation"** only (Research card moved up into Recon).

### ✅ Post Details (Direction D) — DONE (pending your sign-off on the layout)
- Built a **unified Recon reader template** (`02 · Recon · /recon/:slug`):
  research framing → **side-by-side "Candidates considered" table** (qualitative cells, no
  numbers) → **Sources** → **Decision → the stack**. Sidebar: *Chosen for the demo*,
  *Reconned* (scope, "no scores assigned"), *Final call depends on* (stakeholder skills +
  client constraints), and *Feeds → Demo* (the workflow link).
- **Removed** the Tech Rating template (score panel) and the standalone Research Article
  template. Renumbered to five templates; intro now reads *"Five categories, five detail
  layouts."*

### ✅ Library Page (Direction A) — DONE
- **Hero / counts:** "Index of Seven." → **"Index of Five."**; "Seven kinds of artifact" →
  "Five categories of work"; stat "07 Kinds of work" → "05 Categories"; section head
  "Index by content type" → "Index by category"; "7 types · …" → "5 categories · …".
- **Grid:** collapsed the three cards (SaaS Evaluation, Tech Rating, Research Article) into
  **one Recon card** (`var-org`, count 52, "All recon →"). Renumbered Product/Demo/Docs to
  03/04/05. Merged the two CTAs (Subscribe + Browse-all) into one, giving a clean **6-cell
  3×2 grid** (5 categories + 1 CTA).
- **"Recent across all" strip:** the `Tech rating · 8.4/10` and `SaaS evaluation` cards folded
  into **Recon**, scores stripped; head copy "all 7 kinds" → "all 5 categories".

### ✅ Strays cleaned across the whole file
- Topic Page featured kicker `Research · R12` → `Recon · R12`.
- Stale comments: `DIRECTION A — INDEX OF SEVEN` → `LIBRARY`; `DIRECTION D … (all 7 types)` →
  `(five categories)`; Library grid comment `9-CELL … 7 types` → `6-CELL … 5 categories`.
- **Note — dead CSS left in place (harmless):** `.score-mini` and `.post-mock .score-panel`
  rule blocks are now unused (no markup references them). Left for a later cleanup pass to
  keep this diff content-only.

---

## 4. Open questions

1. **Home feed repetition** — keep three honest "Recon" rows, or diversify the sample?
2. **Recon entry numbering** — sample cards currently reuse old numbers (08–11). Adopt a
   dedicated `R##` scheme (matching the old `R12` research convention) or leave as-is?
3. **Library card for Recon** — should the single Recon card expose its sub-formats
   (research / comparison) as a hint, or stay a single flat doorway?

---

## 5. Once all four screens are consistent
- Bump `index.html` `<meta name="version">` and add a `CHANGELOG.md` entry (next version).
- Commit + tag/release per the established `vX.Y.Z` workflow.
