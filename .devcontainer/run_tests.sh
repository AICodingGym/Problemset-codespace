#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/client/desktop/DesktopDownloadManagerTest.ts test/client/nodemocker.ts 2>/dev/null || true" EXIT
git checkout 51818218c6ae33de00cbea3a4d30daac8c34142e -- test/client/desktop/DesktopDownloadManagerTest.ts test/client/nodemocker.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/client/desktop/DesktopDownloadManagerTest.ts,test/api/Suite.ts,test/client/nodemocker.ts
