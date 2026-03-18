#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2022-06-07 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

echo "================= 0909 INSTALLING DEPENDENCIES 0909 ================="
yarn install --frozen-lockfile

export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
export PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

echo "================= 0909 BUILDING PROJECT 0909 ================="
yarn run build:compile

echo "================= 0909 BUILD START 0909 ================="
if [ ! -f src/component-index.js ]; then
    echo "Creating component-index.js file"
    echo "// Auto-generated component index for tests" > src/component-index.js
    echo "export const components = {};" >> src/component-index.js
fi

export NODE_ENV=test
export CI=true

echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
