#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/features/spawn.feature tests/unit/misc/test_guiprocess.py 2>/dev/null || true" EXIT
git checkout 0b621cb0ce2b54d3f93d8d41d8ff4257888a87e5 -- tests/end2end/features/spawn.feature tests/unit/misc/test_guiprocess.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/misc/test_guiprocess.py
