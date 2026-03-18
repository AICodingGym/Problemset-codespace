#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_configutils.py 2>/dev/null || true" EXIT
git checkout 21b426b6a20ec1cc5ecad770730641750699757b -- tests/unit/config/test_configutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_configutils.py
