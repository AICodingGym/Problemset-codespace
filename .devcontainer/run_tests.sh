#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/walk_dir_tree_test.go tests/navidrome-test.toml 2>/dev/null || true" EXIT
git checkout 6b3b4d83ffcf273b01985709c8bc5df12bbb8286 -- scanner/walk_dir_tree_test.go tests/navidrome-test.toml

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestScanner
