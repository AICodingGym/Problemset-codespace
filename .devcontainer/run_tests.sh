#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/artwork/artwork_internal_test.go core/artwork/artwork_test.go 2>/dev/null || true" EXIT
git checkout 3f2d24695e9382125dfe5e6d6c8bbeb4a313a4f9 -- core/artwork/artwork_internal_test.go core/artwork/artwork_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestArtwork
