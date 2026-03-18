#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/browser/test_qutescheme.py tests/unit/config/test_config.py tests/unit/config/test_configcommands.py 2>/dev/null || true" EXIT
git checkout ed19d7f58b2664bb310c7cb6b52c5b9a06ea60b2 -- tests/unit/browser/test_qutescheme.py tests/unit/config/test_config.py tests/unit/config/test_configcommands.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/browser/test_qutescheme.py,tests/unit/config/test_config.py,tests/unit/config/test_configcommands.py
