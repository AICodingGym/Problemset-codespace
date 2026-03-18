#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/components/test_braveadblock.py 2>/dev/null || true" EXIT
git checkout 6dd402c0d0f7665d32a74c43c5b4cf5dc8aff28d -- tests/unit/components/test_braveadblock.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/components/test_braveadblock.py
