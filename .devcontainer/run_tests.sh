#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/marc/tests/test_parse.py 2>/dev/null || true" EXIT
git checkout 9c392b60e2c6fa1d68cb68084b4b4ff04d0cb35c -- openlibrary/catalog/marc/tests/test_parse.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/marc/tests/test_parse.py
