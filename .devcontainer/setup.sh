#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2020-05-27 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

echo "Installing pip and upgrading setuptools..."
pip install -U pip setuptools wheel

echo "Installing Ansible core dependencies..."
pip install -r requirements.txt

echo "Installing Ansible test dependencies..."
pip install -r test/lib/ansible_test/_data/requirements/units.txt
pip install -r test/units/requirements.txt

echo "Installing pytest and additional dependencies..."
pip install pytest pytest-xdist pytest-mock mock cryptography jinja2 PyYAML
pip install pytest-forked pytest-cov

echo "Setting up ansible-test..."
chmod +x /app/bin/ansible-test

export PYTHONPATH=/app:$PYTHONPATH
export PATH=/app/bin:$PATH

echo "================= 0909 BUILD START 0909 ================="
echo "Setting up Ansible for development..."
python setup.py develop

echo "Verifying Ansible installation..."
ansible --version

echo "Verifying pytest installation..."
python -m pytest --version

echo "Verifying ansible-test..."
ls -la /app/bin/ansible-test
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
