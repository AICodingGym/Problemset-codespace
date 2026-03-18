#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/adhoc/aliases test/integration/targets/adhoc/runme.sh test/units/cli/test_adhoc.py 2>/dev/null || true" EXIT
git checkout cb94c0cc550df9e98f1247bc71d8c2b861c75049 -- test/integration/targets/adhoc/aliases test/integration/targets/adhoc/runme.sh test/units/cli/test_adhoc.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/cli/test_adhoc.py
