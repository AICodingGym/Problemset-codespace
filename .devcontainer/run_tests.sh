#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/test_qt_machinery.py tests/unit/utils/test_version.py 2>/dev/null || true" EXIT
git checkout a25e8a09873838ca9efefd36ea8a45170bbeb95c -- tests/unit/test_qt_machinery.py tests/unit/utils/test_version.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/test_qt_machinery.py,tests/unit/utils/test_version.py
