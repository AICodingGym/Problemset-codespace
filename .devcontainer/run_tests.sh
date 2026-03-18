#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- model/album_test.go model/mediafile_test.go persistence/helpers_test.go 2>/dev/null || true" EXIT
git checkout 8e640bb8580affb7e0ea6225c0bbe240186b6b08 -- model/album_test.go model/mediafile_test.go persistence/helpers_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestModel
