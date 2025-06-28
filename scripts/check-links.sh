#!/usr/bin/env bash
# Simple link checker for markdown files. Avoids external dependencies.
set -euo pipefail

files=("$@")
if [ ${#files[@]} -eq 0 ]; then
  files=(README.md)
fi

fail=0
for file in "${files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "Missing file: $file" >&2
    fail=1
    continue
  fi
  links=$(grep -oE 'https?://[^)]+' "$file" | sort -u)
  for url in $links; do
    if curl -Is "$url" >/dev/null 2>&1; then
      echo "OK: $url"
    else
      echo "BROKEN: $url" >&2
      fail=1
    fi
  done
  echo
done
exit $fail
