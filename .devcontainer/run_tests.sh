#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/plugins.js 2>/dev/null || true" EXIT
git checkout 76c6e30282906ac664f2c9278fc90999b27b1f48 -- test/plugins.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/i18n.js,test/plugins.js
