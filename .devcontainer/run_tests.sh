#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/ext/exporter_test.go 2>/dev/null || true" EXIT
git checkout b3cd920bbb25e01fdb2dab66a5a913363bc62f6c -- internal/ext/exporter_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestImport,TestImport_Namespaces_Mix_And_Match,TestExport,TestImport_InvalidVersion,TestImport_Export,TestImport_FlagType_LTVersion1_1,FuzzImport,TestImport_Rollouts_LTVersion1_1
