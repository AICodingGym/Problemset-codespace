#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2023-02-06 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

go mod download
go mod verify

export CGO_ENABLED=1
export PAM_TAG=pam
export FIPS_TAG=""
export BPF_TAG=""
export LIBFIDO2_TEST_TAG=""
export TOUCHID_TAG=""
export PIV_TEST_TAG=""
export VNETDAEMON_TAG=""

echo "================= BUILD START ================="
go build -v ./lib/... || echo "Lib build had issues, continuing..."
echo "================= BUILD END ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
