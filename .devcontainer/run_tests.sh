#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- persistence/user_repository_test.go tests/mock_user_repo.go utils/encrypt_test.go 2>/dev/null || true" EXIT
git checkout 66b74c81f115c78cb69910b0472eeb376750efc4 -- persistence/user_repository_test.go tests/mock_user_repo.go utils/encrypt_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestUtils,TestPersistence
