#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/marc/tests/test_data/bin_expect/ithaca_two_856u.json 2>/dev/null || true" EXIT
git checkout e8084193a895d8ee81200f49093389a3887479ce -- openlibrary/catalog/marc/tests/test_data/bin_expect/ithaca_two_856u.json

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/marc/tests/test_parse.py
