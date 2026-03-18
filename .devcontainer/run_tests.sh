#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/components/test_blockutils.py 2>/dev/null || true" EXIT
git checkout e57b6e0eeeb656eb2c84d6547d5a0a7333ecee85 -- tests/unit/components/test_blockutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/components/test_blockutils.py
