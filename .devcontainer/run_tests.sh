#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/payments/Bitcoin.test.tsx 2>/dev/null || true" EXIT
git checkout 5f0745dd6993bb1430a951c62a49807c6635cd77 -- packages/components/containers/payments/Bitcoin.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/payments/Bitcoin.test.tsx,containers/payments/Bitcoin.test.ts
