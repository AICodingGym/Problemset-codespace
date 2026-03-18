#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/utils/test_jinja.py 2>/dev/null || true" EXIT
git checkout 35168ade46184d7e5b91dfa04ca42fe2abd82717 -- tests/unit/utils/test_jinja.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_jinja.py
