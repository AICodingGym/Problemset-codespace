#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/groups.js test/user.js 2>/dev/null || true" EXIT
git checkout 8168c6c40707478f71b8af60300830fe554c778c -- test/groups.js test/user.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/groups.js,test/user.js
