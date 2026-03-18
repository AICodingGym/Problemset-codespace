#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- contrib/trivy/parser/v2/parser_test.go 2>/dev/null || true" EXIT
git checkout 878c25bf5a9c9fd88ac32eb843f5636834d5712d -- contrib/trivy/parser/v2/parser_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestParse
