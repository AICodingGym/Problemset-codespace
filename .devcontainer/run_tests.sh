#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/database/sorted.js 2>/dev/null || true" EXIT
git checkout b1f9ad5534bb3a44dab5364f659876a4b7fe34c1 -- test/database/sorted.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/database.js,test/database/sorted.js
