#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/database/sorted.js 2>/dev/null || true" EXIT
git checkout f083cd559d69c16481376868c8da65172729c0ca -- test/database/sorted.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/database.js,test/database/sorted.js
