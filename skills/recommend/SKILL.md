---
name: recommend
description: Turn the scored research into a recommendation and a typeset PDF — the answer up front, why the runner-up lost, where to invest study effort, and what would change the conclusion. Writes report/meta.yaml and report/narrative.yaml, then builds pdf/certification-report.pdf. Final stage of the spec-led certification workflow.
---

# Write the recommendation

Turn scored data into a decision a person can act on, and into a document that is
still useful when nobody remembers this conversation.

## What you write, and what you must not

You write **prose only**, into two data files:

- `report/meta.yaml` — title, subject, author, date, run number, and the one-sentence
  headline printed at the top
- `report/narrative.yaml` — four sections of Typst markup: `answer`, `reasoning`,
  `invest`, `limits`

You do **not** write numbers. The ranking, the weighted totals, the comparison table
and the excluded list are all computed by `report/report.typ` at compile time from
`scorecard/criteria.csv` and `research/scores.csv`. This is deliberate: a figure typed
into prose can drift from its data, and given enough revisions it will.

So refer to scores in words — "scores highest on portability", "the two criteria the
spec weighted heaviest" — and let the tables carry the digits. Where you must quote a
number in prose to make an argument land, quote one you have just read from the CSV
and keep it to the weights, which do not change after freezing.

## Before writing, check the arithmetic disagrees with nobody

Compute the weighted totals yourself from the CSVs and confirm the ordering matches
what the built PDF shows. If they differ, the CSVs are malformed — usually an
unquoted comma inside a field — and the report is wrong in a way that is very hard to
see once it is typeset.

Check also: do the weights sum to 1.0, does every candidate have a row for every
criterion or a deliberate omission, and did any candidate get scored despite being
excluded.

## The four sections

**`answer`** — two or three short paragraphs. Name the recommendation and the single
reason for it *before* any qualification. A reader who stops after the first sentence
should have the decision. If the answer is "sit nothing", say that first and just as
plainly; the kill condition in `profile/objectives.md` was written for this and
honouring it is what makes the rest of the report trustworthy.

**`reasoning`** — why the ranking came out this way. Address the top two or three
candidates directly, and **say why the runner-up lost**. That is the part a reader
actually wants and the part most comparisons omit.

If a famous credential ranked low, explain that in terms of the weights rather than
apologising for it. Naming which weight did the work — and being explicit that a
different objective would produce a different answer — is what makes the ranking
legible instead of merely authoritative.

**`invest`** — the areas worth putting effort into, set against the recommended
credential's blueprint and `profile/benchmark.md`.

Frame these as investments, not deficiencies. Be specific enough to act on: name the
thing to build or practise, not "study harder". Prefer gaps that are narrow,
concentrated and closable by building — those are the useful kind, and they are worth
more than a longer list of vague ones. Say explicitly where the user is already strong
and should *not* spend time; that instruction is as valuable as the gaps and nobody
ever gives it.

This section has the longest shelf life in the document, because it stays useful
whether or not the exam is ever sat.

**`limits`** — what could not be established, which scores rest on **I**-tagged
inference, and what would change the answer. If the top recommendation would survive
the inferred scores being wrong, say so — and if it would not, say that louder. Name
the specific change that would flip the conclusion, because that is what tells the
user when to re-run.

## Build

```bash
./report/build.sh
```

Output is `pdf/certification-report.pdf`. If Typst is not installed the script says
so and exits; the markdown in `research/` and `scorecard/` is complete on its own, so
a missing Typst is an inconvenience rather than a blocker.

Read the built PDF before showing it to the user. Check the totals match, no section
is empty, and no narrative block rendered as literal markup — a YAML block scalar with
the wrong indentation fails quietly and looks like prose until you look at it.

## Then

Tell the user the recommendation in two or three lines in the conversation itself,
not only in the PDF. Point them at the file. Say when it will be worth re-running —
usually tied to the specific condition you named in `limits`, plus the date
`profile/benchmark.md` goes stale.
