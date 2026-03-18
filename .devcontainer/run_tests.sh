#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/controllers.js 2>/dev/null || true" EXIT
git checkout 51d8f3b195bddb13a13ddc0de110722774d9bb1b -- test/controllers.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/controllers.js
