#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-10673
export REPO=sphinx-doc/sphinx
export VERSION=5.2
export BASE_COMMIT=f35d2a6cc726f97d0e859ca7a0e1729f7da8a6c8
export ENV_SETUP_COMMIT=a651e6bf4ad7a1dc293525d0a70e6d0d11b827db
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES='tests/roots/test-toctree-index/conf.py tests/roots/test-toctree-index/foo.rst tests/roots/test-toctree-index/index.rst tests/test_environment_toctree.py'
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
