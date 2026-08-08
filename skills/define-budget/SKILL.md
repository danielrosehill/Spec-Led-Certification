---
name: define-budget
description: Capture the two budgets — money (ceiling, comfortable figure, retakes, who pays, renewals) and time (hours per week, weeks available, whether the time is protected). Writes profile/budget.md. Fifth and final intake stage of the spec-led certification workflow.
---

# Define the budget

Two budgets, captured separately because they fail separately. A credential you can
afford and have no time to prepare for is as unobtainable as one you have all year for
and cannot pay for, and a single "what's your budget" question reliably surfaces only
one of them.

## Financial

**The ceiling and the comfortable figure.** Ask for both. The ceiling is where the
answer becomes no; the comfortable figure is what they would spend without thinking
about it. The gap between them is where most real decisions sit, and a scorecard with
only one number cannot score anything into that gap.

**All-in, not headline.** Say explicitly that the figure should cover the whole route
to the credential, not the exam fee: prerequisite exams, mandatory training, partner
or membership fees, proctoring, identity verification, and the first renewal. Headline
prices systematically understate this, and the research phase is instructed to price
the whole route — so the budget has to be stated on the same basis or the comparison
is meaningless.

**Retakes.** Ask whether a second sitting is budgeted. Many exams charge close to full
price again, and a user who has not considered it is holding a ceiling that is really
half a ceiling.

**Who pays.** Self, employer, or client. Employer funding usually carries conditions —
approved vendor lists, clawback on leaving, a fixed annual allowance with a deadline —
and those conditions are often hard filters that the user will not think to mention.
Ask.

**Recurring cost.** Renewal fees and continuing-education requirements. A cheap exam
with an expensive annual renewal is not a cheap credential, and this is the cost most
easily missed at decision time because it lands long after the decision.

## Time

**Hours per week, realistically.** Push back gently on aspirational numbers. Ask what
last week actually looked like rather than what a good week looks like. An
over-stated hours figure produces a time-fit score that clears a candidate the user
will then fail to prepare for, which is the single most common way this decision goes
wrong.

**Weeks available.** Bounded by the window in `profile/objectives.md` — read it rather
than asking again. If no window was set, ask for a horizon here.

**Protected or leftover?** A fixed slot in the week is a different thing from
whatever time is left over, even at the same nominal hours. Leftover time does not
survive a busy month, so a candidate needing sustained preparation should be scored
down for a user whose hours are unprotected.

**The total** is hours × weeks, and it is the number the research phase tests
candidates against. Compute it and show it to the user — seeing "forty hours, total"
written down frequently corrects the inputs.

## Non-negotiables

Anything about cost or time that is a filter rather than a score: cannot travel to a
test centre, cannot take weekdays off, cannot pay before the next quarter. These
become rows in `scorecard/filters.csv` alongside the standing positions from
objectives.

## Write

Replace `profile/budget.md`, keeping the frontmatter shape:

```yaml
status: filled
captured: <today, YYYY-MM-DD>
volatility: medium
review_after: <today + 6 months>
```

This is the last intake stage. When it is written, the profile is complete and
`build-scorecard` can run. Tell the user that, and tell them that the next step
freezes the specification before any credential is looked up.
