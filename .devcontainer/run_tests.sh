#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/middleware/grpc/middleware_test.go 2>/dev/null || true" EXIT
git checkout c12967bc73fdf02054cf3ef8498c05e25f0a18c0 -- internal/server/middleware/grpc/middleware_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestErrorUnaryInterceptor
