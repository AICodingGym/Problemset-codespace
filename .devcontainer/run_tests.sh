#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/walk_dir_tree_test.go 2>/dev/null || true" EXIT
git checkout eebfbc5381a1e506ff17b5f1371d1ad83d5fd642 -- scanner/walk_dir_tree_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestScanner
