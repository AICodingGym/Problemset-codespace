#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/network/meraki/test_meraki.py 2>/dev/null || true" EXIT
git checkout 489156378c8e97374a75a544c7c9c2c0dd8146d1 -- test/units/module_utils/network/meraki/test_meraki.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/network/meraki/test_meraki.py
