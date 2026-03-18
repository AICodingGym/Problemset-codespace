#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_resources.py tests/unit/utils/test_utils.py 2>/dev/null || true" EXIT
git checkout 3d01c201b8aa54dd71d4f801b1dd12feb4c0a08a -- tests/unit/utils/test_resources.py tests/unit/utils/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/scripts/test_check_coverage.py,tests/unit/utils/test_utils.py,tests/unit/utils/test_resources.py
