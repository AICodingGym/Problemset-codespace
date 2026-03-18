#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/serve_index_test.go server/serve_test.go 2>/dev/null || true" EXIT
git checkout 10108c63c9b5bdf2966ffb3239bbfd89683e37b7 -- server/serve_index_test.go server/serve_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestServer
