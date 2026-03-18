#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/controllers.js 2>/dev/null || true" EXIT
git checkout 3c85b944e30a0ba8b3ec9e1f441c74f383625a15 -- test/controllers.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/controllers.js
