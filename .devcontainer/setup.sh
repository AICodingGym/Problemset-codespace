#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2024-10-03 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

pip install --upgrade pip "setuptools<67" wheel
pip install -r requirements_test.txt

pip install selenium webdriver-manager splinter

git config --global user.email "test@example.com"
git config --global user.name "Test User"

make git

make i18n

echo "================= 0909 BUILD START 0909 ================="
echo "Build completed - Python project with dependencies installed"
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
