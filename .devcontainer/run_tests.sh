#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/connection/test_winrm.py 2>/dev/null || true" EXIT
git checkout 942424e10b2095a173dbd78e7128f52f7995849b -- test/units/plugins/connection/test_winrm.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/connection/test_winrm.py
