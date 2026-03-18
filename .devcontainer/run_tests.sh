#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/utils/test_vars.py 2>/dev/null || true" EXIT
git checkout 0ea40e09d1b35bcb69ff4d9cecf3d0defa4b36e8 -- test/units/utils/test_vars.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/utils/test_vars.py
