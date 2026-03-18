#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/tests/test_partner_batch_imports.py 2>/dev/null || true" EXIT
git checkout de6ae10512f1b5ef585c8341b451bc49c9fd4996 -- scripts/tests/test_partner_batch_imports.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/tests/test_partner_batch_imports.py
