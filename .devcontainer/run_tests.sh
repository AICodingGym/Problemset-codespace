#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/offers/operations/summer2023/eligibility.test.ts 2>/dev/null || true" EXIT
git checkout 708ed4a299711f0fa79a907cc5847cfd39c0fc71 -- packages/components/containers/offers/operations/summer2023/eligibility.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/offers/operations/summer2023/eligibility.test.ts,containers/offers/operations/summer2023/eligibility.test.ts
