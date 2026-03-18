#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/posts.js 2>/dev/null || true" EXIT
git checkout 0c81642997ea1d827dbd02c311db9d4976112cd4 -- test/posts.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/posts.js
