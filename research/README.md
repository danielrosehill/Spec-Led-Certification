# research/ — what the market actually offers

Written by the `research-market` skill, against the frozen scorecard. Three machine
files and a folder of prose.

| Path | Contents |
| --- | --- |
| [candidates.csv](candidates.csv) | Every credential surveyed, one row each, with its all-in cost and whether it survived the filters |
| [scores.csv](scores.csv) | One row per candidate × criterion: the score, its confidence tag, and a one-line justification |
| [sources.md](sources.md) | The verification log — every URL, what it was used for, and when it was read |
| `candidates/` | One markdown file per surviving candidate, from [candidates/TEMPLATE.md](candidates/TEMPLATE.md) |

## Rules the research phase runs under

**The scorecard does not move.** The agent scores against the criteria it was given.
If a criterion turns out to be unanswerable from public information, that is a score
of unknown and a note — not a redefinition of the criterion.

**Vendor first, always.** The certification's own site, its published blueprint or
exam guide, and its own eligibility and pricing pages outrank everything else. Prep
providers, training partners, and exam-cram blogs are secondary by definition: they
paraphrase material that is often gated, and they sell preparation, which gives them a
standing reason to be optimistic about how attainable and how valuable a credential
is. Score from a prep site and the score is **S** at best.

**Eligibility is checked before content.** A credential nobody can sit is not a
cheaper or slower option, it is not an option. Partner-tier requirements, employer
size, prerequisite certifications, geography, and identity verification have all
locked people out of exams they were otherwise ready for, and every one of them is
published on a page that ranks below the marketing.

**All-in cost, not headline price.** Prerequisites, mandatory courses, membership
fees, proctoring, and renewal all belong in `cost_all_in`. If a component cannot be
priced, record the components in the candidate's file and mark the total as a floor.

**Absence is a finding.** If the survey turns up no credential that clears the
filters, that is the answer and the report says so. A ranked list of things that all
failed the spec is worse than no list.

## Anti-patterns worth naming

- Ranking by how well-known a credential is and then reverse-engineering criteria
  scores to match. The frozen scorecard exists to make this visible.
- Treating a syllabus keyword as coverage. "Mentions MCP" and "assesses MCP as a
  named objective with a stated weight" are different scores.
- Letting a well-documented candidate outrank a well-suited one because there was more
  to read about it. Score the credential, not its content marketing.
