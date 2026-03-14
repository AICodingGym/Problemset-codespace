#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/links/useLinksListing.test.tsx 2>/dev/null || true" EXIT
git checkout 3a6790f480309130b5d6332dce6c9d5ccca13ee3 -- applications/drive/src/app/store/links/useLinksListing.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) applications/drive/src/app/store/links/useLinksListing.test.tsx,src/app/store/links/useLinksListing.test.ts
