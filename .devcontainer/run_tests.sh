#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/mail/src/app/hooks/useMoveSystemFolders.helpers.test.ts 2>/dev/null || true" EXIT
git checkout fc9d535e9beb3ae30a52a7146398cadfd6e30606 -- applications/mail/src/app/hooks/useMoveSystemFolders.helpers.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/mail/src/app/hooks/useMoveSystemFolders.helpers.test.ts,src/app/hooks/useMoveSystemFolders.helpers.test.ts
