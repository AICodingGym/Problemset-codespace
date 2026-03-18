#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/config/test_qtargs_locale_workaround.py 2>/dev/null || true" EXIT
git checkout 9b71c1ea67a9e7eb70dd83214d881c2031db6541 -- tests/unit/config/test_qtargs_locale_workaround.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/config/test_qtargs_locale_workaround.py
