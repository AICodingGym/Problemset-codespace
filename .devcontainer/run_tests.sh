#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/cmd/grpc_test.go 2>/dev/null || true" EXIT
git checkout 36e62baffae2132f78f9d34dc300a9baa2d7ae0e -- internal/cmd/grpc_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestGetTraceExporter,TestTrailingSlashMiddleware
