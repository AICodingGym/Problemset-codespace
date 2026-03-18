#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/database/keys.js test/user/emails.js 2>/dev/null || true" EXIT
git checkout 04998908ba6721d64eba79ae3b65a351dcfbc5b5 -- test/database/keys.js test/user/emails.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/database.js,test/database/keys.js,test/user/emails.js
