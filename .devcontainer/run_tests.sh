#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/Markdown-test.ts 2>/dev/null || true" EXIT
git checkout 18c03daa865d3c5b10e52b669cd50be34c67b2e5 -- test/Markdown-test.ts

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/components/structures/ThreadView-test.ts,test/UserActivity-test.ts,test/utils/beacon/timeline-test.ts,test/audio/VoiceRecording-test.ts,test/Markdown-test.ts,test/HtmlUtils-test.ts,test/components/structures/RightPanel-test.ts,test/utils/FixedRollingArray-test.ts
