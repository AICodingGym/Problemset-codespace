#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/utils/test_isidentifier.py 2>/dev/null || true" EXIT
git checkout 1ee70fc272aff6bf3415357c6e13c5de5b928d9b -- test/units/utils/test_isidentifier.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/utils/test_isidentifier.py
