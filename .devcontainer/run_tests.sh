#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/ext/importer_fuzz_test.go internal/ext/importer_test.go internal/storage/sql/evaluation_test.go 2>/dev/null || true" EXIT
git checkout dae029cba7cdb98dfb1a6b416c00d324241e6063 -- internal/ext/importer_fuzz_test.go internal/ext/importer_test.go internal/storage/sql/evaluation_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestImport,TestImport_Export,TestImport_Namespaces_Mix_And_Match,TestOpen,TestJSONField_Scan,TestImport_FlagType_LTVersion1_1,TestParse,TestNullableTimestamp_Value,TestImport_Rollouts_LTVersion1_1,TestMigratorRun,TestTimestamp_Value,TestMigratorRun_NoChange,TestDBTestSuite,TestNullableTimestamp_Scan,TestAdaptedDriver,TestTimestamp_Scan,TestImport_InvalidVersion,TestJSONField_Value,Test_AdaptError,FuzzImport,TestMigratorExpectedVersions,TestAdaptedConnectorConnect,TestExport
