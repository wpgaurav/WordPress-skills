---
name: stop-slop
description: Remove predictable AI writing patterns from prose without flattening the writer's voice. Use when drafting, editing or reviewing reader-facing text such as articles, READMEs, product copy, captions and error messages.
argument-hint: "[text or file]"
license: MIT
metadata:
  version: 2.0.0
  source: https://github.com/hardikpandya/stop-slop
  author: Hardik Pandya (original), Gaurav Tiwari (this edition)
---
> Based on [stop-slop](https://github.com/hardikpandya/stop-slop) by Hardik Pandya, used under the MIT License. Hardik wrote the original five rules, the first quick checks, the scoring grid, the core phrase and structure tables and examples 1 to 5. Gaurav Tiwari added the severity model, the voice-preserving defaults, rules 6 to 9, the self-audit, more checks, phrase and structure sections and examples 6 to 13. See [LICENSE](LICENSE).

# Stop Slop

Slop is predictable writing. A reader feels it within two sentences: the throat-clearing opener, the "not X, but Y" flip, the em dash before a reveal and a closing line that would fit any article on the internet.

I run this on every piece of copy before it ships. The goal is to remove the predictable parts and leave the writer in place. A pass that strips the slop and the voice with it has failed too.

## How I Read a Match

A tell is evidence to inspect, not proof. Sort every finding before you change anything:

- **Hard fail:** production or process narration in reader-facing copy. A caption that says how the image was made, a "fresh screenshot," the name of the tool you used, a list of what you could not test. Rewrite or delete it. A good score never rescues it.
- **Warn if repeated:** a scaffold that works once and turns robotic by the third time. "No X. Just Y." Mirrored contrasts. Lists of three. Count the whole family across the piece before you touch one.
- **Contextual review:** a word or phrase with honest uses. Read the sentence first. Quotations, code, product names and precise technical terms stay.
- **Structural diagnostic:** a document-level pattern, such as paragraphs of identical length or equal space for options that do not matter equally. Find the cause. Never add fragments, emotion or asides only to break the pattern.

Facts sit above all of this. A clean draft with an invented number or an untested claim still fails.

## Core Rules

The first five are Hardik's, and they still carry the skill.

1. **Cut filler phrases.** Remove throat-clearing openers and emphasis crutches. See [phrases.md](phrases.md).

2. **Break formulaic structures.** Avoid binary contrasts, dramatic fragmentation, rhetorical setups. See [structures.md](structures.md).

3. **Vary rhythm.** Mix sentence lengths. Two items beat three. End paragraphs differently.

4. **Trust readers.** State facts directly. Skip softening, justification, hand-holding.

5. **Cut quotables.** If it sounds like a pull-quote, rewrite it.

The next four are mine. They come from the failures I kept seeing after the first five had done their job.

6. **Keep production off the page.** Captions and alt text name the subject or the evidence. They never mention capture tools, renderers, prompts, AI generation, stock alternatives or why a visual was chosen. Body copy follows the same rule: state the result and one claim boundary, not the research diary.

7. **Don't fake a human.** Random fragments, invented typos, "Actually, wait" corrections and asides with no reason behind them are slop too. Rhythm should change only when the thought, the stakes or the evidence changes.

8. **Give every detail a job.** A number, version, anecdote or example stays only if it changes the argument, the decision or the next step. A precise-looking number nobody measured is worse than none. State the mechanism instead.

9. **Leave working prose alone.** Every edit must fix a real problem with meaning, accuracy, clarity, repetition or flow. A smoother synonym is not a reason. A few useful changes beat a full rewrite.

## What I Keep

Most slop lists over-correct. These stay unless the sentence is genuinely worse for them:

- **Plain evaluative words.** Important, ensure, substantial, properly, wise, "a good idea" and "under the hood" carry judgment. Review them in context; never replace them on sight.
- **First person.** "I'd start with shared hosting" owns a judgment and needs no proof. Claims about tests, clients, results and history do.
- **Short warm signposts.** One or two sentences that tell the reader where they are and what comes next. The section roadmap ("In this article, we'll cover...") still goes.
- **A dry closer.** One wry line at the end of a paragraph, after the evidence, aimed at a practice and never at the reader.
- **A stated middle path.** Have a preference when the evidence has one. When the honest answer is moderate, say so in plain words instead of inventing a winner.
- **The writer's own grammar.** A regional idiom, a spaced hyphen used as a dash and a missing Oxford comma are voice. Don't flatten them into generic blog English.

## Quick Checks

Before delivering prose:

- Three consecutive sentences match length? Break one.
- Paragraph ends with punchy one-liner? Vary it.
- Em-dash before a reveal? Remove it.
- Explaining a metaphor? Trust it to land.
- Same concept called three different names? Pick one and repeat it.
- "Serves as" or "stands as" where "is" works? Use "is."
- Stacked "from X to Y" ranges? Pick one specific example.
- Closing paragraph could apply to any article? Make it specific.
- Caption or alt text explains how the image was made, or why it "beats a stock photo"? Say what it shows, or cut it.
- Same sentence closes every item in a list or roundup? Swap in another item's name. If it still reads right, delete it.
- More than one "not X, but Y" flip? Keep the one that carries a real turn.
- Every list has three items? Let the evidence set the count.
- A number that looks measured but wasn't? Replace it with the mechanism.
- Every option gets the same space? Spend it where the decision lives.

## Self-Audit (Final Pass)

After writing, ask: **"What makes this obviously AI-generated?"** Read every paragraph looking for:

1. Synonym cycling (same thing, different words each time)
2. -ing gerund clusters (highlighting, showcasing, fostering)
3. Significance inflation (testament, pivotal, transformative)
4. False comprehensiveness (from X to Y, whether A or B)
5. Generic optimistic closing
6. Performed roughness (fragments, fake corrections or typos added for texture)
7. Explained implications (the evidence lands, then a sentence explains it again)

Fix every instance found. Then read it aloud once. If it sounds like a LinkedIn post, a press release or a corporate memo, it isn't done.

Then run the opposite check: compare your edit with the original. If you removed the writer's idiom, opinion, warmth or humor along with the slop, put it back.

## Scoring

Rate 1-10 on each dimension:

| Dimension | Question |
|-----------|----------|
| Directness | Statements or announcements? |
| Rhythm | Varied or metronomic? |
| Trust | Respects reader intelligence? |
| Authenticity | Sounds human? |
| Density | Anything cuttable? |

Below 35/50: revise.

This grid is a quick self-check, not a gate. For a scored pass, count only findings that survive the contextual read:

- +2 for each repeated scaffold past its threshold
- +1 for each confirmed contextual finding
- +1 to +3 for each structural pattern, by priority

A total of 0 to 5 is clean, 6 to 15 needs editing and 16 or more needs a rewrite of the affected passages. Hard fails block on their own and are not scored. The [slop-detector](https://github.com/wpgaurav/claude-code-skills/tree/master/slop-detector) skill runs this model with a scanner and tests.

## What It Won't Do

- **It won't fact-check.** Run a separate verification pass on numbers, versions, prices and claims.
- **It won't fix structure.** A long piece needs an outline pass first. This skill works sentence by sentence and paragraph by paragraph.
- **It won't supply a voice.** Without a voice file, the output is clean and a little bland. Pair it with one.
- **It won't replace the last human read.** It replaces the first hour of editing. The last twenty minutes still happen.

## Where I Run It

- Article drafts and updates
- README files and code docblocks
- Pricing cards, CTAs and modal copy
- Error messages and admin notices
- Captions and alt text
- Email subject lines

## Examples

See [examples.md](examples.md) for before/after transformations: Hardik's five and eight of mine, including one where the right edit is no edit.

## License

MIT. The original rules, lists and examples are Copyright (c) 2025 Hardik Pandya. The additions in this edition are Copyright (c) 2026 Gaurav Tiwari. See [LICENSE](LICENSE).
