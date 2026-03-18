#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/plugins/importapi/tests/test_import_validator.py 2>/dev/null || true" EXIT
git checkout b112069e31e0553b2d374abb5f9c5e05e8f3dbbe -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/plugins/importapi/tests/test_import_validator.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/importapi/tests/test_import_validator.py,openlibrary/catalog/add_book/tests/test_add_book.py
