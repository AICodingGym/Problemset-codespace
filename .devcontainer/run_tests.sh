#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/solr/test_update_work.py 2>/dev/null || true" EXIT
git checkout e390c1212055dd84a262a798e53487e771d3fb64 -- openlibrary/tests/solr/test_update_work.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/solr/test_update_work.py
