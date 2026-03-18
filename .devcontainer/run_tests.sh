#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/marc/tests/test_data/bin_expect/880_Nihon_no_chasho.json openlibrary/catalog/marc/tests/test_data/bin_expect/880_arabic_french_many_linkages.json 2>/dev/null || true" EXIT
git checkout 0dc5b20fa186f9714f8a838178597e69f549d026 -- openlibrary/catalog/marc/tests/test_data/bin_expect/880_Nihon_no_chasho.json openlibrary/catalog/marc/tests/test_data/bin_expect/880_arabic_french_many_linkages.json

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/marc/tests/test_parse.py
