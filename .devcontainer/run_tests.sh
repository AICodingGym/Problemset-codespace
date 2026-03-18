#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/artwork/artwork_internal_test.go core/artwork/artwork_test.go server/subsonic/media_retrieval_test.go 2>/dev/null || true" EXIT
git checkout d8e794317f788198227e10fb667e10496b3eb99a -- core/artwork/artwork_internal_test.go core/artwork/artwork_test.go server/subsonic/media_retrieval_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestArtwork,TestSubsonicApi
