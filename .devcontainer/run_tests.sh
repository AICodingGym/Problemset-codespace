#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/template-helpers.js 2>/dev/null || true" EXIT
git checkout f1a80d48cc45877fcbadf34c2345dd9709722c7f -- test/template-helpers.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/template-helpers.js
