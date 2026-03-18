#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- test/units/module_utils/basic/test_platform_distribution.py test/units/module_utils/common/test_sys_info.py test/units/modules/test_service.py 2>/dev/null || true" EXIT
git checkout 9a21e247786ebd294dafafca1105fcd770ff46c6 -- test/units/module_utils/basic/test_platform_distribution.py test/units/module_utils/common/test_sys_info.py test/units/modules/test_service.py

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) test/units/module_utils/common/test_sys_info.py::test_get_distribution_not_linux[SunOS-Solaris],test/units/module_utils/common/test_sys_info.py::test_get_distribution_not_linux[Darwin-Darwin],test/units/module_utils/common/test_sys_info.py::test_get_distribution_version_not_linux[SunOS-11.4],test/units/module_utils/common/test_sys_info.py::test_get_distribution_version_not_linux[Darwin-19.6.0],test/units/module_utils/common/test_sys_info.py::test_get_distribution_not_linux[FreeBSD-Freebsd],test/units/module_utils/common/test_sys_info.py::test_get_distribution_version_not_linux[FreeBSD-12.1]
