# Core Principles

These principles govern every chart. The detailed rules in the other documents are applications of them; when a situation is not covered by a specific rule, decide by these.

## 0.1 P-1 The message comes first (MUST)

Every chart MUST have a single, stateable message. If you cannot complete the sentence “this chart shows that …”, the chart is not ready. The Financial Times’ Visual Vocabulary makes this operational: chart choice starts from the *analytical function* of the message — deviation, correlation, ranking, distribution, change over time, magnitude, part-to-whole, spatial, or flow — not from a preferred chart form.

## 0.2 P-2 Titles state the finding (SHOULD)

The main title SHOULD be an assertive headline stating what the chart shows (“Vaccination halved infections”), not a variable listing (“Infections by vaccination status, 2020–24”). The descriptive part — measure, unit, geography, period — belongs in the subtitle. This is the consistent practice of the BBC, FT, and The Economist, and the UK Analysis Function formalizes it as “headline title plus statistical subtitle.”

## 0.3 P-3 Show the data honestly (MUST)

- Bar and column charts encode value in length, so their value axis MUST start at zero and MUST NOT be broken. (Economist style guide; UK Analysis Function; Urban Institute.)
- Line charts MAY use a non-zero baseline when the level is not the story, but the axis MUST NOT be broken silently, and the range MUST NOT be chosen to manufacture drama.
- Dual value axes SHOULD NOT be used. The Urban Institute bans them outright (“confusing, difficult to read, and often misleading”); The Economist permits them only under strict conditions (aligned zero lines, no broken scales, no disparate measures forced into visual correlation) and otherwise directs: split into panels or index the series to a common base.
- Areas MUST scale with the values they represent: no 3-D effects, no perspective, no pictograms sliced to represent fractions (“do not slice off an arm to represent a decimal” — FT Visual Vocabulary).

## 0.4 P-4 Maximize data, minimize decoration (SHOULD)

Every non-data element must earn its place. Defaults that follow from this:

- Gridlines: light grey, one axis only where possible, never more than about 10 (UK Analysis Function). The BBC’s default theme draws horizontal gridlines only.
- A single strong zero/base line anchors the chart (BBC: `#333333` baseline).
- No borders, shadows, textures, or background fills that do not encode data.
- Prefer direct labels over legends ([04-typography-annotation.qmd](../newsroom-data-reporting-standards/04-typography-annotation.llms.md), TY-6).

## 0.5 P-5 Less, but comparable (SHOULD)

Fewer well-chosen series beat exhaustive ones. Working limits used throughout this standard: at most **4 lines** on one line chart, at most **4 bars** per cluster, at most **6–7 categories** per chart (UK Analysis Function; Urban Institute; The Economist’s tooling plots at most 6 colors). When the data exceed these limits, use small multiples — repeat the same chart per category with shared scales — rather than cramming one panel.

## 0.6 P-6 Consistency across the publication (MUST)

The same entity MUST keep the same color, the same measure the same format, and the same chart family the same conventions across a page or report. **Readers learn your** **encoding once; do not make them relearn it per chart.**

## 0.7 P-7 Every chart cites its source (MUST)

A source line (“Source: …”, or “Sources: …”) MUST appear on or directly beneath every chart, bottom-left, naming the data provider — not the file, not the analyst. Footnote markers (`*`, `†`) qualify individual figures. This is uniform BBC, FT, and Economist practice; the BBC’s `finalise_plot()` makes the source line a required argument.

## 0.8 P-8 Design for the reader you don’t control (MUST)

The chart will be read on a phone, projected, printed in greyscale, or read aloud by a screen reader. It MUST survive all four:

- Meaning MUST NOT be carried by color alone (WCAG 1.4.1) — see [05-accessibility.qmd](../newsroom-data-reporting-standards/05-accessibility.llms.md).

- Text MUST remain legible at the smallest published size.

- Every chart MUST have a text alternative (alt text, a data table, or descriptive

  # 1 prose).
