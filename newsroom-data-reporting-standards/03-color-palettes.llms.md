# Color Palettes

***Color in a chart is an encoding, not a decoration.*** Every color on a published chart belongs to one of five roles, each with its own palette. Hex codes below are taken verbatim from the cited sources; contrast ratios were computed against WCAG 2.x relative-luminance formulas (see [05-accessibility.qmd](../newsroom-data-reporting-standards/05-accessibility.llms.md)).

## 1 Roles and rules

- **CO-1 (MUST)** Use only colors defined in this document (or a project palette derived under CO-10). **No ad-hoc colors.**
- **CO-2 (MUST)** Pick the palette by data type: **categorical** for unordered groups, **sequential** for ordered/continuous values, **diverging** for values around a meaningful midpoint, **highlight** for featuring one series, **neutral** for everything that is not data.
- **CO-3 (MUST)** Assign categorical colors in the palette’s stated order, starting from the first. Exceptions (The Economist’s “colour overrides”): chronological categories take a light-to-dark sequential scale; semantically grouped categories take colors that reinforce the grouping; categories with fixed public associations (political parties, “don’t know” = grey) keep them.
- **CO-4 (SHOULD NOT)** More than **6** categorical colors on one chart (The Economist’s tooling maxes at 6; UK AF recommends ≤4). Beyond that: group into “other”, or facet.
- **CO-5 (MUST)** Grey is a data color. Context series, de-emphasized data, and “don’t know” categories take grey; emphasis takes one saturated highlight color. Datawrapper: “Gray is the most important color in data visualization.”
- **CO-6 (MUST)** Diverging palettes MUST place their neutral midpoint at the meaningful zero/midpoint of the data, and MUST NOT be used on data without one.
- **CO-7 (MUST)** Meaning MUST NOT be carried by color alone (WCAG 1.4.1): pair color with direct labels, position, or line style. See AX-2.
- **CO-8 (MUST)** Semantic consistency: the same entity keeps the same color across every chart in a publication (P-6). Reserve sign conventions (e.g. red = negative) and do not reuse those hues for arbitrary categories nearby.
- **CO-9 (SHOULD)** Check every palette use in a colorblind simulator and in greyscale before publishing; distinguish adjacent categorical colors by lightness, not hue alone (Datawrapper: aim for a wide lightness range; UK AF: check adjacent colors).
- **CO-10 (MAY)** A project MAY define a brand palette, but it inherits all rules above; brand color is best spent on the single most important series (Datawrapper’s brand-integration guidance), not sprayed across all categories.

------------------------------------------------------------------------

## 2 Default palettes (normative)

### 2.1 Categorical default — UK Analysis Function palette

Chosen as the default because it is the only published newsroom/government palette in our sources where **every color meets WCAG 1.4.11’s 3:1 contrast against white** (verified: 3.03–10.86:1). Use in this order:

| Order | Name         | Hex       | Contrast vs white |
|-------|--------------|-----------|-------------------|
| 1     | Dark blue    | `#12436D` | 10.25:1           |
| 2     | Turquoise    | `#28A197` | 3.17:1            |
| 3     | Dark pink    | `#801650` | 9.77:1            |
| 4     | Orange       | `#F46A25` | 3.03:1            |
| 5     | Dark grey    | `#3D3D3D` | 10.86:1           |
| 6     | Light purple | `#A285D1` | 3.08:1            |

### 2.2 Categorical alternative — Okabe–Ito (colorblind-safe)

The reference palette for color-vision-deficiency safety (Okabe & Ito 2008). Its distinctions survive protanopia/deuteranopia, but note three of its colors fall below 3:1 contrast on white (yellow 1.32:1, orange 2.25:1, sky blue 2.31:1) — on white backgrounds pair them with direct labels and adequate mark weight, or prefer the Analysis Function palette for thin lines.

| Name           | Hex       | RGB           |
|----------------|-----------|---------------|
| Black          | `#000000` | 0, 0, 0       |
| Orange         | `#E69F00` | 230, 159, 0   |
| Sky blue       | `#56B4E9` | 86, 180, 233  |
| Bluish green   | `#009E73` | 0, 158, 115   |
| Yellow         | `#F0E442` | 240, 228, 66  |
| Blue           | `#0072B2` | 0, 114, 178   |
| Vermilion      | `#D55E00` | 213, 94, 0    |
| Reddish purple | `#CC79A7` | 204, 121, 167 |

(Okabe–Ito also recommends vermilion over pure red for protanope visibility.)

### 2.3 Sequential default

Single-hue blue ramp (UK Analysis Function), light → dark:

`#F2F2F2` → `#ADD1F1` → `#6BACE6` → `#2073BC` → `#12436D` → `#092135`

Use as many steps as the data need, keeping ends far apart in lightness (Datawrapper: cover a wide lightness range, ideally 60+ percentage points). For continuous scales in software, **viridis** family scales are an acceptable perceptually-uniform, colorblind-safe substitute. Adjacent steps of any sequential ramp rarely meet 3:1 contrast — so a sequential-colored graphic MUST also be readable via labels or an alternative format (UK AF).

### 2.4 Diverging default

Build from the two endpoint hues of the categorical palette around a pale neutral midpoint, e.g. dark blue `#12436D` ↔︎ pale grey `#F2F2F2` ↔︎ dark pink `#801650`; or ColorBrewer’s tested diverging schemes (e.g. RdBu). Prefer blue/red or blue/orange pairs over green/red (colorblind-hostile).

### 2.5 Highlight/focus pair

One featured series + greyed context (UK AF “focus” palette):

- Highlight: `#12436D` (or the publication’s brand accent)
- Context: `#BFBFBF`

### 2.6 Neutrals (non-data ink)

Following BBC `bbplot` values, which sit comfortably on white:

| Element | Hex | Note |
|----|----|----|
| Chart text / annotations | `#222222`–`#333333` | 12.6:1 on white at `#333333` |
| Secondary text | `#555555` | 7.5:1 on white |
| Baseline / zero line | `#333333` | strong single anchor line |
| Gridlines | `#CBCBCB` | light grey, y-axis only by default |
| De-emphasized data | `#DDDDDD` |  |
| Background | `#FFFFFF` | white only (UK AF) unless a brand paper color is a documented house choice |

------------------------------------------------------------------------

## 3 House palettes from the three newsrooms (informative)

These are documented **as worked examples** of the rules above — not for direct reuse, since they are those publications’ brands.

### 3.1 The Economist — web chart palette (visual style guide, 2017)

Main order: Econ red `#E3120B`, red `#DB444B`, blue `#006BA2`, cyan `#3EBCD2`, green `#379A8B`, yellow `#EBB434`, olive `#B4BA39`, purple `#9A607F`, gold `#D1B07C`, grey `#758D99`. Black `#0C0C0C`; chart text `#3F5661`; boxes/nav background `#E9EDF0`. The guide also defines **equal-lightness color scales** under each main hue (e.g. blue `#00588D` → `#1270A8` → `#3D89C3` → `#5DA4DF` → `#7BBFFC` → `#98DAFF`) so any hue can serve as a sequential ramp at consistent lightness steps. Note the severe hue discipline — mostly reds/blues plus grey — which Datawrapper credits for their instant brand recognition.

### 3.2 BBC — bbplot working colors (Visual & Data Journalism cookbook)

Data hues used in the cookbook: blue `#1380A1`, gold `#FAAB18`, dark red `#990000`, green `#588300`. Neutrals as tabulated above (`#333333` baseline, `#CBCBCB` gridlines, `#DDDDDD` de-emphasis). Legends top or removed in favor of direct labels; y-gridlines only.

### 3.3 Financial Times — chart colors (g-chartcolour / Origami)

Backgrounds: web “paper” `#FFF1E5`, video `#333`/`#335`, clean white `#FFF`. Web line palette: `#0F5499`, `#EB5E8D`, `#70DCE6`, `#9DBF57`, `#208FCE`, `#7F062E`, `#C2B7AF`. Diverging: `#B31147` ↔︎ `#1162B3` (through a warm neutral `#CEC6B9`). Sequential multi: `#F3DEC8` → `#0F5499`. Fixed political colors (e.g. US Democrat `#238FCE`, Republican `#E5262D`) illustrate CO-3’s “fixed public association” override. The FT’s pink paper deliberately narrows the usable lightness range — a reminder that background choice constrains the whole palette (Datawrapper).
