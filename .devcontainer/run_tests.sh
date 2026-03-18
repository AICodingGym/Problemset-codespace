#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/tests/test_affiliate_server.py 2>/dev/null || true" EXIT
git checkout 123e6e5e1c85b9c07d1e98f70bfc480bc8016890 -- scripts/tests/test_affiliate_server.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/tests/test_affiliate_server.py
