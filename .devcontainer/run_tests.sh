#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/shell/test_powershell.py 2>/dev/null || true" EXIT
git checkout f86c58e2d235d8b96029d102c71ee2dfafd57997 -- test/units/plugins/shell/test_powershell.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/shell/test_powershell.py
