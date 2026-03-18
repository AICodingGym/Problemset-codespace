#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/connection/test_psrp.py 2>/dev/null || true" EXIT
git checkout 1a4644ff15355fd696ac5b9d074a566a80fe7ca3 -- test/units/plugins/connection/test_psrp.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/connection/test_psrp.py
