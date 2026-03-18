#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/cli/test_doc.py 2>/dev/null || true" EXIT
git checkout fb144c44144f8bd3542e71f5db62b6d322c7bd85 -- test/units/cli/test_doc.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/cli/test_doc.py
