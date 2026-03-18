#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/multiplexer/multiplexer_test.go 2>/dev/null || true" EXIT
git checkout af5e2517de7d18406b614e413aca61c319312171 -- lib/multiplexer/multiplexer_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMux/SSHProxyHelloSignature,TestMux
