#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- persistence/album_repository_test.go 2>/dev/null || true" EXIT
git checkout 8d56ec898e776e7e53e352cb9b25677975787ffc -- persistence/album_repository_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPersistence
