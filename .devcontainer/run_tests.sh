#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/tests/test_import_standard_ebooks.py 2>/dev/null || true" EXIT
git checkout 798055d1a19b8fa0983153b709f460be97e33064 -- scripts/tests/test_import_standard_ebooks.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/tests/test_import_standard_ebooks.py
