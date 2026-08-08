---
name: update-profile
description: Change what is stored about the user — their position, learning preferences, objectives, budget or subject — without running a search. Re-interviews only the files that changed, re-dates them, and marks the scorecard stale so the next run rebuilds it. Use when circumstances change, when a review date passes, or when the user says a stored answer is wrong.
---

# Update the profile

The maintenance path. Changes what is on file about the user, and stops there.

Use it when something about them has changed — more time, less money, a new job, a
finished course, a shifted deadline — or when a `review_after` date has passed, or
when they read a profile file and disagreed with it. Running a search afterwards is
offered, not assumed.

Separating this from the search is deliberate. Updating a profile and re-surveying a
market are different jobs on different clocks: the first is a two-minute correction
that should not drag an hour of research behind it, and the second should not quietly
re-open questions about the user that nobody asked to reconsider.

## 1. Work out what actually changed

If the user named it — "I've got more time now" — go straight there. Otherwise show
the five files with their `captured` dates and ask which is wrong, rather than
proposing a full re-interview.

Also flag anything past `review_after`, but flag it, do not act on it. Someone who
came to fix their budget does not necessarily want to redo their benchmark in the same
sitting, and bundling the two is how a two-minute correction becomes an abandoned
conversation.

| File | Re-run when |
| --- | --- |
| `spec.md` | The subject or the topic list changed. Consider whether this is really a **new search** in a new directory |
| `benchmark.md` | They have built, learned or shipped something; three months have passed; the evidence has moved |
| `learning-preferences.md` | Rarely. A change in circumstances — a commute, a new device, a course that failed in an instructive way |
| `objectives.md` | The purpose, the audience, a standing position, or the deadline changed |
| `budget.md` | Money or hours changed, or who is paying |

## 2. Re-run only those stage skills

Invoke the corresponding skill for each file that changed. Each rewrites its file and
sets a fresh `captured` and `review_after`.

Two things to hold on to while doing it:

**Do not silently reopen the rest.** If a benchmark update surfaces something that
bears on objectives, say so and ask — do not edit `objectives.md` because it seemed
implied.

**Preserve what did not change.** These interviews rewrite the whole file. Read the
existing content first and carry forward the parts still true, especially the open
questions and the standing positions, which are easy to lose and expensive to
re-elicit.

## 3. Mark the scorecard stale

**This is the step that makes the update mean anything.**

If any profile file changed, set in `scorecard/methodology.md` frontmatter:

```yaml
stale: true
stale_since: <today, YYYY-MM-DD>
stale_reason: <which files changed, in a few words>
```

Leave `frozen: true` and `frozen_at` exactly as they are. The old scorecard remains the
record of what was frozen before the last research ran — overwriting that would destroy
the evidence that the process was followed. `stale` says it needs rebuilding next time;
it does not say it never happened.

`rerun-search` reads this flag and rebuilds and re-freezes before researching. Without
it, the next run scores a changed person against an unchanged specification, produces a
ranking that looks fine, and is wrong in a way nothing surfaces.

Tell the user plainly: their scorecard and their last recommendation are now
provisional, and the ranking may move.

## 4. Offer, do not assume

Ask whether they want to re-run the search now.

**Yes** → hand off to `rerun-search`, which will see `stale: true` and rebuild.

**No** → say what is now inconsistent and leave it. That is a legitimate state: the
profile is current, the scorecard is stale, and both facts are on record. Do not
rebuild the scorecard here as a tidying-up gesture — a scorecard frozen in one session
and researched against in another, with the freeze commit in between, is exactly the
audit trail the method depends on.

## Correcting rather than updating

If the user is not reporting a change but saying the file is *wrong* — a
misunderstanding in the interview, or a position recorded at the wrong strength — fix
it directly rather than re-running the whole interview, and keep the original
`captured` date if the underlying facts are unchanged. Only a genuine change of
circumstances re-dates a file. Re-dating on a correction hides how old the answers
really are, which is the one thing these dates exist to prevent.
