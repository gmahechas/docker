#!/bin/bash

# secrets
vault secrets enable -version=2 -description=kv kv

echo "creating secrets"
# postgres
vault kv put kv/databases/postgres password=postgres


# policies
echo "creating policies"
vault policy write postgres postgres.hcl

# approle
vault auth enable approle

echo "enable approle for postgres"
vault write auth/approle/role/postgres policies=postgres
vault read auth/approle/role/postgres/role-id
vault write -f auth/approle/role/postgres/secret-id