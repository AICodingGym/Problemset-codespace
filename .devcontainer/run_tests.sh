#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/test_match.py openlibrary/utils/tests/test_lccn.py 2>/dev/null || true" EXIT
git checkout c12943be1db80cf1114bc267ddf4f9933aca9b28 -- openlibrary/catalog/add_book/tests/test_match.py openlibrary/utils/tests/test_lccn.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/test_match.py,openlibrary/utils/tests/test_lccn.py
