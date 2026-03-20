#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=pylint-dev__pylint-6528
export REPO=pylint-dev/pylint
export VERSION=2.14
export BASE_COMMIT=273a8b25620467c1e5686aa8d2a1dbb8c02c78d0
export ENV_SETUP_COMMIT=680edebc686cad664bbed934a490aeafa775f163
export TEST_CMD='pytest -rA'
export TEST_FILES='tests/lint/unittest_lint.py tests/regrtest_data/directory/ignored_subdirectory/failing.py tests/test_self.py'
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
