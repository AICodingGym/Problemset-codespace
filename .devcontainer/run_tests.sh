#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/components/test_hostblock.py tests/unit/config/test_configutils.py tests/unit/utils/test_urlutils.py 2>/dev/null || true" EXIT
git checkout c580ebf0801e5a3ecabc54f327498bb753c6d5f2 -- tests/unit/components/test_hostblock.py tests/unit/config/test_configutils.py tests/unit/utils/test_urlutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/components/test_hostblock.py,tests/unit/utils/test_urlutils.py,tests/unit/config/test_configutils.py
