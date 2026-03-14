#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/payments/RenewToggle.test.tsx packages/components/hooks/helpers/test/useSubscription.ts 2>/dev/null || true" EXIT
git checkout 5e815cfa518b223a088fa9bb232a5fc90ab15691 -- packages/components/containers/payments/RenewToggle.test.tsx packages/components/hooks/helpers/test/useSubscription.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/hooks/helpers/test/useSubscription.ts,containers/payments/RenewToggle.test.ts,packages/components/containers/payments/RenewToggle.test.tsx
