#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- tests/end2end/features/tabs.feature tests/unit/mainwindow/test_tabwidget.py 2>/dev/null || true" EXIT
git checkout 1943fa072ec3df5a87e18a23b0916f134c131016 -- tests/end2end/features/tabs.feature tests/unit/mainwindow/test_tabwidget.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) tests/unit/mainwindow/test_tabwidget.py
