#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/core/test_wikidata.py 2>/dev/null || true" EXIT
git checkout 4a5d2a7d24c9e4c11d3069220c0685b736d5ecde -- openlibrary/tests/core/test_wikidata.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/test_wikidata.py
