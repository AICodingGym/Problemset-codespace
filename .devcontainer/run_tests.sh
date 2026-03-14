#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/_downloads/DownloadProvider/useDownloadMetrics.test.ts 2>/dev/null || true" EXIT
git checkout b9387af4cdf79c2cb2a221dea33d665ef789512e -- applications/drive/src/app/store/_downloads/DownloadProvider/useDownloadMetrics.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/store/_downloads/DownloadProvider/useDownloadMetrics.test.ts,src/app/store/_downloads/DownloadProvider/useDownloadMetrics.test.ts
