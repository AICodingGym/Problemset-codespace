#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- openlibrary/tests/core/sample_amazon_record.py openlibrary/tests/core/test_vendors.py 2>/dev/null || true" EXIT
git checkout 2abe28b472ffed563a87cfe83685b161b35263b0 -- openlibrary/tests/core/sample_amazon_record.py openlibrary/tests/core/test_vendors.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) openlibrary/tests/core/sample_amazon_record.py,openlibrary/tests/core/test_vendors.py
