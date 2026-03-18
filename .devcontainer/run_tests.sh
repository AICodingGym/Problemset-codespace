#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/multiplexer/multiplexer_test.go 2>/dev/null || true" EXIT
git checkout 3ff19cf7c41f396ae468797d3aeb61515517edc9 -- lib/multiplexer/multiplexer_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMux/ProxyLineV2,TestMux
