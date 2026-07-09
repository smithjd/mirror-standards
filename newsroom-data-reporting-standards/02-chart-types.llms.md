# Chart Types

Chart selection starts from the **analytical function** of the message. This document adopts the Financial Times Visual Vocabulary’s nine functions as the normative taxonomy (Financial-Times/chart-doctor, `visual-vocabulary`), annotated with selection rules drawn from the BBC, The Economist, the UK Government Analysis Function, and the Urban Institute.

## 1 Selection rules

- **CT-1 (MUST)** Choose the chart by asking what relationship the message expresses — one of the nine functions below — and pick from that function’s list. A message can serve two functions (e.g. a ranked magnitude); pick the function the title asserts.
- **CT-2 (MUST)** When in doubt, use the boring chart. Bar, line, and scatter cover the large majority of published messages; exotic forms need to pay for the learning cost they impose on readers.
- **CT-3 (SHOULD)** When series or categories exceed the limits in P-5 (4 lines, 4 bars per cluster, ~6 categories), switch to **small multiples** with shared scales instead of one dense panel.
- **CT-4 (MUST)** Respect each form’s encoding constraints: zero baselines for bars/columns (P-3), whole numbers only for pictograms, rates (not totals) for choropleth maps.

------------------------------------------------------------------------

## 2 1. Deviation — variation from a fixed reference point

Use for surplus/deficit, above/below target, positive/negative sentiment.

| Chart | Use when |
|----|----|
| Diverging bar | Values carry sign; a standard bar handles “both negative and positive magnitude values” |
| Diverging stacked bar | Survey sentiment scales (disagree/neutral/agree) |
| Spine chart | One value split into two contrasting components |
| Surplus/deficit filled line | A balance over time against a baseline or between two series |

**CT-5 (MUST)** Diverging charts MUST place the reference value (usually zero) as a visible, aligned axis line. Encode sign with the diverging palette ([03-color-palettes.qmd](../newsroom-data-reporting-standards/03-color-palettes.llms.md), CO-6) only when the difference is meaningful — The Economist: differentiate positive/negative by color “only where there is a meaningful difference, i.e. imports/exports.”

## 3 2. Correlation — relationship between variables

| Chart | Use when |
|----|----|
| Scatterplot | The standard for two continuous variables |
| Bubble | A third variable sized by circle **area** |
| Connected scatterplot | How a two-variable relationship changed over time |
| XY heatmap | Patterns between two categories; imprecise for fine differences |
| Line + column | An amount (columns) against a rate (line) |

**CT-6 (SHOULD)** State correlation ≠ causation in the surrounding prose, not the chart. **CT-7 (MUST)** Bubble sizes MUST scale by area, never by radius.

## 4 3. Ranking — position in an ordered list is the story

| Chart | Use when |
|----|----|
| Ordered bar / ordered column | Default; unsorted bars hide the rank |
| Lollipop | Draws attention to the value end; keep zero baseline where value matters |
| Slope chart | Rank changes between two points in time or two categories |
| Dot strip plot | Space-efficient ranks across multiple categories |
| Ordered proportional symbol | Large value ranges where fine differences don’t matter |

**CT-8 (MUST)** Sort by value, not alphabetically, unless the reader will look up a specific row (then alphabetical is a lookup table, and consider an actual table).

## 5 4. Distribution — values and their frequency

| Chart | Use when |
|----|----|
| Histogram | The standard; keep column gaps minimal so the *shape* reads |
| Boxplot | Summarize many distributions: median and range |
| Violin plot | Complex distributions a five-number summary misrepresents |
| Dot plot / dot strip plot | Show individual values, or change/range (min–max) per category |
| Barcode plot | All values in a small space; best when highlighting individuals |
| Population pyramid | Age–sex structure (back-to-back histograms) |
| Cumulative curve | Inequality of a distribution (cumulative frequency on y) |

**CT-9 (SHOULD)** Prefer showing the distribution over reporting a lone mean whenever spread or skew affects the conclusion.

## 6 5. Change over time — trends

| Chart | Use when |
|----|----|
| Line | The standard for time series; mark points if data are irregular |
| Column | Change over time for a **single** series, esp. few periods |
| Area chart | Change in a *total* — component changes are hard to read; use with care |
| Slope chart | Data simplifiable to 2–3 time points without losing the story |
| Fan chart | Projections with widening uncertainty |
| Calendar heatmap | Daily/weekly/monthly patterns, at the cost of precision |
| Connected scatterplot | Two variables over time with a clear progression |
| Priestley timeline | Date **and** duration both matter |
| Circle timeline / seismogram | Discrete events of very different sizes over time |

**CT-10 (MUST)** Time runs left to right. **CT-11 (SHOULD NOT)** More than 4 lines per panel (UK Analysis Function); grey the context lines and color only the featured ones, or facet. **CT-12 (MUST)** Stacked area charts MUST NOT be used when the message is about an individual component’s trend — only the bottom band and the total read accurately.

## 7 6. Magnitude — size comparisons

| Chart | Use when |
|----|----|
| Bar / column | The standard. “Must always start at 0 on the axis” (FT) |
| Paired bar / column | Up to 2 series per category; beyond that, facet |
| Proportional symbol | Big variations; fine differences invisible by design |
| Isotype / pictogram | Counts of whole things only — never fractional icons |
| Lollipop | Emphasis on the value point; zero baseline still preferable |
| Radar / parallel coordinates | Many variables per entity; ordering of axes is critical — use rarely |

**CT-13 (MUST)** Zero baseline, no broken axis, no 3-D (P-3). **CT-14 (SHOULD)** Horizontal bars when category labels are long — labels stay horizontal (TY-4).

## 8 7. Part-to-whole — composition

| Chart | Use when |
|----|----|
| Stacked column / bar | Default composition form; hard to read past a few components |
| Proportional (100%) stacked bar | Size and share at once, if data are simple |
| Pie / donut | Familiar, but segment comparison is imprecise — see CT-15 |
| Treemap | Hierarchical composition; weak with many small segments |
| Gridplot / waffle | Percentages as counted squares; best with whole numbers |
| Waterfall | Composition including negative components |
| Arc | Parliaments and similar seat allocations |
| Venn | Schematic only, never quantitative |

**CT-15 (SHOULD NOT / MUST NOT)** Pies SHOULD NOT be used at all when segments are similar in size, and MUST NOT exceed **4–5 segments** — The Economist: pie/doughnut “should probably be abandoned in favour of stacked bar if over 4 categories”; UK Analysis Function caps pies at 5; Urban Institute flags 5+ slices as an absolute. When used: start the first sector at 12 o’clock, order segments by size, label directly.

## 9 8. Spatial — location or geographic pattern is the point

| Chart | Use when |
|----|----|
| Choropleth | The standard — **rates or ratios only**, sensible base geography |
| Proportional symbol map | Totals/counts (never choropleth for totals) |
| Dot density | Individual events; annotate the pattern the reader should see |
| Flow map | Unambiguous movement across geography |
| Cartogram (equalised or scaled) | Units re-sized to equal or value-based areas, e.g. election results |
| Contour / heat map | Continuous surfaces not snapped to admin boundaries |

**CT-16 (MUST)** Use a map only when *where* is the story (“only when precise locations or geographical patterns in data are more important than anything else” — FT). A bar chart of regions usually communicates values better than a choropleth. **CT-17 (MUST)** Choropleths encode rates; totals go on symbol maps.

## 10 9. Flow — movement between states

| Chart | Use when |
|----|----|
| Sankey | Flows from one condition to others; tracing outcomes of a process |
| Waterfall | Sequenced flows, typically budgets, with +/- components |
| Chord | Two-way flows in a matrix; powerful but expensive to learn |
| Network | Strength and connectedness of relationships |

**CT-18 (SHOULD)** Flow diagrams need aggressive simplification: merge minor flows into “other” before publishing.

------------------------------------------------------------------------

## 11 Named anti-patterns

Reviewers cite these directly.

| ID | Anti-pattern | Rule | Backed by |
|----|----|----|----|
| CT-A1 | Truncated or broken bar axis | MUST NOT | Economist (“broken scale distorts data”), UK AF, Urban |
| CT-A2 | 3-D effects, shadows, textures | MUST NOT | UK AF, Urban Institute |
| CT-A3 | Dual value axes to force correlation | MUST NOT (see P-3 for the narrow exception) | Economist, Urban Institute |
| CT-A4 | Misaligned zero lines on a permitted dual axis | MUST NOT | Economist |
| CT-A5 | Inverted scale combined with an index to imply correlation | MUST NOT | Economist |
| CT-A6 | Pie with \>4–5 segments or similar-sized segments | MUST NOT / SHOULD NOT | Economist, UK AF, Urban |
| CT-A7 | Spaghetti line chart (\>4 undifferentiated lines) | SHOULD NOT — grey the context or facet | UK AF, BBC practice |
| CT-A8 | Legend when direct labeling fits | SHOULD NOT | UK AF, Economist |
| CT-A9 | Fractional pictograms | MUST NOT | FT Visual Vocabulary |
| CT-A10 | Choropleth of raw totals | MUST NOT | FT Visual Vocabulary |
| CT-A11 | Unordered ranking bars | MUST NOT | FT Visual Vocabulary |
| CT-A12 | Radar chart with arbitrary axis order | SHOULD NOT | FT Visual Vocabulary |
