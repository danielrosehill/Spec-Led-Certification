---
status: unfilled
frozen: false
frozen_at:
---

# Scorecard methodology

> Filled by the `build-scorecard` skill, from `profile/`, before any research runs.
> The skill writes the reasoning here and the machine-readable rows into
> [criteria.csv](criteria.csv) and [filters.csv](filters.csv).

## Why this file is written before the research

The scorecard is the specification. If it were written after the options were known,
it would be a rationalisation of whichever option already appealed — the weights would
land wherever they needed to land, and the process would produce the same answer as
picking on reputation, dressed up in arithmetic.

So the order is fixed, and the freeze is the mechanism:

1. Intake completes. `profile/` is filled and dated.
2. This scorecard is derived from `profile/` alone. **No candidate has been named yet
   and none may be looked up.** If the agent already knows the market — and it will —
   it must not let that knowledge shape a weight here.
3. `frozen: true` and `frozen_at` are set, and the scorecard is committed.
4. Research runs against the frozen scorecard.

Once frozen, criteria and weights change only by an explicit decision the user makes,
recorded in [Amendments](#amendments) below with the reason. Amending is allowed —
research legitimately turns up considerations nobody anticipated. Amending *silently*
is not, and an amendment made after the scores are in gets its own line in the report
so the reader can discount it.

## Two kinds of requirement

**Filters** are hard requirements, in `filters.csv`. A candidate that fails one is
excluded and does not appear in the ranking — it appears in the report's excluded list
with the filter it failed. Filters are not scored, because a score of zero on a heavy
criterion can still be outweighed, and a hard requirement by definition cannot.

**Criteria** are scored, in `criteria.csv`. Each carries:

| Column | Meaning |
| --- | --- |
| `id` | Short stable identifier, used to join to the scores |
| `label` | Human-readable name, appears in the report table |
| `weight` | Relative importance. The whole column must sum to 1.0 |
| `kind` | `coverage` (does it teach the named topics), `constraint` (cost, time, access), or `quality` (recognition, currency, rigour) |
| `anchor_1`, `anchor_half`, `anchor_0` | What a score of 1.0, 0.5 and 0.0 actually look like |
| `source` | The line in `profile/` this criterion comes from |

### Anchors are not optional

A criterion without written anchors is not a criterion, it is a vibe with a decimal
point. The anchors are what make two candidates comparable, and what make a re-run six
months later comparable to this one. Write them as observable facts about a credential,
not as adjectives: "published blueprint names the topic as an assessed objective" is an
anchor; "good coverage" is not.

### Every criterion traces to the profile

The `source` column is a requirement, not documentation. A criterion that cannot name
the statement in `profile/` it came from is one the agent invented, and inventing
criteria is exactly the failure this workflow exists to prevent. If research suggests a
criterion is missing, the fix is to go back and ask the user, not to add it here.

## Scoring scale

Every score is a decimal from **0.0 to 1.0**, to two places. Not stars, not
letters, not percentages — one scale, so weighted arithmetic means something.

Each score also carries a **confidence tag**, and the report prints it alongside the
number:

| Tag | Means |
| --- | --- |
| **V** | Vendor-confirmed — the credential's own site, blueprint, or published policy |
| **S** | Secondary — prep providers, training partners, blogs, forums, press |
| **I** | Inferred — the agent's judgement from adjacent evidence |

A high score at **I** confidence is a hypothesis. The report must never present one as
a finding, and a recommendation resting on **I**-tagged scores at its top criteria says
so in its own words.

## Weighted total

For each surviving candidate:

```
total = Σ(weight × score) / Σ(weight over criteria actually scored)
```

The denominator is the weights actually scored, not 1.0, so a candidate with an
unscored criterion is not silently penalised — but an unscored criterion is itself a
finding and the report flags it rather than quietly renormalising past it.

The arithmetic is done by the Typst document at compile time, reading the CSVs
directly. Nobody types a total into prose; the report cannot disagree with its data.

## Criteria

<!-- The skill writes the derivation here: each criterion, the weight it got, and
     why that weight. One short paragraph each. This is the part a reader checks
     when they disagree with the ranking. -->

## Amendments

<!-- Append-only. Date, what changed, why, and whether scores already existed
     when it changed. Empty is the normal state. -->

*None.*
