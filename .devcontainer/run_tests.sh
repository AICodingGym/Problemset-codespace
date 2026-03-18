#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/features/misc.feature tests/end2end/fixtures/webserver_sub.py tests/unit/browser/test_shared.py 2>/dev/null || true" EXIT
git checkout ec2dcfce9eee9f808efc17a1b99e227fc4421dea -- tests/end2end/features/misc.feature tests/end2end/fixtures/webserver_sub.py tests/unit/browser/test_shared.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/end2end/fixtures/webserver_sub.py,tests/unit/browser/test_shared.py
