---
name: benchmark-me
description: Establish where the user actually stands today against the capability areas in the spec, from evidence they point at — repos, site, CV, published work — rather than self-report alone. Writes profile/benchmark.md. Second stage of the spec-led certification workflow.
---

# Benchmark the user

Produce a dated, evidence-backed picture of the user's current position in each
capability area named in `profile/spec.md`. This feeds two things downstream: the
readiness estimate for each candidate credential, and the *Where to invest* section
of the final report.

It is also the file that goes stale fastest. Three-month review interval, and the
date on it is load-bearing — a benchmark with no date is a claim about nothing in
particular.

## Prerequisite

`profile/spec.md` must be filled. The capability areas come from there; benchmarking
against areas you invented is how the scorecard ends up measuring the wrong thing.

## Gather evidence first, ask second

The order matters. If you ask first, you get self-assessment, and self-assessment on
technical capability is unreliable in both directions — people under-rate what they
do daily and over-rate what they read about once.

Ask what you may look at:

- public repositories, and whether you may read the local tree
- a portfolio or personal site
- a CV, résumé, or LinkedIn export
- published writing, talks, packages, or answers
- anything at work that can be described but not shown

Then actually look. For a repo tree, the useful signals are structural rather than
linguistic: what exists, what is conspicuously absent, what is recent versus dormant.
Absences are frequently the sharpest finding — no tests anywhere, no CI workflows, no
error handling around a subsystem that is otherwise sophisticated. Note them.

Record every source you reviewed and the date in the evidence table. The next run
re-reads them instead of re-asking, which is most of why a second pass is cheap.

## Then interview, to fill what evidence cannot show

Evidence shows what someone has built. It does not show what they understand, what
they did at a previous job, or what they are currently mid-way through learning. Ask
about the areas where you found nothing, and ask specifically — "I found no
evaluation harnesses anywhere; is that a gap or is it somewhere I cannot see?"

## Scoring positions

Four levels only: **Strong**, **Working**, **Weak**, **None**. Resist finer grain.
The scorecard does not consume this numerically and false precision here reads as
authority it has not earned.

Every row carries a **basis** of either `evidence` or `self-reported`, and these must
never be blurred. A Strong on evidence and a Strong on self-report are different
claims, and the report will treat them differently.

## Say what you found, including the unflattering parts

The benchmark is only useful if it is honest. A benchmark that tells the user they
are strong everywhere produces a recommendation that cannot distinguish between
credentials and an investment section with nothing in it. If the evidence is thin,
say the evidence is thin.

Equally, do not manufacture severity. "Weak" means the evidence shows weakness, not
that you found it convenient to have something to recommend.

## Write

Replace `profile/benchmark.md`, keeping the frontmatter shape:

```yaml
status: filled
captured: <today, YYYY-MM-DD>
volatility: high
review_after: <today + 3 months>
```

Report back with the two or three sharpest findings — particularly any narrow,
concentrated, fixable gap, which is the most actionable thing this stage produces.
