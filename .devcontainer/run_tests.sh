#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/cli/test_galaxy.py test/units/galaxy/test_api.py 2>/dev/null || true" EXIT
git checkout 83909bfa22573777e3db5688773bda59721962ad -- test/units/cli/test_galaxy.py test/units/galaxy/test_api.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/cli/test_galaxy.py,test/units/galaxy/test_api.py
