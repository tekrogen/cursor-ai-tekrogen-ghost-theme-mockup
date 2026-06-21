# V8 + V6 — evidence review (s1 Home)

**Work orders:** V8 (locked tagline verbatim) · V6 (brand lockup → home link)  
**Surface:** `mockups/Cursor/Tekrogen-Flywheel/index.html` · screen **s1**  
**Captured:** Ink + Paper × 1440 + 390 · served at `http://127.0.0.1:8000/mockups/Cursor/Tekrogen-Flywheel/index.html`

| Change | Before → After | Callout |
|--------|----------------|---------|
| **V8 — H1** | `We build real solutions to real problems.` → `Real solutions. Built, proven, ready to use.` | `callouts/before/h1-ink-1440.png` → `callouts/after/h1-ink-1440.png` |
| **V8 — og:title** | `Tekrogen — We build real solutions to real problems.` → `Real solutions. Built, proven, ready to use.` | inspect `<head>` (same string as H1) |
| **V8 — twitter:title** | `Tekrogen — We build real solutions to real problems.` → `Real solutions. Built, proven, ready to use.` | inspect `<head>` (same string as H1) |
| **V6 — masthead brand** | `<div data-tk-slot="brand">` (non-interactive) → `<a data-tk-slot="brand" href="#/">` ×9 mastheads | `callouts/before/brand-ink-1440.png` → `callouts/after/brand-ink-1440.png` |

Full-page backup: `before/s1-{ink\|paper}-{1440\|390}.png` → `after/s1-{ink\|paper}-{1440\|390}.png`

**Acceptance check (agent — not sign-off):** `grep "real problems"` on consumer file returns no matches; nine masthead brand slots are anchors with `href="#/"`; footer brand slots unchanged.
