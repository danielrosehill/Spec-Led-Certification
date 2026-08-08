---
name: define-objectives
description: Establish what the credential is actually for — its purpose, its audience, the user's standing positions such as vendor neutrality, the calendar window, and the condition under which sitting nothing is the right answer. Writes profile/objectives.md. Fourth stage of the spec-led certification workflow and the main source of scorecard weights.
---

# Define objectives

The stage that decides what a good answer looks like. `define-spec` established the
subject; this establishes the job the credential has to do, and that is what sets the
weights. Two people wanting a certification in the same field, for different reasons,
should get different recommendations — if they do not, the workflow is not doing
anything that reading a listicle would not.

## Interview

**1. Purpose — what does the credential have to *do*?**

Not the subject. The job. These are genuinely different instruments:

- signal general competence when moving into a field from outside it
- satisfy a procurement or tender requirement that names a credential
- unlock a partner tier, marketplace listing, or reseller status
- force structured study of a topic, where the badge is incidental
- keep an existing certification current

Ask which, and accept "the badge is not really the point" as a valid answer — it is
a common one and it changes the weights dramatically, pushing coverage up and
recognition to near zero.

**2. Audience — who has to find it credible?**

Anonymous recruiters, procurement officers, existing clients, one specific employer,
a marketplace's eligibility reviewer, or the user themselves. Ask what that audience
already knows about them. A credential aimed at someone who has already seen the work
is doing a different job from one aimed at a keyword filter, and this single answer
usually moves the recognition weight more than anything else.

**3. Standing positions — what do they believe before seeing any options?**

This is the heart of the stage. Elicit the principles they hold *independently of
what is on the market*, and record them before research begins, so that research
cannot quietly argue them out of it.

The most common one is some version of *no vendor-specific credential without a
specific reason*. Do not just record the position — probe what would count as a good
enough reason, because that is what separates a criterion from a filter.

Classify each position by strength, and be strict about it:

| Strength | Meaning |
| --- | --- |
| **hard requirement** | A candidate failing this is excluded, not scored down |
| **strong preference** | Heavy weight on the scorecard |
| **preference** | Ordinary weight |
| **tiebreak** | Only separates otherwise equal candidates |

Users reach for "must" loosely. Test each one: *if a credential were outstanding on
everything else and failed this, would you still consider it?* If yes, it is a
preference. A hard requirement quietly demoted to a preference is exactly how a
spec-led process turns back into a market-led one, and getting this classification
right is most of what this stage is for.

**4. The certification window — by when, and what fixes the date?**

A tender deadline, a job search, a renewal date, a visa application, or nothing
harder than "this year". Keep this distinct from the study-hours budget in
`define-budget`: this is the *when by*, that is the *how much per week*. A candidate
can pass the hours test and still miss the window if the exam only runs twice a year,
or if a prerequisite takes a quarter on its own.

**5. What would make this not worth doing?**

The kill condition. If research finds it, the recommendation is "sit nothing".

Ask it plainly and do not let it be waved away. A workflow with no kill condition is
a machine for justifying a decision already made, and this one question is most of
what stops that. Reasonable answers exist: nothing covers more than half the topic
list, everything credible is gated, the cheapest route exceeds the ceiling, the
field's credentials are all under two years old and none is recognised anywhere.

## Write

Replace `profile/objectives.md`, keeping the frontmatter shape:

```yaml
status: filled
captured: <today, YYYY-MM-DD>
volatility: medium
review_after: <today + 12 months>
```

Then read the standing positions back to the user with their strengths, and confirm
the hard requirements specifically. Those are about to exclude candidates
unconditionally, and this is the last cheap moment to correct one.
