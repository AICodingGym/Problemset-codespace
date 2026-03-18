#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- wordpress/wordpress_test.go 2>/dev/null || true" EXIT
git checkout 8d5ea98e50cf616847f4e5a2df300395d1f719e9 -- wordpress/wordpress_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestRemoveInactive
