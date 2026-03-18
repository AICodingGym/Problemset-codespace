#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/network/icx/fixtures/lag_running_config.txt test/units/modules/network/icx/test_icx_linkagg.py 2>/dev/null || true" EXIT
git checkout 7e1a347695c7987ae56ef1b6919156d9254010ad -- test/units/modules/network/icx/fixtures/lag_running_config.txt test/units/modules/network/icx/test_icx_linkagg.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/network/icx/test_icx_linkagg.py
