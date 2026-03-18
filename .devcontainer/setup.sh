#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2021-09-07 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

pip install --upgrade pip wheel setuptools

pip install "jinja2==2.11.3" "MarkupSafe==1.1.1" PyYAML cryptography packaging

pip install pycrypto passlib pywinrm pytz pexpect

pip install mock pytest pytest-xdist

pip install argparse

pip install -e .

export PYTHONPATH=/app/lib:/app/test/lib:/app/test:$PYTHONPATH
export PATH=/app/bin:$PATH
export ANSIBLE_VERBOSITY=1

echo "================= 0909 BUILD START 0909 ================="
echo "Ansible installation completed successfully"
echo "Python path: $PYTHONPATH"
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
