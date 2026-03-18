#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/misc/test_elf.py tests/unit/utils/test_version.py 2>/dev/null || true" EXIT
git checkout 394bfaed6544c952c6b3463751abab3176ad4997 -- tests/unit/misc/test_elf.py tests/unit/utils/test_version.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/utils/test_version.py,tests/unit/misc/test_elf.py
