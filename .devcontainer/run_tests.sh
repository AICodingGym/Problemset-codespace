#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/posts/uploads.js 2>/dev/null || true" EXIT
git checkout 84dfda59e6a0e8a77240f939a7cb8757e6eaf945 -- test/posts/uploads.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/posts/uploads.js
