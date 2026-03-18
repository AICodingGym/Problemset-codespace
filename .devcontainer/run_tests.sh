#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/subsonic/album_lists_test.go server/subsonic/media_annotation_test.go server/subsonic/media_retrieval_test.go 2>/dev/null || true" EXIT
git checkout 677d9947f302c9f7bba8c08c788c3dc99f235f39 -- server/subsonic/album_lists_test.go server/subsonic/media_annotation_test.go server/subsonic/media_retrieval_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApi
