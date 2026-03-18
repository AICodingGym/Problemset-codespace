#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/conftest.py openlibrary/tests/catalog/test_utils.py 2>/dev/null || true" EXIT
git checkout 7f7e53aa4cf74a4f8549a5bcd4810c527e2f6d7e -- openlibrary/catalog/add_book/tests/conftest.py openlibrary/tests/catalog/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/catalog/test_utils.py,openlibrary/catalog/add_book/tests/conftest.py
