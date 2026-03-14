#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/helpers/url.test.ts 2>/dev/null || true" EXIT
git checkout 51742625834d3bd0d10fe0c7e76b8739a59c6b9f -- packages/components/helpers/url.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/helpers/url.test.ts,helpers/url.test.ts
