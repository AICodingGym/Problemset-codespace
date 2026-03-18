#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/backend/dynamo/dynamodbbk_test.go 2>/dev/null || true" EXIT
git checkout 2bb3bbbd8aff1164a2353381cb79e1dc93b90d28 -- lib/backend/dynamo/dynamodbbk_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCreateTable/read/write_capacity_units_are_ignored_if_on_demand_is_on,TestCreateTable/bad_parameter_when_the_incorrect_billing_mode_is_set,TestCreateTable/table_creation_succeeds,TestCreateTable/bad_parameter_when_provisioned_throughput_is_set,TestCreateTable,TestCreateTable/create_table_succeeds
