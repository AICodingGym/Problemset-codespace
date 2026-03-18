#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/callback/test_callback.py 2>/dev/null || true" EXIT
git checkout 185d41031660a676c43fbb781cd1335902024bfe -- test/units/plugins/callback/test_callback.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/callback/test_callback.py
