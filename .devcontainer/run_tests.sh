#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/completion/test_models.py 2>/dev/null || true" EXIT
git checkout 305e7c96d5e2fdb3b248b27dfb21042fb2b7e0b8 -- tests/unit/completion/test_models.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/completion/test_models.py
