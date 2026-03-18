#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- build/testing/integration/readonly/readonly_test.go internal/ext/importer_fuzz_test.go internal/ext/importer_test.go 2>/dev/null || true" EXIT
git checkout c6a7b1fd933e763b1675281b30077e161fa115a1 -- build/testing/integration/readonly/readonly_test.go internal/ext/importer_fuzz_test.go internal/ext/importer_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestImport_Namespaces,TestImport_Export,TestExport,TestImport_InvalidVersion,FuzzImport,TestImport
