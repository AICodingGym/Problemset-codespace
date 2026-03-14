#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/payments/client-extensions/usePollEvents.test.ts 2>/dev/null || true" EXIT
git checkout 863d524b5717b9d33ce08a0f0535e3fd8e8d1ed8 -- packages/components/payments/client-extensions/usePollEvents.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/payments/client-extensions/usePollEvents.test.ts,payments/client-extensions/usePollEvents.test.ts
