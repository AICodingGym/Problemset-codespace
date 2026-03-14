#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/payments/subscription/helpers/payment.test.ts 2>/dev/null || true" EXIT
git checkout ac23d1efa1a6ab7e62724779317ba44c28d78cfd -- packages/components/containers/payments/subscription/helpers/payment.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/payments/subscription/helpers/payment.test.ts,containers/payments/subscription/helpers/payment.test.ts
