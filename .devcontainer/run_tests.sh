#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/sanity/ignore.txt test/units/executor/test_task_executor.py test/units/plugins/action/test_raw.py test/units/plugins/connection/test_psrp.py test/units/plugins/connection/test_ssh.py test/units/plugins/connection/test_winrm.py 2>/dev/null || true" EXIT
git checkout 8127abbc298cabf04aaa89a478fc5e5e3432a6fc -- test/sanity/ignore.txt test/units/executor/test_task_executor.py test/units/plugins/action/test_raw.py test/units/plugins/connection/test_psrp.py test/units/plugins/connection/test_ssh.py test/units/plugins/connection/test_winrm.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/plugins/connection/test_psrp.py,test/units/plugins/connection/test_ssh.py,test/units/plugins/connection/test_winrm.py,test/units/plugins/action/test_raw.py,test/units/executor/test_task_executor.py
