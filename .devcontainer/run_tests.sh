#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/tests/test_new_solr_updater.py 2>/dev/null || true" EXIT
git checkout 03095f2680f7516fca35a58e665bf2a41f006273 -- scripts/tests/test_new_solr_updater.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) scripts/tests/test_new_solr_updater.py
