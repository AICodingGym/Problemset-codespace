#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/galaxy/test_collection.py 2>/dev/null || true" EXIT
git checkout deb54e4c5b32a346f1f0b0a14f1c713d2cc2e961 -- test/units/galaxy/test_collection.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/galaxy/test_collection.py
