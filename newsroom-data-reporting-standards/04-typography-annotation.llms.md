# Typography & Annotation

Text is how a chart explains itself. These rules cover the text hierarchy, axis and data labeling, number formatting, and the source line.

## 1 Text hierarchy

- **TY-1 (MUST)** Every chart carries, in order: **title** (the finding, P-2), **subtitle** (measure, unit, geography, period), and **source line** (P-7). Optional between subtitle and source: axis labels, annotations, footnotes.
- **TY-2 (MUST)** Title and subtitle are left-aligned at the chart’s left edge (BBC `finalise_plot()` convention; Economist and FT practice). Units live in the subtitle (“GDP, % change on a year earlier”), not repeated on every axis tick.
- **TY-3 (MUST)** Chart text uses a single sans-serif family at web sizes that stay legible on phones. Reference scale (Urban Institute web values):
  - title ~20px bold,
  - subtitle ~16px,
  - axis and data labels ~12px,
  - legend ~14px,
  - source/notes ~11px.
  - Sentence case for all chart text; never all-caps for data labels.
- **TY-4 (MUST)** All text is horizontal — no vertical or diagonal axis labels (UK Analysis Function). If category labels don’t fit horizontally, flip to horizontal bars (CT-14).

## 2 Titles and subtitles on the web (accessibility interaction)

- **TY-5 (SHOULD)** On web pages, render title, subtitle, and source as HTML text adjacent to the graphic rather than baking them into the image — screen readers and reflow then get them for free (UK Analysis Function 1.4.5 guidance).

## 3 Legends vs direct labels

- **TY-6 (SHOULD)** Label series directly at the line end or on the bar whenever space allows; use a legend only when direct labels genuinely don’t fit (UK AF: “don’t use legends if direct labeling is possible”; Economist: where linking lines get crowded, “key the labels with small colour block”). If a legend is used, order it to match the visual order of the series and place it above the plot (BBC default: legend at top, no legend title).

## 4 Axes, gridlines, ticks

- **TY-7 (MUST)** Value axis: right-align numeric tick labels; use thousands separators (“121,576”); at most ~10 light-grey gridlines; label the final tick when space permits (UK AF).
- **TY-8 (MUST)** Draw one strong baseline at zero (or the reference value) — BBC style `#333333` — heavier than gridlines. Other chart borders and axis lines are omitted.
- **TY-9 (SHOULD)** Abbreviate time axes after first mention the way newsrooms do: “1994 96 98 2000 02 …” (Economist practice); don’t repeat the century on every tick.

## 5 Numbers

- **TY-10 (MUST)** Round to the precision the story needs — no false precision (write 4.5, not 4.5271). Keep decimal places consistent within a series.
- **TY-11 (MUST)** State units once, in the subtitle or axis header: %, \$bn, per 100,000 population. Symbols (%, \$) don’t repeat on every tick if stated in the subtitle.
- **TY-12 (SHOULD)** For scale words follow one convention: bn/m/trn abbreviations or full words, publication-wide.

## 6 Annotation

- **TY-13 (SHOULD)** Annotate the chart where the story happens: short labels with a thin pointer at the event (“Privatisation begins” — Economist example), placed near the relevant data in dark grey/black (UK AF). An annotated chart beats a caption paragraph.
- **TY-14 (MUST)** Footnote markers (`*`, `†`, `‡`) attach caveats to specific values; the note text sits with the source line (“\*To June 30th”).

## 7 Source and credit line

- **TY-15 (MUST)** Bottom-left: `Source:` / `Sources:` naming the data provider(s), separated by semicolons (“Sources: Thomson Reuters; IMF”). Bottom-right MAY carry the publication credit or logo (BBC `finalise_plot()` places the logo bottom-right).
