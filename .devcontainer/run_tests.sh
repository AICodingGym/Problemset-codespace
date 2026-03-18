#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_log.py tests/unit/utils/test_qtlog.py 2>/dev/null || true" EXIT
git checkout f91ace96223cac8161c16dd061907e138fe85111 -- tests/unit/utils/test_log.py tests/unit/utils/test_qtlog.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_log.py,tests/unit/utils/test_qtlog.py
