#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_configtypes.py 2>/dev/null || true" EXIT
git checkout 6b320dc18662580e1313d2548fdd6231d2a97e6d -- tests/unit/config/test_configtypes.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_configtypes.py
