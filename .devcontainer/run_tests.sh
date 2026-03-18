#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/facts/system/test_pkg_mgr.py 2>/dev/null || true" EXIT
git checkout 748f534312f2073a25a87871f5bd05882891b8c4 -- test/units/module_utils/facts/system/test_pkg_mgr.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/facts/system/test_pkg_mgr.py
