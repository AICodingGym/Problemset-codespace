#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2025-08-26 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install "setuptools<69" || true
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

echo "Installing Python dependencies..."
pip3 install --upgrade pip setuptools==59.6.0 wheel

pip3 install "jaraco.functools>=1.20"

pip3 install -r requirements.txt

pip3 install -r misc/requirements/requirements-pyqt-5.15.txt

pip3 install -r misc/requirements/requirements-tests.txt

pip3 install tox

pip3 install --force-reinstall "urllib3>=1.21.1,<1.26" "chardet>=3.0.2,<4" "requests>=2.20.0,<3.0.0"

export PYTEST_QT_API=pyqt5
export QT_QPA_PLATFORM=offscreen
export DISPLAY=:99

echo "================= 0909 BUILD START 0909 ================="
pip3 install -e .
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
