#!/usr/bin/env bash
# Run repository sanity checks. Exits non-zero if any check fails.
set -euo pipefail

./scripts/check-markdown.sh
