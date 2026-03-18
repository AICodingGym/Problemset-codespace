#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/subsonic/middlewares_test.go 2>/dev/null || true" EXIT
git checkout 1e96b858a91c640fe64e84c5e5ad8cc0954ea38d -- server/subsonic/middlewares_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApi
