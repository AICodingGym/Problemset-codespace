#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/catalog/add_book/tests/test_match.py openlibrary/catalog/merge/tests/test_merge_marc.py openlibrary/tests/catalog/test_utils.py 2>/dev/null || true" EXIT
git checkout 1351c59fd43689753de1fca32c78d539a116ffc1 -- openlibrary/catalog/add_book/tests/test_add_book.py openlibrary/catalog/add_book/tests/test_match.py openlibrary/catalog/merge/tests/test_merge_marc.py openlibrary/tests/catalog/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/catalog/test_utils.py,openlibrary/catalog/merge/tests/test_merge_marc.py,openlibrary/catalog/add_book/tests/test_match.py,openlibrary/catalog/add_book/tests/test_add_book.py
