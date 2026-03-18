#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/catalog/marc/tests/test_data/bin_expect/ithaca_college_75002321.json openlibrary/catalog/marc/tests/test_data/bin_expect/lesnoirsetlesrou0000garl_meta.json openlibrary/catalog/marc/tests/test_data/bin_expect/memoirsofjosephf00fouc_meta.json openlibrary/catalog/marc/tests/test_data/bin_expect/warofrebellionco1473unit_meta.json openlibrary/catalog/marc/tests/test_data/xml_expect/00schlgoog.json openlibrary/catalog/marc/tests/test_data/xml_expect/warofrebellionco1473unit.json 2>/dev/null || true" EXIT
git checkout 08ac40d050a64e1d2646ece4959af0c42bf6b7b5 -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/catalog/marc/tests/test_data/bin_expect/ithaca_college_75002321.json openlibrary/catalog/marc/tests/test_data/bin_expect/lesnoirsetlesrou0000garl_meta.json openlibrary/catalog/marc/tests/test_data/bin_expect/memoirsofjosephf00fouc_meta.json openlibrary/catalog/marc/tests/test_data/bin_expect/warofrebellionco1473unit_meta.json openlibrary/catalog/marc/tests/test_data/xml_expect/00schlgoog.json openlibrary/catalog/marc/tests/test_data/xml_expect/warofrebellionco1473unit.json

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/marc/tests/test_parse.py,openlibrary/catalog/add_book/tests/test_add_book.py
