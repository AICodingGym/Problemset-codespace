#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_devices/useDevicesListing.test.tsx 2>/dev/null || true" EXIT
git checkout cba6ebbd0707caa524ffee51c62b197f6122c902 -- applications/drive/src/app/store/_devices/useDevicesListing.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/store/_devices/useDevicesListing.test.tsx,src/app/store/_devices/useDevicesListing.test.ts
