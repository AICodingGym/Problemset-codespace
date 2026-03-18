#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/coverstore/tests/test_archive.py 2>/dev/null || true" EXIT
git checkout bb152d23c004f3d68986877143bb0f83531fe401 -- openlibrary/coverstore/tests/test_archive.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/coverstore/tests/test_archive.py
