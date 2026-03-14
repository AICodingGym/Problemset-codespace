#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/containers/notifications/manager.test.tsx 2>/dev/null || true" EXIT
git checkout da91f084c0f532d9cc8ca385a701274d598057b8 -- packages/components/containers/notifications/manager.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/containers/notifications/manager.test.tsx,containers/notifications/manager.test.ts
