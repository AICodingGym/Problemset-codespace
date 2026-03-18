#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/walk_dir_tree_test.go tests/navidrome-test.toml 2>/dev/null || true" EXIT
git checkout 3853c3318f67b41a9e4cb768618315ff77846fdb -- scanner/walk_dir_tree_test.go tests/navidrome-test.toml

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestScanner
