#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/worksearch/tests/test_worksearch.py 2>/dev/null || true" EXIT
git checkout 9bdfd29fac883e77dcbc4208cab28c06fd963ab2 -- openlibrary/plugins/worksearch/tests/test_worksearch.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/worksearch/tests/test_worksearch.py
