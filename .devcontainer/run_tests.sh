#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/auth/http_test.go test/api.sh 2>/dev/null || true" EXIT
git checkout b6cef5cdc0daff3ee99e5974ed60a1dc6b4b0d67 -- internal/server/auth/http_test.go test/api.sh

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestUnaryInterceptor,TestHandler,TestErrorHandler
