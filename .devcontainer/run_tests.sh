#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/test_async_wrapper.py 2>/dev/null || true" EXIT
git checkout 39bd8b99ec8c6624207bf3556ac7f9626dad9173 -- test/units/modules/test_async_wrapper.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/test_async_wrapper.py
