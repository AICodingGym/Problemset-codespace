#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/openlibrary/tests/test_bestbookapi.py 2>/dev/null || true" EXIT
git checkout 630221ab686c64e75a2ce253c893c033e4814b2e -- openlibrary/plugins/openlibrary/tests/test_bestbookapi.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/openlibrary/tests/test_bestbookapi.py
