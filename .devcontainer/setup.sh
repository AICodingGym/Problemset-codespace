#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=django__django-15104
export REPO=django/django
export VERSION=4.1
export BASE_COMMIT=a7e7043c8746933dafce652507d3b821801cdc7d
export ENV_SETUP_COMMIT=647480166bfe7532e8c471fef0146e3a17e6c0c9
export TEST_CMD='./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1'
export TEST_FILES=tests/migrations/test_autodetector.py
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
  - ld_impl_linux-64=2.40=h12ee557_0
  - libffi=3.4.4=h6a678d5_1
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - ncurses=6.4=h6a678d5_0
  - openssl=3.0.15=h5eee18b_0
  - pip=24.2=py39h06a4308_0
  - python=3.9.20=he870216_1
  - readline=8.2=h5eee18b_0
  - setuptools=75.1.0=py39h06a4308_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - wheel=0.44.0=py39h06a4308_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - aiohappyeyeballs==2.4.3
      - aiohttp==3.10.9
      - aiosignal==1.3.1
      - aiosmtpd==1.4.6
      - argon2-cffi==23.1.0
      - argon2-cffi-bindings==21.2.0
      - asgiref==3.8.1
      - async-timeout==4.0.3
      - atpublic==5.0
      - attrs==24.2.0
      - bcrypt==4.2.0
      - black==24.10.0
      - certifi==2024.8.30
      - cffi==1.17.1
      - charset-normalizer==3.4.0
      - click==8.1.7
      - docutils==0.21.2
      - exceptiongroup==1.2.2
      - frozenlist==1.4.1
      - geoip2==4.8.0
      - h11==0.14.0
      - idna==3.10
      - jinja2==3.1.4
      - markupsafe==3.0.1
      - maxminddb==2.6.2
      - multidict==6.1.0
      - mypy-extensions==1.0.0
      - numpy==2.0.2
      - outcome==1.3.0.post0
      - packaging==24.1
      - pathspec==0.12.1
      - pillow==10.4.0
      - platformdirs==4.3.6
      - propcache==0.2.0
      - pycparser==2.22
      - pylibmc==1.6.3
      - pymemcache==4.0.0
      - pysocks==1.7.1
      - pytz==2024.2
      - pywatchman==2.0.0
      - pyyaml==6.0.2
      - redis==5.1.1
      - requests==2.32.3
      - selenium==4.25.0
      - sniffio==1.3.1
      - sortedcontainers==2.4.0
      - sqlparse==0.5.1
      - tblib==3.0.0
      - tomli==2.0.2
      - trio==0.26.2
      - trio-websocket==0.11.1
      - typing-extensions==4.12.2
      - tzdata==2024.2
      - urllib3==2.2.3
      - websocket-client==1.8.0
      - wsproto==1.2.0
      - yarl==1.14.0
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml

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
