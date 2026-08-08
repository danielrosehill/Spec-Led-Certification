---
name: spec-led-certification
description: Run the whole spec-led certification workflow end to end — intake interviews, freeze the scorecard, survey and score the market, produce the recommendation PDF. Handles first runs and re-runs, skipping intake stages whose answers are still current. Use when the user wants to find a certification worth taking, or to refresh an earlier run against a changed market.
---

# Spec-led certification — full run

Sequences the eight stage skills and carries each one's output to the next. Use this
rather than invoking stages by hand unless the user wants to redo one piece.

## The order, and why it is not negotiable

```
  intake ─────────────────────────────────────────┐
    define-spec            what field, which topics
    benchmark-me           where they are now, from evidence
    learning-preferences   how they take information in
    define-objectives      what it is for; standing positions; the window
    define-budget          money and hours
                                                  │
  build-scorecard   ◄───── derives weights from the profile alone
                          ── FREEZE ──  commit before looking anything up
                                                  │
  research-market   ◄───── survey, filter, price, score against the frozen card
                                                  │
  recommend         ◄───── narrative + computed tables → PDF
```

The freeze is the whole mechanism. A scorecard written after the options are known is
a rationalisation of whichever option already appealed, and the process then produces
the same answer as picking on reputation, with arithmetic bolted on. So: no credential
is named, searched for, or considered until `scorecard/methodology.md` says
`frozen: true`.

You will already know some of the market. Do not let that shape a weight. The
`source` column on every criterion is the check — a criterion that cannot name the
line in `profile/` it came from does not go on the card.

## Start by reading the state

Check the frontmatter of all five files in `profile/`, plus
`scorecard/methodology.md`. Decide which of three situations you are in:

**First run** — everything `unfilled`. Run all eight stages in order.

**Re-run** — profile filled. For each file, compare `review_after` to today:

| Situation | Action |
| --- | --- |
| Past `review_after` | Run that intake skill again |
| Current | Show the user a two-line summary and ask them to confirm or amend. Do not re-interview |
| Any change at all to the profile | Rebuild the scorecard, re-freeze, re-research |

Typically only `benchmark.md` has expired — high volatility, three months — and the
re-run costs one short conversation plus a fresh market sweep. That is the payoff for
having written the profile down in the first place, so say so: tell the user which
stages you are skipping and why.

**Resumed run** — some stages filled, some not, nothing expired. Pick up where it
stopped and say where that was.

## Running the stages

Invoke each stage skill in turn. Between stages:

- Tell the user what was captured, in no more than two lines. They should be able to
  catch a wrong answer without reading the file.
- Commit, if this is a git checkout. One commit per stage. The commit before research
  is the one that proves the scorecard was frozen first, and it is the only evidence
  that the process was followed rather than described.
- Do not silently continue past a refusal or a "let me think about that". Record the
  gap and move on; `define-spec` and `define-objectives` both have places for open
  questions.

## Delegating to subagents

If the agent supports subagents, the three roles in `agents/` map to the phases:
`intake`, `research`, `recommendation`. Three benefits, in order of importance:

1. **The research agent never sees the intake conversation.** It receives the frozen
   scorecard and nothing else, which enforces the freeze structurally rather than by
   good intentions.
2. The research phase reads a lot of pages, and that stays out of the main context.
3. Each role can carry its own tool permissions — the research agent needs web
   access, the intake agent does not.

Without subagent support, run the stages inline. The workflow is designed to work
either way; the subagents make the separation harder to violate, they do not create
it.

## Where everything is written

Nothing goes into the agent's own memory store — not Claude's memory, not a hosted
profile, not "I'll remember". It all goes into this repository as plain markdown and
CSV. That is what makes the workflow agent-agnostic and what makes the six-month
re-run cheap: the user brings the repo, not the assistant.

| Stage | Writes |
| --- | --- |
| `define-spec` | `profile/spec.md` |
| `benchmark-me` | `profile/benchmark.md` |
| `learning-preferences` | `profile/learning-preferences.md` |
| `define-objectives` | `profile/objectives.md` |
| `define-budget` | `profile/budget.md` |
| `build-scorecard` | `scorecard/criteria.csv`, `scorecard/filters.csv`, `scorecard/methodology.md` |
| `research-market` | `research/candidates.csv`, `research/scores.csv`, `research/candidates/*.md`, `research/sources.md` |
| `recommend` | `report/meta.yaml`, `report/narrative.yaml`, `pdf/certification-report.pdf` |

## On a re-run, keep the old run readable

Before overwriting `research/`, note the previous run's date and headline in
`research/sources.md` under a new dated section. What changed in the market between
two runs is frequently the most interesting output of the second one — a blueprint
revision, a price rise, an eligibility rule that opened or closed — and it is
invisible if the first run was simply overwritten.

Bump `run` in `report/meta.yaml`.

## Finishing

Give the recommendation in the conversation, not only in the PDF. Then say when it is
worth running again: the earliest `review_after` in `profile/`, or the specific
condition named in the report's limits section, whichever comes first.

If the honest answer is that no credential clears the spec, say that as the
recommendation. The kill condition in `profile/objectives.md` was written for this
case, and a workflow that cannot return "none of these" is not evaluating anything.
