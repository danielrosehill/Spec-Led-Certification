---
name: research-market
description: Survey the certification market against the frozen scorecard — find every plausible credential, apply the hard filters, price the whole route, and score the survivors with a confidence tag and a source for every number. Writes research/candidates.csv, research/scores.csv, research/candidates/*.md and research/sources.md. Sixth stage of the spec-led certification workflow.
---

# Research the market

Go and find out what actually exists, and score it against the scorecard you were
given. This is the stage with the most web work in it and the most ways to go wrong.

## Read first, and do not deviate from it

`scorecard/criteria.csv`, `scorecard/filters.csv`, `scorecard/methodology.md`.

**The scorecard does not move during this stage.** If a criterion turns out to be
unanswerable from the public record, that is an unscored criterion and a note — not a
redefinition. If research suggests an obviously missing criterion, surface it to the
user as a proposed amendment and let them decide; do not add it yourself.

Read `profile/budget.md` and `profile/objectives.md` too — the cost-fit and time-fit
criteria are scored against the user's actual figures, and the window is scored
against the exam's actual availability.

## Survey wide before scoring anything

Cast a broad net first: vendor certifications, professional bodies, standards
organisations, universities and their extension arms, industry consortia, and the
awkward middle category of well-regarded assessments that are not called
certifications. Search in more than one register — the phrase a certifying body uses
for itself is often not the phrase a practitioner would search for.

List everything plausible in `research/candidates.csv` before scoring anything. If you
score as you go, you will stop when you find something good, and "the first acceptable
option" is precisely the market-led outcome this workflow replaces.

## Filter before you score

For each candidate, check eligibility **first**, against `filters.csv`.

This order is not arbitrary. Eligibility gates are published on pages that rank well
below the marketing, they are the constraint that most often locks a well-prepared
person out of an exam, and finding one after scoring nine criteria wastes the effort.
Partner-tier requirements, minimum employer size, prerequisite certifications,
geographic restrictions, identity verification, exam scheduling windows.

A candidate that fails a filter: set `status: excluded`, name the filter in
`excluded_by`, write a short candidate file recording what it failed and where you
read that, and stop. Do not score it. It appears in the report's excluded list, which
is what stops the same question being asked again on the next run.

## Source discipline

Every score carries a confidence tag, and the tag is determined by where the claim
came from — not by how sure you feel:

| Tag | Source |
| --- | --- |
| **V** | The certifying body's own site, blueprint, exam guide, policy or pricing page |
| **S** | Prep providers, training partners, resellers, blogs, forums, press, course listings |
| **I** | Your own inference from adjacent evidence, with no source |

**Vendor pages outrank everything.** Prep providers paraphrase material that is often
gated, and they sell preparation, which gives them a standing reason to be optimistic
about how attainable and how valuable a credential is. A well-documented failure mode
is a prep site restating an eligibility rule more loosely than the vendor does —
generously enough that a reader concludes they qualify when they do not. Where a
vendor page and a secondary source disagree, the vendor wins and the disagreement goes
in `research/sources.md` under Contradictions, because the disagreement is often more
informative than either claim.

Log every URL in `research/sources.md` with its tier, what it was used for, and the
date read. This is what makes the next run cheap, and what lets a future reader tell
whether a score has rotted.

**A status code is not a verdict.** A 200 can front an empty page, a 403 can front a
healthy one, and a 301 can lead to a resource that no longer exists. Confirm you got
the resource, not just a response. If a page is gated, withdrawn, or renders nothing
useful, record it under Dead ends rather than silently inferring around it.

## Price the whole route

`cost_all_in` covers everything mandatory to reach the credential: exam fee,
prerequisite exams, required training, membership or partner fees, proctoring,
identity verification. If a component cannot be priced, itemise what you found in the
candidate file and mark the total as a floor rather than guessing.

Note renewal cost separately in the candidate file. It does not belong in
`cost_all_in` but it belongs in the decision.

## Score

One row per candidate × criterion in `research/scores.csv`: score to two decimals on a
0–1 scale, confidence tag, and a one-line justification. The reasoning that will not
fit in a line goes in the candidate's own file, which is also where the full blueprint
is transcribed with its published domain weights.

Score against the anchors, not against your impression. Read `anchor_1`, `anchor_half`
and `anchor_0` before each score and place the credential between them.

Leave a criterion unscored rather than guessing. An unscored criterion is excluded
from the total and flagged in the report; a guessed one silently moves a ranking.

## Traps

**Coverage is not keyword matching.** "Mentions MCP in a syllabus bullet" and
"assesses MCP as a named objective with a stated weight" are different scores, and
the anchors say so.

**Do not let documentation volume become quality.** A credential with extensive
content marketing is easier to score highly simply because there is more to read.
Score the credential, not its marketing budget.

**Do not import reputation.** If a credential is famous, that belongs in the
recognition criterion at whatever weight the user gave it — and nowhere else.

**Absence is a finding.** If nothing clears the filters, or nothing covers more than
half the topic list, say so. A ranked list of things that all failed the spec is worse
than no list, and the kill condition in `profile/objectives.md` exists for exactly
this outcome.

## Finish

Write the candidate files from `research/candidates/TEMPLATE.md`. Then report back:
how many surveyed, how many excluded and on what, where the evidence is thin, and any
criterion you could not establish for anyone — that last one usually means the
criterion was written in a way the public record cannot answer, which is worth knowing
before the next run.
