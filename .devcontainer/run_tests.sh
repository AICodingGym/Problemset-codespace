#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/worksearch/tests/test_autocomplete.py openlibrary/tests/catalog/test_get_ia.py 2>/dev/null || true" EXIT
git checkout 3f580a5f244c299d936d73d9e327ba873b6401d9 -- openlibrary/plugins/worksearch/tests/test_autocomplete.py openlibrary/tests/catalog/test_get_ia.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/worksearch/tests/test_autocomplete.py,openlibrary/tests/catalog/test_get_ia.py
