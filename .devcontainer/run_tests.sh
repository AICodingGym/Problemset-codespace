#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_shares/useDefaultShare.test.tsx 2>/dev/null || true" EXIT
git checkout 6f8916fbadf1d1f4a26640f53b5cf7f55e8bedb7 -- applications/drive/src/app/store/_shares/useDefaultShare.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/store/_shares/useDefaultShare.test.tsx,src/app/store/_shares/useDefaultShare.test.ts
