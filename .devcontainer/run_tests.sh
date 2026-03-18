#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/audit/logfile/logfile_test.go 2>/dev/null || true" EXIT
git checkout 72d06db14d58692bfb4d07b1aa745a37b35956f3 -- internal/server/audit/logfile/logfile_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestNewSink_ExistingFile,TestNewSink_Error,TestNewSink_NewFile,TestNewSink_DirNotExists,TestSink_SendAudits
