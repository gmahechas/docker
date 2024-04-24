#!/bin/sh

# secrets
echo "###### enabling secrets ######"
vault secrets enable database

# postgres
echo "###### creating secrets ######"
vault write database/config/postgresql \
      plugin_name=postgresql-database-plugin \
      allowed_roles=readonly \
      connection_url="postgresql://{{username}}:{{password}}@10.1.0.228/myapp?sslmode=require" \
      username=root \
      password=root


vault write database/roles/readonly db_name=postgresql \
        creation_statements=@readonly.sql \
        default_ttl=1h max_ttl=24h
			
vault policy write database_credentials database_credentials.hcl # it should be for all database credentials
#vault policy write db_creds db_creds.hcl


# DB_TOKEN=$(vault token create -policy="db_creds" -format json | jq -r '.auth | .client_token')
# vault token create -policy="db_creds" -format json