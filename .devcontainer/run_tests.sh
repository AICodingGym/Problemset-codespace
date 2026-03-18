#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- report/util_test.go 2>/dev/null || true" EXIT
git checkout 4c04acbd9ea5b073efe999e33381fa9f399d6f27 -- report/util_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestPlusDiff,TestIsCveInfoUpdated,TestMinusDiff,TestGetNotifyUsers,TestSyslogWriterEncodeSyslog,TestPlusMinusDiff,TestIsCveFixed
