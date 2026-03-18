#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/ext/importer_test.go 2>/dev/null || true" EXIT
git checkout 1737085488ecdcd3299c8e61af45a8976d457b7e -- internal/ext/importer_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestImport
