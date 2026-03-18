#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/connection/test_winrm.py 2>/dev/null || true" EXIT
git checkout e22e103cdf8edc56ff7d9b848a58f94f1471a263 -- test/units/plugins/connection/test_winrm.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/connection/test_winrm.py
