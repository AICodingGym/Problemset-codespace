#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_configfiles.py 2>/dev/null || true" EXIT
git checkout 8d05f0282a271bfd45e614238bd1b555c58b3fc1 -- tests/unit/config/test_configfiles.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_configfiles.py
