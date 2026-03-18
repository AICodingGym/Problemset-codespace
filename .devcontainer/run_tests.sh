#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/features/hints.feature tests/end2end/features/spawn.feature tests/unit/misc/test_guiprocess.py 2>/dev/null || true" EXIT
git checkout e70f5b03187bdd40e8bf70f5f3ead840f52d1f42 -- tests/end2end/features/hints.feature tests/end2end/features/spawn.feature tests/unit/misc/test_guiprocess.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/misc/test_guiprocess.py
