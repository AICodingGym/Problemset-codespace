#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/browser/webkit/test_certificateerror.py 2>/dev/null || true" EXIT
git checkout e5340c449f23608803c286da0563b62f58ba25b0 -- tests/unit/browser/webkit/test_certificateerror.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/webkit/test_certificateerror.py
