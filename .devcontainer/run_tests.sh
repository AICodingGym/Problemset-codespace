#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- contrib/trivy/parser/v2/parser_test.go 2>/dev/null || true" EXIT
git checkout 7e91f5ef7e5712b1a3d7d5066ad6607e9debc21c -- contrib/trivy/parser/v2/parser_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestParse
