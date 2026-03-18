#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/cli/test_doc.py 2>/dev/null || true" EXIT
git checkout be2c376ab87e3e872ca21697508f12c6909cf85a -- test/units/cli/test_doc.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/cli/test_doc.py
