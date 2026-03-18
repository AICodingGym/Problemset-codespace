#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/cue/validate_fuzz_test.go internal/cue/validate_test.go internal/storage/fs/snapshot_test.go 2>/dev/null || true" EXIT
git checkout c8d71ad7ea98d97546f01cce4ccb451dbcf37d3b -- internal/cue/validate_fuzz_test.go internal/cue/validate_test.go internal/storage/fs/snapshot_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) FuzzValidate,TestFSWithIndex,TestFS_Invalid_VariantFlag_Distribution,TestFSWithoutIndex,TestValidate_Failure,TestFS_Invalid_VariantFlag_Segment,Test_Store,TestFS_Invalid_BooleanFlag_Segment,TestValidate_Latest_Segments_V2,TestValidate_V1_Success,TestValidate_Latest_Success
