#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/metrics/mailMetricsHelper.test.ts 2>/dev/null || true" EXIT
git checkout d3e513044d299d04e509bf8c0f4e73d812030246 -- applications/mail/src/app/metrics/mailMetricsHelper.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/metrics/mailMetricsHelper.test.ts,applications/mail/src/app/metrics/mailMetricsHelper.test.ts
