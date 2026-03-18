#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2023-05-02 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

echo "Installing Python dependencies..."
python -m pip install --upgrade pip wheel
python -m pip install --default-timeout=100 -r requirements.txt
python -m pip install --default-timeout=100 -r requirements_test.txt

echo "Installing Node.js dependencies..."
npm ci --no-audit

echo "Setting up git submodules and building assets..."
rm -f infogami
ln -s vendor/infogami/infogami infogami
make git

echo "================= 0909 BUILD START 0909 ================="
make
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
