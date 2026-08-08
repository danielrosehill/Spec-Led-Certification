---
name: rerun-search
description: Second and later runs — archive the previous run, confirm the profile is still current, re-survey the market and report what changed since last time. Use when the intake is already on file and the user wants to know whether the market has moved, or whether an earlier recommendation still holds. For a first run use start-search; to change stored answers first use update-profile.
---

# Re-run the search

The iterative path, and the one the whole design pays off in. The intake is already on
file, so this is a short confirmation and a fresh market sweep — minutes rather than an
hour.

**The output is a comparison, not a second snapshot.** By the time someone runs this,
their question is not "what should I sit" in the abstract; it is "has anything changed,
and does last time's answer still hold". A re-run that silently overwrites the previous
one and re-derives from scratch cannot answer that, and throws away the most
interesting thing it knows.

## 1. Check the profile is fit to research against

Read the frontmatter of all five files in `profile/`.

| Finding | Do |
| --- | --- |
| All current | Show a two-line summary of each and ask for confirmation. Do not re-interview |
| One or more past `review_after` | Name them and offer `update-profile` before continuing |
| `benchmark.md` expired | **Stop and say so.** Do not carry on without asking |

The benchmark is the hard stop because it is the fastest-decaying file and it feeds
both the readiness estimates and the *Where to invest* section. Researching against a
year-old benchmark produces a report that looks current and quietly is not.

If the user wants to proceed anyway, that is their call — proceed, and record in the
report's limits that the benchmark is stale and by how long.

## 2. Archive the previous run

Before writing anything, copy the current state to `runs/<date-of-that-run>/`, taking
the date from `report/meta.yaml`:

```
runs/2026-08-08/
  criteria.csv  filters.csv        the scorecard that run used
  candidates.csv  scores.csv       what it found and how it scored
  meta.yaml  narrative.yaml        what it concluded
```

A run is scorecard *and* data *and* conclusion together — archiving only the scores
makes the next diff unreadable the moment a weight changes. Copy the built PDF too if
one exists.

This is not optional and it is not recoverable later. Do it before touching anything.

## 3. Rebuild the scorecard only if it is stale

Check `scorecard/methodology.md` frontmatter.

- **`stale: true`** — the profile changed since the scorecard was frozen. Run
  `build-scorecard` again and re-freeze. Note in the amendments section what changed
  and why, because the ranking is about to become non-comparable with the previous run
  and the report has to say so.
- **`stale: false`** and `frozen: true` — leave it exactly as it is. A re-run against
  an unchanged scorecard is the clean case: the only variable is the market, which is
  precisely what makes the comparison meaningful.

Never quietly adjust a weight during a re-run. A scorecard that drifts run to run
turns a comparison into two unrelated snapshots.

## 4. Re-survey

Run `research-market` in full. Do not shortcut it by re-scoring last run's candidates:
new credentials appear, and a survey that only revisits known names cannot find them.

Give particular attention to what the archive says was true before:

- **Blueprint revisions.** Domains added, dropped, or reweighted. This is the change
  most likely to move a coverage score and the least likely to be announced.
- **Price and eligibility.** Both move, and eligibility changes in both directions —
  a gate that closes, or a partner requirement that relaxes and makes a previously
  excluded candidate live again. Re-check the excluded list, not just the ranked one.
- **Credentials that vanished** or were superseded by a renamed successor.
- **Anything the last run recorded as unestablished** in `research/sources.md` under
  Dead ends. Some of those are now answerable; the log exists so the sweep does not
  spend its budget rediscovering the same walls.

Start a new dated section in `research/sources.md` rather than editing the old one. A
claim that was true in August and false in February should leave a trace.

## 5. Recommend, leading with what changed

Run `recommend`, and fill the `changes` key in `report/narrative.yaml` — the section
the report prints immediately after the answer, and the reason this run exists.

It should answer, in this order:

1. **Does the previous recommendation still hold?** Say it in the first sentence,
   plainly, including "yes, nothing material moved" when that is the truth. A re-run
   that confirms is a useful result and should not be dressed up as a finding.
2. **What moved, and did it change the ranking?** Name specific scores that changed and
   why. Distinguish a credential that genuinely changed from one that was scored on
   better evidence this time — the second is a correction, not a market movement, and
   conflating them makes the market look more volatile than it is.
3. **New entrants and departures**, including anything that moved between the ranked
   and excluded lists.
4. **If the scorecard was rebuilt**, say so and say that totals are not directly
   comparable with the archived run. This is the one thing a reader will otherwise get
   wrong.

Bump `run` in `report/meta.yaml`, and set `date` to today.

## Finish

Two or three lines in the conversation: whether the answer changed, and what moved.

Then say when to run again — the earliest `review_after` in `profile/`, or the specific
condition the report's limits section names as what would flip the conclusion.

If nothing has changed and nothing is close to expiring, say that too, and say the
honest thing: there is no point running this again for a while.
