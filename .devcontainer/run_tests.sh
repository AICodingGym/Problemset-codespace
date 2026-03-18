#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- log/formatters_test.go 2>/dev/null || true" EXIT
git checkout 9c3b4561652a15846993d477003e111f0df0c585 -- log/formatters_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestLevelThreshold/errorLogLevel,TestEntryMessage,TestLevelThreshold,TestLevels,TestEntryDataValues,TestLevels/undefinedAcceptedLevels,TestLevelThreshold/unknownLogLevel,TestEntryDataValues/map_value,TestLevels/definedAcceptedLevels,TestInvalidRegex,TestEntryDataValues/match_on_key,TestEntryDataValues/string_value,TestLog
