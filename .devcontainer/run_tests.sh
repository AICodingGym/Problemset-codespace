#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- applications/drive/src/app/store/links/useLinksListing.test.tsx 2>/dev/null || true" EXIT
git checkout 7b833df125859e5eb98a826e5b83efe0f93a347b -- applications/drive/src/app/store/links/useLinksListing.test.tsx

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) src/app/store/links/useLinksListing.test.ts,applications/drive/src/app/store/links/useLinksListing.test.tsx
