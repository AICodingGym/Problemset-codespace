#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/browser/webengine/test_webview.py 2>/dev/null || true" EXIT
git checkout c0be28ebee3e1837aaf3f30ec534ccd6d038f129 -- tests/unit/browser/webengine/test_webview.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/webengine/test_webview.py
