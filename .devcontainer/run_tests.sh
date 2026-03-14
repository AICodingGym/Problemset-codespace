#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_links/extendedAttributes.test.ts 2>/dev/null || true" EXIT
git checkout 4feccbc9990980aee26ea29035f8f931d6089895 -- applications/drive/src/app/store/_links/extendedAttributes.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/store/_links/extendedAttributes.test.ts,applications/drive/src/app/store/_links/extendedAttributes.test.ts
