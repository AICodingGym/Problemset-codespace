#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_links/useLink.test.ts 2>/dev/null || true" EXIT
git checkout c5a2089ca2bfe9aa1d85a664b8ad87ef843a1c9c -- applications/drive/src/app/store/_links/useLink.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/store/_links/useLink.test.ts,src/app/store/_links/useLink.test.ts
