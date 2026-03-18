#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/config/config_test.go internal/oci/ecr/ecr_test.go internal/oci/options_test.go 2>/dev/null || true" EXIT
git checkout c188284ff0c094a4ee281afebebd849555ebee59 -- internal/config/config_test.go internal/oci/ecr/ecr_test.go internal/oci/options_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCredentialFunc,TestWithCredentials,TestStore_Fetch,TestECRCredential,TestScheme,TestLogEncoding,TestCacheBackend,TestTracingExporter,TestParseReference,TestDefaultDatabaseRoot,TestFile,TestMarshalYAML,Test_mustBindEnv,TestAnalyticsClickhouseConfiguration,TestStore_List,TestServeHTTP,TestJSONSchema,TestLoad,TestStore_Fetch_InvalidMediaType,TestWithManifestVersion,TestDatabaseProtocol,TestStore_Build,TestAuthenicationTypeIsValid,TestStore_Copy
