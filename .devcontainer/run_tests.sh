#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/features/misc.feature tests/unit/commands/test_cmdexc.py tests/unit/commands/test_parser.py 2>/dev/null || true" EXIT
git checkout a84ecfb80a00f8ab7e341372560458e3f9cfffa2 -- tests/end2end/features/misc.feature tests/unit/commands/test_cmdexc.py tests/unit/commands/test_parser.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/commands/test_cmdexc.py,tests/unit/commands/test_parser.py
