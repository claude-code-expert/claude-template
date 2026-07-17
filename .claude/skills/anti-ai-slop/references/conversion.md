# Anti-Slop: Document Conversion & Editing

Applies to converting a document between formats (Markdown ↔ DOCX/PDF/HTML/LaTeX/slides) and to editing/refactoring an existing document.

## What slop is here

Any transform that silently degrades a document: dropping content, flattening semantic structure, or a lossy round-trip on conversion — and, when a small edit was asked, rewriting wholesale or regex-hacking a structured format instead of parsing it. The result looks plausible and is quietly wrong.

## Tells (anti-patterns)

- Regex / find-replace on HTML or Markdown structure instead of a parser — breaks on `#` inside code blocks, Setext headings, nested tags, `$` in prose vs. math.
- Wholesale rewrite when a minimal, span-level edit was requested; returning the whole file instead of a diff.
- Dropping or inlining footnotes, merged table cells, cross-references, YAML frontmatter, or code-block language tags on conversion.
- Flattening heading hierarchy (H2/H3 → bold text) or collapsing nested lists.
- Breaking internal links, anchors, and the TOC after moving or renaming sections.
- Changing the author's voice mid-edit — "fixing" contractions, idiosyncratic capitalization, or reordering paragraphs; editing quoted material or code that was meant to stay verbatim.
- No validation: never diffing output against source, never opening the result.
- PDF-from-screenshot / raster (e.g. html2pdf.js) producing non-selectable, non-searchable text, with no running headers or real pagination.

## Rules (do this)

- Use AST/parser tools (Pandoc, remark/rehype) for structured formats; never regex-transform HTML/Markdown structure.
- Preserve semantic elements: headings, list nesting, tables, footnotes, links, code-block languages, metadata/frontmatter.
- Prefer a minimal diff over a rewrite; edit the flagged spans in place, leave clean passages untouched.
- Keep one source of truth (e.g. Markdown) and generate the rest; don't hand-maintain parallel copies.
- Validate output against source — diff, round-trip, or open the file — before declaring done.
- Make transforms idempotent: re-running produces no further change.
- Preserve the author's voice on edits; don't touch quotes, code, or attributed text — flag it instead.
- After structural edits, update cross-references, anchors, and the TOC.
- Treat conversion as lossy by design (Pandoc's AST is a least-common-denominator); flag dropped elements rather than hiding the loss.
- Enforce mechanical formatting with a deterministic linter, not by re-writing the prose.

## Tools & standards

- **Pandoc** — universal reader→AST→writer converter; Lua/JSON **filters** transform structure, not text; `--to native` shows what the AST kept or dropped.
- **Typst** — fast Rust typesetter, Markdown-like syntax; a modern `--pdf-engine` alternative to LaTeX.
- **WeasyPrint** — HTML/CSS→PDF via CSS Paged Media (running headers, footnotes, real pagination); selectable text, no screenshotting.
- **remark / rehype** — unified mdast/hast AST pipeline (parse→transform→stringify); use `unist-util-visit`, not regex.
- **markdownlint** — deterministic Markdown structure/style linting; catches heading and whitespace drift without touching prose.

## Sources

- Pandoc — Filters — https://pandoc.org/filters.html
- Pandoc — User's Guide (conversion is not lossless) — https://pandoc.org/MANUAL.html
- Transforming Markdown with remark & rehype — https://ryanfiller.com/blog/remark-and-rehype-plugins
- Modifying nodes in an AST (CSS-Tricks) — https://css-tricks.com/how-to-modify-nodes-in-an-abstract-syntax-tree/
- WeasyPrint vs. other PDF generators — https://weasyprint.com/
- Typst as a fast (Xe)LaTeX alternative — https://slhck.info/software/2025/10/25/typst-pdf-generation-xelatex-alternative.html
