#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- server/evaluator_test.go 2>/dev/null || true" EXIT
git checkout cf06f4ebfab7fa21eed3e5838592e8e44566957f -- server/evaluator_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestEvaluate_FlagNoRules,TestEvaluate_FlagNotFound,TestBatchEvaluate_FlagNotFound,TestEvaluate_MatchAll_NoVariants_NoDistributions,TestEvaluate_MatchAll_RolloutDistribution,TestEvaluate_MatchAll_RolloutDistribution_MultiRule,TestEvaluate_MatchAny_NoVariants_NoDistributions,TestEvaluate_MatchAny_SingleVariantDistribution,Test_matchesBool,TestValidationUnaryInterceptor,TestEvaluate_MatchAll_NoConstraints,TestBatchEvaluate,TestEvaluate_RulesOutOfOrder,Test_matchesString,TestEvaluate_MatchAny_NoConstraints,TestEvaluate_MatchAny_RolloutDistribution_MultiRule,TestEvaluate_MatchAny_RolloutDistribution,TestEvaluate_FirstRolloutRuleIsZero,TestErrorUnaryInterceptor,TestEvaluate_MultipleZeroRolloutDistributions,Test_matchesNumber,TestEvaluate_FlagDisabled,TestEvaluate_MatchAll_SingleVariantDistribution,TestBatchEvaluate_FlagNotFoundExcluded
