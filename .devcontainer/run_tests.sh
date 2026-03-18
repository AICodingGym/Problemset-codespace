#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_qtutils.py 2>/dev/null || true" EXIT
git checkout 2dd8966fdcf11972062c540b7a787e4d0de8d372 -- tests/unit/utils/test_qtutils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_qtutils.py
