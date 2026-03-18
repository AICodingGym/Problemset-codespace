#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- config/tomlloader_test.go 2>/dev/null || true" EXIT
git checkout 9aa0d87a21bede91c2b45c32187456bb69455e92 -- config/tomlloader_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestMajorVersion,TestIsValidImage/no_image_name_with_digest,TestToCpeURI,TestIsValidImage/ok_with_tag,TestIsValidImage,TestIsValidImage/no_tag_and_digest,TestSyslogConfValidate,TestIsValidImage/no_image_name_with_tag,TestIsValidImage/ok_with_digest
