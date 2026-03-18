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
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

git submodule init
git submodule sync
git submodule update

python -m pip install --upgrade pip "setuptools<67" wheel
python -m pip install --default-timeout=100 -r requirements.txt
python -m pip install -r requirements_test.txt

npm install --no-audit

ln -sf vendor/infogami/infogami infogami

echo "================= 0909 BUILD START 0909 ================="
make css
make js
make components
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
