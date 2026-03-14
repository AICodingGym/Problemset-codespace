#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/payments/RenewalNotice.test.tsx packages/shared/test/helpers/checkout.spec.ts 2>/dev/null || true" EXIT
git checkout 6e165e106d258a442ae849cdf08260329cb92d39 -- packages/components/containers/payments/RenewalNotice.test.tsx packages/shared/test/helpers/checkout.spec.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/payments/RenewalNotice.test.tsx,packages/shared/test/helpers/checkout.spec.ts,containers/payments/RenewalNotice.test.ts
