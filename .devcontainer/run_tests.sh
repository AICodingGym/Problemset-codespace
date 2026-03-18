#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/browser/webengine/test_webview.py 2>/dev/null || true" EXIT
git checkout fea33d607fde83cf505b228238cf365936437a63 -- tests/unit/browser/webengine/test_webview.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/webengine/test_webview.py
