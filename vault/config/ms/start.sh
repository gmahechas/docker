#!/bin/bash

# secrets
vault secrets enable -version=2 -description=kv kv

echo "creating secrets"
# ms-0
vault kv put kv/erp/ms-0/development redis_url=redis://10.1.0.229
vault kv put kv/erp/ms-0/development publicKey=publicKey
vault kv put kv/erp/ms-0/development cookie_name=cerp
vault kv put kv/erp/ms-0/development cookie_secret=mySuperSecret

vault kv put kv/erp/ms-0/stage redis_url=redis://10.1.0.229
vault kv put kv/erp/ms-0/stage publicKey=publicKey
vault kv put kv/erp/ms-0/stage cookie_name=cerp
vault kv put kv/erp/ms-0/stage cookie_secret=mySuperSecret

vault kv put kv/erp/ms-0/production redis_url=redis://10.1.0.229
vault kv put kv/erp/ms-0/production publicKey=publicKey
vault kv put kv/erp/ms-0/production cookie_name=cerp
vault kv put kv/erp/ms-0/production cookie_secret=mySuperSecret

# ms-1
vault kv put kv/erp/ms-1/development mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_1?authSource=admin
vault kv put kv/erp/ms-1/development publicKey=publicKey
vault kv put kv/erp/ms-1/development privateKey=privateKey

vault kv put kv/erp/ms-1/stage mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_1?authSource=admin
vault kv put kv/erp/ms-1/stage publicKey=publicKey
vault kv put kv/erp/ms-1/stage privateKey=privateKey

vault kv put kv/erp/ms-1/production mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_1?authSource=admin
vault kv put kv/erp/ms-1/production publicKey=publicKey
vault kv put kv/erp/ms-1/production privateKey=privateKey

# ms-3
vault kv put kv/erp/ms-3/development mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_3?authSource=admin
vault kv put kv/erp/ms-3/development publicKey=publicKey

vault kv put kv/erp/ms-3/stage mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_3?authSource=admin
vault kv put kv/erp/ms-3/stage publicKey=publicKey

vault kv put kv/erp/ms-3/production mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_3?authSource=admin
vault kv put kv/erp/ms-3/production publicKey=publicKey

# ms-4
vault kv put kv/erp/ms-4/development mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_4?authSource=admin
vault kv put kv/erp/ms-4/development publicKey=publicKey

vault kv put kv/erp/ms-4/stage mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_4?authSource=admin
vault kv put kv/erp/ms-4/stage publicKey=publicKey

vault kv put kv/erp/ms-4/production mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_4?authSource=admin
vault kv put kv/erp/ms-4/production publicKey=publicKey

# policies
echo "creating policies"
vault policy write ms-0 ms-0.hcl
vault policy write ms-1 ms-1.hcl
vault policy write ms-3 ms-3.hcl
vault policy write ms-4 ms-4.hcl

# approle
vault auth enable approle

echo "enable approle for ms-0"
vault write auth/approle/role/ms-0 policies=ms-0
vault read auth/approle/role/ms-0/role-id
vault write -f auth/approle/role/ms-0/secret-id

echo "enable approle for ms-1"
vault write auth/approle/role/ms-1 policies=ms-1
vault read auth/approle/role/ms-1/role-id
vault write -f auth/approle/role/ms-1/secret-id

echo "enable approle for ms-3"
vault write auth/approle/role/ms-3 policies=ms-3
vault read auth/approle/role/ms-3/role-id
vault write -f auth/approle/role/ms-3/secret-id

echo "enable approle for ms-4"
vault write auth/approle/role/ms-4 policies=ms-4
vault read auth/approle/role/ms-4/role-id
vault write -f auth/approle/role/ms-4/secret-id