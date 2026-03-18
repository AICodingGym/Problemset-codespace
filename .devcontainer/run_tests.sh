#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/data/misc/xhr_headers.html tests/end2end/features/misc.feature tests/unit/browser/test_shared.py 2>/dev/null || true" EXIT
git checkout e15d26630934d0b6415ed2295ac42fd570a57620 -- tests/end2end/data/misc/xhr_headers.html tests/end2end/features/misc.feature tests/unit/browser/test_shared.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/test_shared.py
