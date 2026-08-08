# Spec-Led Certification

A template repository for choosing a professional certification the way you would run
a procurement: **write the specification first, then go to market.**

Clone it, run the skills against your own situation, and you end up with a repo
holding the spec you wrote, the credentials you surveyed, the scores you gave them,
the sources behind every score, and a typeset report — rather than a bookmark folder
and a hunch.

## The premise

Choosing a certification is normally market-led and reactive:

> I work in this field → here is what's on offer → this one looks well-regarded →
> I'll sit that.

The exam's blueprint becomes the specification by default. You find out what you
wanted from the credential *after* agreeing to want what it teaches, and the criteria
you would have written are recovered afterwards, as reasons for a choice already made.

Spec-led inverts the order:

> Here is what a credential has to do for me, and the constraints it has to survive →
> here is everything on the market → here is how each one scores against **my**
> specification → this one, for these reasons, and here is what would change my mind.

The specification is written and frozen before the options are known, so it cannot be
back-fitted to whichever exam you were already drawn to. Nothing about this is
specific to certifications — it is ordinary requirements-then-sourcing discipline
applied to a decision people usually make on reputation. Full reasoning in
[docs/method.md](docs/method.md).

## The workflow

```
  intake ─────────────────────────────────────────┐
    define-spec            what field, which topics
    benchmark-me           where you are now, from evidence
    learning-preferences   how you take information in
    define-objectives      what it's for; standing positions; the window
    define-budget          money and hours
                                                  │
  build-scorecard   ◄───── weights derived from the profile alone
                          ── FREEZE ──  committed before anything is looked up
                                                  │
  research-market   ◄───── survey, filter, price, score against the frozen card
                                                  │
  recommend         ◄───── narrative + computed tables → PDF
```

## Three ways in

The stages above are the same every time, but the three situations you arrive in are
not, so each has its own entry point rather than a branch inside one skill.

| Entry point | When | Costs |
| --- | --- | --- |
| [`start-search`](skills/start-search/SKILL.md) | First run, or a new subject | ~an hour, nearly all of it intake |
| [`rerun-search`](skills/rerun-search/SKILL.md) | Intake already on file — has the market moved? | Minutes plus a fresh sweep |
| [`update-profile`](skills/update-profile/SKILL.md) | Something about *you* changed | A couple of minutes |

`rerun-search` archives the previous run to `runs/<date>/` — scorecard, data and
conclusion together — and its report leads with **what changed**: whether the earlier
recommendation still holds, which scores moved and why, and what entered or left. That
comparison is the payoff for having written the profile down, and it is why the second
pass is cheap.

`update-profile` deliberately stops short of researching. It re-interviews only the
files that changed and marks the scorecard `stale`, so the next run rebuilds it. A
two-minute correction should not drag an hour of research behind it, and a market
sweep should not quietly reopen questions about you that nobody asked to reconsider.

Not sure which? [`spec-led-certification`](skills/spec-led-certification/SKILL.md)
reads the state on disk and routes.

| Skill | Does |
| --- | --- |
| [`spec-led-certification`](skills/spec-led-certification/SKILL.md) | Router — reads the state and picks one of the three above |
| [`define-spec`](skills/define-spec/SKILL.md) | The headline ask — field, named topics, what's out of scope |
| [`benchmark-me`](skills/benchmark-me/SKILL.md) | Where you stand, read off repos, site, CV — not self-report |
| [`learning-preferences`](skills/learning-preferences/SKILL.md) | Modality, devices, session shape, assessment formats, what has failed before |
| [`define-objectives`](skills/define-objectives/SKILL.md) | Purpose, audience, standing positions, the window, the kill condition |
| [`define-budget`](skills/define-budget/SKILL.md) | Money and hours, captured separately because they fail separately |
| [`build-scorecard`](skills/build-scorecard/SKILL.md) | Weighted anchored criteria + hard filters, then freeze |
| [`research-market`](skills/research-market/SKILL.md) | Survey, filter on eligibility, price the whole route, score with sources |
| [`recommend`](skills/recommend/SKILL.md) | The answer, why the runner-up lost, where to invest, what would change it |

Three subagent roles in [`agents/`](agents/) map to the phases. The research agent
never sees the intake conversation, which enforces the freeze structurally rather
than by good intentions.

## Four properties worth knowing before you start

**The memory lives in the repo, not in the assistant.** Every intake skill writes to
`profile/` as plain markdown and is forbidden from using the agent's own memory
store. You can read it, correct it, diff it, and take it to a different assistant next
time.

**Everything is dated, and decays at its own rate.** What you know is stale in a
quarter; how you learn is much the same in five years. Each profile file carries a
`review_after`, so a re-run six months later re-asks the one file that expired and
confirms the other four. That is the difference between a workflow you run once and
one you run whenever the market moves — and it is why `update-profile` and
`rerun-search` are separate skills rather than one.

**Hard requirements exclude, they don't score down.** A requirement that can be
outweighed is not a requirement. Eligibility gates and non-negotiables filter
candidates out, and the excluded ones appear in the report with the filter they
failed — so "why not that one?" isn't re-asked every run.

**Every number in the report is computed from the data.** `report/report.typ` reads
the CSVs at compile time and works out the weighted totals, the ranking and the
comparison table itself. The recommendation skill writes prose only. A report whose
narrative can drift from its arithmetic is untrustworthy in exactly the respect that
matters.

## See it before you run it

```bash
./report/build.sh example      # → pdf/example-report.pdf
```

A complete scored run with [deliberately fictional
credentials](examples/worked-run/), built from the same template as a live run. Its
most instructive case is the best-known credential in the set finishing last — not
because it is weak, but because the spec weighted recognition at 0.05 and vendor
neutrality at 0.22, and the report says so.

## Or install it as a Claude Code plugin

```
/plugin marketplace add danielrosehill/Claude-Code-Plugins
/plugin install spec-led-certification@danielrosehill
```

Then `/cert-search` in any directory. The plugin
([spec-led-certification-plugin](https://github.com/danielrosehill/spec-led-certification-plugin))
vendors these skills verbatim and adds two ways to stand a workspace up:
`create-workspace` instantiates **this repo as a private GitHub repo** and clones it —
the default, since the search then survives the machine — and `scaffold-workspace`
copies the structure into a plain local directory when there should be no remote.

**This repo stays canonical.** Changes to a stage skill go here first and reach the
plugin through its sync script.

## Getting started

1. Use this template, or clone it. One repo per search.
2. Install [Typst](https://github.com/typst/typst#installation) if you want the PDF.
   Everything else works without it; the markdown stands on its own.
3. Point your agent at the repo and invoke `start-search`.
4. Answer the interview honestly, including the question about what would make this
   not worth doing at all.

Roughly an hour of conversation for a first run, most of it in intake. Come back with
`rerun-search` when you want to know if the market moved, or `update-profile` when
something about you changes.

## Adapting it

The shape generalises to any decision made by surveying a market against personal
requirements — a degree programme, a framework, a vendor, a contract. Swap the
coverage criteria in `build-scorecard` for whatever the domain's topics are; the
freeze, the filters, the confidence tags and the compile-time arithmetic carry over
unchanged.

## Licence

MIT — see [LICENSE](LICENSE).
