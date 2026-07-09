# Newsroom Web Standard for Data Reporting

A house standard for publishing charts and data-driven reporting on the web. It defines which chart types to use for which analytical task, which color palettes to use, and the typography, annotation, and accessibility rules that hold the two together.

The standard is distilled from the published practice of three newsrooms with mature data-visualization operations — the **BBC** (Visual & Data Journalism cookbook and `bbplot`), the **Financial Times** (Visual Vocabulary and chart color tokens), and **The Economist** (visual style guide) — cross-checked against non-newsroom authorities: the UK Government Analysis Function, the Urban Institute, Datawrapper, the Okabe–Ito colorblind-safe palette, and WCAG 2.2. Every hex code and rule traces to a published source; see [07-sources.qmd](../newsroom-data-reporting-standards/07-sources.llms.md).

## 1 Conformance language

The key words **MUST**, **MUST NOT**, **SHOULD**, **SHOULD NOT**, and **MAY** are used as described in [RFC 2119](https://www.rfc-editor.org/rfc/rfc2119):

- **MUST / MUST NOT** — an absolute requirement. A chart violating it fails review.
- **SHOULD / SHOULD NOT** — the default. Deviating requires a documented reason.
- **MAY** — genuinely optional.

Rules carry stable IDs (e.g. `CT-3`, `CO-7`) so reviews can cite them.

## 2 Documents

| File | Scope |
|----|----|
| [01-principles.qmd](../newsroom-data-reporting-standards/01-principles.llms.md) | Core principles: clarity, integrity, titling, sourcing (rules `P-*`) |
| [02-chart-types.qmd](../newsroom-data-reporting-standards/02-chart-types.llms.md) | Chart-type selection by analytical function; anti-patterns (rules `CT-*`) |
| [03-color-palettes.qmd](../newsroom-data-reporting-standards/03-color-palettes.llms.md) | Palettes with hex codes; color usage rules (rules `CO-*`) |
| [04-typography-annotation.qmd](../newsroom-data-reporting-standards/04-typography-annotation.llms.md) | Titles, labels, legends, number formatting, source lines (rules `TY-*`) |
| [05-accessibility.qmd](../newsroom-data-reporting-standards/05-accessibility.llms.md) | Contrast, alt text, color-independence (rules `AX-*`) |
| [06-implementation-r.qmd](../newsroom-data-reporting-standards/06-implementation-r.llms.md) | Non-normative appendix: applying the standard in ggplot2/Quarto |
| [07-sources.qmd](../newsroom-data-reporting-standards/07-sources.llms.md) | Annotated bibliography |

## 3 How to use this standard

1.  **Choosing a chart** — start from the analytical function of the message ([02-chart-types.qmd](../newsroom-data-reporting-standards/02-chart-types.llms.md)), not from a chart you like.
2.  **Coloring it** — pick the palette role (categorical, sequential, diverging, highlight) in [03-color-palettes.qmd](../newsroom-data-reporting-standards/03-color-palettes.llms.md); never invent ad-hoc colors.
3.  **Finishing it** — apply the titling, labeling, and sourcing rules ([04-typography-annotation.qmd](../newsroom-data-reporting-standards/04-typography-annotation.llms.md)) and the accessibility checklist ([05-accessibility.qmd](../newsroom-data-reporting-standards/05-accessibility.llms.md)).
4.  **Reviewing** — a reviewer should be able to pass/fail any published chart against the numbered rules alone.

## 4 Scope

Applies to any chart published on the web: static images, SVG, and interactive graphics embedded in articles, dashboards, or reports. The core standard is technology-agnostic; [06-implementation-r.qmd](../newsroom-data-reporting-standards/06-implementation-r.llms.md) maps it to an R/ggplot2/Quarto stack but any charting library can conform.
