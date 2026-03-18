#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/release/check_test.go 2>/dev/null || true" EXIT
git checkout ee02b164f6728d3227c42671028c67a4afd36918 -- internal/release/check_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestIs,TestCheck
