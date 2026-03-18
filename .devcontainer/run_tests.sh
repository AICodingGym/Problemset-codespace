#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/worksearch/tests/test_autocomplete.py 2>/dev/null || true" EXIT
git checkout 7edd1ef09d91fe0b435707633c5cc9af41dedddf -- openlibrary/plugins/worksearch/tests/test_autocomplete.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/plugins/worksearch/tests/test_autocomplete.py
