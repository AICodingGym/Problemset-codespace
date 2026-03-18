#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/javascript/test_js_quirks.py 2>/dev/null || true" EXIT
git checkout 5e0d6dc1483cb3336ea0e3dcbd4fe4aa00fc1742 -- tests/unit/javascript/test_js_quirks.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/javascript/test_js_quirks.py
