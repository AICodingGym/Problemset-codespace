#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/conftest.py openlibrary/tests/catalog/test_utils.py 2>/dev/null || true" EXIT
git checkout c05ccf2cd8baa81609434e0e35c4a63bc0da5a25 -- openlibrary/catalog/add_book/tests/conftest.py openlibrary/tests/catalog/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/conftest.py,openlibrary/tests/catalog/test_utils.py
