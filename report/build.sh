#!/usr/bin/env bash
# Build the findings report to pdf/.
#
# --root is the repo root, not report/, because report.typ reads the scorecard and
# research data with absolute-from-root paths. Compiling from inside report/ without
# it fails on the first csv() call with a file-not-found.
#
# The worked example builds from the same template via --input data=..., so there is
# only ever one report.typ to maintain.
#
# Usage:  ./report/build.sh            build from the live run
#         ./report/build.sh example    build from examples/worked-run

set -euo pipefail
cd "$(dirname "$0")/.."

command -v typst >/dev/null 2>&1 || {
  echo "typst not found. See https://github.com/typst/typst#installation" >&2
  exit 1
}

mkdir -p pdf

if [[ "${1:-}" == "example" ]]; then
  # examples/ ships only in the template repo, not in a scaffolded workspace, so this
  # mode is genuinely absent rather than broken when the plugin created the directory.
  [[ -d examples/worked-run ]] || {
    echo "No examples/worked-run here — the worked example ships only in the" >&2
    echo "Spec-Led-Certification template repo, not in a scaffolded workspace:" >&2
    echo "  https://github.com/danielrosehill/Spec-Led-Certification" >&2
    exit 1
  }
  echo "Building the worked example."
  typst compile --root . --input data=/examples/worked-run \
    report/report.typ pdf/example-report.pdf
  echo "Built: pdf/example-report.pdf"
else
  typst compile --root . report/report.typ pdf/certification-report.pdf
  echo "Built: pdf/certification-report.pdf"
fi
