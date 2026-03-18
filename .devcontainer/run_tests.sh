#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/tests/catalog/test_utils.py 2>/dev/null || true" EXIT
git checkout f0341c0ba81c790241b782f5103ce5c9a6edf8e3 -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/tests/catalog/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/catalog/test_utils.py,openlibrary/catalog/add_book/tests/test_add_book.py
