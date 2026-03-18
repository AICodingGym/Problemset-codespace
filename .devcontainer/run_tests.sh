#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/features/completion.feature tests/end2end/features/javascript.feature tests/end2end/features/tabs.feature tests/manual/completion/changing_title.html tests/unit/completion/test_completer.py tests/unit/completion/test_models.py 2>/dev/null || true" EXIT
git checkout fd6790fe8c02b144ab2464f1fc8ab3d02ce3c476 -- tests/end2end/features/completion.feature tests/end2end/features/javascript.feature tests/end2end/features/tabs.feature tests/manual/completion/changing_title.html tests/unit/completion/test_completer.py tests/unit/completion/test_models.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/completion/test_completer.py,tests/unit/completion/test_models.py
