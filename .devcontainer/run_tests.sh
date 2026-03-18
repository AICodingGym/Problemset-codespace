#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/events/emitter_test.go 2>/dev/null || true" EXIT
git checkout ac2fb2f9b4fd1896b554d3011df23d3d71295779 -- lib/events/emitter_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestWriterEmitter,TestAuditWriter/ResumeStart,TestProtoStreamer/small_load_test_with_some_uneven_numbers,TestAuditWriter/ResumeMiddle,TestProtoStreamer/no_events,TestProtoStreamer,TestAuditLog,TestProtoStreamer/5MB_similar_to_S3_min_size_in_bytes,TestAuditWriter/Session,TestProtoStreamer/one_event_using_the_whole_part,TestProtoStreamer/get_a_part_per_message,TestAuditWriter
