#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/facts/test_sysctl.py 2>/dev/null || true" EXIT
git checkout 709484969c8a4ffd74b839a673431a8c5caa6457 -- test/units/module_utils/facts/test_sysctl.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/facts/test_sysctl.py
