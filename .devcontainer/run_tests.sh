#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py 2>/dev/null || true" EXIT
git checkout fdbc0d8f418333c7e575c40b661b582c301ef7ac -- openlibrary/catalog/add_book/tests/test_add_book.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/test_add_book.py
