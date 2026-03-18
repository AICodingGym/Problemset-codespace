#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/uploads.js 2>/dev/null || true" EXIT
git checkout 22368b996ee0e5f11a5189b400b33af3cc8d925a -- test/uploads.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/uploads.js
