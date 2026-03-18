#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/components/views/elements/ExternalLink-test.tsx test/components/views/elements/__snapshots__/ExternalLink-test.tsx.snap 2>/dev/null || true" EXIT
git checkout 1216285ed2e82e62f8780b6702aa0f9abdda0b34 -- test/components/views/elements/ExternalLink-test.tsx test/components/views/elements/__snapshots__/ExternalLink-test.tsx.snap

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/views/elements/__snapshots__/ExternalLink-test.tsx.snap,test/components/views/elements/ExternalLink-test.tsx,test/components/views/elements/ExternalLink-test.ts
