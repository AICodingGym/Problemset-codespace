#!/bin/bash
set -euo pipefail

# Environment variables from test_patch.yml
export INSTANCE_ID=sphinx-doc__sphinx-7748
export REPO=sphinx-doc/sphinx
export VERSION=3.1
export BASE_COMMIT=9988d5ce267bf0df4791770b469431b1fb00dcdd
export ENV_SETUP_COMMIT=5afc77ee27fc01c57165ab260d3a76751f9ddb35
export TEST_CMD='tox --current-env -epy39 -v --'
export TEST_FILES='tests/roots/test-ext-autodoc/target/docstring_signature.py tests/test_ext_autodoc_configs.py'
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
