#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_utils.py 2>/dev/null || true" EXIT
git checkout cc360cd4a34a126274c7b51f3b63afbaf3e05a02 -- tests/unit/utils/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_utils.py
