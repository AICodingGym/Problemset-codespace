#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/logic/elements/helpers/elementBypassFilters.test.ts 2>/dev/null || true" EXIT
git checkout ae36cb23a1682dcfd69587c1b311ae0227e28f39 -- applications/mail/src/app/logic/elements/helpers/elementBypassFilters.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/mail/src/app/logic/elements/helpers/elementBypassFilters.test.ts,src/app/logic/elements/helpers/elementBypassFilters.test.ts
