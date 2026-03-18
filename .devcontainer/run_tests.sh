#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/integration/targets/iptables/aliases test/integration/targets/iptables/tasks/chain_management.yml test/integration/targets/iptables/tasks/main.yml test/integration/targets/iptables/vars/alpine.yml test/integration/targets/iptables/vars/centos.yml test/integration/targets/iptables/vars/default.yml test/integration/targets/iptables/vars/fedora.yml test/integration/targets/iptables/vars/redhat.yml test/integration/targets/iptables/vars/suse.yml test/units/modules/test_iptables.py 2>/dev/null || true" EXIT
git checkout 3889ddeb4b780ab4bac9ca2e75f8c1991bcabe83 -- test/integration/targets/iptables/aliases test/integration/targets/iptables/tasks/chain_management.yml test/integration/targets/iptables/tasks/main.yml test/integration/targets/iptables/vars/alpine.yml test/integration/targets/iptables/vars/centos.yml test/integration/targets/iptables/vars/default.yml test/integration/targets/iptables/vars/fedora.yml test/integration/targets/iptables/vars/redhat.yml test/integration/targets/iptables/vars/suse.yml test/units/modules/test_iptables.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/modules/test_iptables.py
