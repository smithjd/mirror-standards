# 07 — Sources

Annotated bibliography. All sources were consulted directly in July 2026 except where
noted. Hex codes in [03-color-palettes.md](03-color-palettes.md) trace to the starred
(★) primary sources.

## The three newsrooms

### Financial Times

- ★ **Visual Vocabulary** — Financial-Times/chart-doctor, `visual-vocabulary/`,
  <https://github.com/Financial-Times/chart-doctor/tree/main/visual-vocabulary>.
  The normative chart-type taxonomy in [02-chart-types.md](02-chart-types.md): nine
  analytical functions (deviation, correlation, ranking, distribution, change over
  time, magnitude, part-to-whole, spatial, flow) with per-chart usage notes.
  Interactive version: <https://ft-interactive.github.io/visual-vocabulary/>.
- ★ **g-chartcolour** — ft-interactive, <https://github.com/ft-interactive/g-chartcolour>,
  docs <https://ft-interactive.github.io/g-chartcolour/>. FT chart color tokens:
  paper `#FFF1E5`, web line palette, sequential/diverging ramps, political palettes.
- **Origami o-colors** — <https://github.com/Financial-Times/o-colors> (archived; now
  in <https://github.com/Financial-Times/origami>). Brand palette Sass tokens.

### BBC

- ★ **BBC Visual & Data Journalism cookbook for R graphics** —
  <https://bbc.github.io/rcookbook/> (source: <https://github.com/bbc/rcookbook>).
  Working hex codes (`#1380A1`, `#FAAB18`, `#990000`, `#588300`; neutrals `#333333`,
  `#CBCBCB`, `#DDDDDD`), gridline/legend/baseline rules, chart types demonstrated,
  annotation conventions.
- ★ **bbplot** — <https://github.com/bbc/bbplot>. `bbc_style()` theme and
  `finalise_plot()`: left-aligned title block, source bottom-left, logo bottom-right,
  640×450 px default export.

### The Economist

- ★ **The Economist visual styleguide** (chart style guide PDF, 2017-05-05). Mirror
  consulted:
  <https://sa.ipaa.org.au/wp-content/uploads/2026/02/Economist-CHARTstyleguide_20170505.pdf>.
  Web chart palette (Econ red `#E3120B`, blue `#006BA2`, cyan `#3EBCD2`, …; black
  `#0C0C0C`, text `#3F5661`), equal-lightness color scales, standard color order and
  overrides, pie limit ("abandoned in favour of stacked bar if over 4 categories"),
  double-scale rules (no broken scales, aligned zero lines, no disparate measures;
  else panels or indexing).
- **"Mistakes, we've drawn a few"** — Sarah Leo, The Economist (Medium, 2019),
  <https://medium.economist.com/mistakes-weve-drawn-a-few-8cdd8a42d368>. Self-audit of
  misleading practices (truncated axes, forced dual-scale correlations). *Not
  fetchable at time of writing; cited from the styleguide's matching rules.*

## Corroborating authorities

- ★ **UK Government Analysis Function** — *Data visualisation: charts*,
  <https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-charts/>,
  and *Data visualisation: colours*,
  <https://analysisfunction.civilservice.gov.uk/policy-store/data-visualisation-colours-in-charts/>.
  Accessible categorical palette (`#12436D`, `#28A197`, `#801650`, `#F46A25`,
  `#3D3D3D`, `#A285D1` — all ≥3:1 on white), sequential blues, focus palette
  (`#12436D` + `#BFBFBF`), and the do/don't list (≤4 lines, ≤4 bars per cluster,
  never break bar axes, horizontal text, direct labels, ≤10 gridlines, pie rules,
  SVG output). Implementations: `afcharts` (R), `py_af_colours` (Python).
- ★ **Okabe, M. & Ito, K.** — *Color Universal Design: How to make figures and
  presentations that are friendly to colorblind people*,
  <https://jfly.uni-koeln.de/color/>. The 8-color colorblind-safe palette and the
  redundancy principles (shape/line-type pairing, vermilion over red). Also shipped in
  R as `grDevices::palette.colors(palette = "Okabe-Ito")`.
- ★ **Urban Institute Data Visualization Style Guide** —
  <https://urbaninstitute.github.io/graphics-styleguide/>. Typography scale, palette
  structure, the "absolutes" (no dual axes, zero baselines for bars, pie ≤5 slices,
  ≤7 categories, no 3-D), alt-text practice (~160 characters).
- **Datawrapper** — Lisa Charlotte Muth, *A detailed guide to colors in data vis style
  guides*, <https://www.datawrapper.de/blog/colors-for-data-vis-style-guides>.
  Palette-construction guidance: data vs non-data greys, lightness range (60+ points),
  semantic category colors, size-dependent saturation, brand-color discipline, and the
  newsroom comparisons cited in 03.
- **W3C, WCAG 2.2** — <https://www.w3.org/TR/WCAG22/>. Criteria applied: 1.1.1
  (non-text content), 1.4.1 (use of color), 1.4.3 (text contrast 4.5:1), 1.4.5
  (images of text), 1.4.11 (non-text contrast 3:1).
- **ColorBrewer** — Cynthia Brewer, <https://colorbrewer2.org/>. Tested sequential
  and diverging schemes referenced for diverging defaults.
- **viridis** — perceptually uniform, colorblind-safe continuous scales; in ggplot2 as
  `scale_*_viridis_*()`. <https://sjmgarnier.github.io/viridis/>.

## Verification notes

- Contrast ratios quoted in 03 and 05 were computed from the cited hex codes with the
  WCAG 2.x relative-luminance formula (not copied from the sources): Analysis Function
  categorical palette 3.03–10.86:1 vs white; Okabe–Ito yellow 1.32:1, orange 2.25:1,
  sky blue 2.31:1 vs white (hence the caveat in 03); BBC `#333333` text 12.63:1.
- The Economist hex values were extracted from the styleguide PDF's own text layer;
  where third-party summaries disagreed with the PDF, the PDF was used.
