#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/catalog/add_book/tests/test_match.py 2>/dev/null || true" EXIT
git checkout 1894cb48d6e7fb498295a5d3ed0596f6f603b784 -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/catalog/add_book/tests/test_match.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/test_match.py,openlibrary/catalog/add_book/tests/test_add_book.py
