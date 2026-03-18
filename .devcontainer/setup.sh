#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2023-05-15 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

# Common Setup, DO NOT MODIFY
set -e

# COMPLETE THE FOLLOWING SECTIONS
# PROJECT DEPENDENCIES AND CONFIGURATION
# Install Go dependencies
echo "Installing Go dependencies..."
go mod download

export CGO_ENABLED=1
export BUILDDIR=build
export OS=$(go env GOOS)
export ARCH=$(go env GOARCH)
export WEBASSETS_SKIP_BUILD=1

# BUILD
echo "================= BUILD START ================="
make -C /app build/teleport build/tctl build/tsh build/tbot
echo "================= BUILD END ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
