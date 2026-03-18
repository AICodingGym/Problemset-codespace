#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/core/test_models.py 2>/dev/null || true" EXIT
git checkout 5de7de19211e71b29b2f2ba3b1dff2fe065d660f -- openlibrary/tests/core/test_models.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/test_models.py
