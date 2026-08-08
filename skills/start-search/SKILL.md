---
name: start-search
description: First run — onboard someone who has never done this, take them through all five intake interviews, freeze the scorecard, survey the market and produce the recommendation. Use when profile/ is unfilled, when the user is starting a search for a new subject, or when they ask how this works. For a second pass use rerun-search; to change stored answers use update-profile.
---

# Start a search

The onboarding path. Assume the user has never done this and does not know what they
are agreeing to — the whole point is that they answer questions about themselves
before seeing any options, and that is an unusual enough request to need explaining.

Use this when `profile/` is unfilled, or when the subject is new. If the profile is
already filled and current, the user wants [`rerun-search`](../rerun-search/SKILL.md);
if they want to change a stored answer, [`update-profile`](../update-profile/SKILL.md).

## Check there is somewhere to write

The workflow's state lives on disk. If `profile/` does not exist, the workspace has
not been scaffolded — clone the template repo, or run the plugin's
`scaffold-workspace` skill.

If `profile/` is filled and current and the user still asked to start, ask whether
they mean a **new subject**. One workspace per search: two subjects sharing one
`profile/` gives a spec that describes neither. A new subject means a new directory.

## Set expectations before the first question

Say four things, briefly. People answer better when they know why they are being
asked, and the second point in particular changes how they answer.

1. **Roughly an hour**, nearly all of it in this conversation. The market research is
   the fast part.
2. **You will be asked about yourself before any certification is named** — including
   by you. That ordering is the method: a scorecard written after the options are known
   bends toward whichever one already appealed, and a weighted table is a very good way
   of making that look rigorous.
3. **Nothing is stored in the assistant.** It goes into files in this directory that
   they can read, correct, and take to a different assistant later.
4. **"I don't know" is a usable answer.** It gets recorded as an open question. An
   invented answer becomes a weight, then a ranking, and by then it is invisible.

Then ask if they want to go on, and stop if they say no. This is the only stage where
the whole thing can still be cheaply abandoned.

## Intake, in order

Run all five, in this sequence, following each skill:

1. **`define-spec`** — the field, and the named topics a credential must cover.
2. **`benchmark-me`** — where they stand, read off evidence before it is asked for.
3. **`learning-preferences`** — how they take information in.
4. **`define-objectives`** — what the credential is *for*, who has to believe it, the
   standing positions, the window, and the kill condition.
5. **`define-budget`** — money and hours.

The order is not arbitrary. Topics before evidence, because the benchmark is measured
against the topics. Objectives before budget, because the window bounds the weeks.

Between each: two lines on what was captured, so a wrong answer is cheap to catch.
Commit if this is a git checkout.

## Guardrails specific to a first run

**Do not name a credential, and stop the user gently if they do.** They will, often in
the first minute, and it is the single most damaging thing that can happen at this
stage. Everything downstream — the topic list, the weights, the search — bends toward
whatever is mentioned first. Record it in `profile/spec.md` under open questions as
something to check later, say that is what you are doing and why, and carry on.

**Do not let the interview become a quiz they think they can fail.** The benchmark
exists to aim the study effort, not to grade them. If someone starts overstating,
the resulting readiness numbers are wrong in the direction that hurts them.

**Ask the kill condition properly.** New users wave it away. A workflow with no answer
to "what would make this not worth doing" is a machine for justifying a decision
already made, and this one question is most of what prevents that.

## Then the rest of the run

6. **`build-scorecard`** — derive weights and filters from `profile/` alone, set
   `frozen: true`, and commit *before* anything is looked up. That commit is the only
   evidence the scorecard was frozen first rather than described as frozen.
7. **`research-market`** — survey, filter on eligibility, price the whole route, score.
8. **`recommend`** — narrative and PDF.

Leave `changes` empty in `report/narrative.yaml`. There is no previous run to compare
against, and the report omits that section when it is empty.

## Finish

Give the recommendation in the conversation, not only in the PDF.

Then tell them how to come back, because this is the part that makes the hour worth
spending and nobody discovers it on their own:

- **`rerun-search`** when they want to know if the market has moved. The profile is
  already on file, so it is a short confirmation and a fresh sweep.
- **`update-profile`** when something about them changes — more time, a new job, a
  finished course.
- The earliest `review_after` date in `profile/`, which is usually `benchmark.md` at
  three months.
