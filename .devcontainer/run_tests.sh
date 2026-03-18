#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_utils.py 2>/dev/null || true" EXIT
git checkout 96b997802e942937e81d2b8a32d08f00d3f4bc4e -- tests/unit/utils/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_utils.py
