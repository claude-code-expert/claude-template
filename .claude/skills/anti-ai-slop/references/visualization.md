# Anti-Slop: Visualization & Images

Applies to charts, graphs, diagrams, and any image placed in a document.

## What slop is here

Charts that decorate instead of encode — default colors, wrong chart type, clutter that hides the point — and generated raster images that carry the tell-tale "AI look" where a real screenshot or a built diagram belonged.

## Chart tells (anti-patterns)

- Rainbow / jet colormap for continuous data (perceptually non-uniform, invents false bands). Use a perceptually-uniform map (viridis) instead.
- 3D pie charts, and pie charts at all beyond ~3 slices — angle/area sit low on the accuracy hierarchy.
- Truncated y-axis on a bar chart (exaggerates difference); undeclared dual y-axes (implies a correlation you didn't show).
- Chartjunk: heavy gridlines, borders, backgrounds, gradient fills, drop shadows, 3D extrusion — ink that encodes nothing.
- Too many series on one chart (>6 lines/categories); facet into small multiples instead.
- A legend the reader must ping-pong to, where direct labels on the lines/bars would do.
- Unsorted categorical bars (sort by value unless the category has a natural order).
- Unlabeled or unitless axes; a chart whose title states the topic, not the finding.
- Decorative-only charts that add no information a sentence wouldn't carry better.

## AI-image tells (avoid, and prefer real assets)

The "AI look": waxy over-smooth skin, warped hands / wrong finger count, garbled text in the image, bilateral-symmetry mush, oversaturation and HDR halo, impossible lighting/shadows, melting or repeating backgrounds, generic stock vibe.

**Rule:** for docs, prefer a real screenshot, an SVG/Mermaid diagram, or a hand-built chart over a generated raster image. Generated images belong in a doc only when the subject is illustrative and no real asset exists — and even then, check the tells above before using one.

## Rules (do this)

- Match the chart to the data using the perceptual order: **position > length > angle > area > color** (Cleveland & McGill). Bars/dots/scatter for precise comparison.
- Categorical color: start from a colorblind-safe qualitative palette (**Okabe-Ito**, or Paul Tol for >8); keep to ≤6 colors.
- Vary lightness, not just hue, so the palette survives grayscale; avoid red/green and blue/purple pairs.
- Sequential data → sequential map; centered/divergent data → diverging map; categories → qualitative palette. Don't cross these.
- Direct-label series where you can; sort categorical bars by value; start bar axes at zero.
- Maximize data-ink: delete gridlines, borders, and backgrounds that encode nothing (Tufte) — within reason.
- Annotate the insight on the chart; the title states the finding, not the topic.
- Never rely on color alone — add shape, label, or pattern (WCAG 1.4.1).
- Always write alt text describing the finding, not "a chart."

## Tools & standards

- **Cleveland & McGill** — perceptual accuracy hierarchy for choosing encodings.
- **Tufte** — data-ink ratio and chartjunk.
- **Okabe-Ito / Paul Tol / ColorBrewer** — colorblind-safe categorical and sequential palettes.
- **viridis** — perceptually-uniform continuous colormap (matplotlib default).
- **WCAG 2.2** — contrast (1.4.3) and use-of-color (1.4.1).
- **Vega-Lite / Datawrapper** — grammar-of-graphics and newsroom-grade chart defaults.

## Sources

- Cleveland-McGill hierarchy — https://www.textbookofusability.com/glossary/cleveland-mcgill-hierarchy.html
- Practitioners' perspectives on chartjunk / data-ink (Tufte) — https://arxiv.org/pdf/2009.02634
- Okabe-Ito palette (hex + usage; = Wong, Nature Methods) — https://conceptviz.app/blog/okabe-ito-palette-hex-codes-complete-reference
- ColorBrewer — https://colorbrewer2.org · matplotlib colormaps — https://matplotlib.org/stable/users/explain/colors/colormaps.html
- WCAG 2.2 — Use of Color (1.4.1) & Contrast (1.4.3) — https://www.w3.org/WAI/WCAG22/Understanding/use-of-color.html
- Spotting AI-generated images (tells) — https://insight.kellogg.northwestern.edu/article/ai-photos-identification
