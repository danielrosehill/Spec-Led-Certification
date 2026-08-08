---
name: build-scorecard
description: Derive weighted, anchored scoring criteria and hard filters from the completed profile, then freeze them before any credential is researched. Writes scorecard/criteria.csv, scorecard/filters.csv and scorecard/methodology.md. The pivot of the spec-led certification workflow — run after intake, before research.
---

# Build the scorecard

Turn the profile into a specification the market can be measured against. This is the
stage the whole workflow is named for, and the one place where doing it in the wrong
order silently destroys the value of everything else.

## The constraint that makes this work

**No credential may be named, looked up, or considered while this file is being
written.** Not by the user, not by you, not "just to sanity-check the criteria".

You will already know some of the options — that knowledge is not erasable, but it is
containable. The containment is procedural: derive every criterion from a line in
`profile/`, record which line in the `source` column, and refuse to add one you cannot
trace. A criterion that exists because you know a particular exam does well on it is
the exact failure this workflow exists to prevent, and the `source` column is how it
gets caught.

If the user offers "well, I've heard X is good" during this stage, take the note, put
it in `profile/spec.md` under open questions as a candidate to check, and carry on.
Do not let it shape a weight.

## Read first

All five profile files. If any is `unfilled` or past `review_after`, stop and say
which — building a scorecard on a stale benchmark or a missing objective produces
weights that look authoritative and are not.

## Separate filters from criteria

Go through `profile/objectives.md` standing positions and `profile/budget.md`
non-negotiables. Anything marked **hard requirement** becomes a row in
`filters.csv`, not a criterion.

The distinction is not cosmetic. A zero on a heavy criterion can be outweighed by
strength elsewhere; a hard requirement by definition cannot. Scoring a hard
requirement instead of filtering on it is how a credential the user cannot actually
sit ends up ranked third.

Write each filter as an *applicable rule* — something you can hold a credential's
eligibility page against and get a yes or no. "Must be accessible" is not a rule.
"Excluded if eligibility requires partner-network membership or a minimum employer
size" is.

## Derive the criteria

Three kinds, and a scorecard wants some of each:

| Kind | From | Typical |
| --- | --- | --- |
| `coverage` | The named topics in `spec.md` | One criterion per topic, or per cluster if there are many |
| `constraint` | `budget.md`, and the window in `objectives.md` | Cost fit, time fit, accessibility |
| `quality` | `objectives.md` purpose and audience | Vendor neutrality, recognition, currency, rigour |

Also fold in `learning-preferences.md` — usually as a preparation-route-fit criterion,
scoring how well a credential's realistic prep route matches how the user actually
learns and is assessed.

Ten criteria is a good target. Fewer than six and the scorecard cannot discriminate;
more than about fourteen and the weights become noise, because nobody can hold
fourteen relative importances consistently in mind.

## Set the weights with the user, not for them

Weights are the user's values expressed as numbers. Do not assign them silently.

Propose a starting set with a one-line justification each, tied to what they said —
"recognition at 0.05 because you told me the audience is existing clients who have
already seen your work" — and then have them push back. The pushback is the useful
part, and it is where a mis-stated objective usually surfaces.

The column must sum to **1.0**. If the user's stated importances do not, normalise and
show them the result rather than quietly rescaling.

## Anchors are mandatory

Every criterion needs `anchor_1`, `anchor_half` and `anchor_0`: what a score of 1.0,
0.5 and 0.0 actually look like. A criterion without anchors is a vibe with a decimal
point, and two credentials scored against it are not comparable — nor is this run
comparable to the re-run in six months.

Write anchors as **observable facts about a credential**, not adjectives:

- Good: "MCP named as an assessed objective with a stated blueprint weight"
- Bad: "good MCP coverage"

The test is whether a different person, reading the same vendor page, would land on
the same score.

## Write and freeze

1. `scorecard/criteria.csv` — one row per criterion. Quote any field containing a
   comma. Weights sum to 1.0.
2. `scorecard/filters.csv` — one row per hard requirement.
3. `scorecard/methodology.md` — fill the Criteria section with the derivation: each
   criterion, the weight it got, and why. This is what a reader checks when they
   disagree with the ranking, so write it for them rather than for the user.
4. Set `status: filled`, `frozen: true`, `frozen_at: <today>` in the methodology
   frontmatter.
5. Commit, if the repo is a git checkout. A frozen scorecard that was never committed
   before research is not evidence of anything.

Then show the user the criteria table and the filters, and say plainly that research
is about to run against exactly this and nothing else. Amendments after this point
are allowed but they get recorded in the Amendments section with the reason, and an
amendment made after scores exist gets its own line in the final report so the reader
can discount it.
