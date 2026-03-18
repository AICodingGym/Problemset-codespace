#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/facts/hardware/aix_data.py test/units/module_utils/facts/hardware/test_aix_processor.py 2>/dev/null || true" EXIT
git checkout a6e671db25381ed111bbad0ab3e7d97366395d05 -- test/units/module_utils/facts/hardware/aix_data.py test/units/module_utils/facts/hardware/test_aix_processor.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/facts/hardware/test_aix_processor.py,test/units/module_utils/facts/hardware/aix_data.py
