# Bento deck — template & design system

**The single source of truth for building the AI4Good bento decks** (`workshop1-slides.html`). Layout, type, colour, components, behaviour, and the CSS architecture all live here. CLAUDE.md points to this file; don't duplicate these rules elsewhere. The per-slide storyboard (`slides-with-notes.md`) only notes what *differs* from these defaults.

---

## 1. Canvas & layout

- **16:9 dark stage** `#0C0D12` with a soft violet glow top-right; subtle rounded corners.
- **All sizing in container-query units** (`cqw`/`cqh`) so the whole slide scales as one unit — **never fixed px**.
- Each content slide is a **CSS grid** defined per slide (`.sN{grid-template-…}`); the head usually spans all columns (`grid-column:1 / -1`).

## 2. Type

- **Space Grotesk** for display — eyebrows, headings, big numbers.
- **Inter** for body.
- Accent a single word with `<em>` → renders in the **stage accent** colour, upright (not italic). See §4.

## 3. Palette (tokens in `:root`)

| Token | Hex | Role |
|---|---|---|
| `--mint` | `#3CE6B0` | primary · Stage 1 · **the brand** |
| `--violet` | `#8B7CFF` | Stage 2 |
| `--amber` | `#FFC24B` | Stage 3 |
| `--pink` | `#FF7EB6` | Stage 4 |
| `--blue` | `#58A6FF` | Stage 5 |
| `--ink` | `#F3F4F8` | default text |
| `--muted` | `#9498A8` | de-emphasised text, citations |
| `--card` `#16171F` · `--line` `#262833` | — | card fill · card border |

---

## 4. Colour rules (the heart of the system)

Colour carries meaning. Two rules govern every accent decision.

**Per-stage accent.** Each stage owns one accent colour; everything *emphasised* in that stage uses it, so the deck reads as five coloured "movements."

| Stage | Name | Accent |
|---|---|---|
| 1 | Discovery | mint `#3CE6B0` |
| 2 | UX-first | violet `#8B7CFF` |
| 3 | Eval as spec | pink `#FF7EB6` |
| 4 | Build (MVP · crawl/walk/run) | blue `#58A6FF` |
| 5 | Safeguard / project mgmt | amber `#FFC24B` |

> Mapping rationale: **amber = safety/caution** (the universal warning convention, and the deck already uses amber for warnings — so warning-amber and Stage-5-amber reinforce); **blue = build/engineering**. The review-board skill colours follow their stage: `pm-critic` mint · `design-critic` violet · `eval-critic` pink · `eng-critic` blue · `safety-critic` amber.

**Rule 1 — Emphasis uses the stage accent.** Highlight the *one* important thing on a slide — a key word in the H1, the eyebrow, a punch/gate strip — in the **current stage's accent**. Everything else stays `--ink` (or `--muted` when de-emphasised). One emphasis colour per slide.
> *Example:* Stage-2 slide "UX matters more for **AI**" — "AI", the `UX-FIRST` eyebrow, and the punch strip are all **violet**.

**Rule 2 — Enumeration uses the rotating palette.** For a *set of distinct, parallel options* the audience scans as separate items — numbered cards, a list of choices, steps — give each a **different** colour from the cycle **mint → violet → amber → pink**, regardless of stage. The colours differentiate; they don't mean anything individually.
> *Example:* the "Three questions before you build" checklist — cards **1 / 2 / 3** are mint / violet / amber so they read as three separate tests, even in a mint stage.

**The test:** *Am I stressing ONE thing, or distinguishing SEVERAL?* → One = stage accent (Rule 1). Several parallel = rotate the palette (Rule 2).

**The brand exemption — never recolour per stage:**
1. **Page chrome** — the `.hud` footer ("… · **BENTO**" + slide counter) stays **mint** always. It's brand furniture, not slide content.
2. **Enumeration cycles** — `.dot` / `.q .n` nth-child sequences keep their mint→violet→amber→pink rotation; a stage recolour must not flatten them to the stage accent.

---

## 5. Components

- **Eyebrow.** Space Grotesk 600, ~1.4cqw, `letter-spacing:.3em`, UPPERCASE, **stage accent**. Top-left of content slides.
- **Cards (the bento).** bg `--card`, 1px `--line` border, ~2.2cqw radius, ~4cqh×3cqw padding.
  - **Fact card** = coloured dot on the **left**, `h3` + one short line beside it (row layout, top-aligned; nudge the dot down ~0.9cqh to sit on the heading line). Dots cycle mint→violet→amber→pink across a group (enumeration — Rule 2).
  - **Accent / callout card** = same row layout with a `→` lead instead of a dot; stage-accent gradient tint, stage-accent border, stage-accent heading, `--ink` body.
- **Alignment rule.** Cards in a row **top-align** their content with a consistent gap, so dots+headings sit on the same baseline regardless of body length. Never bottom-align (space-between) when comparing cards.
- **Lead-glyph alignment — no orphaned glyph (recurring mistake — read this).** Any element with a lead glyph (a dot, a `→`/`▸` arrow, a number chip) keeps the glyph and its text as **one left-aligned group**: row layout, `justify-content:flex-start`, a fixed `gap`, text immediately beside the glyph. **Never** leave the glyph flush-left while the text centres or right-aligns — that orphaned-glyph look is wrong every time.
  - ⚠️ **The trap that causes it:** the base `.card` sets `justify-content:space-between`. Any card/strip switched to `flex-direction:row` therefore **inherits space-between** and throws its children to opposite edges (glyph hard-left, text hard-right — reads as mis-centred). So **every row-layout card/strip MUST set its own `justify-content`** (normally `flex-start`). Don't rely on the default.
  - To **centre** a strip instead, centre the glyph+text *as a group* (`justify-content:center` on the row) — never `text-align:center` on the text while the glyph sits separately.
  - **General principle:** one alignment per element. Items that belong together (glyph + its text, label + its value) share one alignment and sit adjacent; don't mix a flush-left element with centred/right text in the same row.
- **Lead / divider slides.** Centered: eyebrow + huge H1 + a glowing **stage-accent** rule beneath.
- **Title slide.** Hero card (~1.45fr) spanning both rows holds eyebrow + H1 + lede; a narrow right column stacks small meta cards (date, facilitator).
- **References / citations.** **Always bottom-right**, as muted footer text in a `.foot` (`justify-content:flex-end`; `--muted`, ~1.3cqw). Never inside a coloured card or strip. If the slide has a left-aligned "Next:" line, the citation sits opposite it (space-between).
- **HUD chrome.** Fixed bottom bar: deck name · **BENTO** + slide counter + nav hint. Mint `<b>`, always (brand — §4 exemption).

## 6. Behaviour

- Navigate with **← → arrow keys only** — clicks never change slides (text stays selectable).
- **Esc = overview** grid of numbered thumbnails, current outlined in the stage accent.

## 7. Text discipline

Minimalist on-slide — a few words per heading, ≤1 short line of body. The full narration lives in the storyboard's **Say:** line, not on the slide.

---

## 8. Implementation (CSS architecture)

So a stage recolours in **one place**, the template uses a single `--accent` variable rather than hard-coded mint:

```css
:root{ --accent: var(--mint); }          /* Stage 1 default */
.stage2{ --accent: var(--violet); }
.stage3{ --accent: var(--pink); }
.stage4{ --accent: var(--blue); }
.stage5{ --accent: var(--amber); }
```

- **Route every emphasis role through `var(--accent)`** — eyebrow colour, `h1 em`, divider rule/quote, hot-row, punch/gate strip, accent-card heading, foot `.ln`.
- **Tints/borders use `color-mix`**, not literal rgba, so they recolour automatically:
  `background:linear-gradient(120deg, color-mix(in srgb, var(--accent) 18%, transparent), transparent), var(--card)` and `border-color:color-mix(in srgb, var(--accent) 45%, transparent)`.
- **Keep literal (NOT routed through `--accent`):** the `.hud b` brand mint, and the `.dot` / `.q .n` nth-child enumeration cycles (§4 exemption).
- **Apply the stage class** (`.stage1`…`.stage5`) to **every** slide in that stage, including its divider.

This collapses per-stage override blocks (e.g. hand-written `.stage2 …{color:var(--violet)}`) into one line per stage.

## 9. Authoring workflow

- Edit **`workshop1-slides.html`** directly (it's the rendered deck). Keep the **`slides-with-notes.md`** storyboard in sync — each slide there carries a layout sketch, on-slide content, **UI:** (only what differs from this template), **Say:**, **Build:**.
- The W2 deck (`Building ML Apps/workshop2-slides.html`) is **also built on this template** — same `:root`/chrome/nav, with a two-act `--accent` flip (blue=JP, violet=Rohan) and two W2-local components (`.clip`, `.demo`). Keep its storyboard (`Building ML Apps/slides-with-notes.md`) in sync. *(The old W2 Marp deck is retired → `_deprecated/W2-marp-deck/`.)*
