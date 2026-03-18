#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/executor/test_play_iterator.py 2>/dev/null || true" EXIT
git checkout 395e5e20fab9cad517243372fa3c3c5d9e09ab2a -- test/units/executor/test_play_iterator.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/executor/test_play_iterator.py
