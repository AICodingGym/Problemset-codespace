#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/authz/engine/bundle/engine_test.go internal/server/authz/engine/rego/engine_test.go 2>/dev/null || true" EXIT
git checkout 507170da0f7f4da330f6732bffdf11c4df7fc192 -- internal/server/authz/engine/bundle/engine_test.go internal/server/authz/engine/rego/engine_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestEngine_IsAuthMethod
