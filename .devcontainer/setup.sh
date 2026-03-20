#!/bin/bash
set -e

# Environment variables from test_patch.yml
export INSTANCE_ID=django__django-10097
export REPO=django/django
export VERSION=2.2
export BASE_COMMIT=b9cf764be62e77b4777b3a75ec256f6209a57671
export ENV_SETUP_COMMIT=4fc35a9c3efdc9154efce28cb23cb84f8834517e
export TEST_CMD='./tests/runtests.py --verbosity 2 --settings=test_sqlite --parallel 1'
export TEST_FILES='tests/validators/invalid_urls.txt tests/validators/valid_urls.txt'
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
  - certifi=2020.6.20=pyhd3eb1b0_3
  - libffi=3.3=he6710b0_2
  - libgcc-ng=11.2.0=h1234567_1
  - libgomp=11.2.0=h1234567_1
  - libstdcxx-ng=11.2.0=h1234567_1
  - ncurses=6.4=h6a678d5_0
  - openssl=1.1.1w=h7f8727e_0
  - pip=10.0.1=py35_0
  - python=3.5.6=h12debd9_1
  - readline=8.2=h5eee18b_0
  - setuptools=40.2.0=py35_0
  - sqlite=3.45.3=h5eee18b_0
  - tk=8.6.14=h39e8969_0
  - wheel=0.37.1=pyhd3eb1b0_0
  - xz=5.4.6=h5eee18b_1
  - zlib=1.2.13=h5eee18b_1
  - pip:
      - argon2-cffi==21.1.0
      - bcrypt==3.1.7
      - cffi==1.15.1
      - chardet==4.0.0
      - docutils==0.18.1
      - geoip2==3.0.0
      - idna==2.10
      - jinja2==2.11.3
      - markupsafe==1.1.1
      - maxminddb==2.0.0
      - numpy==1.18.5
      - pillow==7.2.0
      - pycparser==2.21
      - pylibmc==1.6.1
      - python-memcached==1.62
      - pytz==2024.2
      - pywatchman==1.4.1
      - pyyaml==5.3.1
      - requests==2.25.1
      - selenium==3.141.0
      - six==1.16.0
      - sqlparse==0.4.4
      - tblib==1.7.0
      - urllib3==1.26.9
ENV_EOF
conda env create --file /tmp/environment.yml
conda activate "$CONDA_ENV"
rm /tmp/environment.yml
python -m pip install setuptools

# Install repo
conda activate "$CONDA_ENV"
git fetch --tags "https://github.com/$REPO.git" || true
TARGET_TIMESTAMP=$(git show -s --format=%ci "$BASE_COMMIT")
git tag -l | while read tag; do TAG_COMMIT=$(git rev-list -n 1 "$tag"); TAG_TIME=$(git show -s --format=%ci "$TAG_COMMIT"); if [[ "$TAG_TIME" > "$TARGET_TIMESTAMP" ]]; then git tag -d "$tag"; fi; done
sudo apt-get update && sudo apt-get install -y locales
sudo bash -c 'echo '"'"'en_US UTF-8'"'"' > /etc/locale.gen'
sudo locale-gen en_US.UTF-8
python setup.py install


# Install AI coding CLI tools
npm install -g @anthropic-ai/claude-code @openai/codex || true
pip install aicodinggym-cli || true

echo ""
echo "=== Environment ready! ==="
echo "Activate with:  conda activate $CONDA_ENV"
echo "Run tests with: bash .devcontainer/run_tests.sh"
