# survey-page-conventions

Standards derived from the `survey-page-conventions` skill

## 0.1 Purpose

This standard clarifies good practice as it applies to societal mirror pages that present data from Survey Monkey.

## 0.2 Standard

# 1 Survey Page Conventions

Survey pages draw from labelled SPSS files such as (`m26`, `m25`, `m24`, `L26`, `L25`, `L24`) loaded by `shared_code_26.R`. They use the `labelled` package throughout — `var_label()`, `to_factor()`, `to_character()` — and differ visually from admin pages via background tint.

Alternatively use the following code:

``` r
dictionary <- spss_df |> look_for()
```

## 1.1 Data Dictionary

When constructing pipelines or graphs, use `./back-end/dd_m26.json` as a reference data dictionary describing the `m26` survey.

When constructing pipelines or graphs, use `./back-end/dd_C26.json` as a reference data dictionary describing the `C26` survey.

## 1.2 Visual Identity: Background Tints

| Survey | Constant | Hex | Use |
|----|----|----|----|
| Member (`m26`, `m25`, `m24`) | `member_background_tint` | \#FEF7F4 | warm pinkish |
| Centre/Leader (`C26`,`L25`, `L24`) | `leader_background_tint` | \#F4FFF5 | cool greenish |
| Admin/SDB | `sdb_background_tint` | \#F4F4F4 | neutral grey |

Every survey ggplot must carry its tint in both backgrounds:

``` r

theme(
  plot.background = element_rect(fill = member_background_tint),
  panel.background = element_rect(fill = member_background_tint)
)
```

## 1.3 ggplot Template: Horizontal Bar (percentages)

The dominant pattern — categories sorted by `pct`, labels inside bars:

``` r

data |>
  mutate(
    category = str_wrap(category, width = 30),
    category = fct_reorder(category, pct)
  ) |>
  ggplot(aes(category, pct)) +
  geom_col(fill = dark_bar_green) +
  geom_text(
    aes(label = scales::percent(pct, accuracy = 1)),
    y = pct / 2, # center in bar
    color = "white",
    fontface = "bold"
  ) +
  scale_y_continuous(
    labels = scales::percent_format(), # data is 0–1 proportions
    limits = c(0, 0.8)
  ) +
  labs(title = str_wrap("Question text here", width = 40), x = NULL, y = NULL) +
  coord_flip() +
  mirror_theme() +
  theme(
    panel.grid.major.y = element_blank(),
    plot.background = element_rect(fill = member_background_tint),
    panel.background = element_rect(fill = member_background_tint)
  )
```

**Scale note:** Survey percentages are often stored as 0–1 proportions — use `scales::percent_format()` and `scales::percent(pct, accuracy = 1)`. If stored as 0–100 (e.g., after `* 100`), use `scales::percent_format(scale = 1)` and `scales::percent(pct, accuracy = 1, scale = 1)`.

## 1.4 ggplot Template: Stacked Bar (multi-response fill)

For yes/maybe/no or ordered response categories:

``` r

data |>
  mutate(
    response = to_factor(response),
    response = fct_rev(response),
    var_label = fct_reorder(var_label, pct, .fun = sum)
  ) |>
  ggplot(aes(var_label, pct, fill = response)) +
  geom_col() +
  geom_text(
    aes(label = scales::percent(pct, accuracy = 1, scale = 1)),
    color = "white",
    fontface = "bold",
    position = position_stack(vjust = 0.5)
  ) +
  scale_fill_manual(values = c("Yes" = "#247467ff", "Maybe" = "#63bba9ff")) +
  scale_y_continuous(
    labels = scales::percent_format(scale = 1),
    limits = c(0, 80)
  ) +
  labs(title = str_wrap("...", 40), x = NULL, y = NULL, fill = NULL) +
  coord_flip() +
  mirror_theme() +
  theme(
    legend.position = "top",
    panel.grid.major.y = element_blank(),
    plot.background = element_rect(fill = member_background_tint),
    panel.background = element_rect(fill = member_background_tint)
  )
```

## 1.5 Key Utility Functions (shared_functions_26.R)

### 1.5.1 role_subset() — filter by role flag, get counts

``` r

q <- role_subset(
  data = m26_relate_to_a_center,
  title_flag_var = q0035, # unquoted; rows where == 1 kept
  subject_vars = c("q0036", sprintf("q0037_%04d", 1:5)),
  comment_var = q0037_other
)
# Returns list: q$df, q$counts (named list of tibbles), q$comments
# e.g. q$counts$n_q0036 is a count tibble for q0036
```

### 1.5.2 count_yes_str() — count binary Yes (==1) across role vars

``` r

role_counts <- map(role_vars, \(v) count_yes_str(m26_relate_to_a_center, v)) |>
  bind_rows() |>
  mutate(pct = round(n / n_total * 100))
# Returns: n, label (var_label), var_name
```

### 1.5.3 calc_pct_selected() — % selecting follow-up items among role-holders

``` r

calc_pct_selected(
  data = m26_relate_to_a_center,
  root_var = "q0035", # character string
  filter_value = "Yes",
  list_vars = sprintf("q0042_%04d", 1:5)
)
# Returns: root_var, var_label, var_value, choice_label, have_the_job, n, pct
```

### 1.5.4 calc_val_labels() — build long-format count df for multi-item series

``` r

# Requires q$counts to exist in environment
count_all <- calc_val_labels("q0037", n_levels = 5)
# Returns long-format tibble: n, name, value (factor), choice_label
```

### 1.5.5 plot_1_level() — quick horizontal bar for a single categorical var

``` r

plot_1_level(q$counts$n_q0036) # auto-extracts var_label as title
plot_1_level(q$counts$n_q0036, pct_max = 100)
```

### 1.5.6 plot_interest() — horizontal bar for interest/support items

``` r

plot_interest(teacher_interest_counts, gtitle = "Are you interested in...?")
```

### 1.5.7 count_all_that_apply() — multiple-select (“check all that apply”) questions

``` r

count_all_that_apply(m26, "q0015")
# Returns: value, n, percent — denominator is all respondents who answered
```

### 1.5.8 Counting Yes (==1) across non-contiguous named variables

When variables share no common prefix, name them explicitly with `any_of()` and pivot long:

``` r

activity_vars <- c("q0001", "q0003", "q0009", "q0011", "q0013")
n_total <- 1335 # set denominator explicitly

activity_counts <- m26 |>
  select(RespondentID, any_of(activity_vars)) |>
  pivot_longer(-RespondentID, names_to = "variable", values_to = "value") |>
  filter(value == 1) |>
  count(variable, name = "n_yes") |>
  mutate(pct = n_yes / n_total)
```

### 1.5.9 Extracting joinable variable labels for a named set of columns

When you need `var_label()` as a data frame to join onto counts:

``` r

var_labels <- m26 |>
  select(any_of(activity_vars)) |>
  var_label() |>
  as_tibble_row() |>
  pivot_longer(everything(), names_to = "variable", values_to = "label") |>
  mutate(label = as.character(label))

activity_counts <- activity_counts |>
  left_join(var_labels, by = join_by(variable))
```

### 1.5.10 Deriving a short_label from verbose SPSS variable label text

Variable labels often share a common preamble (e.g., “In the past 12 months, did you …?”). Extract just the differentiating fragment with a lookbehind/lookahead regex, then recode to human-friendly labels. Use **`replace_values()`** when you only need to fix a few labels and want all other values to pass through unchanged:

``` r

mutate(
  short_label = str_extract(label, "(?<=did you ).*?(?=\\?)"),
  short_label = str_to_sentence(short_label),
  short_label = replace_values(
    short_label,
    "Donate financially or pay dues to shambhala" ~ "Any donation or dues payment",
    "Participate in group meditation practice" ~ "Participate in group meditation"
    # unspecified values are left as-is automatically
  )
)
```

Use **`case_match()`** instead when building an entirely new vector and enumerating all cases (any omitted value becomes `NA` unless `.default` is set):

``` r

short_label <- case_match(
  short_label,
  "Donate financially or pay dues to shambhala" ~ "Any donation or dues payment",
  .default = short_label # required — omitting makes unmatched values NA
)
```

**Rule of thumb:** partial update → `replace_values()`; full recode → `case_match()`.

Adjust the lookbehind string to match the preamble in your question series. Note: `dplyr::recode()` is deprecated — use `replace_values()` or `case_match()` instead.

### 1.5.11 disp_var_prep() — select a variable group by prefix

``` r

disp_var_prep(m26, "q0015")
# Returns: RespondentID + all cols starting with "q0015", drops character cols
```

### 1.5.12 pivot_df() — pivot to long format with within-variable percentages

``` r

disp_var_prep(m26, "q0015") |> pivot_df()
# Returns: var_name, value, n, pct (pct is within-var, sums to 1 per var_name)
```

## 1.6 labelled Package Patterns

Survey data is SPSS-style labelled. Always handle labels explicitly:

``` r

# Get variable label (question text) — use as plot title
var_label(m26$q0035)
var_label(df) |> pluck(1) # from single-column df

# Convert value labels to factor for plotting
df |> to_factor() # converts all labelled cols
df |> mutate(q0035 = to_factor(q0035)) # single col

# Convert to character (for counting, joining)
df |> to_character()

# Inspect what variables exist
m26 |> look_for("keyword")
makedd() # creates m26dd, m25dd, L25dd, m24dd, L24dd in global env

# ggplot2 4.0+ picks up var_label automatically on bare column names:
ggplot(m26, aes(q0035, q0036)) + geom_point() # axis labels auto-filled
# For bulk override: labs(dictionary = unlist(var_label(df)))
```

## 1.7 Variable-Specific Transformations

### 1.7.1 q0080 — Decade first joined (always collapse)

Whenever `q0080` is used, immediately follow `to_factor()` with this collapse to reduce the 7-level decade variable to 4 meaningful groups:

``` r

to_factor() |>
  mutate(
    q0080 = fct_collapse(
      q0080,
      "70's-80's" = c("1970s", "1980s"),
      "90's-2007" = c("1990s", "2000-2007"),
      "2008-2017" = c("2008-2012", "2013-2017")
    )
  ) |>
```

The four resulting levels are: `"70's-80's"`, `"90's-2007"`, `"2008-2017"`, `"2018-2025"`.

### 1.7.2 q0032 — Relates to a centre (strip parenthetical label)

`q0032` value labels for “No” and “Not sure” contain a long parenthetical that must be stripped before plotting or factoring:

``` r

mutate(
  q0032 = str_remove_all(
    as.character(q0032),
    "\\s*\\(you will automatically skip to the next set of questions\\)"
  ),
  q0032 = str_trim(q0032),
  q0032 = factor(q0032, levels = c("Yes", "Not sure", "No"))
)
```

Apply this after `to_character()` or `as.character()` — do not apply to the raw labelled column.

### 1.7.3 q0034 — Primary membership identity (filter to centre-affiliates)

`q0034` asks respondents to identify as centre member, global member, friend, donor, etc. It is only meaningful for those who relate to a centre. Always filter to `q0032 == 1` before using `q0034`:

``` r

m26 |>
  filter(q0032 == 1) |>
  select(q0080, q0034) |>
  ...
```

`q0034` has 6 long value labels — always apply `str_wrap(as.character(q0034), width = 30)` after `to_factor()` to keep legends readable. Use `fct_inorder()` afterward to preserve label order:

``` r

mutate(
  q0034 = str_wrap(as.character(q0034), width = 30),
  q0034 = fct_inorder(q0034)
)
```

## 1.8 Color Palette — When to Use `scale_fill_brewer`

The standard `green_step_2[3:1]` fill works for **3-level** outcomes. For variables with **4+ unordered categories** (e.g., `q0034` with 6 levels), use:

``` r

scale_fill_brewer(palette = "Dark2")
```

For ordered/sequential outcomes (low → high), continue using `green_step_2[3:1]` (3 levels) or `green_step_5` (5 levels).

## 1.9 Variable Naming Conventions

- Single items: `q0035`, `q0038`, `q0062`
- Multi-part items: `q0037_0001` through `q0037_0005` — generate with `sprintf("q0037_%04d", 1:5)`
- Binary flags (role held): coded `1` = Yes
- Open-ended text companions: `q0037_other` (character class — excluded by `disp_var_prep`)
- Sub-population filter: `q0032 == 1` for centre-affiliated respondents

## 1.10 Standard Sub-population Filters

``` r

# Set once at top of page, then use throughout
m26_relate_to_a_center <- m26 |> filter(q0032 == 1)
n_relate_to_local_center <- nrow(m26_relate_to_a_center)

# Always report n in table source notes:
tab_source_note(source_note = paste0("n = ", n_relate_to_local_center, " ..."))
```

## 1.11 gt Table Template (survey)

``` r

data |>
  gt() |>
  cols_label(var = "Label", pct = "% of Total") |>
  fmt_percent(is.numeric, decimals = 0) |>
  tab_header(title = md("Title<br>Subtitle")) |>
  tab_source_note(source_note = paste0("n = ", n, " respondents")) |>
  mrr_gt_theme(col_label_size = 18) # note: survey tables often use 18
```

For grouped tables with row group headers:

``` r

gt() |>
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_row_groups()
  ) |>
  mrr_gt_theme()
```

## 1.12 Page Structure

Survey sections follow the **Capacity + Interest + Table** tabset pattern:

## 1.13 Role Name

(the following three colons are deliberatly spaced to avoid being interpreted as a YAML front matter block)  
: : panel-tabset

## 1.14 Capacity

``` r

#| label: img-role_capacity
q <- role_subset(
  m26_relate_to_a_center,
  q00XX,
  c("q00YY", sprintf("q00ZZ_%04d", 1:N))
)
plot_1_level(q$counts$n_q00YY)
```

## 1.15 Interest in support

``` r

#| label: img-role_interest_in_support
interest_counts <- all_pct_selected |>
  filter(var_label == "Role Label", str_detect(var_value, "Yes, I would"))
plot_interest(interest_counts, gtitle)
```

## 1.16 Interest in support table

``` r

#| label: tbl-role_interest_table
gt_table_interest(interest_counts_full, gtitle)
```

: : :

Collapsible tables use raw HTML:

``` r
<details><summary>Click to show all responses in a table</summary>
```

# 2 gt table code

``` r
</details>
```

## 2.1 Chunk Label Prefixes

- `fig-` for figures
- `tbl-` for tables
- Descriptive snake_case after the prefix

## 2.2 show_open_endeds Flag

Set at top of page:

``` r

show_open_endeds <- FALSE
```

Use `#| eval: !expr show_open_endeds` on chunks with open-ended text.
