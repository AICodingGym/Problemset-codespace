#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=pytest-dev__pytest-5787
export REPO=pytest-dev/pytest
export VERSION=5.1
export BASE_COMMIT=955e54221008aba577ecbaefa15679f6777d3bf8
export ENV_SETUP_COMMIT=c1361b48f83911aa721b21a4515a5446515642e2
export TEST_CMD='pytest -rA'
export TEST_FILES='testing/code/test_code.py testing/code/test_excinfo.py testing/conftest.py testing/test_reports.py'
export CONDA_ENV=testbed
export REPO_ROOT="$(pwd)"

source "$(conda info --base)/etc/profile.d/conda.sh" || { echo "ERROR: conda not found — run setup.sh first"; exit 1; }
conda activate "$CONDA_ENV" || { echo "ERROR: conda env $CONDA_ENV not found — run setup.sh first"; exit 1; }

echo "=== Running tests ==="
if echo "$TEST_CMD" | grep -q "runtests.py"; then
    # Django runtests.py requires dotted module names, not file paths
    MODULES=$(python3 -c 'import sys,re; print(" ".join(re.sub(r"\.py$","",re.sub(r"^tests/","",f)).replace("/",".") for f in sys.argv[1].split()))' "$TEST_FILES")
    $TEST_CMD $MODULES
else
    $TEST_CMD $TEST_FILES
fi
