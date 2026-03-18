#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/marc/tests/test_data/bin_expect/equalsign_title.mrc openlibrary/catalog/marc/tests/test_data/bin_expect/zweibchersatir01horauoft_meta.mrc openlibrary/catalog/marc/tests/test_data/xml_expect/zweibchersatir01horauoft_marc.xml 2>/dev/null || true" EXIT
git checkout 3c48b4bb782189e0858e6c3fc7956046cf3e1cfb -- openlibrary/catalog/marc/tests/test_data/bin_expect/equalsign_title.mrc openlibrary/catalog/marc/tests/test_data/bin_expect/zweibchersatir01horauoft_meta.mrc openlibrary/catalog/marc/tests/test_data/xml_expect/zweibchersatir01horauoft_marc.xml

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/marc/tests/test_parse.py
