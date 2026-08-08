---
id:
name:
vendor:
url:
surveyed:
status: candidate    # candidate | excluded
excluded_by:
---

# <Name> — <vendor>

One paragraph: what this credential claims to certify, who it is aimed at, and the
single reason it is or is not interesting here.

## Eligibility

Checked before anything else. Prerequisites, partner or membership requirements,
employer or organisation conditions, geography, ID requirements, exam availability.

| Condition | Status | Confidence | Source |
| --- | --- | --- | --- |

If a hard filter fails, say so here in one line, set `status: excluded`, name the
filter in `excluded_by`, and stop. Do not score an excluded candidate.

## Cost, all-in

| Component | Amount | Confidence | Source |
| --- | --- | --- | --- |
| Exam fee | | | |
| Prerequisite exams | | | |
| Mandatory training | | | |
| Membership / partner fee | | | |
| Proctoring | | | |
| **Total** | | | |
| Renewal, per cycle | | | |

## Time to prepare

The vendor's own estimate, any independent estimate, and the agent's estimate given
`profile/benchmark.md`. Keep the three separate — a vendor estimate assumes a
generic candidate, and the whole point of having a benchmark is that this one is not
generic.

## Blueprint

Every published domain with its stated weight. This is the source for the coverage
scores, and quoting it in full is what lets a re-run six months later detect that the
blueprint changed.

| Domain | Weight | Assessed objectives | Position vs benchmark |
| --- | --- | --- | --- |

## Scores against the scorecard

Mirror of this candidate's rows in `../scores.csv`, with the reasoning that the CSV's
one-line note cannot hold. The CSV is authoritative for the numbers; this is where the
argument lives.

| Criterion | Score | Confidence | Reasoning |
| --- | --- | --- | --- |

## What could not be established

Anything the public record does not answer, and what it would take to answer it —
an email to the vendor, a partner login, someone who has sat it. Naming these is how
the next run knows where to start rather than re-hitting the same wall.
