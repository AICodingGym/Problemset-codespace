#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/auth/middleware_test.go 2>/dev/null || true" EXIT
git checkout 6fe76d024ee0c50ddb09c86f4ae0bd4c208fd65f -- internal/server/auth/middleware_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestUnaryInterceptor
