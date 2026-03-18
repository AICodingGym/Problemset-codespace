#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/user.js 2>/dev/null || true" EXIT
git checkout bad15643013ca15affe408b75eba9e47cc604bb2 -- test/user.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/user.js
