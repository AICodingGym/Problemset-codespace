#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/tokens.js 2>/dev/null || true" EXIT
git checkout 7b8bffd763e2155cf88f3ebc258fa68ebe18188d -- test/tokens.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/tokens.js
