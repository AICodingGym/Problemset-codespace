#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2023-01-13 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

# Common Setup, DO NOT MODIFY
set -e

# COMPLETE THE FOLLOWING SECTIONS
# PROJECT DEPENDENCIES AND CONFIGURATION
# TODO: Install project dependencies if needed based on relevant config/lock files in the repo.
# Note that we are developing the project, even if dependencies have been installed before, we need to install again to accommodate the changes we made.
# <dependency-installation-commands>
# TODO: Configure project and environment variables
# <config-commands>

# BUILD
echo "================= 0909 BUILD START 0909 ================="
# TODO: Build the project if needed. Note that we are developing the project and making changes to it, even if it has been build before, we need to build it again.
# Install development tools
make setup
# Build the project to verify the installation
make build
echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
