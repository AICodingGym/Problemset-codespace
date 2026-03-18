#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/mocks/databasemock.js test/socket.io.js test/user.js 2>/dev/null || true" EXIT
git checkout 00c70ce7b0541cfc94afe567921d7668cdc8f4ac -- test/mocks/databasemock.js test/socket.io.js test/user.js

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/mocks/databasemock.js,test/translator.js,test/user.js,test/socket.io.js,test/database.js,test/meta.js
