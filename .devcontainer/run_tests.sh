#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scripts/dev/quit_segfault_test.sh tests/end2end/features/completion.feature tests/end2end/features/editor.feature tests/end2end/features/misc.feature tests/end2end/features/private.feature tests/end2end/features/prompts.feature tests/end2end/features/search.feature tests/end2end/features/tabs.feature tests/end2end/features/utilcmds.feature tests/end2end/fixtures/quteprocess.py tests/unit/misc/test_utilcmds.py 2>/dev/null || true" EXIT
git checkout 3fd8e12949b8feda401930574facf09dd4180bba -- scripts/dev/quit_segfault_test.sh tests/end2end/features/completion.feature tests/end2end/features/editor.feature tests/end2end/features/misc.feature tests/end2end/features/private.feature tests/end2end/features/prompts.feature tests/end2end/features/search.feature tests/end2end/features/tabs.feature tests/end2end/features/utilcmds.feature tests/end2end/fixtures/quteprocess.py tests/unit/misc/test_utilcmds.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/misc/test_utilcmds.py,tests/end2end/fixtures/quteprocess.py
