#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/executor/module_common/test_module_common.py 2>/dev/null || true" EXIT
git checkout 9142be2f6cabbe6597c9254c5bb9186d17036d55 -- test/units/executor/module_common/test_module_common.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/executor/module_common/test_module_common.py
