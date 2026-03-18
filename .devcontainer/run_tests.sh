#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/common/validation/test_check_type_dict.py 2>/dev/null || true" EXIT
git checkout d9f1866249756efc264b00ff7497e92c11a9885f -- test/units/module_utils/common/validation/test_check_type_dict.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/common/validation/test_check_type_dict.py
