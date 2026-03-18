#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/plugins/upstream/tests/test_models.py openlibrary/tests/core/lists/test_model.py openlibrary/tests/core/test_models.py 2>/dev/null || true" EXIT
git checkout 798a582540019363d14b2090755cc7b89a350788 -- openlibrary/plugins/upstream/tests/test_models.py openlibrary/tests/core/lists/test_model.py openlibrary/tests/core/test_models.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/lists/test_model.py,openlibrary/plugins/upstream/tests/test_models.py,openlibrary/tests/core/test_models.py
