#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/activitypub.js 2>/dev/null || true" EXIT
git checkout da0211b1a001d45d73b4c84c6417a4f1b0312575 -- test/activitypub.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/activitypub.js
