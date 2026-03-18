#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/controllers.js 2>/dev/null || true" EXIT
git checkout bd80d36e0dcf78cd4360791a82966078b3a07712 -- test/controllers.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/controllers.js
