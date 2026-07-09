#!/usr/bin/env Rscript
# render_standard.R
#
# Turns a single SKILL.md into a draft standards .qmd page. Never overwrites
# an existing hand-edited page — if the target already exists, writes a
# sibling "*.draft.qmd" instead, for a human to merge in manually.
#
# Usage:
#   Rscript R/render_standard.R path/to/SKILL.md standards/page-structure.qmd [source_label]
#
# Requires: stringr, readr, glue, fs

library(stringr)
library(readr)
library(glue)
library(fs)

# ---- Parse ------------------------------------------------------------

#' Split a SKILL.md into YAML frontmatter fields and body
#'
#' @param path path to a SKILL.md file
#' @return list(name, description, body)
parse_skill_md <- function(path) {
  lines <- read_lines(path)
  fence <- which(lines == "---")
  if (length(fence) < 2) {
    stop(glue("No YAML frontmatter found in {path}"))
  }

  yaml_lines <- lines[(fence[1] + 1):(fence[2] - 1)]
  body_lines <- lines[(fence[2] + 1):length(lines)]

  name_line <- yaml_lines[str_detect(yaml_lines, "^name:")]
  desc_line <- yaml_lines[str_detect(yaml_lines, "^description:")]

  list(
    name = str_trim(str_remove(name_line, "^name:\\s*")),
    description = str_trim(str_remove(desc_line, "^description:\\s*")),
    body = paste(body_lines, collapse = "\n")
  )
}

# ---- Build draft --------------------------------------------------------

#' Build a draft standards page from a parsed skill
#'
#' Keeps the skill's own prose (rules, anti-pattern tables, examples) as the
#' bulk of the page, and adds a sourcing callout + sync date so the page can
#' be checked for staleness later by sync_skills.R.
build_draft <- function(skill, source_path, source_label) {
  glue(
    "---\n",
    "title: \"{skill$name}\"\n",
    "subtitle: \"Standards derived from the `{skill$name}` skill\"\n",
    "---\n\n",
    "::: {{.callout-note}}\n",
    "## Source\n",
    "Derived from the `{skill$name}` skill ({source_label}).\n\n",
    "Source file: `{source_path}`\n\n",
    "Last synced: {Sys.Date()}\n",
    ":::\n\n",
    "## Purpose\n\n",
    "{skill$description}\n\n",
    "## Standard\n\n",
    "{skill$body}\n\n",
    "## Notes for reviewers\n\n",
    "_This section is not auto-generated. Add concrete examples, the \"why\"\n",
    "behind each rule, and links to this project's actual code (shared\n",
    "setup scripts, theme functions, etc.) that the skill above may only\n",
    "refer to abstractly._\n"
  )
}

# ---- Render -------------------------------------------------------------

#' Render one SKILL.md to a draft .qmd next to (or in place of) the intended
#' standards page
#'
#' @param skill_md_path path to the source SKILL.md
#' @param output_path intended final location of the standards page
#' @param source_label short label for the callout, e.g. "general" or "project"
#' @return the path actually written, invisibly
render_standard <- function(
  skill_md_path,
  output_path,
  source_label = "project"
) {
  skill <- parse_skill_md(skill_md_path)
  draft <- build_draft(skill, skill_md_path, source_label)

  target <- if (file_exists(output_path)) {
    path_ext_set(output_path, "draft.qmd")
  } else {
    output_path
  }

  dir_create(path_dir(target))
  write_lines(draft, target)
  message(glue("Wrote {target}"))
  invisible(target)
}

# ---- CLI entry point -------------------------------------------------------

if (identical(environment(), globalenv()) && !interactive()) {
  args <- commandArgs(trailingOnly = TRUE)
  if (length(args) < 2) {
    stop(
      "Usage: Rscript render_standard.R <path/to/SKILL.md> ",
      "<output/standards/page.qmd> [source_label]"
    )
  }
  source_label <- if (length(args) >= 3) args[3] else "project"
  render_standard(args[1], args[2], source_label)
}
