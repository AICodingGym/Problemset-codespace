#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/cache/fncache_test.go 2>/dev/null || true" EXIT
git checkout 78b0d8c72637df1129fb6ff84fc49ef4b5ab1288 -- lib/cache/fncache_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestFnCacheCancellation,TestApplicationServers,TestDatabases,TestDatabaseServers,TestFnCacheSanity,TestState
