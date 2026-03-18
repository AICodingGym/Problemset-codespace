#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- core/archiver_test.go core/ffmpeg/ffmpeg_test.go core/media_streamer_test.go tests/mock_ffmpeg.go 2>/dev/null || true" EXIT
git checkout 812dc2090f20ac4f8ac271b6ed95be5889d1a3ca -- core/archiver_test.go core/ffmpeg/ffmpeg_test.go core/media_streamer_test.go tests/mock_ffmpeg.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestCore,TestArtwork,TestFFmpeg
