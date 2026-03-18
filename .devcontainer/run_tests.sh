#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py 2>/dev/null || true" EXIT
git checkout 9cd47f4dc21e273320d9e30d889c864f8cb20ccf -- openlibrary/catalog/add_book/tests/test_add_book.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/test_add_book.py
