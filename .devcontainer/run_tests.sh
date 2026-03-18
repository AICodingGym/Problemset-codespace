#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/plugins/lookup/test_password.py test/units/utils/test_encrypt.py 2>/dev/null || true" EXIT
git checkout 1bd7dcf339dd8b6c50bc16670be2448a206f4fdb -- test/units/plugins/lookup/test_password.py test/units/utils/test_encrypt.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/utils/test_encrypt.py,test/units/plugins/lookup/test_password.py
