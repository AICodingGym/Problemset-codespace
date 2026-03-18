#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/utils/parse/parse_test.go 2>/dev/null || true" EXIT
git checkout bb69574e02bd62e5ccd3cebb25e1c992641afb2a -- lib/utils/parse/parse_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestRoleVariable/no_curly_bracket_prefix,TestRoleVariable/invalid_dot_syntax,TestInterpolate/error_in_mapping_traits,TestInterpolate/mapped_traits_with_email.local,TestRoleVariable,TestInterpolate,TestRoleVariable/empty_variable,TestRoleVariable/variable_with_local_function,TestRoleVariable/invalid_syntax,TestRoleVariable/string_literal,TestInterpolate/missed_traits,TestRoleVariable/internal_with_no_brackets,TestRoleVariable/no_curly_bracket_suffix,TestRoleVariable/variable_with_prefix_and_suffix,TestRoleVariable/valid_with_brackets,TestInterpolate/mapped_traits,TestInterpolate/traits_with_prefix_and_suffix,TestRoleVariable/internal_with_spaces_removed,TestRoleVariable/external_with_no_brackets,TestInterpolate/literal_expression,TestRoleVariable/invalid_variable_syntax,TestRoleVariable/too_many_levels_of_nesting_in_the_variable
