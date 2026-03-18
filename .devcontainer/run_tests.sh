#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/connection_windows_ssh/runme.sh test/units/plugins/connection/test_ssh.py 2>/dev/null || true" EXIT
git checkout 935528e22e5283ee3f63a8772830d3d01f55ed8c -- test/integration/targets/connection_windows_ssh/runme.sh test/units/plugins/connection/test_ssh.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/connection/test_ssh.py
