#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/utils/prompt/context_reader_test.go 2>/dev/null || true" EXIT
git checkout 0ecf31de0e98b272a6a2610abe1bbedd379a38a3 -- lib/utils/prompt/context_reader_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestNotifyExit_restoresTerminal,TestContextReader_ReadPassword,TestInput,TestContextReader
