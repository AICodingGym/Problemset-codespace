#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/importapi/tests/test_import_validator.py 2>/dev/null || true" EXIT
git checkout 00bec1e7c8f3272c469a58e1377df03f955ed478 -- openlibrary/plugins/importapi/tests/test_import_validator.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/importapi/tests/test_import_validator.py
