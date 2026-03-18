#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2021-06-11 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

pip install -e .
pip install pytest pytest-xdist pytest-mock mock
pip install 'bcrypt ; python_version >= "3.10"'
pip install 'passlib ; python_version >= "3.10"'
pip install 'pexpect ; python_version >= "3.10"'
pip install 'pywinrm ; python_version >= "3.10"'

echo "================= 0909 BUILD START 0909 ================="
python -m pip install --upgrade pip setuptools wheel
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
