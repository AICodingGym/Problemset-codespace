#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/lookup/test_password.py 2>/dev/null || true" EXIT
git checkout 0fd88717c953b92ed8a50495d55e630eb5d59166 -- test/units/plugins/lookup/test_password.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/lookup/test_password.py
