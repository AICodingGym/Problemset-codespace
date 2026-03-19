#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/payments/subscription/SubscriptionModalProvider.test.tsx 2>/dev/null || true" EXIT
git checkout 0200ce0fc1d4dbd35178c10d440a284c82ecc858 -- packages/components/containers/payments/subscription/SubscriptionModalProvider.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) containers/payments/subscription/SubscriptionModalProvider.test.ts,packages/components/containers/payments/subscription/SubscriptionModalProvider.test.tsx
