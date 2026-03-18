#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_load_book.py 2>/dev/null || true" EXIT
git checkout 0d13e6b4bf80bced6c0946b969b9a1b6963f6bce -- openlibrary/catalog/add_book/tests/test_load_book.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/test_load_book.py
