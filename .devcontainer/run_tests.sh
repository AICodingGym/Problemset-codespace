#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/core/test_wikidata.py 2>/dev/null || true" EXIT
git checkout 3aeec6afed9198d734b7ee1293f03ca94ff970e1 -- openlibrary/tests/core/test_wikidata.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/test_wikidata.py
