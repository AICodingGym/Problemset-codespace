#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/topics.js 2>/dev/null || true" EXIT
git checkout 84e065752f6d7fbe5c08cbf50cb173ffb866b8fa -- test/topics.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/topics.js
