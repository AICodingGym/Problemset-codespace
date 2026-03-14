#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/drawer/views/SecurityCenter/PassAliases/PassAliases.test.tsx 2>/dev/null || true" EXIT
git checkout 6dcf0d0b0f7965ad94be3f84971afeb437f25b02 -- packages/components/components/drawer/views/SecurityCenter/PassAliases/PassAliases.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) components/drawer/views/SecurityCenter/PassAliases/PassAliases.test.ts,packages/components/components/drawer/views/SecurityCenter/PassAliases/PassAliases.test.tsx
