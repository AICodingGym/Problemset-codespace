#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/solr/test_update_work.py 2>/dev/null || true" EXIT
git checkout 322d7a46cdc965bfabbf9500e98fde098c9d95b2 -- openlibrary/tests/solr/test_update_work.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/solr/test_update_work.py
