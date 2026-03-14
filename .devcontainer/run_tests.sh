#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/payments/paymentTokenHelper.test.ts 2>/dev/null || true" EXIT
git checkout df60460f163fd5c34e844ab9015e3176f1ab1ac0 -- packages/components/containers/payments/paymentTokenHelper.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/payments/paymentTokenHelper.test.ts,containers/payments/paymentTokenHelper.test.ts
