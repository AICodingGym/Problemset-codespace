#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/messaging.js 2>/dev/null || true" EXIT
git checkout 445b70deda20201b7d9a68f7224da751b3db728c -- test/messaging.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/messaging.js
