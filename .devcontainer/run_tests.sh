#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- scanner/metadata/ffmpeg/ffmpeg_test.go scanner/metadata/metadata_test.go scanner/metadata/taglib/taglib_test.go 2>/dev/null || true" EXIT
git checkout e12a14a87d392ac70ee4cc8079e3c3e0103dbcb2 -- scanner/metadata/ffmpeg/ffmpeg_test.go scanner/metadata/metadata_test.go scanner/metadata/taglib/taglib_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestFFMpeg,TestMetadata,TestTagLib
