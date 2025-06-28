#!/usr/bin/env bash
set -euo pipefail

# Compile TypeScript files using the repo tsconfig
tsc --project tsconfig.json

# Run tests first
node dist/markdown-stats.test.js

# Run main script with provided args
node dist/markdown-stats.js "$@"
