#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/serve_index_test.go 2>/dev/null || true" EXIT
git checkout 27875ba2dd1673ddf8affca526b0664c12c3b98b -- server/serve_index_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestServer
