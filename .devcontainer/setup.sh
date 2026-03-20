#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=pallets__flask-5014
export REPO=pallets/flask
export VERSION=2.3
export BASE_COMMIT=7ee9ceb71e868944a46e1ff00b506772a53a4f1d
export ENV_SETUP_COMMIT=182ce3dd15dfa3537391c3efaf9c3ff407d134d4
export TEST_CMD='pytest -rA'
export TEST_FILES=tests/test_blueprints.py
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
  - bzip2=1.0.8=h5eee18b_6
  - ca-certificates=2024.9.24=h06a4308_0
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.4.4=h6a678d5_1
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - libuuid=1.41.5=h5eee18b_0
  - ncurses=6.4=h6a678d5_0
  - openssl=3.0.15=h5eee18b_0
  - pip=24.2=py311h06a4308_0
  - python=3.11.10=he870216_0
  - readline=8.2=h5eee18b_0
  - setuptools=75.1.0=py311h06a4308_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - tzdata=2024b=h04d1e81_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - alabaster==0.7.13
      - asgiref==3.6.0
      - babel==2.12.1
      - build==0.10.0
      - cachetools==5.3.0
      - certifi==2022.12.7
      - cffi==1.15.1
      - cfgv==3.3.1
      - chardet==5.1.0
      - charset-normalizer==3.1.0
      - click==8.1.3
      - colorama==0.4.6
      - cryptography==40.0.1
      - distlib==0.3.6
      - docutils==0.17.1
      - filelock==3.11.0
      - identify==2.5.22
      - idna==3.4
      - imagesize==1.4.1
      - iniconfig==2.0.0
      - itsdangerous==2.1.2
      - jinja2==3.1.2
      - markupsafe==2.1.1
      - mypy==1.2.0
      - mypy-extensions==1.0.0
      - nodeenv==1.7.0
      - packaging==23.0
      - pallets-sphinx-themes==2.0.3
      - pip-compile-multi==2.6.2
      - pip-tools==6.13.0
      - platformdirs==3.2.0
      - pluggy==1.0.0
      - pre-commit==3.2.2
      - pycparser==2.21
      - pygments==2.15.0
      - pyproject-api==1.5.1
      - pyproject-hooks==1.0.0
      - pytest==7.3.0
      - python-dotenv==1.0.0
      - pyyaml==6.0
      - requests==2.28.2
      - snowballstemmer==2.2.0
      - sphinx==4.5.0
      - sphinx-issues==3.0.1
      - sphinx-tabs==3.3.1
      - sphinxcontrib-applehelp==1.0.4
      - sphinxcontrib-devhelp==1.0.2
      - sphinxcontrib-htmlhelp==2.0.1
      - sphinxcontrib-jsmath==1.0.1
      - sphinxcontrib-log-cabinet==1.0.1
      - sphinxcontrib-qthelp==1.0.3
      - sphinxcontrib-serializinghtml==1.1.5
      - toposort==1.10
      - tox==4.4.11
      - types-contextvars==2.4.7.2
      - types-dataclasses==0.6.6
      - types-setuptools==67.6.0.7
      - typing-extensions==4.5.0
      - urllib3==1.26.15
      - virtualenv==20.21.0
      - werkzeug==2.3.7
      - wheel==0.40.0
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml
python -m pip install setuptools==70.0.0 click==8.1.3 itsdangerous==2.1.2 Jinja2==3.1.2 MarkupSafe==2.1.1 Werkzeug==2.3.7

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
