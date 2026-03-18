#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/conftest.py tests/end2end/features/misc.feature tests/unit/config/test_configfiles.py tests/unit/config/test_configinit.py 2>/dev/null || true" EXIT
git checkout 233cb1cc48635130e5602549856a6fa4ab4c087f -- tests/end2end/conftest.py tests/end2end/features/misc.feature tests/unit/config/test_configfiles.py tests/unit/config/test_configinit.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_configfiles.py,tests/unit/config/test_configinit.py,tests/end2end/conftest.py
