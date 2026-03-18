#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/config/test_manager.py 2>/dev/null || true" EXIT
git checkout d33bedc48fdd933b5abd65a77c081876298e2f07 -- test/units/config/test_manager.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/config/test_manager.py
