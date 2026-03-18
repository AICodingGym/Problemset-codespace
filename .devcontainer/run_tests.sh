#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/solr/test_update_work.py 2>/dev/null || true" EXIT
git checkout 53e02a22972e9253aeded0e1981e6845e1e521fe -- openlibrary/tests/solr/test_update_work.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/solr/test_update_work.py
