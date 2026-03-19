#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/smartBanner/SmartBanner.test.tsx 2>/dev/null || true" EXIT
git checkout 1501eb765873b2884b6f1944fd242ecfc9d6b103 -- packages/components/components/smartBanner/SmartBanner.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) components/smartBanner/SmartBanner.test.ts,packages/components/components/smartBanner/SmartBanner.test.tsx
