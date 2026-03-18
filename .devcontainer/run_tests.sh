#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_utils.py tests/unit/utils/test_version.py 2>/dev/null || true" EXIT
git checkout 46e6839e21d9ff72abb6c5d49d5abaa5a8da8a81 -- tests/unit/utils/test_utils.py tests/unit/utils/test_version.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_utils.py,tests/unit/utils/test_version.py
