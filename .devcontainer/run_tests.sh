#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_photos/usePhotosRecovery.test.ts 2>/dev/null || true" EXIT
git checkout 428cd033fede5fd6ae9dbc7ab634e010b10e4209 -- applications/drive/src/app/store/_photos/usePhotosRecovery.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/store/_photos/usePhotosRecovery.test.ts,src/app/store/_photos/usePhotosRecovery.test.ts
