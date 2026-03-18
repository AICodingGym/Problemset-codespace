#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/executor/module_common/test_recursive_finder.py test/units/module_utils/common/test_locale.py 2>/dev/null || true" EXIT
git checkout 415e08c2970757472314e515cb63a51ad825c45e -- test/units/executor/module_common/test_recursive_finder.py test/units/module_utils/common/test_locale.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/executor/module_common/test_recursive_finder.py,test/units/module_utils/common/test_locale.py
