#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/ansible-doc/fakecollrole.output test/integration/targets/ansible-doc/fakemodule.output test/integration/targets/ansible-doc/fakerole.output test/integration/targets/ansible-doc/noop.output test/integration/targets/ansible-doc/noop_vars_plugin.output test/integration/targets/ansible-doc/notjsonfile.output test/integration/targets/ansible-doc/randommodule-text-verbose.output test/integration/targets/ansible-doc/randommodule-text.output test/integration/targets/ansible-doc/randommodule.output test/integration/targets/ansible-doc/runme.sh test/integration/targets/ansible-doc/test.yml test/integration/targets/ansible-doc/test_docs_returns.output test/integration/targets/ansible-doc/test_docs_suboptions.output test/integration/targets/ansible-doc/test_docs_yaml_anchors.output test/integration/targets/ansible-doc/yolo-text.output test/integration/targets/ansible-doc/yolo.output test/integration/targets/collections/runme.sh test/units/cli/test_doc.py 2>/dev/null || true" EXIT
git checkout bec27fb4c0a40c5f8bbcf26a475704227d65ee73 -- test/integration/targets/ansible-doc/fakecollrole.output test/integration/targets/ansible-doc/fakemodule.output test/integration/targets/ansible-doc/fakerole.output test/integration/targets/ansible-doc/noop.output test/integration/targets/ansible-doc/noop_vars_plugin.output test/integration/targets/ansible-doc/notjsonfile.output test/integration/targets/ansible-doc/randommodule-text-verbose.output test/integration/targets/ansible-doc/randommodule-text.output test/integration/targets/ansible-doc/randommodule.output test/integration/targets/ansible-doc/runme.sh test/integration/targets/ansible-doc/test.yml test/integration/targets/ansible-doc/test_docs_returns.output test/integration/targets/ansible-doc/test_docs_suboptions.output test/integration/targets/ansible-doc/test_docs_yaml_anchors.output test/integration/targets/ansible-doc/yolo-text.output test/integration/targets/ansible-doc/yolo.output test/integration/targets/collections/runme.sh test/units/cli/test_doc.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/cli/test_doc.py
