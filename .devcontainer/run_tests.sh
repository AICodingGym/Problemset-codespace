#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/config_test.go config/syslog/syslogconf_test.go reporter/syslog_test.go 2>/dev/null || true" EXIT
git checkout dc496468b9e9fb73371f9606cdcdb0f8e12e70ca -- config/config_test.go config/syslog/syslogconf_test.go reporter/syslog_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSyslogConfValidate
