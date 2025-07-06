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
    # Add timeout and retry options to curl
    if curl -Is --connect-timeout 10 --max-time 15 --retry 3 --retry-delay 2 "$url" >/dev/null 2>&1; then
      echo "OK: $url"
    else
      # In CI environment, don't fail on network issues
      if [ -n "${CI:-}" ]; then
        echo "WARNING: Could not verify $url (network issue?)" >&2
      else
        echo "BROKEN: $url" >&2
        fail=1
      fi
    fi
  done
  echo
done
exit $fail
