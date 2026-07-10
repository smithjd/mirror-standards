# r-data-pipeline-review

Standards derived from the `r-data-pipeline-review` skill

## 0.1 Purpose

Review a set of R data-retrieval/ETL scripts (the backend pipeline that produces the .Rds/.csv files a Quarto site or analysis consumes) to write a code-quality report. Use when the user asks to review, audit, or check the retrieval/pipeline scripts, or when preparing for a new reporting cycle.

## 0.2 Standard

# 1 R Data Pipeline Review

Read a set of backend data-retrieval/cleaning scripts and write a code-quality report to `tasks/data-pipeline-review.md` (create `tasks/` if it doesn’t exist).

## 1.1 Step 1 — Identify the files and their order

Ask the user (or infer from imports/sourced files) which scripts make up the pipeline, and in what order they must run. Note any script that is *sourced* by others rather than run directly — document the dependency chain explicitly, including which steps could run in parallel.

## 1.2 Step 2 — Critical Issues

Flag anything that would produce wrong output or silently fail:

- **Date/period math.** Any date arithmetic that builds a cutoff or reporting period — verify it resolves to the date the author intended. Off-by-one-year and off-by-one-day errors in formulas like `as.double(year) - 1 + 2000` are common; check the arithmetic by hand.
- **Disabled filters.** Look for date-range or status filters that have been commented out — these often get disabled “temporarily” during debugging and never restored.
- **File extension mismatches.** `write_csv()` calls should produce `.csv`; `write_rds()`/ `saveRDS()` calls should produce `.rds`/`.Rds`. Flag mismatches.
- **Unreachable guards.** `is.null(x)` immediately after `x <- readRDS(...)` (or similar) can never be true — `readRDS` either returns a value or errors. Flag dead guards like this.
- **Dead objects.** Objects that are computed but never used downstream or saved.
- **Non-existent column references.** Cross-check `filter()`/`select()` column names against what the upstream step actually produces.

## 1.3 Step 3 — Convention Issues

Check against the project’s stated R conventions (usually in a `CLAUDE.md` or style guide):

- **Pipe**: native `|>`, not `%>%`
- **Joins**: `join_by()`, not `by = c("a" = "b")`
- **Grouping**: `.by =` or explicit `ungroup()` — flag any function that returns a still-grouped data frame to its caller
- **map**: `map() |> list_rbind()` — `map_dfr()` is deprecated
- **Performance**: `rowwise() |> mutate(min(...))` (or similar) on large tables — usually replaceable with a vectorized function like `pmin()`
- **Type safety**: `ifelse()` where `if_else()` would catch type mismatches; numeric comparisons done as strings (e.g. `<= "3"` instead of `<= 3L`)
- **Tidy-eval misuse**: `{ }` used where a plain `.env$var` or string would be correct

## 1.4 Step 4 — Readability and Logic Issues

- Hardcoded values that should be derived from a previous step instead of pasted in
- `NA` converted to the literal string `"NA"` (breaks downstream `is.na()` checks)
- Duplicate column selections in the same `select()` call
- `knitr::opts_chunk$set()` inside a plain `.R` script (no-op outside a `.qmd`/`.Rmd`)
- A local variable shadowing a package function name (e.g. `today <- Sys.Date()` shadowing `lubridate::today()`)
- Date-span math done with `365 * n` instead of a calendar-aware function (`years(n)`, `months(n)`) — fails on leap years
- Leftover `View()` calls and large commented-out blocks in production scripts
- Missing `file.exists()` guards before reading a file that might not be there yet

## 1.5 Step 5 — Summary Table

End with:

| \#  | File | Severity | Issue |
|-----|------|----------|-------|

Severity levels: **Critical** (wrong output), **High** (convention violation or performance), **Medium** (logic or clarity), **Low** (style).

## 1.6 Tone and Format

- Use fenced code blocks to show the problem and the fix side by side where helpful.
- Keep descriptions factual and specific — cite file and line number where possible.
- Do not summarize what each file does; focus entirely on problems and fixes.
- No introductory preamble; start directly with “## Execution Order”.
