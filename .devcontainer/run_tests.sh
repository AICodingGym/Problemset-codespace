#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/browser/webengine/test_darkmode.py 2>/dev/null || true" EXIT
git checkout 99029144b5109bb1b2a53964a7c129e009980cd9 -- tests/unit/browser/webengine/test_darkmode.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/webengine/test_darkmode.py
