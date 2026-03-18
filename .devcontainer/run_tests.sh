#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_configinit.py tests/unit/config/test_qtargs.py 2>/dev/null || true" EXIT
git checkout de4a1c1a2839b5b49c3d4ce21d39de48d24e2091 -- tests/unit/config/test_configinit.py tests/unit/config/test_qtargs.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_qtargs.py,tests/unit/config/test_configinit.py
