#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- detector/wordpress_test.go 2>/dev/null || true" EXIT
git checkout 50580f6e98eeb36f53f27222f7f4fdfea0b21e8d -- detector/wordpress_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) Test_convertToVinfos,Test_convertToVinfos/WordPress_vulnerabilities_Enterprise,Test_convertToVinfos/WordPress_vulnerabilities_Researcher
