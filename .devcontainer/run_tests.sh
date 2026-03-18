#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/catalog/add_book/tests/conftest.py openlibrary/plugins/importapi/tests/test_code.py openlibrary/plugins/upstream/tests/test_utils.py 2>/dev/null || true" EXIT
git checkout 6e889f4a733c9f8ce9a9bd2ec6a934413adcedb9 -- openlibrary/catalog/add_book/tests/conftest.py openlibrary/plugins/importapi/tests/test_code.py openlibrary/plugins/upstream/tests/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/catalog/add_book/tests/conftest.py,openlibrary/plugins/upstream/tests/test_utils.py,openlibrary/plugins/importapi/tests/test_code.py
