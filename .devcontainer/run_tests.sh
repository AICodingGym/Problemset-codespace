#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/PosthogAnalytics-test.ts 2>/dev/null || true" EXIT
git checkout 4c6b0d35add7ae8d58f71ea1711587e31081444b -- test/PosthogAnalytics-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/PosthogAnalytics-test.ts
