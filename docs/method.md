# The method

Why the workflow is shaped the way it is. Read this if you want to adapt it, argue
with it, or apply the same pattern to a decision that is not about certifications.

## The problem

Choosing a certification is normally market-led:

> I work in this field → here is what's on offer → this one seems well-regarded →
> I'll sit that.

The failure is not that people pick badly. It is that **the exam's blueprint becomes
the specification by default.** You discover what you wanted from the credential
after you have already agreed to want what it teaches, and the criteria you would
have written — portability, cost, the format you actually learn in — are only
recovered afterwards, as reasons for a choice already made.

The tell is that the answer is usually the most famous option, and the reasoning is
usually assembled backwards from it.

## The inversion

Write the specification before the options are known.

1. **Intake.** Who the user is, where they stand, how they learn, what the credential
   is for, what they can spend.
2. **Freeze.** Derive weighted criteria and hard filters from that alone, and commit
   them before looking anything up.
3. **Research.** Survey the market and score against the frozen card.
4. **Recommend.** Rank by the arithmetic, and explain which weights did the work.

Nothing here is novel. It is ordinary requirements-then-sourcing discipline — the
same shape as writing a spec before going out to tender — applied to a decision people
usually make on reputation.

## Why the freeze is the whole thing

Everything else is presentation. Without the freeze, the weights land wherever they
need to land to justify the option that already appealed, and a weighted scorecard is
a very effective way to make that look rigorous.

Three mechanisms enforce it, in increasing order of reliability:

- **Instruction.** The skills say not to look anything up before freezing.
- **Traceability.** Every criterion carries a `source` column naming the line in
  `profile/` it came from. A criterion that exists because you knew a particular exam
  scored well on it cannot fill that column honestly.
- **Separation.** The research subagent never sees the intake conversation. It
  receives the scorecard and nothing else, so there is no anchor available to bend
  toward.

The commit before research matters for the same reason. A frozen scorecard that was
never committed first is a claim about the process, not evidence of it.

## Why intake is five skills and not one

Because the five decay at completely different rates.

What you know is stale in a quarter. How you learn is much the same in five years.
Fusing them into one profile means the whole thing expires at the rate of its fastest
component, and a re-run six months later becomes a full re-interview — which is
exactly the cost that stops people re-running anything.

Split, with a `review_after` on each, a second pass typically re-asks one file and
confirms four. That is the difference between a workflow you run once and one you run
whenever the market moves.

## Why filters are separate from criteria

A hard requirement that can be outweighed is not a hard requirement.

Scoring eligibility as a criterion — even at a heavy weight — lets a credential the
user cannot actually sit place third, because strength elsewhere compensates. So
eligibility gates and non-negotiables exclude rather than score, and excluded
candidates appear in their own section of the report with the filter they failed,
which is what stops "why not that one?" being re-asked on every run.

Getting the classification right is most of what the objectives interview is for.
Users say "must" loosely, and the test — *if it were outstanding on everything else
and failed this, would you still consider it?* — is what separates the two.

## Why every figure is computed at compile time

`report/report.typ` reads `scorecard/criteria.csv` and `research/scores.csv` and
computes the weighted totals, the ranking and the comparison table itself. Nobody
types a number into prose.

A report that restates its own data in narrative form will eventually contradict it —
a score gets revised, the paragraph does not. Since the ranking is the output, a
report whose prose can disagree with its arithmetic is not trustworthy in the one
respect that matters. Prose refers to scores in words; the tables carry the digits.

The same property is what makes a re-run comparable: two runs with the same criteria
file produce numbers computed identically.

## Why confidence tags on every claim

Certification research has a specific, reliable bias in its source material.

The bodies that certify often gate their blueprints. The sites that are not gated are
mostly selling preparation, which gives them a standing reason to be optimistic about
how attainable a credential is and how much it is worth. A prep provider restating an
eligibility rule slightly loosely — generously enough that a reader concludes they
qualify when they do not — is a repeated pattern, not an occasional lapse.

So every score records where it came from: `V` vendor, `S` secondary, `I` inferred.
The report prints the tag next to the number, and a recommendation resting on
`I`-tagged scores at its heaviest criteria has to say so. This is also what lets a
future reader tell which parts of an old run have rotted: `V` claims need re-checking
against the vendor, `S` and `I` claims were never solid.

## Limits

**It cannot tell you what you want.** Garbage in the objectives produces a
confidently-ranked answer to the wrong question. The interview probes, but it cannot
substitute for the user knowing why they are doing this.

**Weights are arguable and that is fine.** The scorecard does not claim the weights
are correct — it claims they are *yours*, written down before the options were known,
so a reader who disagrees can argue with a number rather than with a conclusion. A
ranking whose reasoning can be attacked at a specific weight is more useful than one
that cannot.

**Precision is not accuracy.** Two decimal places on a judgement about how portable a
blueprint is are a convenience for arithmetic, not a claim of measurement. The
anchors are what keep the scores comparable; without them the decimals mean nothing.

**It has a shelf life.** Blueprints get revised, prices rise, eligibility rules open
and close. Every run is dated, and the report names the specific condition that would
flip its own conclusion, so you know when to run it again rather than assuming it
still holds.
