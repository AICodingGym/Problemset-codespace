#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/data/click_element.html tests/end2end/features/misc.feature tests/unit/utils/test_utils.py 2>/dev/null || true" EXIT
git checkout 85b867fe8d4378c8e371f055c70452f546055854 -- tests/end2end/data/click_element.html tests/end2end/features/misc.feature tests/unit/utils/test_utils.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_utils.py
