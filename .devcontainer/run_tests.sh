#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/agents/agents_test.go core/artwork/artwork_internal_test.go core/artwork/artwork_test.go tests/mock_mediafile_repo.go 2>/dev/null || true" EXIT
git checkout 69e0a266f48bae24a11312e9efbe495a337e4c84 -- core/agents/agents_test.go core/artwork/artwork_internal_test.go core/artwork/artwork_test.go tests/mock_mediafile_repo.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestArtwork
