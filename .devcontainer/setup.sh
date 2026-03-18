#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2022-10-28 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

pip install -r requirements.txt
pip install -r requirements_test.txt

pip install selenium splinter

echo "Attempting npm install..."
npm install || (echo "npm install failed, trying with --ignore-scripts" && npm install --ignore-scripts) || echo "All npm install attempts failed, continuing without npm packages..."

export PYTHONPATH=/app:$PYTHONPATH
export OL_CONFIG=/app/conf/openlibrary.yml

git submodule init
git submodule sync  
git submodule update

cp /workspace/auth.yaml /app/auth.yaml || echo "auth.yaml not found, creating minimal version"
echo -e "username: test_user\npassword: test_password" > /app/auth.yaml

echo "================= 0909 BUILD START 0909 ================="

make css || echo "CSS build failed, continuing..."
make js || echo "JS build failed, continuing..."

echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
