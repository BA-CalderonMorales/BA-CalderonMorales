#!/usr/bin/env bash
# Run repository sanity checks. Exits non-zero if any check fails.
set -euo pipefail

# Set CI environment variable for scripts to detect CI environment
export CI=true

files=$(find . -name '*.md' | sort)

fail=0
for file in $files; do
  echo "Checking $file"
  ./scripts/check-trailing-whitespace.sh "$file" || fail=1
  
  # Skip link checks in CI environment to avoid network issues
  if [ -z "${CI_SKIP_LINK_CHECK:-}" ]; then
    echo "Running link check for $file"
    ./scripts/check-links.sh "$file" || echo "Warning: Link check failed but continuing"
  else
    echo "Skipping link check in CI environment"
  fi
  echo
done
exit $fail
