# Anti-Slop: Document & Technical Writing

Applies to prose: docs, READMEs, reports, PR/commit bodies, code comments, chat answers.

## What slop is here

Fluent, structurally uniform text that adds words without adding information. It hedges, restates, and decorates instead of committing to concrete claims. Reads smooth, says little.

## Tells (anti-patterns)

- **Overused diction — grep list:** delve, leverage, utilize, robust, seamless, streamline, foster, harness, underscore, embark, comprehensive, crucial, pivotal, nuanced, multifaceted, realm, landscape, tapestry, ecosystem, navigate, unprecedented, resonate, spearhead.
- **"Not just X, but Y" / "It isn't X, it's Y":** negation-then-correction reaching for unearned emphasis; LLMs emit roughly one per paragraph.
- **Rule of three:** matched tricolons ("fast, reliable, and affordable") — always three, never two or four.
- **"From X to Y":** false-range framing ("from startups to enterprises").
- **Throat-clearing openers:** "In today's rapidly evolving landscape," "In an era of," "It's important to note that," "It's worth noting that."
- **Booster conclusions:** "At the end of the day," "Moving forward," "Ultimately" — a pivot to generic profundity ("broader implications").
- **Bold-label bullets:** every list item starts `**Phrase:**` — list scaffolding leaking into what should be prose.
- **Empty hedging / false balance:** "it depends," "both approaches have merit," qualifiers that perform nuance without picking a side.
- **Filler adverbs:** importantly, essentially, fundamentally, inherently, increasingly, particularly.
- **Stock metaphors:** double-edged sword, tip of the iceberg, north star, game-changer, perfect storm.
- **Format tics:** em-dashes replacing every comma; decorative emoji in headings; a rhetorical question answered in the next line.
- **Sycophancy:** "Great question!", "You're absolutely right."
- **Low burstiness:** uniform sentence length and 3–5-sentence paragraphs throughout.

## Rules (do this)

- Lead with the conclusion; front-load the words a scanner needs.
- Omit needless words — if a word carries no information, cut it (Strunk).
- Prefer the short everyday word to the long one (Orwell rule 2).
- Use active voice; name who does the action (Google style; Orwell rule 4).
- Replace abstractions with concrete nouns, numbers, and named examples.
- One idea per sentence; break compound sentences that pad rhythm.
- Vary sentence and paragraph length on purpose.
- Read it aloud; if you wouldn't say it to a colleague, rewrite it (Graham).
- Delete any sentence that only restates the prompt or the sentence before it.
- Show, don't tell: give the command, the metric, the failure mode — not adjectives about them.
- Cut reflexive "please," "certainly," and hedges from instructions.
- Break any rule here before writing something genuinely barbarous (Orwell rule 6).

## Tools & standards

- **Google developer documentation style guide** — active voice, second person, conditions before instructions.
- **Microsoft Writing Style Guide** — "warm and relaxed, crisp and clear"; write for scanning; get to the point.
- **Strunk & White, *The Elements of Style*** — concision, active voice, "make every word tell."
- **Orwell, "Politics and the English Language"** — six rules against stale metaphor, long words, passive, jargon.
- **Vale** — configurable prose linter; ships Google/Microsoft/proselint/write-good packs; flags passive voice, weasel words, banned terms.
- **proselint** — heuristics for hedging, redundancy, clichés, pretension.
- **write-good** — flags passive voice, weasel words, wordy phrasing.

## Sources

- Google developer documentation style guide — https://developers.google.com/style/highlights
- Microsoft Writing Style Guide, Top 10 tips — https://learn.microsoft.com/en-us/style-guide/top-10-tips-style-voice
- Orwell's six rules (Duke Scientific Writing) — https://sites.duke.edu/scientificwriting/orwells-6-rules/
- Paul Graham, "Write Simply" — https://paulgraham.com/simply.html
- LLM prose tells catalog — https://git.eeqj.de/sneak/prompts/src/branch/main/prompts/LLM_PROSE_TELLS.md
- Vale — https://vale.sh/ · proselint — https://github.com/amperser/proselint
