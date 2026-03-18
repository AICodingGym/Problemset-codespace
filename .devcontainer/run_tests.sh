#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_qtargs_locale_workaround.py 2>/dev/null || true" EXIT
git checkout 473a15f7908f2bb6d670b0e908ab34a28d8cf7e2 -- tests/unit/config/test_qtargs_locale_workaround.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_qtargs_locale_workaround.py
