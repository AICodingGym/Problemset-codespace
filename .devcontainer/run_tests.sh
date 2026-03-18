#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/importapi/tests/test_code.py openlibrary/plugins/upstream/tests/test_utils.py openlibrary/utils/tests/test_isbn.py 2>/dev/null || true" EXIT
git checkout 0a90f9f0256e4f933523e9842799e39f95ae29ce -- openlibrary/plugins/importapi/tests/test_code.py openlibrary/plugins/upstream/tests/test_utils.py openlibrary/utils/tests/test_isbn.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/importapi/tests/test_code.py,openlibrary/utils/tests/test_isbn.py,openlibrary/plugins/upstream/tests/test_utils.py
