#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/cmd/grpc_test.go internal/tracing/tracing_test.go 2>/dev/null || true" EXIT
git checkout 690672523398c2b6f6e4562f0bf9868664ab894f -- internal/cmd/grpc_test.go internal/tracing/tracing_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestGetTraceExporter,TestNewResourceDefault
