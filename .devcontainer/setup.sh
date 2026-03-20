#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=matplotlib__matplotlib-13989
export REPO=matplotlib/matplotlib
export VERSION=3.0
export BASE_COMMIT=a3e2897bfaf9eaac1d6649da535c4e721c89fa69
export ENV_SETUP_COMMIT=d0628598f8d9ec7b0da6b60e7b29be2067b6ea17
export TEST_CMD='pytest -rA'
export TEST_FILES=lib/matplotlib/tests/test_axes.py
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
  - ca-certificates=2025.2.25=h06a4308_0
  - certifi=2022.12.7=py37h06a4308_0
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.4.4=h6a678d5_1
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - ncurses=6.4=h6a678d5_0
  - openssl=1.1.1w=h7f8727e_0
  - pip=22.3.1=py37h06a4308_0
  - python=3.7.16=h7a1cb2a_0
  - readline=8.2=h5eee18b_0
  - setuptools=65.6.3=py37h06a4308_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - wheel=0.38.4=py37h06a4308_0
  - xz=5.6.4=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - cachetools==5.5.2
      - chardet==5.2.0
      - charset-normalizer==3.4.1
      - codecov==2.1.13
      - colorama==0.4.6
      - coverage==7.2.7
      - cycler==0.11.0
      - distlib==0.3.9
      - exceptiongroup==1.2.2
      - execnet==2.0.2
      - filelock==3.12.2
      - idna==3.10
      - importlib-metadata==6.7.0
      - iniconfig==2.0.0
      - kiwisolver==1.4.5
      - numpy==1.21.6
      - packaging==24.0
      - pillow==9.5.0
      - platformdirs==4.0.0
      - pluggy==1.2.0
      - pyparsing==3.1.4
      - pyproject-api==1.5.3
      - pytest==7.4.4
      - pytest-cov==4.1.0
      - pytest-faulthandler==2.0.1
      - pytest-rerunfailures==13.0
      - pytest-timeout==2.3.1
      - pytest-xdist==3.5.0
      - python-dateutil==2.9.0.post0
      - requests==2.31.0
      - six==1.17.0
      - tomli==2.0.1
      - tornado==6.2
      - tox==4.8.0
      - typing-extensions==4.7.1
      - urllib3==2.0.7
      - virtualenv==20.26.6
      - zipp==3.15.0
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml
python -m pip install pytest

# Install repo
conda activate "$CONDA_ENV"
git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get install -y imagemagick ffmpeg libfreetype6-dev pkg-config
QHULL_URL="http://www.qhull.org/download/qhull-2020-src-8.0.2.tgz"
QHULL_TAR="/tmp/qhull-2020-src-8.0.2.tgz"
QHULL_BUILD_DIR="$REPO_ROOT/build"
wget -O "$QHULL_TAR" "$QHULL_URL"
mkdir -p "$QHULL_BUILD_DIR"
tar -xvzf "$QHULL_TAR" -C "$QHULL_BUILD_DIR"
python -m pip install -e .


# Install AI coding CLI tools
npm install -g @anthropic-ai/claude-code @openai/codex || true
pip install aicodinggym-cli || true

echo ""
echo "=== Environment ready! ==="
echo "Activate with:  conda activate $CONDA_ENV"
echo "Run tests with: bash .devcontainer/run_tests.sh"
