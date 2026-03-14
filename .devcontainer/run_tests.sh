#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- packages/components/hooks/assistant/assistantUpsellConfig.test.ts 2>/dev/null || true" EXIT
git checkout 2c3559cad02d1090985dba7e8eb5a129144d9811 -- packages/components/hooks/assistant/assistantUpsellConfig.test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) packages/components/hooks/assistant/assistantUpsellConfig.test.ts,hooks/assistant/assistantUpsellConfig.test.ts
