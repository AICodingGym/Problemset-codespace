#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- contrib/trivy/parser/v2/parser_test.go 2>/dev/null || true" EXIT
git checkout fd18df1dd4e4360f8932bc4b894bd8b40d654e7c -- contrib/trivy/parser/v2/parser_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestParse
