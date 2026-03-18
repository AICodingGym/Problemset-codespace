#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/topics/thumbs.js 2>/dev/null || true" EXIT
git checkout 0f788b8eaa4bba3c142d171fd941d015c53b65fc -- test/topics/thumbs.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/topics/thumbs.js
