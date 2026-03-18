#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/netapp_eseries_drive_firmware/aliases test/integration/targets/netapp_eseries_drive_firmware/tasks/main.yml test/integration/targets/netapp_eseries_drive_firmware/tasks/run.yml test/units/modules/storage/netapp/test_netapp_e_drive_firmware.py 2>/dev/null || true" EXIT
git checkout f02a62db509dc7463fab642c9c3458b9bc3476cc -- test/integration/targets/netapp_eseries_drive_firmware/aliases test/integration/targets/netapp_eseries_drive_firmware/tasks/main.yml test/integration/targets/netapp_eseries_drive_firmware/tasks/run.yml test/units/modules/storage/netapp/test_netapp_e_drive_firmware.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/storage/netapp/test_netapp_e_drive_firmware.py
