#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_configtypes.py 2>/dev/null || true" EXIT
git checkout 9ed748effa8f3bcd804612d9291da017b514e12f -- tests/unit/config/test_configtypes.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_configtypes.py
