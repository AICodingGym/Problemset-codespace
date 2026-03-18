#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/solr/test_data_provider.py openlibrary/tests/solr/test_update_work.py 2>/dev/null || true" EXIT
git checkout acdddc590d0b3688f8f6386f43709049622a6e19 -- openlibrary/tests/solr/test_data_provider.py openlibrary/tests/solr/test_update_work.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/solr/test_update_work.py,openlibrary/tests/solr/test_data_provider.py
