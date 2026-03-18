#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/test_qutebrowser.py 2>/dev/null || true" EXIT
git checkout 8f46ba3f6dc7b18375f7aa63c48a1fe461190430 -- tests/unit/test_qutebrowser.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/test_qutebrowser.py
