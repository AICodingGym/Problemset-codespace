#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- wordpress/wordpress_test.go 2>/dev/null || true" EXIT
git checkout aaea15e516ece43978cf98e09e52080478b1d39f -- wordpress/wordpress_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSearchCache,TestRemoveInactive
