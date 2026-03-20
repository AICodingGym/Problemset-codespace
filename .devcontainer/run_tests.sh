#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-8593
export REPO=sphinx-doc/sphinx
export VERSION=3.5
export BASE_COMMIT=07983a5a8704ad91ae855218ecbda1c8598200ca
export ENV_SETUP_COMMIT=4f8cb861e3b29186b38248fe81e4944fd987fcce
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES='tests/roots/test-ext-autodoc/target/private.py tests/test_ext_autodoc_private_members.py'
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
