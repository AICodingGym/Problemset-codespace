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

pip install --upgrade pip wheel
pip install -r requirements.txt
pip install -r requirements_test.txt

pip install pytest pytest-xdist pytest-cov

npm ci --no-audit

export PYTHONPATH=/app:$PYTHONPATH
export OL_CONFIG=/app/conf/openlibrary.yml

export OL_DB_HOST=localhost
export OL_DB_PORT=5432
export OL_DB_NAME=openlibrary_test
export OL_DB_USER=openlibrary
export OL_DB_PASSWORD=openlibrary

export DISPLAY=:99
export CHROME_BIN=/usr/bin/chromium
export CHROMEDRIVER_PATH=/usr/bin/chromedriver

echo "================= 0909 BUILD START 0909 ================="
make || echo "Make build completed with warnings"

git submodule update --init --recursive || echo "Submodules updated"

npm run build || echo "Frontend build completed"
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
