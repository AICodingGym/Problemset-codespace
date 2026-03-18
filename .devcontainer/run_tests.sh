#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/lookup/test_password.py 2>/dev/null || true" EXIT
git checkout 5d253a13807e884b7ce0b6b57a963a45e2f0322c -- test/units/plugins/lookup/test_password.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/lookup/test_password.py
