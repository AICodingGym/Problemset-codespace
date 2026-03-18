#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/monitoring/tests/test_utils_py.py 2>/dev/null || true" EXIT
git checkout 8a5a63af6e0be406aa6c8c9b6d5f28b2f1b6af5a -- scripts/monitoring/tests/test_utils_py.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/monitoring/tests/test_utils_py.py
