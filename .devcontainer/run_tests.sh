#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/common/text/formatters/test_human_to_bytes.py 2>/dev/null || true" EXIT
git checkout d62496fe416623e88b90139dc7917080cb04ce70 -- test/units/module_utils/common/text/formatters/test_human_to_bytes.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/common/text/formatters/test_human_to_bytes.py
