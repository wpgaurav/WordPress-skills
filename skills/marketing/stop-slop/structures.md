# Structures to Avoid

Hardik Pandya wrote the original sections: Binary Contrasts, Dramatic Fragmentation, Rhetorical Setups, Formulaic Constructions and Rhythm Patterns. The other sections are Gaurav Tiwari's additions, each marked with how to treat a match (see "How I Read a Match" in SKILL.md).

## Binary Contrasts

These create false drama. State the point directly.

| Pattern | Problem |
|---------|---------|
| "Not because X. Because Y." | Telegraphed reversal |
| "[X] isn't the problem. [Y] is." | Formulaic reframe |
| "The answer isn't X. It's Y." | Predictable pivot |
| "It feels like X. It's actually Y." | Setup/reveal cliche |
| "The question isn't X. It's Y." | Rhetorical misdirection |

**Instead:** State Y directly. "The problem is Y." "Y matters here."

## Dramatic Fragmentation

Sentence fragments for emphasis read as manufactured profundity.

| Pattern | Problem |
|---------|---------|
| "[Noun]. That's it. That's the [thing]." | Performative simplicity |
| "X. And Y. And Z." | Staccato drama |
| "This unlocks something. [Word]." | Artificial revelation |

**Instead:** Complete sentences. Trust content over presentation.

## Rhetorical Setups

These announce insight rather than deliver it.

| Pattern | Problem |
|---------|---------|
| "What if [reframe]?" | Socratic posturing |
| "Here's what I mean:" | Redundant preview |
| "Think about it:" | Condescending prompt |
| "And that's okay." | Unnecessary permission |

**Instead:** Make the point. Let readers draw conclusions.

## Formulaic Constructions

| Pattern | Problem |
|---------|---------|
| "By the time X, I was Y." | Narrative template |
| "X that isn't Y" | Indirect. Say "X is broken" |

## False Ranges

"From X to Y" constructions that pad word count with obvious breadth.

| Pattern | Problem |
|---------|---------|
| "From X to Y, from A to B" | Stacked ranges = filler |
| "Whether it's X or Y" | False comprehensiveness |
| "Everything from X to Y" | Vague scope padding |
| "Spanning X to Y" | Inflated range |

**Instead:** Pick the most relevant example. One specific beats two vague.

## Elegant Variation (Synonym Cycling)

AI avoids repeating words by cycling through synonyms, making prose feel thesaurus-driven.

| Pattern | Problem |
|---------|---------|
| Tool → platform → solution → offering | Same thing, four names |
| Said → stated → noted → remarked | Unnecessary variation |
| Important → crucial → vital → essential | Escalating synonyms |
| Use → utilize → leverage → employ | Fancy for no reason |

**Instead:** Repeat the natural word. "Tool" three times reads better than tool/platform/solution.

## Generic Positive Conclusions

AI defaults to optimistic, forward-looking closings regardless of content.

| Pattern | Problem |
|---------|---------|
| "The future looks bright" | Unearned optimism |
| "Exciting times lie ahead" | Generic hype |
| "Only time will tell" | Non-committal filler |
| "One thing is clear:" | Performative certainty |
| "As we move forward" | Empty transition |

**Instead:** End with a specific action, recommendation, or honest assessment.

## Rhythm Patterns

| Pattern | Fix |
|---------|-----|
| Three-item lists | Use two items or one |
| Questions answered immediately | Let questions breathe or cut them |
| Paragraphs starting with "So" | Start with content |
| Sentences starting with "Look," | Remove |
| Every paragraph ends punchily | Vary endings |
| Em-dashes before reveals | Use periods or commas |

## Mirrored Contrast Scaffolds (warn if repeated)

The "not X, but Y" snap in all its costumes:

- "It's not just X. It's Y."
- "It's not about X. It's about Y."
- "This isn't X. This is Y."
- "X isn't dead. Lazy X is."
- "X, not Y."

One mirrored contrast can carry a real turn. The tell is the reflex: the flip every few paragraphs, restating the same claim backwards to sound deep.

**Test:** can the Y half stand as its own sentence with evidence behind it? If not, the construction was decoration. Name the consequence instead.

## Repeated Parallel Punchlines (warn if repeated)

```
No X. Just Y.
No A. Just B.
No C. Just D.
```

One is emphasis. Three in a row is a model signature. The same goes for adjective triples ("fast, simple and reliable") and lists that always land on three. Allow one deliberate triad per piece. After that, let the evidence set the count: two or four items read more human than perpetual threes.

## Templated Per-Item Filler (warn if repeated)

In roundups and comparisons, every item section comes from one shape. Any sentence that survives unchanged across items is padding.

- "Check the official site for current pricing before you buy."
- "Read the reviews and try the free version first."
- "It's a good fit if your needs match its feature set."

**Test:** swap another item's name into the sentence. If it still reads correctly, it says nothing about this item. Put advice that applies to every item once, in the intro or buying section.

## Production Commentary (hard fail)

Captions, alt text, callouts and body copy that narrate how the content was made:

- "A fresh screenshot of..." / "a fresh capture"
- "Captured with [tool]" or the name of any capture or render tool
- "Not a generic mockup" / "a real screenshot beats another stock photo"
- "Created with AI" or the name of any image or text generator
- Any caption whose point is that the visual is authentic, not what it shows

**Instead:** name what the reader sees. "The Permalinks screen with Post name selected." If the alt text already covers it and the caption adds no fact, leave the caption empty.

## Process Leakage (hard fail when it narrates tooling)

The caption rule's bigger sibling. Research narration leaks into prose, bullets and tables, where it reads like an apology or a lab notebook.

- **Hard fail:** naming the scraper, browser, script or tool you used; a table column such as "Status in this study"; a "weak spot" that is a gap in your testing, not a flaw in the product.
- **Warn if repeated:** "I didn't test this" stapled to every item; "for this update" or "in this round of testing" on every claim.

**Allowed once:** a single scope statement that bounds a specific claim. "I haven't run this test on the newer plan, so the ranking uses the documented limits." That prevents an overclaim. The third one is a habit.

**Test:** delete every clause about how you researched or what you couldn't check. If nothing factual remains, the sentence was never for the reader.

## Performed Humanity (structural)

The newest slop is slop pretending not to be slop:

- Random fragments and one-word paragraphs with no change in thought
- "Actually, wait" or "scratch that" with no real change of mind
- Invented typos or casual misspellings
- A tidy personal mistake inserted because the template wanted vulnerability
- An emotional beat in every section, whether the subject earns one or not

**Instead:** remove the performance. Let rhythm and feeling change only when the evidence, the stakes or the source changes. A calm technical piece may need no emotional turn at all.

## Template Symmetry (structural)

Every option, objection or example gets equal space even though they don't matter equally:

- Three pros and three cons of identical length
- Fifteen tools with a paragraph each
- "There are several aspects to consider: performance, pricing, ease of use, support, integrations and scalability."

**Instead:** let priority show. "Two things matter here: speed and price." Cover the options that matter, mention the next few briefly and skip the rest.

## Explained Implication (structural)

The draft shows the evidence, then a sentence explains what it means, because the writer didn't trust it to land.

**Instead:** keep the evidence and, at most, one practical consequence. Delete the restatement.

## Buried Answer (structural)

A decision section opens with "There are many factors to consider" and gets to the answer three paragraphs later.

**Instead:** when the reader came for a decision, give it first, then the condition that would change it. Narrative and teaching sections can still build up to their point.

## Over-Hedging (contextual review)

"While there are many factors, it might be worth exploring whether this could potentially work for your use case."

**Instead:** keep the one hedge that changes the claim. "This works on a single site. I haven't checked multisite, so don't assume it."

## Dead Table Columns (structural)

A data column with the same value in every row ("Source: official docs" ×10) carries zero information. State the fact once beside the table and delete the column. Columns of action links ("Download," "Try free") are expected to repeat and are fine.
