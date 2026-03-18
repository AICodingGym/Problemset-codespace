#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2023-05-28 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

pip install --upgrade pip setuptools wheel
pip install -r requirements.txt
pip install -r misc/requirements/requirements-tests.txt

pip install PyQt6 PyQt6-WebEngine

export QT_QPA_PLATFORM=offscreen
export DISPLAY=:99
export PYTEST_QT_API=pyqt6
export QUTE_QT_WRAPPER=PyQt6

echo "================= 0909 BUILD START 0909 ================="
pip install -e .
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
