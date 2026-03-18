#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/playlists_test.go model/playlists_test.go 2>/dev/null || true" EXIT
git checkout 28389fb05e1523564dfc61fa43ed8eb8a10f938c -- core/playlists_test.go model/playlists_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestModel
