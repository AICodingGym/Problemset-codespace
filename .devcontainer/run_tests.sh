#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/messaging.js 2>/dev/null || true" EXIT
git checkout f48ed3658aab7be0f1165d4c1f89af48d7865189 -- test/messaging.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/messaging.js
