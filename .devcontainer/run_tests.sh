#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/cue/validate_fuzz_test.go internal/cue/validate_test.go internal/storage/fs/snapshot_test.go 2>/dev/null || true" EXIT
git checkout e594593dae52badf80ffd27878d2275c7f0b20e9 -- internal/cue/validate_fuzz_test.go internal/cue/validate_test.go internal/storage/fs/snapshot_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestValidate_Extended,TestSnapshotFromFS_Invalid
