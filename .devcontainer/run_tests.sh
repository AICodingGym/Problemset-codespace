#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/devicetrust/enroll/enroll_test.go lib/devicetrust/enroll/export_test.go 2>/dev/null || true" EXIT
git checkout 4e1c39639edf1ab494dd7562844c8b277b5cfa18 -- lib/devicetrust/enroll/enroll_test.go lib/devicetrust/enroll/export_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestRunCeremony,TestRunCeremony/macOS_device
