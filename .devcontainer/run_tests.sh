#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-8638
export REPO=sphinx-doc/sphinx
export VERSION=4.0
export BASE_COMMIT=4b452338f914d4f6b54704222d70ae8a746e3db5
export ENV_SETUP_COMMIT=8939a75efaa911a12dbe6edccedf261e88bf7eef
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES=tests/test_domain_py.py
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
