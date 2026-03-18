#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/solr_builder/tests/test_fn_to_cli.py 2>/dev/null || true" EXIT
git checkout 6afdb09df692223c3a31df65cfa92f15e5614c01 -- scripts/solr_builder/tests/test_fn_to_cli.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/solr_builder/tests/test_fn_to_cli.py
