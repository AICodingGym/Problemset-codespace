#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/user.js 2>/dev/null || true" EXIT
git checkout cfc237c2b79d8c731bbfc6cadf977ed530bfd57a -- test/user.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/user.js
