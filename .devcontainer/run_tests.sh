#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/posts.js 2>/dev/null || true" EXIT
git checkout 82562bec444940608052f3e4149e0c61ec80bf3f -- test/posts.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/posts.js
