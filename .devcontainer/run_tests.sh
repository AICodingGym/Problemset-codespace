#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/walk_dir_tree_test.go 2>/dev/null || true" EXIT
git checkout 0130c6dc13438b48cf0fdfab08a89e357b5517c9 -- scanner/walk_dir_tree_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestScanner
