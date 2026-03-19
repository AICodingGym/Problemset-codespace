#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- reporter/sbom/purl_test.go 2>/dev/null || true" EXIT
git checkout f6cc8c263dc00329786fa516049c60d4779c4a07 -- reporter/sbom/purl_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestParsePkgName/npm,TestParsePkgName/maven,TestParsePkgName/golang,TestParsePkgName/pypi,TestParsePkgName,TestParsePkgName/cocoapods
