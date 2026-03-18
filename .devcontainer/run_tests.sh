#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/solr/updater/test_author.py 2>/dev/null || true" EXIT
git checkout 62d2243131a9c7e6aee00d1e9c5660fd5b594e89 -- openlibrary/tests/solr/updater/test_author.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/solr/updater/test_author.py
