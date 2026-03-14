#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/utils/replaceLocalURL.test.ts 2>/dev/null || true" EXIT
git checkout cb8cc309c6968b0a2a5fe4288d0ae0a969ff31e1 -- applications/drive/src/app/utils/replaceLocalURL.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/utils/replaceLocalURL.test.ts,src/app/utils/replaceLocalURL.test.ts
