#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- internal/server/authz/engine/bundle/engine_test.go internal/server/authz/engine/rego/engine_test.go internal/server/authz/middleware/grpc/middleware_test.go internal/server/namespace_test.go 2>/dev/null || true" EXIT
git checkout ea9a2663b176da329b3f574da2ce2a664fc5b4a1 -- internal/server/authz/engine/bundle/engine_test.go internal/server/authz/engine/rego/engine_test.go internal/server/authz/middleware/grpc/middleware_test.go internal/server/namespace_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestEngine_IsAuthMethod,TestUpdateRule,TestUpdateConstraint,TestListRollouts_PaginationPageToken,TestOrderRules,TestListSegments_PaginationOffset,TestDeleteSegment,TestBatchEvaluate_FlagNotFound,TestDeleteDistribution,TestAuthorizationRequiredInterceptor,TestListNamespaces_WithAuthz,TestCreateSegment,TestUpdateDistribution,TestDeleteRollout,TestDeleteNamespace_HasFlagsWithForce,TestDeleteNamespace,TestDeleteRule,TestBatchEvaluate_FlagNotFoundExcluded,TestBatchEvaluate,TestCreateRule_MultipleSegments,TestEngine_IsAllowed,TestListSegments_PaginationPageToken,TestCreateRollout,TestDeleteConstraint,TestListFlags_PaginationOffset,TestDeleteNamespace_NonExistent,TestListNamespaces_PaginationOffset,TestListRules_PaginationOffset,TestEngine_NewEngine,TestCreateDistribution,TestListRules_PaginationPageToken,TestDeleteNamespace_HasFlags,TestUpdateRollout,TestOrderRollouts,TestUpdateNamespace,TestDeleteNamespace_ProtectedWithForce,TestListFlags_PaginationPageToken,TestUpdateSegment,TestCreateRule,TestListNamespaces_PaginationPageToken,TestCreateNamespace,TestCreateConstraint,TestViewableNamespaces,TestBatchEvaluate_NamespaceMismatch,TestDeleteNamespace_Protected
