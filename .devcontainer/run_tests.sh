#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/test_docker_compose.py 2>/dev/null || true" EXIT
git checkout 92db3454aeaa02f89b4cdbc3103f7e95c9759f92 -- tests/test_docker_compose.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/test_docker_compose.py
