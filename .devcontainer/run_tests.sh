#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/solr/test_query_utils.py 2>/dev/null || true" EXIT
git checkout a7b7dc5735a1b3a9824376b1b469b556dd413981 -- openlibrary/tests/solr/test_query_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/solr/test_query_utils.py
