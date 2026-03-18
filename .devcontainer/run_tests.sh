#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/KeyBindingsManager-test.ts 2>/dev/null || true" EXIT
git checkout 33e8edb3d508d6eefb354819ca693b7accc695e7 -- test/KeyBindingsManager-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/KeyBindingsManager-test.ts
