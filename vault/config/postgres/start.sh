#!/bin/sh

# secrets
echo "###### enabling secrets ######"
vault secrets enable -version=2 -description=kv kv

echo "###### creating secrets ######"
# postgres
vault kv put kv/databases/postgres password=postgres


# policies
echo "###### creating policies ######"
vault policy write postgres postgres.hcl

# approle
echo "###### enabling approle auth ######"
vault auth enable approle

echo "###### creating approle for postgres ######"
vault write auth/approle/role/postgres policies=postgres
vault read auth/approle/role/postgres/role-id
vault write -f auth/approle/role/postgres/secret-id

# userpass
echo "###### enabling userpass auth ######"
vault auth enable userpass

echo "###### creating userpass for consul ######"
vault write auth/userpass/users/consul password=consul policies=postgres
vault list auth/userpass/users
vault read auth/userpass/users/consul