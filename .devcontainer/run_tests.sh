#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/basic/test_no_log.py test/units/module_utils/basic/test_sanitize_keys.py 2>/dev/null || true" EXIT
git checkout bf98f031f3f5af31a2d78dc2f0a58fe92ebae0bb -- test/units/module_utils/basic/test_no_log.py test/units/module_utils/basic/test_sanitize_keys.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/basic/test_sanitize_keys.py,test/units/module_utils/basic/test_no_log.py
