#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/marc/tests/test_data/bin_expect/880_arabic_french_many_linkages.json openlibrary/catalog/marc/tests/test_data/xml_expect/nybc200247.json openlibrary/catalog/marc/tests/test_data/xml_input/nybc200247_marc.xml openlibrary/catalog/marc/tests/test_parse.py 2>/dev/null || true" EXIT
git checkout 111347e9583372e8ef91c82e0612ea437ae3a9c9 -- openlibrary/catalog/marc/tests/test_data/bin_expect/880_arabic_french_many_linkages.json openlibrary/catalog/marc/tests/test_data/xml_expect/nybc200247.json openlibrary/catalog/marc/tests/test_data/xml_input/nybc200247_marc.xml openlibrary/catalog/marc/tests/test_parse.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/marc/tests/test_parse.py
