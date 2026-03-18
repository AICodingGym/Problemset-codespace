#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/connection/test_winrm.py 2>/dev/null || true" EXIT
git checkout e9e6001263f51103e96e58ad382660df0f3d0e39 -- test/units/plugins/connection/test_winrm.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/connection/test_winrm.py
