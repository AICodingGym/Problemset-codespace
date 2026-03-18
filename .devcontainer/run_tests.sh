#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/database/hash.js 2>/dev/null || true" EXIT
git checkout 767973717be700f46f06f3e7f4fc550c63509046 -- test/database/hash.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/database/hash.js,test/database.js
