# Working in this repository

Instructions for any AI agent operating here. The skills in `skills/` are written as
Claude Code skills, but nothing in the workflow depends on Claude — each `SKILL.md` is
a plain-markdown procedure any capable agent can follow, and the whole state of a run
lives in this repository rather than in any assistant's memory.

## What this repo is

A workflow for choosing a professional certification specification-first: write the
requirements, freeze them, then survey and score the market against them. It is a
template — a user clones it and fills it with their own run.

## The one rule that is not negotiable

**Write everything you learn into this repository, never into your own memory
store.** Not a hosted user profile, not a memory tool, not "I'll remember this next
time".

Two reasons, and the second is the important one:

1. The user may run the next pass with a different assistant. The repo goes with
   them; your memory does not.
2. A profile in an agent's memory cannot be read, corrected, dated, diffed or
   reviewed by the person it describes. One in `profile/spec.md` can.

If you have a memory tool available, this is the case where you do not reach for it.

## Three entry points

Which one applies is a property of the workspace, not a preference. Read the state
before choosing, and say which you picked.

| Entry point | When |
| --- | --- |
| `start-search` | `profile/` unfilled, or a new subject |
| `rerun-search` | Intake on file. Archives the previous run, re-surveys, reports what changed |
| `update-profile` | Something about the user changed. Re-interviews only what moved |

`spec-led-certification` is a router over the three and carries no procedure itself.

**`frozen` and `stale` are different flags.** `frozen` records that the scorecard was
fixed before research ran, and is never unset — the commit carrying it is the evidence.
`stale` records that the profile has changed since, is set by `update-profile`, and is
cleared when `build-scorecard` runs again. Never unset `frozen` to signal "needs
rebuilding": that destroys the record that the method was followed.

## The order is the mechanism

```
intake → freeze the scorecard → research → recommend
```

**No credential may be named, searched for, or considered before
`scorecard/methodology.md` says `frozen: true`.** A scorecard written after the
options are known is a rationalisation of whichever one already appealed. You will
already know some of the market; the containment is that every criterion carries a
`source` column pointing at the line in `profile/` it came from, and one that cannot
name its source does not go on the card.

## Where things live

| Directory | Contents | Written by |
| --- | --- | --- |
| `profile/` | The five intake files — the durable, dated, agent-agnostic memory | intake skills |
| `scorecard/` | Weighted criteria, hard filters, and the frozen methodology | `build-scorecard` |
| `research/` | Candidates, scores, per-credential notes, verification log | `research-market` |
| `report/` | Narrative prose and metadata, plus the Typst template | `recommend` |
| `runs/<date>/` | Archived previous runs — scorecard, data and conclusion together | `rerun-search` |
| `pdf/` | Built reports | `report/build.sh` |
| `agents/` | Subagent definitions for the three phases | — |
| `examples/worked-run/` | A complete fictional run, for shape — template repo only | — |

## Two ways this directory comes to exist

**A clone of the template repo.** Everything above is present, including
`examples/worked-run/` and `docs/`.

**Scaffolded by the `spec-led-certification` Claude Code plugin**, into a directory
that may sit inside a larger, unrelated repo. Then a `.spec-led-certification` marker
file at the workspace root records the creation date and the template version, and
**that marker is the workspace root** — resolve every path in these instructions
against it, not against the enclosing git repo. Look for it in the current directory
and then upward.

Scaffolded workspaces have no `examples/`, so `./report/build.sh example` is correctly
absent there rather than broken.

## Conventions

**Dates are absolute.** `2026-08-08`, never "last month". Every profile file carries
`captured` and `review_after`, and a re-run reads those to decide what to re-ask.

**Confidence tags on every research claim.** `V` vendor-confirmed, `S` secondary,
`I` inferred. The tag is decided by where the claim came from, not by how sure you
feel. A high score at `I` is a hypothesis and the report must not present it as a
finding.

**Numbers live in CSVs, prose lives in markdown and YAML.** `report/report.typ` reads
the CSVs at compile time and computes every figure it prints, so the report cannot
disagree with its data. Never type a total into prose.

**Unscored beats guessed.** An unscored criterion is excluded from the weighted total
and flagged in the report. A guessed one silently changes a ranking.

## Typst

`report/report.typ` must be compiled with `--root` at the repo root, because it reads
the CSVs with paths rooted there. Use `report/build.sh` rather than calling `typst`
directly.

One trap, learned the hard way: **a method chain must keep its dot on the same line
as the expression it applies to.** `live\n  .map(...)` does not continue the
statement — Typst ends it at the newline and renders the rest of the chain as body
text, with no error and no warning. Use an intermediate binding instead.
