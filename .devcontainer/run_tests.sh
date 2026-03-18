#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/api.js test/groups.js 2>/dev/null || true" EXIT
git checkout 18c45b44613aecd53e9f60457b9812049ab2998d -- test/api.js test/groups.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/api.js,test/groups.js,test/utils.js
