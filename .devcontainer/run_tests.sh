#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/catalog/add_book/tests/test_load_book.py 2>/dev/null || true" EXIT
git checkout d40ec88713dc95ea791b252f92d2f7b75e107440 -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/catalog/add_book/tests/test_load_book.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/test_load_book.py,openlibrary/catalog/add_book/tests/test_add_book.py
