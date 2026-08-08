# profile/ — what the agent knows about you

Five files. Together they are the input to the scorecard, and the scorecard is what
the research is scored against. Nothing here is about the certification market; it is
all about you.

**These files are the memory.** No intake skill may write what it learns into the
agent's own memory store — not Claude's memory, not a vendor-hosted profile, not a
conversation it hopes to still have next time. It goes here, in the repo, in git, in
plain markdown. That is what makes the workflow agent-agnostic and what makes the
six-month re-run cheap: you bring the repo, not the assistant.

## The five

| File | Holds | Written by |
| --- | --- | --- |
| [spec.md](spec.md) | The headline ask — what field, what kind of credential | `define-spec` |
| [benchmark.md](benchmark.md) | Where you actually are now, with evidence | `benchmark-me` |
| [learning-preferences.md](learning-preferences.md) | How you take information in | `learning-preferences` |
| [objectives.md](objectives.md) | What the credential is *for*, and your standing positions | `define-objectives` |
| [budget.md](budget.md) | Money, study hours, and the calendar window | `define-budget` |

## Volatility — why every file carries a date

These decay at very different rates. Your benchmark is stale in a season; how you
learn is probably the same at fifty as at thirty. So each file's frontmatter carries:

```yaml
captured: 2026-08-08     # when this was last confirmed with the user
volatility: high         # high | medium | low
review_after: 2026-11-08 # captured + the interval for that volatility
```

| Volatility | Interval | Files |
| --- | --- | --- |
| high | 3 months | `benchmark.md` |
| medium | 6–12 months | `objectives.md`, `budget.md`, `spec.md` |
| low | 24 months | `learning-preferences.md` |

On a re-run, the meta-skill reads these dates and **only re-interviews what is past
`review_after`**. Everything else is confirmed in a single line rather than asked
again. A second pass six months later should cost you a few minutes of conversation
and a fresh market sweep — not the whole intake over again.

`status: unfilled` in the frontmatter means the skill has not run yet. The meta-skill
treats unfilled and expired identically: both need the interview.

## Editing by hand

Encouraged. These are plain markdown and you know yourself better than the interview
does. If you edit one, bump `captured` and `review_after` yourself, or just tell the
agent you changed it.
