#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/utils/arrays-test.ts 2>/dev/null || true" EXIT
git checkout b007ea81b2ccd001b00f332bee65070aa7fc00f9 -- test/utils/arrays-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/utils/arrays-test.ts
