#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/utils/lastActivePersistedUserSession.test.ts 2>/dev/null || true" EXIT
git checkout 3f22e2172cbdfd7b9abb2b1d8fd80c16d38b4bbe -- applications/drive/src/app/utils/lastActivePersistedUserSession.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/utils/lastActivePersistedUserSession.test.ts,src/app/utils/lastActivePersistedUserSession.test.ts
