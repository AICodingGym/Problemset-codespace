#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/middleware/grpc/middleware_test.go internal/server/middleware/grpc/support_test.go internal/storage/cache/cache_test.go internal/storage/cache/support_test.go 2>/dev/null || true" EXIT
git checkout 3ef34d1fff012140ba86ab3cafec8f9934b492be -- internal/server/middleware/grpc/middleware_test.go internal/server/middleware/grpc/support_test.go internal/storage/cache/cache_test.go internal/storage/cache/support_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSetJSON_HandleMarshalError,TestGetProtobuf_HandleUnmarshalError,TestGetJSON_HandleUnmarshalError,TestGetJSON_HandleGetError,TestGetProtobuf_HandleGetError
