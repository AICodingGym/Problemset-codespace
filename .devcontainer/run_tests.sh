#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/components/test_blockutils.py tests/unit/utils/test_version.py 2>/dev/null || true" EXIT
git checkout 01d1d1494411380d97cac14614a829d3a69cecaf -- tests/unit/components/test_blockutils.py tests/unit/utils/test_version.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_version.py,tests/unit/components/test_blockutils.py
