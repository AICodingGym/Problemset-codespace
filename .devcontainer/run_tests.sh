#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_configtypes.py 2>/dev/null || true" EXIT
git checkout 52708364b5f91e198defb022d1a5b4b3ebd9b563 -- tests/unit/config/test_configtypes.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_configtypes.py
