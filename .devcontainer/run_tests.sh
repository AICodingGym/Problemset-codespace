#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/core/test_wikidata.py 2>/dev/null || true" EXIT
git checkout 5fb312632097be7e9ac6ab657964af115224d15d -- openlibrary/tests/core/test_wikidata.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/test_wikidata.py
