# color-standards

The single source of truth for color in The Societal Mirror

## 1 Purpose

Use these standards when adding or reviewing any chart, table, or tinted panel in The Societal Mirror. Color in a Mirror chart is an **encoding, not a decoration**: every hue comes from the `ourmirror` palette functions or a named constant in `shared_code_26.R`, never from a bare hex sprinkled into a chunk. This page is the inventory of what those functions return and where each color is used, so a reviewer can tell at a glance whether a page is palette-compliant.

## 2 Standard

- **Never hardcode a hex.** Call a palette function or a named constant. The only sanctioned bare hexes in the whole code base are the three catalogued in [Remaining bare hexes](#remaining-bare-hexes) — a brown-ramp anchor seed and a table-only tan.
- **Pick the palette by data type.** Categorical for unordered groups, sequential for ordered values, stoplight for good→bad tiers, and the brand palette for the small set of fixed brand accents.
- **Let the palette pick label ink.** Segment and bar labels take their color from `stoplight_ink()` or the `$ink` returned alongside `$fill` — don’t hand-tune label contrast.
- **Tint by survey.** Every ggiraph panel carries its survey’s background tint (member, centre, or SDB); the tint is what visually distinguishes the survey families.

This mirrors the palette rule in [Quarto File Standards](quarto-file-standards.llms.md) (Core Rule 3) — this page is the detailed catalogue behind it.

------------------------------------------------------------------------

## 3 `ourmirror` palette functions (source of truth)

All values below are the live outputs of the installed `ourmirror` package. Pages call these functions rather than hard-coding hexes.

### 3.1 Brand palette — `shambhala_palette_function()`

| Name        | Hex       | Role                      |
|-------------|-----------|---------------------------|
| Light Text  | `#2E3C45` | Axes / secondary text     |
| Header Text | `#232D34` | Website headers           |
| Dark Text   | `#101417` | Primary text / dark ink   |
| Grid        | `#DCE0E3` | Gridlines / neutral grey  |
| Green       | `#5AA678` | Brand green (chart fills) |
| Crimson     | `#D16471` | Brand crimson             |
| Yellow      | `#F1C95B` | Brand yellow              |
| Blue        | `#587AA7` | Brand blue                |

Used directly in `how_engaged_are_they.qmd` and `membership.qmd`; underpins every derived palette below.

### 3.2 Categorical — `mrr_pal_categorical(n)`

| Call | Hexes |
|----|----|
| `mrr_pal_categorical()` (default 4) | `#5AA678` `#587AA7` `#D16471` `#F1C95B` |
| `mrr_pal_categorical(3)` | `#5AA678` `#587AA7` `#D16471` |

Used in `centre_participation.qmd`, `centre_resources.qmd` (`bar_fill <- mrr_pal_categorical()[2]`), and the participation-mode map in `how_engaged_are_they.qmd`.

### 3.3 Stoplight — `mrr_pal_stoplight(n, labels)` → `$fill` + `$ink`

| Call | `$fill` | `$ink` |
|----|----|----|
| `mrr_pal_stoplight(n = 3)` | `#C25B60` `#ECB552` `#5AA678` | white, `#101417`, `#101417` |
| `mrr_pal_stoplight(n = 4)` | `#C25B60` `#E8A24A` `#F1C95B` `#5AA678` | white, `#101417`, `#101417`, `#101417` |

The single most-used palette (**14 calls** across 6 pages). The paired `$ink` gives contrast-safe label colors, so segment-label contrast is no longer hand-tuned. Callers: `centre_connections.qmd`, `centre_participation.qmd`, `centre_size_experience.qmd`, `centre_resources.qmd`, `what_do_they_value_and_need.qmd`.

### 3.4 Stoplight constants — `mrr_stoplight_constants()`

| Name       | Hex       |
|------------|-----------|
| red        | `#C25B60` |
| orange     | `#E8A24A` |
| amber      | `#F1C95B` |
| lightgreen | `#A5B769` |
| green      | `#5AA678` |
| grey       | `#DCE0E3` |

For pages needing named stoplight tiers beyond a simple n-step ramp (e.g. an “Other/grey” residual). Used via `stoplight_constants <- mrr_stoplight_constants()` in `centre_participation.qmd`, `centre_connections.qmd`, `centre_size_experience.qmd`, and `centre_resources.qmd`.

### 3.5 Sequential — `mrr_pal_sequential(anchor, n)`

| Call | Hexes |
|----|----|
| `mrr_pal_sequential("Green", 4)` | `#DEEDE4` `#B2D5C0` `#86BD9C` `#5AA678` |
| `mrr_pal_sequential("Green", 3)` | 3-step green ramp |
| `mrr_pal_sequential("#401F09", 4)` | `#D8D2CD` `#A5968C` `#725A4A` `#401F09` (brown ramp) |

Callers: `centre_size_experience.qmd`, `centre_profile.qmd` (brown ramp), `leadership_and_service_roles.qmd` (Yes/Maybe from a 3-step green).

### 3.6 Contrast ink — `stoplight_ink(fills)`

Returns per-fill label colors (white / dark ink) for whatever fills you pass. This is the standard way bar labels get their color — **~30 call sites** across `membership.qmd`, `leadership_and_service_roles.qmd`, `enrollment_overview.qmd`, `how_engaged_are_they.qmd`, `centre_profile.qmd`, and the centre survey pages (typically `color = stoplight_ink(dark_bar_green)`).

### 3.7 Color steps — `mrr_color_steps(total, index)`

| Call | Output |
|----|----|
| `mrr_color_steps(5, 4)` (`green_step_2`) | `#5AA678` `#7CB594` `#9FC4B1` `#C2D4CD` |
| `mrr_color_steps(5, 5)` (`green_step_5`) | 5-step green ramp ending `#C2D4CD` |

------------------------------------------------------------------------

## 4 Constants in `shared_code_26.R`

These are defined once in shared code and referenced across pages. The three background tints are the most-referenced colors in the whole project — they fill nearly every ggiraph panel.

| Constant | Definition | Value | Uses |
|----|----|----|----|
| `dark_bar_green` | `shambhala_palette_function()[["Green"]]` | `#5AA678` | **63** |
| `member_background_tint` | literal | `#FEF7F4` pale peach | **112** |
| `sdb_background_tint` | literal | `#F4F4F4` light grey | **66** |
| `centre_background_tint` | literal | `#F4FFF5` pale mint | **41** |
| `green_step_2` | `mrr_color_steps(5, 4)` | green ramp | **13** |
| `green_step_5` | `mrr_color_steps(5, 5)` | green ramp | **1** |
| `membership_colors` | `shambhala_palette_function()[c("Yellow","Green","Blue")]`, named Non member / Member / Past member | `#F1C95B` `#5AA678` `#587AA7` | **2** |
| `css_default_hover` | `girafe_css_bicolor("yellow", "red")` | yellow / red | ggiraph hover — wired into `set_girafe_defaults()`, applies globally |

`css_default_hover` is wired into `set_girafe_defaults()`, so it applies to every ggiraph plot in the project without any by-name call in a page.

------------------------------------------------------------------------

## 5 Remaining bare hexes

Only three bare hex literals exist in the code base, and each is intentional. Nothing else should introduce a fourth.

| File:Line | Hex | Context | Assessment |
|----|----|----|----|
| `centre_profile.qmd:750` | `#401F09` | `mrr_pal_sequential("#401F09", 4)` brown-ramp anchor | Intentional seed for a non-brand brown ramp |
| `what_do_they_value_and_need.qmd:755, 1016` | `#f5f0e8` | `gt` `cell_fill()` (pale tan table shading) | Table-only accent; not a chart color |

------------------------------------------------------------------------

## 6 Quick diagnostic

To check a page for palette compliance, grep it:

``` bash
# Should be 0 (bare hexes) — the only sanctioned exceptions are the three above:
grep -nE '#[0-9A-Fa-f]{6}' page.qmd

# Should be > 0 on any page that draws charts:
grep -c "shambhala_palette_function\|mrr_pal_\|dark_bar_green\|_background_tint" page.qmd
```

A page with bare hexes outside the sanctioned three, or one that draws charts without touching the palette functions, is not conforming — regardless of whether it renders.
