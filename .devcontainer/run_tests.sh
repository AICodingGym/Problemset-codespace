#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/storage/fs/git/source_test.go internal/storage/fs/local/source_test.go internal/storage/fs/oci/source_test.go internal/storage/fs/s3/source_test.go internal/storage/fs/store_test.go 2>/dev/null || true" EXIT
git checkout e5fe37c379e1eec2dd3492c5737c0be761050b26 -- internal/storage/fs/git/source_test.go internal/storage/fs/local/source_test.go internal/storage/fs/oci/source_test.go internal/storage/fs/s3/source_test.go internal/storage/fs/store_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCountNamespaces,TestFS_Invalid_VariantFlag_Distribution,Test_SourceSubscribe,TestGetEvaluationRollouts,TestFS_Invalid_BooleanFlag_Segment,TestListRollouts,TestListNamespaces,TestFS_YAML_Stream,Test_SourceGet,Test_SourceString,TestListFlags,TestCountSegments,TestCountFlags,TestListRules,TestFSWithIndex,TestCountRules,TestCountRollouts,TestFS_Empty_Features_File,TestGetEvaluationDistributions,TestFS_Invalid_VariantFlag_Segment,TestListSegments,TestFSWithoutIndex,Test_Store
