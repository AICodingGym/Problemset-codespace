#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/topics.js 2>/dev/null || true" EXIT
git checkout 2657804c1fb6b84dc76ad3b18ecf061aaab5f29f -- test/topics.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/topics.js
