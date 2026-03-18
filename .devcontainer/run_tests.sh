#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/storage/fs/cache_test.go 2>/dev/null || true" EXIT
git checkout aebaecd026f752b187f11328b0d464761b15d2ab -- internal/storage/fs/cache_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCountFlags,TestListRollouts,TestFS_Empty_Features_File,TestListSegments,TestCountSegments,TestSnapshotFromFS_Invalid,TestListRules,TestGetVersion,TestParseFliptIndexParsingError,Test_SnapshotCache_Delete,TestFSWithoutIndex,TestCountNamespaces,TestFSWithIndex,TestWalkDocuments,TestCountRollouts,Test_SnapshotCache_Concurrently,TestListNamespaces,TestCountRules,Test_SnapshotCache,TestParseFliptIndex,TestFS_YAML_Stream
