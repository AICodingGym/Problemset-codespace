#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/database/sorted.js 2>/dev/null || true" EXIT
git checkout 6ea3b51f128dd270281db576a1b59270d5e45db0 -- test/database/sorted.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/database/sorted.js,test/database.js
