#!/usr/bin/env bash
set -euo pipefail

# Simple check for trailing whitespace in markdown files
fail=0
for file in "$@"; do
  if [ ! -f "$file" ]; then
    echo "Missing file: $file" >&2
    fail=1
    continue
  fi
  if grep -nP "\s+$" "$file" >/dev/null; then
    echo "Trailing whitespace found in $file" >&2
    grep -nP "\s+$" "$file" >&2
    fail=1
  else
    echo "No trailing whitespace in $file"
  fi
  # Check for spaces on blank lines
  if grep -nP "^\s+$" "$file" >/dev/null; then
    echo "Blank lines with spaces found in $file" >&2
    grep -nP "^\s+$" "$file" >&2
    fail=1
  fi
  echo
done
exit $fail
