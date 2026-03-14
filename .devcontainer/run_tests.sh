#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/metrics/tests/observeApiError.test.ts 2>/dev/null || true" EXIT
git checkout 944adbfe06644be0789f59b78395bdd8567d8547 -- packages/metrics/tests/observeApiError.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/metrics/tests/observeApiError.test.ts,tests/observeApiError.test.ts
