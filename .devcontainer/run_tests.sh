#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/apt_repository/tasks/mode.yaml test/units/module_utils/basic/test_atomic_move.py 2>/dev/null || true" EXIT
git checkout 5260527c4a71bfed99d803e687dd19619423b134 -- test/integration/targets/apt_repository/tasks/mode.yaml test/units/module_utils/basic/test_atomic_move.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/basic/test_atomic_move.py
