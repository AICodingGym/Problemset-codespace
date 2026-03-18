#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/database/hash.js 2>/dev/null || true" EXIT
git checkout 4327a09d76f10a79109da9d91c22120428d3bdb9 -- test/database/hash.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/database/hash.js,test/database.js
