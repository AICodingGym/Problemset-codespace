#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/unit/completion/test_models.py tests/unit/misc/test_guiprocess.py 2>/dev/null || true" EXIT
git checkout c09e1439f145c66ee3af574386e277dd2388d094 -- tests/unit/completion/test_models.py tests/unit/misc/test_guiprocess.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/completion/test_models.py,tests/unit/misc/test_guiprocess.py
