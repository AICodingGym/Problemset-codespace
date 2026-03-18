#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/messaging.js test/user.js 2>/dev/null || true" EXIT
git checkout a5afad27e52fd336163063ba40dcadc80233ae10 -- test/messaging.js test/user.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/i18n.js,test/user.js,test/messaging.js
