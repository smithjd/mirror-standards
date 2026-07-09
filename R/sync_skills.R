#!/usr/bin/env Rscript
# sync_skills.R
#
# Scans source skill directories, hashes each SKILL.md, and compares
# against the tracked manifest (_sync/skill_manifest.csv) to flag
# new / changed / removed / unchanged skills. Run this before an authoring
# or review pass. It never edits standards pages itself — it only tells you
# what needs attention, updates the manifest, and appends to changelog.qmd.
#
# Usage:
#   Rscript R/sync_skills.R
#
# Requires: here, fs, digest, readr, dplyr, purrr, stringr, glue, tibble
# Optional: cli (nicer console output; falls back to base warning() if absent)

library(here)
library(fs)
library(digest)
library(readr)
library(dplyr)
library(purrr)
library(stringr)
library(glue)
library(tibble)

# ---- Config ----------------------------------------------------------------
# Edit these paths for your machine. Each entry should point to a directory
# tree containing SKILL.md files nested one level down (skill_name/SKILL.md),
# matching Anthropic's standard skill layout.

source_dirs <- c(
  general = "/mnt/skills/public",
  project = "/Users/jds/Documents/cch/SGS_IT/PT-stats/as-mirror.nosync"
)

manifest_path  <- here("_sync", "skill_manifest.csv")
changelog_path <- here("changelog.qmd")

# ---- Helpers -----------------------------------------------------------

cli_or_warning <- function(msg) {
  if (requireNamespace("cli", quietly = TRUE)) {
    cli::cli_alert_warning(msg)
  } else {
    warning(msg, call. = FALSE)
  }
}

# ---- Discover current skills ------------------------------------------

#' Find every SKILL.md under a set of named source directories
#'
#' @param dirs named character vector of directory paths; names become the
#'   `source` column (e.g. "general", "project")
#' @return tibble of source, skill_name, path, hash
discover_skills <- function(dirs) {
  dirs |>
    imap(\(dir_path, source_name) {
      if (!dir_exists(dir_path)) {
        cli_or_warning(glue("Source dir not found, skipping: {dir_path}"))
        return(tibble())
      }
      skill_files <- dir_ls(dir_path, recurse = TRUE, glob = "*SKILL.md")
      if (length(skill_files) == 0) return(tibble())
      tibble(
        source     = source_name,
        skill_name = path_file(path_dir(skill_files)),
        path       = as.character(skill_files),
        hash       = map_chr(skill_files, ~ digest(file = .x, algo = "sha256"))
      )
    }) |>
    list_rbind()
}

# ---- Load / initialize manifest ----------------------------------------

#' Read the tracked manifest, creating an empty skeleton if none exists yet
load_manifest <- function(path) {
  if (file_exists(path)) {
    read_csv(path, col_types = cols(.default = "c"))
  } else {
    tibble(
      source         = character(),
      skill_name     = character(),
      path           = character(),
      hash           = character(),
      standards_page = character(),
      last_synced    = character()
    )
  }
}

# ---- Diff current vs tracked --------------------------------------------

#' Compare freshly discovered skills against the tracked manifest
#'
#' @return tibble with a `status` column: "new", "changed", "unchanged", "removed"
diff_skills <- function(current, tracked) {
  join_cols <- c("source", "skill_name")

  new_or_changed <- current |>
    left_join(
      tracked |> select(source, skill_name, tracked_hash = hash, standards_page),
      by = join_cols
    ) |>
    mutate(
      status = case_when(
        is.na(tracked_hash)  ~ "new",
        hash != tracked_hash ~ "changed",
        TRUE                  ~ "unchanged"
      )
    )

  removed <- tracked |>
    anti_join(current, by = join_cols) |>
    mutate(status = "removed", hash = NA_character_)

  bind_rows(
    new_or_changed |> select(source, skill_name, path, hash, standards_page, status),
    removed        |> select(source, skill_name, path, hash, standards_page, status)
  )
}

# ---- Write manifest + changelog -----------------------------------------

#' Write the manifest back out, stamping today's date on new/changed rows
#' and carrying forward last_synced dates for everything else
write_manifest <- function(diffed, tracked, path) {
  today <- as.character(Sys.Date())

  updated <- diffed |>
    filter(status != "removed") |>
    left_join(
      tracked |> select(source, skill_name, prior_synced = last_synced),
      by = c("source", "skill_name")
    ) |>
    mutate(
      last_synced = case_when(
        status %in% c("new", "changed") ~ today,
        TRUE                             ~ prior_synced
      )
    ) |>
    select(source, skill_name, path, hash, standards_page, last_synced)

  dir_create(path_dir(path))
  write_csv(updated, path)
  invisible(updated)
}

#' Append a dated entry to changelog.qmd for every new/changed/removed skill
append_changelog <- function(diffed, path) {
  notable <- diffed |> filter(status != "unchanged")
  if (nrow(notable) == 0) return(invisible(NULL))

  today <- Sys.Date()
  entry_lines <- notable |>
    mutate(line = glue("- **{skill_name}** ({source}): {status}")) |>
    pull(line)

  if (!file_exists(path)) {
    dir_create(path_dir(path))
    write_lines(c("---", "title: Changelog", "---", ""), path)
  }
  write_lines(c(glue("\n## {today}\n"), entry_lines), path, append = TRUE)
}

# ---- Run ------------------------------------------------------------------

main <- function() {
  current <- discover_skills(source_dirs)
  tracked <- load_manifest(manifest_path)
  diffed  <- diff_skills(current, tracked)

  message("Sync summary:")
  print(diffed |> count(status))

  stale <- diffed |> filter(status %in% c("new", "changed"))
  if (nrow(stale) > 0) {
    message("\nSkills needing a standards-page review:")
    print(stale |> select(source, skill_name, status))
    message(
      "\nNext step: Rscript R/render_standard.R <SKILL.md path> ",
      "<standards/target.qmd> <source label>"
    )
  } else {
    message("Nothing to review — all tracked skills unchanged.")
  }

  write_manifest(diffed, tracked, manifest_path)
  append_changelog(diffed, changelog_path)

  invisible(diffed)
}

if (identical(environment(), globalenv())) main()
