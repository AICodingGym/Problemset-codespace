#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/solr/test_update_work.py openlibrary/tests/solr/test_utils.py 2>/dev/null || true" EXIT
git checkout 25858f9f0c165df25742acf8309ce909773f0cdd -- openlibrary/tests/solr/test_update_work.py openlibrary/tests/solr/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/solr/test_update_work.py,openlibrary/tests/solr/test_utils.py
