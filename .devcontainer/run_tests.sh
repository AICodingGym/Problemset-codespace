#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/core/test_observations.py 2>/dev/null || true" EXIT
git checkout 7cbfb812ef0e1f9716e2d6e85d538a96fcb79d13 -- openlibrary/tests/core/test_observations.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/test_observations.py
