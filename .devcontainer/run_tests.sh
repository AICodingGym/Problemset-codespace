#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/worksearch/schemes/tests/test_works.py openlibrary/plugins/worksearch/tests/test_worksearch.py openlibrary/utils/tests/test_utils.py 2>/dev/null || true" EXIT
git checkout 7f6b722a10f822171501d027cad60afe53337732 -- openlibrary/plugins/worksearch/schemes/tests/test_works.py openlibrary/plugins/worksearch/tests/test_worksearch.py openlibrary/utils/tests/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/worksearch/tests/test_worksearch.py,openlibrary/plugins/worksearch/schemes/tests/test_works.py,openlibrary/utils/tests/test_utils.py
