#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/components/FileBrowser/hooks/useSelectionControls.test.ts 2>/dev/null || true" EXIT
git checkout 8afd9ce04c8dde9e150e1c2b50d32e7ee2efa3e7 -- applications/drive/src/app/components/FileBrowser/hooks/useSelectionControls.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/components/FileBrowser/hooks/useSelectionControls.test.ts,applications/drive/src/app/components/FileBrowser/hooks/useSelectionControls.test.ts
