#!/usr/bin/env bash
# Run repository sanity checks. Exits non-zero if any check fails.
set -euo pipefail

files=$(find . -name '*.md' | sort)

fail=0
for file in $files; do
  echo "Checking $file"
  ./scripts/check-trailing-whitespace.sh "$file" || fail=1
  ./scripts/check-links.sh "$file" || fail=1
  echo
done
exit $fail
