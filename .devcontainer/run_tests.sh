#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- wordpress/wordpress_test.go 2>/dev/null || true" EXIT
git checkout 36456cb151894964ba1683ce7da5c35ada789970 -- wordpress/wordpress_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSearchCache,TestRemoveInactive
