#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/DecryptionFailureTracker-test.js 2>/dev/null || true" EXIT
git checkout 582a1b093fc0b77538052f45cbb9c7295f991b51 -- test/DecryptionFailureTracker-test.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/DecryptionFailureTracker-test.js
