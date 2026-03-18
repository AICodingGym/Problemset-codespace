#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/categories.js test/middleware.js 2>/dev/null || true" EXIT
git checkout b398321a5eb913666f903a794219833926881a8f -- test/categories.js test/middleware.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/i18n.js,test/middleware.js,test/categories.js
