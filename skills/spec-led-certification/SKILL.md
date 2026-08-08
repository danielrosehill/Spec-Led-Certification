---
name: spec-led-certification
description: Entry point for the whole workflow — reads the state on disk and routes to start-search, rerun-search or update-profile. Use when the user wants a certification decision and it is not obvious which of the three they need, or when they do not know what state an existing workspace is in.
---

# Spec-led certification — router

Works out which of the three usage patterns applies and hands off. It does not carry
any procedure of its own; each entry point is self-contained and can be invoked
directly when the user already knows what they want.

| Entry point | When |
| --- | --- |
| [`start-search`](../start-search/SKILL.md) | First run, or a new subject. Onboarding, five interviews, scorecard, research, report |
| [`rerun-search`](../rerun-search/SKILL.md) | Intake already on file. Archive, confirm, re-survey, report what changed |
| [`update-profile`](../update-profile/SKILL.md) | Something about the user changed. Re-interview only what moved, mark the scorecard stale |

If the user's request already names one — "start again", "has anything changed", "I've
got more time now" — go straight there. Only work through the state when it is
genuinely unclear.

## Read the state

Check the frontmatter of the five files in `profile/` and of
`scorecard/methodology.md`.

| State on disk | Route to |
| --- | --- |
| `profile/` missing entirely | Scaffold first, then `start-search` |
| All five `unfilled` | `start-search` |
| Some filled, some unfilled, nothing expired | `start-search`, which skips what is already done |
| All filled and current | `rerun-search` |
| All filled, one or more past `review_after` | `update-profile` for the expired ones, then offer `rerun-search` |
| Filled and current, but `scorecard` is `stale: true` | `rerun-search` — it rebuilds and re-freezes |

Say which route you picked and why, in one line, before starting. If the state and
the user's words disagree — the profile looks current but they say they want to start
over — ask rather than guessing, and check whether they mean a **new subject**, which
means a new directory rather than overwriting this one.

## The rule that holds across all three

**No credential is named, searched for, or considered until
`scorecard/methodology.md` says `frozen: true` and `stale: false`.**

A scorecard written or amended after the options are known is a rationalisation of
whichever one already appealed, and a weighted table is a very effective way of making
that look rigorous. Every criterion carries a `source` column naming the line in
`profile/` it came from; one that cannot fill that column honestly does not go on the
card.

## Subagents

If subagents are available, the three roles in `agents/` map to the phases regardless
of which entry point is running: `intake` for any interview, `research` for any market
sweep, `recommendation` for any report. The research agent receives the frozen
scorecard and not the intake conversation, which enforces the freeze structurally
rather than by instruction.

## Where everything is written

Nothing goes into the agent's own memory store. It all goes into this workspace as
plain markdown and CSV, so the user can read it, correct it, and take it to a
different assistant next time.

| Path | Holds |
| --- | --- |
| `profile/` | The five dated intake files |
| `scorecard/` | Criteria, filters, methodology, and the freeze and stale flags |
| `research/` | Candidates, scores, per-credential notes, verification log |
| `report/` | Narrative and metadata; `report.typ` computes every figure from the CSVs |
| `runs/<date>/` | Archived previous runs — scorecard, data and conclusion together |
| `pdf/` | Built reports |
