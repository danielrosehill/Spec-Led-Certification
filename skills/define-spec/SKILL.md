---
name: define-spec
description: Capture the headline ask — what field the user wants certified in, which capability areas the credential must cover, and what is out of scope. Writes profile/spec.md. First stage of the spec-led certification workflow; run it before any research.
---

# Define the spec

The opening interview. It establishes *what* is being looked for, in enough detail
that a scorecard can later be built from it. It does not establish why, how much, or
by when — those are `define-objectives` and `define-budget`. Keep to scope here; the
modularity is deliberate, because on a re-run this file usually survives and the
others may not.

## Before anything

Read `profile/spec.md`. If `status` is not `unfilled` and `review_after` is in the
future, show the user what is on file and ask whether it still holds. A confirmation
is a one-line exchange and a bumped `captured` date — not a re-interview.

## The rule that governs every intake skill

**Everything learned goes into `profile/` in this repository. Nothing goes into the
agent's own memory store.** Not Claude's memory, not a hosted user profile, not
"I'll remember this". The repo is the memory, and it is the repo the user carries to
whatever assistant they use next. If you have a memory tool available, this is the
one case where you do not reach for it.

## Interview

One question at a time. The user is thinking as they answer, and a wall of six
questions gets six thin answers.

**1. The subject.** What field, in their own words. Let them ramble; the rambling
contains the topic list.

**2. The named topics.** This is the part that matters and the part users skip.
Push for concrete capability areas, then test each one: *could I check a published
exam blueprint and tell whether it covers this?* "Agentic AI" fails that test.
"Sub-agent delegation" passes it. Aim for four to ten.

If they cannot produce topics, offer a starting list drawn from the subject and ask
them to cut and correct it — recognition is easier than recall. Mark anything you
supplied and they merely accepted, because a topic the user did not actually ask for
should not carry much weight later.

**3. The shape.** Proctored exam, assessed project, course completion, a portfolio
review? One credential, or a backbone plus a specialist? Some users have no view;
record that rather than inventing one.

**4. Out of scope.** What have they already ruled out, and why. This is worth its own
question because it saves the research phase re-treading ground and stops a re-run
six months later resurfacing the same rejected options.

## Pitfalls

**Do not name candidate credentials.** You almost certainly know some. Naming one
here anchors the entire process on it, and everything downstream — the topic list,
the weights, the research — bends toward the thing that was mentioned first. If the
user names one, record it under open questions as a candidate to check, not as a
topic.

**Do not let the subject become the topic list.** "I want an agentic AI cert" is a
subject, and a scorecard built from it alone cannot distinguish two credentials.

**Vague is fine, unresolved is not.** If the user genuinely does not know something,
write it under open questions. An honest gap is workable; an invented answer
propagates into a weight and then into a ranking.

## Write

Replace `profile/spec.md` entirely, keeping the frontmatter shape:

```yaml
status: filled
captured: <today, YYYY-MM-DD>
volatility: medium
review_after: <today + 12 months>
```

Then tell the user, in two lines, what you recorded and what remains open. Do not
proceed to the next stage without being asked — unless you are running under the
`spec-led-certification` meta-skill, which sequences the stages itself.
