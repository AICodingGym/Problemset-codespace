#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/upstream/tests/test_checkins.py 2>/dev/null || true" EXIT
git checkout 58999808a17a26b387f8237860a7a524d1e2d262 -- openlibrary/plugins/upstream/tests/test_checkins.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/upstream/tests/test_checkins.py
