#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/audit/template/executer_test.go internal/server/audit/template/leveled_logger_test.go internal/server/audit/webhook/client_test.go 2>/dev/null || true" EXIT
git checkout 8bd3604dc54b681f1f0f7dd52cbc70b3024184b6 -- internal/server/audit/template/executer_test.go internal/server/audit/template/leveled_logger_test.go internal/server/audit/webhook/client_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestExecuter_JSON_Failure,TestExecuter_Execute,TestConstructorWebhookTemplate,TestWebhookClient,TestExecuter_Execute_toJson_valid_Json,TestLeveledLogger,TestConstructorWebhookClient
