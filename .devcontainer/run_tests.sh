#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/posts.js 2>/dev/null || true" EXIT
git checkout be43cd25974681c9743d424238b7536c357dc8d3 -- test/posts.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/posts.js
