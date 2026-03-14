#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/utils/lastActivePersistedUserSession.test.ts 2>/dev/null || true" EXIT
git checkout c8117f446c3d1d7e117adc6e0e46b0ece9b0b90e -- applications/drive/src/app/utils/lastActivePersistedUserSession.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/utils/lastActivePersistedUserSession.test.ts,src/app/utils/lastActivePersistedUserSession.test.ts
