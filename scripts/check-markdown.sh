#!/usr/bin/env bash
# Run basic checks on all markdown files.
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
