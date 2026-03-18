#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/uploads.js 2>/dev/null || true" EXIT
git checkout f9ce92df988db7c1ae55d9ef96d247d27478bc70 -- test/uploads.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/uploads.js
