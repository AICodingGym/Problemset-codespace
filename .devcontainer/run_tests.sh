#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/facts/network/test_locally_reachable_ips.py 2>/dev/null || true" EXIT
git checkout 11c1777d56664b1acb56b387a1ad6aeadef1391d -- test/units/module_utils/facts/network/test_locally_reachable_ips.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/facts/network/test_locally_reachable_ips.py
