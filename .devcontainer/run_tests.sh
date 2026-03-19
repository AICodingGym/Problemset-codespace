#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_uploads/mimeTypeParser/mimeTypeParser.test.ts 2>/dev/null || true" EXIT
git checkout 01b519cd49e6a24d9a05d2eb97f54e420740072e -- applications/drive/src/app/store/_uploads/mimeTypeParser/mimeTypeParser.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/store/_uploads/mimeTypeParser/mimeTypeParser.test.ts,src/app/store/_uploads/mimeTypeParser/mimeTypeParser.test.ts
