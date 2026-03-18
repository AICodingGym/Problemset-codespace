#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/facts/hardware/linux_data.py test/units/module_utils/facts/hardware/test_linux_get_cpu_info.py 2>/dev/null || true" EXIT
git checkout 34db57a47f875d11c4068567b9ec7ace174ec4cf -- test/units/module_utils/facts/hardware/linux_data.py test/units/module_utils/facts/hardware/test_linux_get_cpu_info.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/facts/hardware/test_linux_get_cpu_info.py,test/units/module_utils/facts/hardware/linux_data.py
