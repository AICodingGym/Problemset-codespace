#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/ext/exporter_test.go internal/ext/importer_test.go 2>/dev/null || true" EXIT
git checkout e91615cf07966da41756017a7d571f9fc0fdbe80 -- internal/ext/exporter_test.go internal/ext/importer_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestImport,TestExport
