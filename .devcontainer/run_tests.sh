#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/browser/webengine/test_darkmode.py 2>/dev/null || true" EXIT
git checkout 8cd06741bb56cdca49f5cdc0542da97681154315 -- tests/unit/browser/webengine/test_darkmode.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/webengine/test_darkmode.py
