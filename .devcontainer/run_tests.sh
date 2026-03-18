#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/tests/test_import_open_textbook_library.py 2>/dev/null || true" EXIT
git checkout f8cc11d9c1575fdba5ac66aee0befca970da8d64 -- scripts/tests/test_import_open_textbook_library.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/tests/test_import_open_textbook_library.py
