#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_qtutils.py 2>/dev/null || true" EXIT
git checkout 0d2afd58f3d0e34af21cee7d8a3fc9d855594e9f -- tests/unit/utils/test_qtutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_qtutils.py
