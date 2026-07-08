# 05 — Accessibility

Charts published on the web are subject to WCAG 2.2 Level AA. These rules make that
concrete for data graphics. IDs: `AX-*`.

## Contrast

- **AX-1 (MUST)** Text on and around charts meets **4.5:1** contrast against its
  background (WCAG 1.4.3); large text (≥24px, or ≥18.66px bold) may drop to 3:1.
  The neutral text colors in [03-color-palettes.md](03-color-palettes.md) comply on
  white (`#333333` = 12.6:1, `#555555` = 7.5:1).
- **AX-2 (MUST)** Essential graphical elements — bars, lines, points that the reader
  must distinguish to understand the chart — meet **3:1** against adjacent colors
  (WCAG 1.4.11). The default categorical palette was chosen to satisfy this against
  white (verified 3.03–10.86:1).
- **AX-3 (SHOULD)** Sequential ramps cannot keep 3:1 between adjacent steps; when a
  chart depends on fine sequential distinctions, provide the values as labels or an
  accompanying table (UK Analysis Function requirement). Note also Datawrapper's
  caution that mechanically applying WCAG ratios to gradients can *reduce*
  discriminability — satisfy the intent (readable data) and document exceptions.

## Color independence

- **AX-4 (MUST)** Color is never the only carrier of meaning (WCAG 1.4.1). Pair it
  with direct labels (TY-6), position, marker shape, or line type. Okabe & Ito: "use
  not only different colors but also a combination of different shapes, positions,
  line types."
- **AX-5 (MUST)** Test every published palette combination with a color-vision
  simulator (e.g. Sim Daltonism, Viz Palette) and in greyscale; adjacent categories
  must differ in lightness, not hue alone. Avoid red/green pairs; prefer blue/orange
  or blue/red; use vermilion rather than pure red where red is required (Okabe–Ito).

## Text alternatives

- **AX-6 (MUST)** Every chart has a text alternative serving the equivalent purpose
  (WCAG 1.1.1): alt text on the image, plus either an accessible data table or
  descriptive prose for complex charts (UK Analysis Function).
- **AX-7 (MUST)** Alt text states the chart type, the variables, and the finding —
  content and function, not appearance. Keep it roughly a sentence (~160 characters,
  Urban Institute); put the full data elsewhere. No "image of", no "chart of" prefix
  beyond the type. Example: *"Line chart showing UK inflation falling from 11% in
  2022 to 2% by mid-2024."*
- **AX-8 (SHOULD)** Render titles, subtitles, and sources as HTML text, not pixels
  (TY-5), and publish charts as SVG where feasible (UK AF) so text scales and
  high-contrast modes work.
- **AX-9 (SHOULD)** Offer the underlying data for download with unique, descriptive
  link text (UK AF).

## Legibility floor

- **AX-10 (MUST)** Minimum rendered text size on the web: ~11–12px for source notes,
  12px for axis labels (Urban Institute scale, TY-3); verify at the smallest
  responsive breakpoint, not the desktop layout.
- **AX-11 (SHOULD)** Lines carrying data are thick enough to show their color
  (roughly ≥2px); increase mark weight rather than saturating color to rescue a thin
  mark (Okabe–Ito: bold fonts, thicker lines for color-coded objects).

## Review checklist

1. Title states the finding; subtitle has measure/unit/period. (P-2, TY-1)
2. Correct chart family for the analytical function. (CT-1)
3. Zero baselines where length encodes value; no broken axes. (P-3)
4. Palette role correct; colors in palette order; ≤6 categories. (CO-2/3/4)
5. Survives greyscale and colorblind simulation. (AX-5)
6. No meaning by color alone; direct labels present. (AX-4, TY-6)
7. Text contrast 4.5:1; graphical contrast 3:1 or mitigated. (AX-1/2/3)
8. Alt text + table/prose alternative. (AX-6/7)
9. Source line present and correct. (P-7, TY-15)
10. Readable at mobile width. (AX-10)
