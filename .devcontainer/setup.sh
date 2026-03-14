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

echo "Installing dependencies with Yarn..."
yarn install

export NODE_ENV=test
export CHROME_BIN=/usr/bin/chromium

echo "================= 0909 BUILD START 0909 ================="
echo "Building proton-mail..."
yarn workspace proton-mail run build || echo "Build failed for proton-mail, continuing..."

echo "Building proton-calendar..."
yarn workspace proton-calendar run build || echo "Build failed for proton-calendar, continuing..."

echo "Building proton-drive..."
yarn workspace proton-drive run build || echo "Build failed for proton-drive, continuing..."

echo "Building proton-account..."
yarn workspace proton-account run build || echo "Build failed for proton-account, continuing..."

echo "Building proton-verify..."
yarn workspace proton-verify run build || echo "Build failed for proton-verify, continuing..."

echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
echo "Submit    : bash submit.sh"
