#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/facts/hardware/linux/fixtures/sysinfo test/units/module_utils/facts/hardware/linux/test_get_sysinfo_facts.py 2>/dev/null || true" EXIT
git checkout cd9c4eb5a6b2bfaf4a6709f001ce3d0c92c1eed2 -- test/units/module_utils/facts/hardware/linux/fixtures/sysinfo test/units/module_utils/facts/hardware/linux/test_get_sysinfo_facts.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/facts/hardware/linux/test_get_sysinfo_facts.py
