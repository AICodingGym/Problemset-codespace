#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/utils/test_unsafe_proxy.py 2>/dev/null || true" EXIT
git checkout 164881d871964aa64e0f911d03ae270acbad253c -- test/units/utils/test_unsafe_proxy.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/utils/test_unsafe_proxy.py
