// Spec-Led Certification — findings report.
//
// Reads its data at compile time from the CSVs and meta.yaml. Every number in the
// output is computed here from those files: no figure is typed into prose, so the
// report cannot disagree with the data it was built from.
//
// Paths beginning with / are rooted at the *project* root, not this file, so this
// must be compiled with --root pointing at the repo root. See build.sh.
//
// The data directory is a compile-time input, so the same template renders the live
// run and the worked example without a second copy of this file:
//
//   typst compile --root . report/report.typ out.pdf
//   typst compile --root . --input data=/examples/worked-run report/report.typ out.pdf

#let data = sys.inputs.at("data", default: "")

#let meta = yaml(data + "/report/meta.yaml")
#let narrative-src = yaml(data + "/report/narrative.yaml")
#let criteria = csv(data + "/scorecard/criteria.csv", row-type: dictionary)
#let filters = csv(data + "/scorecard/filters.csv", row-type: dictionary)
#let all-candidates = csv(data + "/research/candidates.csv", row-type: dictionary)
#let scores = csv(data + "/research/scores.csv", row-type: dictionary)

// Narrative sections are Typst markup held as strings, so that everything the
// recommend skill writes is data and nothing is a second module to keep in step.
#let narrative-block(key) = {
  let s = narrative-src.at(key, default: "")
  if type(s) != str or s.trim() == "" { none } else { eval(s.trim(), mode: "markup") }
}

// ─── Arithmetic ──────────────────────────────────────────────────────────────

#let weight-of(id) = {
  let m = criteria.filter(c => c.id == id)
  if m.len() == 0 { 0.0 } else { float(m.first().weight) }
}

#let score-cell(cand, crit) = {
  let m = scores.filter(s => s.candidate == cand and s.criterion == crit)
  if m.len() == 0 { none } else { m.first() }
}

// Weighted mean over the criteria actually scored, so an unscored criterion does
// not silently penalise a candidate. Unscored criteria are reported separately.
#let total-for(cand) = {
  let num = 0.0
  let den = 0.0
  for c in criteria {
    let cell = score-cell(cand, c.id)
    if cell != none {
      let w = float(c.weight)
      num += w * float(cell.score)
      den += w
    }
  }
  if den == 0.0 { (total: 0.0, covered: 0.0) } else { (total: num / den, covered: den) }
}

#let live = all-candidates.filter(c => c.status != "excluded")
#let excluded = all-candidates.filter(c => c.status == "excluded")

// NB: a method chain must keep its dot on the same line as the expression it
// applies to. `live\n  .map(...)` does not continue the statement — Typst ends it
// at the newline and renders the rest as body text, with no error. Hence the
// intermediate binding rather than a wrapped chain.
#let scored = live.map(c => {
  let t = total-for(c.id)
  (
    id: c.id, name: c.name, vendor: c.vendor,
    cost: c.cost_all_in, currency: c.currency, url: c.url,
    total: t.total, covered: t.covered,
  )
})

#let ranked = scored.sorted(key: r => -r.total)

#let weight-sum = criteria.fold(0.0, (a, c) => a + float(c.weight))

// ─── Style ───────────────────────────────────────────────────────────────────

#let ink = rgb("#1a1a1a")
#let muted = rgb("#6b7280")
#let rule = rgb("#d4d4d8")
#let accent = rgb("#1d4ed8")
#let good = rgb("#15803d")
#let warn = rgb("#b45309")
#let bad = rgb("#b91c1c")

#let body-font = ("IBM Plex Sans", "DejaVu Sans", "Liberation Sans")
#let mono-font = ("IBM Plex Mono", "DejaVu Sans Mono", "Liberation Mono")

#set document(title: meta.title, author: meta.author)

#set page(
  paper: "a4",
  margin: (x: 2.1cm, top: 2.3cm, bottom: 2.3cm),
  header: context {
    set text(font: body-font, size: 8pt, fill: muted)
    grid(
      columns: (1fr, auto),
      align(left)[#meta.title — #meta.subject],
      align(right)[#counter(page).display()],
    )
    v(-6pt)
    line(length: 100%, stroke: 0.4pt + rule)
  },
  footer: context {
    set text(font: body-font, size: 8pt, fill: muted)
    line(length: 100%, stroke: 0.4pt + rule)
    v(-2pt)
    grid(
      columns: (1fr, auto),
      align(left)[#meta.author — run #meta.run, #meta.date],
      align(right)[
        #counter(page).display() / #context counter(page).final().first()
      ],
    )
  },
)

#set text(font: body-font, size: 10pt, fill: ink, lang: "en", number-width: "tabular")
#set par(justify: false, leading: 0.68em, spacing: 1.15em)

#show heading: it => {
  set text(font: body-font, weight: 600)
  block(above: 1.5em, below: 0.75em, it)
}
#show heading.where(level: 1): it => {
  block(above: 1.9em, below: 0.85em)[
    #set text(size: 15pt, weight: 600)
    #it.body
    #v(-7pt)
    #line(length: 100%, stroke: 0.9pt + ink)
  ]
}
#show heading.where(level: 2): set text(size: 11.5pt)
#show heading.where(level: 3): set text(size: 10pt)

#show table.cell.where(y: 0): set text(weight: 600, size: 8.5pt)
#set table(
  stroke: (x, y) => (
    top: if y == 0 { 0.9pt + ink } else { 0.4pt + rule },
    bottom: 0.4pt + rule,
  ),
  inset: (x: 6pt, y: 5pt),
)
#show table: set text(size: 9pt)
#show link: it => text(fill: accent, it)
#show raw.where(block: false): it => box(
  fill: rgb("#f4f4f5"), inset: (x: 3pt, y: 0pt), outset: (y: 3pt), radius: 2pt,
  text(font: mono-font, size: 8.5pt, it),
)

// Confidence tag: V vendor-confirmed, S secondary, I inferred.
#let tag(kind) = {
  let (c, l) = if kind == "V" { (good, "V") }
    else if kind == "S" { (warn, "S") }
    else { (muted, "I") }
  box(baseline: 1.5pt, inset: (x: 3pt, y: 1pt), outset: (y: 1pt),
      fill: c.lighten(85%), radius: 2pt,
      text(size: 7pt, weight: 600, fill: c, l))
}

#let callout(fill: rgb("#f8fafc"), stroke-c: accent, body) = block(
  width: 100%, fill: fill, inset: 9pt, radius: 3pt,
  stroke: (left: 2.5pt + stroke-c), body,
)

// Score as a number plus a proportional bar, so the table can be read at a glance.
#let bar(v) = {
  let c = if v >= 0.7 { good } else if v >= 0.4 { warn } else { bad }
  box(width: 26pt, height: 4pt, fill: rule.lighten(40%), radius: 1pt,
    align(left, box(width: 26pt * v, height: 4pt, fill: c, radius: 1pt)))
}

#let fmt(v) = {
  // Two decimal places without relying on locale-dependent formatting.
  let n = calc.round(v * 100)
  let whole = calc.floor(n / 100)
  let frac = n - whole * 100
  [#whole.#(if frac < 10 { "0" } else { "" })#frac]
}

// ─── Title ───────────────────────────────────────────────────────────────────

#block(above: 0pt, below: 1.4em)[
  #text(size: 20pt, weight: 600)[#meta.title]
  #v(-8pt)
  #text(size: 11pt, fill: muted)[#meta.subject]
  #v(-4pt)
  #text(size: 9pt, fill: muted)[
    Run #meta.run · #meta.date · scored against a scorecard frozen before research
  ]
]

#callout[
  #text(weight: 600)[#meta.headline]
]

= The answer

#let n-answer = narrative-block("answer")
#let n-changes = narrative-block("changes")
#let n-reasoning = narrative-block("reasoning")
#let n-invest = narrative-block("invest")
#let n-limits = narrative-block("limits")

#if n-answer == none [_No summary written._] else [#n-answer]

#if n-reasoning != none [
  == Why

  #n-reasoning
]

// Re-runs only. On a first pass `changes` is empty and the section does not exist.
#if n-changes != none [
  = What changed since the last run

  #n-changes
]

= Ranking

#if ranked.len() == 0 [
  #callout(fill: rgb("#fef2f2"), stroke-c: bad)[
    *No candidates survived.* Either the research has not run, or every credential
    surveyed failed a hard filter. If it is the latter, that is the finding: see
    #link("../research/README.md")[the research notes] and the excluded list below,
    and consider whether a filter in `objectives.md` is stricter than intended.
  ]
] else [
  #table(
    columns: (auto, 1fr, auto, auto, auto),
    align: (right, left, left, right, left),
    table.header([\#], [Credential], [Vendor], [All-in], [Score]),
    ..ranked.enumerate().map(((i, r)) => (
      [#(i + 1)],
      [*#r.name*],
      [#r.vendor],
      [#r.currency #r.cost],
      [#fmt(r.total)#h(5pt)#bar(r.total)],
    )).flatten()
  )

  #text(size: 8.5pt, fill: muted)[
    Score is the weighted mean over the criteria scored for that candidate, on a
    0–1 scale. Weights are in the scorecard, frozen before research began.
  ]
]

= How this was decided

The scorecard below was derived from the profile — subject, benchmark, learning
preferences, objectives and budget — and frozen before any credential was looked up.
Research scored against it without amending it.

#if criteria.len() == 0 [
  _No criteria defined. Run the `build-scorecard` skill._
] else [
  #table(
    columns: (1fr, auto, auto, 2fr),
    align: (left, left, right, left),
    table.header([Criterion], [Kind], [Weight], [What a 1.0 looks like]),
    ..criteria.map(c => (
      [*#c.label*],
      [#c.kind],
      [#c.weight],
      [#text(size: 8.5pt)[#c.anchor_1]],
    )).flatten()
  )

  #if calc.abs(weight-sum - 1.0) > 0.001 [
    #v(0.4em)
    #callout(fill: rgb("#fffbeb"), stroke-c: warn)[
      *Weights sum to #fmt(weight-sum), not 1.00.* The ranking is still internally
      consistent, because scoring normalises by the weights actually applied — but
      the scorecard is not what it claims to be, and this should be corrected.
    ]
  ]
]

#if filters.len() > 0 [
  == Hard filters

  Requirements a credential either meets or does not. Failing one excludes rather than
  scores down, because a hard requirement that can be outweighed is not a hard
  requirement.

  #table(
    columns: (1fr, 2fr),
    table.header([Requirement], [Rule applied]),
    ..filters.map(f => ([*#f.label*], [#f.rule])).flatten()
  )
]

= Comparison

#if ranked.len() == 0 or criteria.len() == 0 [
  _Nothing to compare yet._
] else [
  #table(
    columns: (1.6fr, auto) + ranked.map(_ => 1fr),
    align: (left, right) + ranked.map(_ => center),
    table.header(
      [Criterion], [Wt],
      ..ranked.map(r => [#text(size: 8pt)[#r.name]])
    ),
    ..criteria.map(c => (
      [#c.label],
      [#c.weight],
      ..ranked.map(r => {
        let cell = score-cell(r.id, c.id)
        if cell == none {
          text(fill: muted)[—]
        } else {
          [#fmt(float(cell.score))#h(3pt)#tag(cell.confidence)]
        }
      })
    )).flatten(),
    table.hline(stroke: 0.9pt + ink),
    [*Weighted total*], [],
    ..ranked.map(r => [*#fmt(r.total)*]),
  )

  #v(0.5em)
  #text(size: 8.5pt, fill: muted)[
    #tag("V") vendor-confirmed · #tag("S") secondary source · #tag("I") inferred ·
    — not established. A high score carrying #tag("I") is a hypothesis, not a finding.
  ]

  #let all-gaps = ranked.map(r => (r.name, criteria.filter(c => score-cell(r.id, c.id) == none)))
  #let gaps = all-gaps.filter(((n, g)) => g.len() > 0)

  #if gaps.len() > 0 [
    #v(0.6em)
    #callout(fill: rgb("#fffbeb"), stroke-c: warn)[
      *Unscored criteria.* These were not established from the public record and are
      excluded from the totals rather than counted as zero:
      #list(..gaps.map(((n, g)) => [#n — #g.map(c => c.label).join(", ")]))
    ]
  ]
]

#if excluded.len() > 0 [
  = Excluded

  Surveyed and ruled out on a hard filter. Listed because "why not that one" is a
  question that otherwise gets asked again on every re-run.

  #table(
    columns: (1fr, auto, 1.4fr),
    table.header([Credential], [Vendor], [Failed]),
    ..excluded.map(c => ([*#c.name*], [#c.vendor], [#c.excluded_by])).flatten()
  )
]

#if n-invest != none [
  = Where to invest

  #n-invest
]

#if n-limits != none [
  = Limits and what would change this

  #n-limits
]

#v(1.5em)
#line(length: 100%, stroke: 0.4pt + rule)
#text(size: 8pt, fill: muted)[
  Generated by #link("https://github.com/danielrosehill/Spec-Led-Certification")[Spec-Led-Certification].
  Scores and weights read from `scorecard/criteria.csv` and `research/scores.csv` at
  compile time; sources logged in `research/sources.md`.
]
