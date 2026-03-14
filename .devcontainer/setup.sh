#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
##!/bin/sh
pip install setuptools || true
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

python -m pip --version && echo "✓ pip is available" || (echo "✗ pip not found" && exit 1)

echo "Installing project dependencies with yarn..."
yarn install

export NODE_ENV=test
export CI=true
export FORCE_COLOR=0

echo "Installing Playwright browsers..."
npx playwright install chromium firefox || echo "Playwright install failed, continuing..."

echo "================= 0909 BUILD START 0909 ================="
echo "Building all workspaces..."
yarn workspaces foreach --all run build || echo "Some builds may have failed, continuing..."
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
echo "Submit    : bash submit.sh"
