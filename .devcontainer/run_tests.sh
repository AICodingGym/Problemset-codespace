#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/user.js test/user/emails.js 2>/dev/null || true" EXIT
git checkout 9c576a0758690f45a6ca03b5884c601e473bf2c1 -- test/user.js test/user/emails.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/user.js,test/user/emails.js
