#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/browser/webkit/network/test_networkreply.py 2>/dev/null || true" EXIT
git checkout 0833b5f6f140d04200ec91605f88704dd18e2970 -- tests/unit/browser/webkit/network/test_networkreply.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/webkit/network/test_networkreply.py
