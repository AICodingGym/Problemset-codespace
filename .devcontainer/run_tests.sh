#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- models/vulninfos_test.go 2>/dev/null || true" EXIT
git checkout a76302c11174ca081f656c63a000ffa746e350af -- models/vulninfos_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestVulnInfo_Cvss40Scores,TestVulnInfo_Cvss40Scores/happy
