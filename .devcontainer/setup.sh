#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2020-12-15 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

# Common Setup, DO NOT MODIFY
set -e

# PROJECT DEPENDENCIES AND CONFIGURATION
# Install Go module dependencies from the go.mod/go.sum files.
# Even if dependencies are pre-installed, reinstall to reflect recent changes.
go mod download

# Configure any necessary environment variables for the build.
# Example:
# export YOUR_ENV_VARIABLE=value
# For this project, no specific environment variables are needed.

# BUILD
echo "================= BUILD START ================="
# Build the Go project.
# go build -v ./...
echo "================= BUILD END ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
