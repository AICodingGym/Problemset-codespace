#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py 2>/dev/null || true" EXIT
git checkout 43f9e7e0d56a4f1d487533543c17040a029ac501 -- openlibrary/catalog/add_book/tests/test_add_book.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/test_add_book.py
