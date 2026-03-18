#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/solr_builder/tests/test_fn_to_cli.py 2>/dev/null || true" EXIT
git checkout c506c1b0b678892af5cb22c1c1dbc35d96787a0a -- scripts/solr_builder/tests/test_fn_to_cli.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/solr_builder/tests/test_fn_to_cli.py
