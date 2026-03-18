#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- log/log_test.go 2>/dev/null || true" EXIT
git checkout f78257235ec3429ef42af6687738cd327ec77ce8 -- log/log_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLevelThreshold,TestInvalidRegex,TestLevelThreshold/errorLogLevel,TestEntryDataValues/map_value,TestEntryMessage,TestLevels/undefinedAcceptedLevels,TestEntryDataValues/match_on_key,TestLevels,TestEntryDataValues,TestEntryDataValues/string_value,TestLevels/definedAcceptedLevels,TestLog,TestLevelThreshold/unknownLogLevel
