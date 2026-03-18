#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- model/mediafile_test.go 2>/dev/null || true" EXIT
git checkout c90468b895f6171e33e937ff20dc915c995274f0 -- model/mediafile_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestModel
