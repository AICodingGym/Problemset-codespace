#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/features/search.feature tests/unit/browser/webengine/test_webenginetab.py 2>/dev/null || true" EXIT
git checkout bf045f7ec7c27709ea3ef61cf41a24e8fdd2e7da -- tests/end2end/features/search.feature tests/unit/browser/webengine/test_webenginetab.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/webengine/test_webenginetab.py
