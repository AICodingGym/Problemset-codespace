#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/uploads.js 2>/dev/null || true" EXIT
git checkout 8ca65b0c78c67c1653487c02d1135e1b702185e1 -- test/uploads.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/uploads.js
