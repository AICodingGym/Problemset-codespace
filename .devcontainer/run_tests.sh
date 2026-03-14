#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_shares/useShareActions.test.ts 2>/dev/null || true" EXIT
git checkout 2f2f6c311c6128fe86976950d3c0c2db07b03921 -- applications/drive/src/app/store/_shares/useShareActions.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/store/_shares/useShareActions.test.ts,src/app/store/_shares/useShareActions.test.ts
