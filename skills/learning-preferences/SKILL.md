---
name: learning-preferences
description: Capture how the user learns — modality, devices, session shape, assessment formats they do well and badly in, and what has failed before. Writes profile/learning-preferences.md. Third stage of the spec-led certification workflow; the most durable file in the profile.
---

# Capture learning preferences

Separate from the benchmark on purpose. The benchmark is what the user knows and it
changes every quarter; this is how they take information in, and it is much the same
in five years. Two-year review interval, and on most re-runs this file is confirmed
rather than rebuilt.

## Why this is a stage rather than a footnote

Two credentials can score identically on content and be very different propositions
to actually obtain. One is prepared for by reading a specification; another has no
serious route to it except a forty-hour video course; a third assesses by take-home
project rather than timed multiple choice. Which of those suits the user is a real
input to the decision, and the usual failure is to notice it only after the exam is
booked — at which point it becomes a reason the preparation stalls rather than a
factor in choosing.

So this feeds two things: a scorecard criterion on preparation-route fit, and the
tiebreak between candidates that score alike on everything else.

## Interview

**Modality.** How do they actually learn — reading, video, live instruction, building
alongside, problem sets, teaching it to someone else? Ask for a concrete recent
example rather than a preference in the abstract: "what is the last technical thing
you learned properly, and how did that happen?" The answer to that is worth more than
the answer to "how do you like to learn".

**Context and devices.** Where, and on what. Video on a tablet away from the desk is
a different capability from video at a workstation, and it decides whether a course
is realistically consumable. Ask about the commute, the evening, the weekend.

**Session shape.** Long deep sessions or short frequent ones? Fixed slots or
opportunistic? This decides whether a cohort course with weekly live calls is a fit or
a trap.

**Assessment style.** How do they perform under timed multiple choice, open book,
take-home projects, live oral examination? People who build well and test badly are
common, and a credential's assessment format is published, so this is checkable.

**What has not worked.** The highest-signal question and the easiest to skip. Ask
directly about courses started and abandoned, and about why. Do it without any
suggestion that abandoning one was a failure of character — the useful answer is
structural ("it was ninety minutes of video before the first exercise"), and people
only give that answer if the question is not loaded.

## Pitfalls

**Do not turn this into a learning-styles quiz.** The visual/auditory/kinaesthetic
framing does not hold up, and it produces categories that no exam blueprint can be
matched against. Stay concrete: formats, devices, durations, assessment types.

**Do not let stated preference override demonstrated behaviour.** If they say they
learn by reading and then describe having learned their last three tools by building
badly and iterating, record both, and say plainly which one is the observation.

## Write

Replace `profile/learning-preferences.md`, keeping the frontmatter shape:

```yaml
status: filled
captured: <today, YYYY-MM-DD>
volatility: low
review_after: <today + 24 months>
```

Same rule as every intake stage: it goes in the repo, not in the agent's memory.
