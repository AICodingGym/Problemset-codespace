#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/utils/prompt/stdin_test.go 2>/dev/null || true" EXIT
git checkout b8fbb2d1e90ffcde88ed5fe9920015c1be075788 -- lib/utils/prompt/stdin_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestContextReader/simple_read,TestContextReader/close_underlying_reader,TestContextReader/cancelled_read,TestContextReader
