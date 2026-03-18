#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- utils/hasher/hasher_test.go 2>/dev/null || true" EXIT
git checkout 3977ef6e0f287f598b6e4009876239d6f13b686d -- utils/hasher/hasher_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestHasher
