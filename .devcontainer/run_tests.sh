#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/misc/test_guiprocess.py 2>/dev/null || true" EXIT
git checkout cf06f4e3708f886032d4d2a30108c2fddb042d81 -- tests/unit/misc/test_guiprocess.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/misc/test_guiprocess.py
