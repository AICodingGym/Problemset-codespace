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

python -m pip install --upgrade pip wheel
python -m pip install --default-timeout=100 -r requirements.txt
python -m pip install -r requirements_test.txt

python -m pip install selenium splinter

npm ci --no-audit

git submodule update --init --recursive

export PYTHONPATH=/app
export CHROME_BIN=/usr/bin/google-chrome
export CHROMEDRIVER_PATH=/usr/local/bin/chromedriver
export DISPLAY=:99

ln -sf vendor/infogami/infogami infogami

echo "================= 0909 BUILD START 0909 ================="
make git
make css js components i18n
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
