#!/bin/bash
set -e

# Ensure /app resolves to workspace root
[ -e /app ] || ln -sf "$(pwd)" /app

# Apply test files from gold patch (restored on exit)
trap "git checkout HEAD -- lib/srv/db/access_test.go lib/srv/db/ha_test.go 2>/dev/null || true" EXIT
git checkout 0ac7334939981cf85b9591ac295c3816954e287e -- lib/srv/db/access_test.go lib/srv/db/ha_test.go

echo "=== Running tests ==="
bash <(sed 's/\r//g' .swebench/run_script.sh) TestAccessMySQL/has_access_to_nothing,TestProxyProtocolPostgres,TestAccessPostgres/has_access_to_nothing,TestAuthTokens/correct_Postgres_Cloud_SQL_IAM_auth_token,TestAuthTokens/correct_Postgres_Redshift_IAM_auth_token,TestAccessPostgres,TestAuthTokens/incorrect_MySQL_RDS_IAM_auth_token,TestAccessMySQL/access_allowed_to_specific_user,TestHA,TestAuthTokens/incorrect_Postgres_Redshift_IAM_auth_token,TestAuditMySQL,TestAccessDisabled,TestAccessMySQL,TestAccessMySQL/has_access_to_all_database_users,TestAccessPostgres/access_allowed_to_specific_user/database,TestAuthTokens/incorrect_Postgres_RDS_IAM_auth_token,TestAuthTokens/correct_MySQL_RDS_IAM_auth_token,TestAccessPostgres/no_access_to_users,TestProxyClientDisconnectDueToIdleConnection,TestAuthTokens/incorrect_Postgres_Cloud_SQL_IAM_auth_token,TestDatabaseServerStart,TestProxyClientDisconnectDueToCertExpiration,TestAccessMySQL/access_denied_to_specific_user,TestAccessPostgres/has_access_to_all_database_names_and_users,TestAuthTokens,TestAccessPostgres/no_access_to_databases,TestAuditPostgres,TestAccessPostgres/access_denied_to_specific_user/database,TestProxyProtocolMySQL,TestAuthTokens/correct_Postgres_RDS_IAM_auth_token
