#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- contrib/trivy/parser/parser_test.go 2>/dev/null || true" EXIT
git checkout d18e7a751d07260d75ce3ba0cd67c4a6aebfd967 -- contrib/trivy/parser/parser_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestParse
