#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/topics.js 2>/dev/null || true" EXIT
git checkout 0e07f3c9bace416cbab078a30eae972868c0a8a3 -- test/topics.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/topics.js
