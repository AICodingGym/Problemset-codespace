#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/database/sorted.js 2>/dev/null || true" EXIT
git checkout 70b4a0e2aebebe8f2f559de6680093d96a697b2f -- test/database/sorted.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/database.js,test/database/sorted.js
