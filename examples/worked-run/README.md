# Worked example

A complete set of scored data, so you can see the shape of a finished run — and the
report it produces — before running one yourself.

```bash
./report/build.sh example      # → pdf/example-report.pdf
```

It builds from the same `report/report.typ` as a live run, via
`--input data=/examples/worked-run`. There is no second copy of the template to drift.

## The credentials here are invented

Meridian, Northgate, Helios, Tessera, Cascade and Brightline do not exist. That is
deliberate twice over: nobody can mistake the example for a recommendation, and it
cannot rot when a real vendor changes its blueprint or its price.

The *shapes* are real, though — each was built to demonstrate something the workflow
has to handle:

| Candidate | Demonstrates |
| --- | --- |
| Meridian | The winner. Strong on the two heaviest criteria, unremarkable on recognition |
| Tessera | Free and highly protocol-led, so it ranks second on this spec despite being a foundations credential that does not assess delegation at all |
| Helios | A gated blueprint. Two scores come from prep providers (`S`) and one criterion could not be established at all, so it is scored over the remaining weights |
| Northgate | The famous one, finishing last. Scores 0.90 on recognition — which this spec weighted at 0.05 |
| Cascade | Excluded on a hard filter: partner tier requiring 10+ employees |
| Brightline | Excluded on a hard filter: in-person test centre only |

Northgate is the case worth studying. A market-led search would have found it first
and stopped. It is not a bad credential; it is a bad credential *for this
specification*, and the report says which weight did that so a reader who disagrees
can argue with the weight rather than the conclusion.

## What is not here

No `profile/` files. The five intake files contain a person, and a fictional person
would be either a caricature or a template for one. The scorecard's `source` column
points at the profile lines each criterion came from, which shows the trace without
inventing someone to trace it to.
