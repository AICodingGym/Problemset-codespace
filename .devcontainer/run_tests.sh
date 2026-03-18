#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/marc/tests/test_data/bin_expect/wrapped_lines.json openlibrary/catalog/marc/tests/test_get_subjects.py 2>/dev/null || true" EXIT
git checkout 7c8dc180281491ccaa1b4b43518506323750d1e4 -- openlibrary/catalog/marc/tests/test_data/bin_expect/wrapped_lines.json openlibrary/catalog/marc/tests/test_get_subjects.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/marc/tests/test_parse.py,openlibrary/catalog/marc/tests/test_get_subjects.py
