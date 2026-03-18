#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/keyinput/test_keyutils.py 2>/dev/null || true" EXIT
git checkout f7753550f2c1dcb2348e4779fd5287166754827e -- tests/unit/keyinput/test_keyutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/keyinput/test_keyutils.py
