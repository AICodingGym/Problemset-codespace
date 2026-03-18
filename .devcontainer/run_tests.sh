#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/posts/uploads.js 2>/dev/null || true" EXIT
git checkout 6489e9fd9ed16ea743cc5627f4d86c72fbdb3a8a -- test/posts/uploads.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/posts/uploads.js
