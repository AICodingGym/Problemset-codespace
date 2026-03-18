#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- persistence/user_repository_test.go 2>/dev/null || true" EXIT
git checkout 874b17b8f614056df0ef021b5d4f977341084185 -- persistence/user_repository_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPersistence
