#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/modules/test_unarchive.py 2>/dev/null || true" EXIT
git checkout e64c6c1ca50d7d26a8e7747d8eb87642e767cd74 -- test/units/modules/test_unarchive.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/test_unarchive.py
