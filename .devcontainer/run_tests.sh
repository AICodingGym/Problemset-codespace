#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/helpers/transforms/tests/transformStyleAttributes.test.ts 2>/dev/null || true" EXIT
git checkout a6e6f617026794e7b505d649d2a7a9cdf17658c8 -- applications/mail/src/app/helpers/transforms/tests/transformStyleAttributes.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/mail/src/app/helpers/transforms/tests/transformStyleAttributes.test.ts,src/app/helpers/transforms/tests/transformStyleAttributes.test.ts
