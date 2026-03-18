#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/upstream/tests/test_models.py 2>/dev/null || true" EXIT
git checkout 60725705782832a2cb22e17c49697948a42a9d03 -- openlibrary/plugins/upstream/tests/test_models.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/upstream/tests/test_models.py
