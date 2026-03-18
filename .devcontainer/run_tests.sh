#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/utils/collection_loader/test_collection_loader.py 2>/dev/null || true" EXIT
git checkout ed6581e4db2f1bec5a772213c3e186081adc162d -- test/units/utils/collection_loader/test_collection_loader.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/utils/collection_loader/test_collection_loader.py
