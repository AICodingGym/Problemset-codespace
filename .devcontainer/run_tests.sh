#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/misc/test_elf.py 2>/dev/null || true" EXIT
git checkout 34a13afd36b5e529d553892b1cd8b9d5ce8881c4 -- tests/unit/misc/test_elf.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/misc/test_elf.py
