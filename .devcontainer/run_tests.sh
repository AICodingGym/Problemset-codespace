#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/utils/test_display.py 2>/dev/null || true" EXIT
git checkout a7d2a4e03209cff1e97e59fd54bb2b05fdbdbec6 -- test/units/utils/test_display.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/utils/test_display.py
