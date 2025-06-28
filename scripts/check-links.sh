#!/usr/bin/env bash
# Simple link checker for README.md. Avoids external dependencies.
set -euo pipefail

file="README.md"

if [ ! -f "$file" ]; then
  echo "README.md not found" >&2
  exit 1
fi

links=$(grep -oE 'https?://[^)]+' "$file" | sort -u)

fail=0
for url in $links; do
  if curl -Is "$url" >/dev/null 2>&1; then
    echo "OK: $url"
  else
    echo "BROKEN: $url" >&2
    fail=1
  fi
done

exit $fail
