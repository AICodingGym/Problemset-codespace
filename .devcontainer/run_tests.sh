#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/share_test.go server/subsonic/album_lists_test.go server/subsonic/media_annotation_test.go server/subsonic/media_retrieval_test.go server/subsonic/responses/responses_test.go tests/mock_persistence.go tests/mock_playlist_repo.go 2>/dev/null || true" EXIT
git checkout d0dceae0943b8df16e579c2d9437e11760a0626a -- core/share_test.go server/subsonic/album_lists_test.go server/subsonic/media_annotation_test.go server/subsonic/media_retrieval_test.go server/subsonic/responses/responses_test.go tests/mock_persistence.go tests/mock_playlist_repo.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestSubsonicApi,TestSubsonicApiResponses
