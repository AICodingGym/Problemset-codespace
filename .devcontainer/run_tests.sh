#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/solr/test_query_utils.py 2>/dev/null || true" EXIT
git checkout 431442c92887a3aece3f8aa771dd029738a80eb1 -- openlibrary/tests/solr/test_query_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/solr/test_query_utils.py
