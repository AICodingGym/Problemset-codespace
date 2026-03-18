#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/importapi/tests/test_import_validator.py 2>/dev/null || true" EXIT
git checkout f3b26c2c0721f8713353fe4b341230332e30008d -- openlibrary/plugins/importapi/tests/test_import_validator.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/importapi/tests/test_import_validator.py
