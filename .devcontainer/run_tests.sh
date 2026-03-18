#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/browser/webengine/test_webview.py 2>/dev/null || true" EXIT
git checkout 7f9713b20f623fc40473b7167a082d6db0f0fd40 -- tests/unit/browser/webengine/test_webview.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/webengine/test_webview.py
