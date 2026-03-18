#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/parsing/yaml/test_dumper.py 2>/dev/null || true" EXIT
git checkout 12734fa21c08a0ce8c84e533abdc560db2eb1955 -- test/units/parsing/yaml/test_dumper.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/parsing/yaml/test_dumper.py
