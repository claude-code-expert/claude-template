---
name: anti-ai-slop
description: Produce documents, visuals, and file transforms that read as deliberate human work instead of generic AI output. Use whenever writing prose (docs, README, reports, PR/commit bodies, code comments), creating a chart/graph/diagram or choosing an image, or converting/editing an existing document (format conversion, refactor, bulk edit). Read the matching reference before producing the artifact.
---

# Anti-AI-Slop

Slop is fluent, generic, padded output that looks plausible and carries little information. It hedges instead of committing, decorates instead of informing, and uses the same shape every time. It survives because nobody edits it.

This skill is three checklists — one per medium — plus the shared idea below.

## The one test

Before shipping any artifact, ask: *what would the person who owns this and has to defend it cut or sharpen?* Then do that. If you can delete a sentence, a gridline, or a converted element and lose nothing, it was slop.

## Universal rules (every medium)

- **Signal per unit.** Every sentence, every mark of ink, every byte earns its place or gets cut.
- **Commit to specifics.** Named things, real numbers, one clear choice — not a hedged survey of options.
- **Match the reader's task.** Shape the artifact to what the reader needs to do, not to a template.
- **Vary the rhythm.** Uniform length and repeated structure is itself the tell.
- **Preserve what exists.** Edit minimally. Don't rewrite prose, regenerate an image, or reconvert a doc wholesale when a small change was asked.

## Route to the checklist

| When you are… | Read first |
|---|---|
| Writing prose — docs, README, report, PR/commit body, comments | [references/writing.md](references/writing.md) |
| Making a chart/graph/diagram, or choosing/generating an image | [references/visualization.md](references/visualization.md) |
| Converting a document's format, or editing/refactoring one | [references/conversion.md](references/conversion.md) |

Each reference has a grep-able list of tells and a set of positive rules, each backed by named standards and sources. Load the one that matches before you produce the artifact — not after.
