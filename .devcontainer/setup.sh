#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=sympy__sympy-14976
export REPO=sympy/sympy
export VERSION=1.2
export BASE_COMMIT=9cbea134220b0b951587e11b63e2c832c7246cbc
export ENV_SETUP_COMMIT=e53e809176de9aa0fb62e85689f8cdb669d4cacb
export TEST_CMD='PYTHONWARNINGS='"'"'ignore::UserWarning,ignore::SyntaxWarning'"'"' bin/test -C --verbose'
export TEST_FILES='sympy/printing/tests/test_pycode.py sympy/solvers/tests/test_numeric.py'
export CONDA_ENV=testbed
export REPO_ROOT="$(pwd)"

source "$(conda info --base)/etc/profile.d/conda.sh"

# Git safe directory
git config --global --add safe.directory "$REPO_ROOT"

# Create conda environment and install dependencies
cat <<'ENV_EOF' > /tmp/environment.yml
name: testbed
channels:
  - defaults
  - conda-forge
dependencies:
  - _libgcc_mutex=0.1=main
  - _openmp_mutex=5.1=1_gnu
  - ca-certificates=2024.9.24=h06a4308_0
  - flake8=7.1.1=py39h06a4308_0
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.4.4=h6a678d5_1
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - mccabe=0.7.0=pyhd3eb1b0_0
  - mpmath=1.3.0=py39h06a4308_0
  - ncurses=6.4=h6a678d5_0
  - openssl=3.0.15=h5eee18b_0
  - pip=24.2=py39h06a4308_0
  - pycodestyle=2.12.1=py39h06a4308_0
  - pyflakes=3.2.0=py39h06a4308_0
  - python=3.9.20=he870216_1
  - readline=8.2=h5eee18b_0
  - setuptools=75.1.0=py39h06a4308_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - tzdata=2024b=h04d1e81_0
  - wheel=0.44.0=py39h06a4308_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - flake8-comprehensions==3.15.0
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml
python -m pip install mpmath==1.3.0 flake8-comprehensions

# Install repo
conda activate "$CONDA_ENV"
git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
python -m pip install -e .


# Install AI coding CLI tools
npm install -g @anthropic-ai/claude-code @openai/codex || true
pip install aicodinggym-cli || true

echo ""
echo "=== Environment ready! ==="
echo "Activate with:  conda activate $CONDA_ENV"
echo "Run tests with: bash .devcontainer/run_tests.sh"
