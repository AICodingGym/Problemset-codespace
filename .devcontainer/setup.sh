#!/bin/bash
set -e

# Ensure /app resolves to workspace root (run_script.sh uses /app paths)
[ -e /app ] || ln -sf "$(pwd)" /app

echo "=== Installing project dependencies ==="
pip install setuptools || true
pip install pypi-timemachine
pypi-timemachine 2025-08-26 --port 9876 &
pip config set global.index-url http://127.0.0.1:9876/
sleep 3
pip install pytest-rerunfailures
export PYTEST_ADDOPTS="--tb=short -v --continue-on-collection-errors --reruns=3"

set -e

python -m pip install --default-timeout=100 -r requirements.txt
python -m pip install "setuptools<67" || true
pip install -r requirements_test.txt
python -m pip install selenium webdriver-manager splinter

ln -sf vendor/infogami/infogami infogami

export PYTHONPATH=/app
export OL_CONFIG=/app/conf/openlibrary.yml

echo "================= 0909 BUILD START 0909 ================="

echo "Skipping Node.js dependencies to focus on Python testing..."

make git 2>/dev/null || echo "make git failed, continuing..."

echo "Applying YAML loader fix for integration tests..."
sed -i 's/yaml\.load(f)/yaml.load(f, Loader=yaml.FullLoader)/g' tests/integration/__init__.py 2>/dev/null || echo "YAML fix not needed"

echo "Configuring WebDriver for headless Docker environment..."
cat > /tmp/webdriver_fix.py << 'EOF'
import re
import os

integration_init = 'tests/integration/__init__.py'
if os.path.exists(integration_init):
    with open(integration_init, 'r') as f:
        content = f.read()

    if 'from selenium.webdriver.chrome.options import Options' not in content:
        content = content.replace('from selenium import webdriver', 
            'from selenium import webdriver\nfrom selenium.webdriver.chrome.options import Options\nfrom selenium.webdriver.firefox.options import Options as FirefoxOptions')

    old_webdriver_block = '''        try:
            self.driver = webdriver.Chrome()
        except:
            self.driver = webdriver.Firefox()'''

    new_webdriver_block = '''        try:
            chrome_options = Options()
            chrome_options.add_argument('--headless')
            chrome_options.add_argument('--no-sandbox')
            chrome_options.add_argument('--disable-dev-shm-usage')
            chrome_options.add_argument('--disable-gpu')
            chrome_options.add_argument('--remote-debugging-port=9222')
            chrome_options.add_argument('--user-data-dir=/tmp/chrome-user-data')
            self.driver = webdriver.Chrome(options=chrome_options)
        except:
            firefox_options = FirefoxOptions()
            firefox_options.add_argument('--headless')
            self.driver = webdriver.Firefox(options=firefox_options)'''

    content = content.replace(old_webdriver_block, new_webdriver_block)

    with open(integration_init, 'w') as f:
        f.write(content)
EOF

python /tmp/webdriver_fix.py

echo "Skipping CSS/JS builds that require Node.js dependencies..."

echo "================= 0909 BUILD END 0909 ================="

echo ""
echo "=== Environment ready! ==="
echo "Run tests : bash .devcontainer/run_tests.sh"
