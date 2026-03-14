#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/components/dropdown/Dropdown.test.tsx 2>/dev/null || true" EXIT
git checkout 8be4f6cb9380fcd2e67bcb18cef931ae0d4b869c -- packages/components/components/dropdown/Dropdown.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/components/dropdown/Dropdown.test.tsx,components/dropdown/Dropdown.test.ts
