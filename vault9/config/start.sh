#!/bin/bash

# secrets
vault secrets enable -version=2 -description=kv kv

echo "creating secrets"
vault kv put kv/erp/ms-0/development redis_url=redis://10.1.0.229
vault kv put kv/erp/ms-0/stage redis_url=redis://10.1.0.229
vault kv put kv/erp/ms-0/production redis_url=redis://10.1.0.229

vault kv put kv/erp/ms-1/development mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_1?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false
vault kv put kv/erp/ms-1/stage mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_1?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false
vault kv put kv/erp/ms-1/production mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_1?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false

vault kv put kv/erp/ms-3/development mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_3?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false
vault kv put kv/erp/ms-3/stage mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_3?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false
vault kv put kv/erp/ms-3/production mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_3?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false

vault kv put kv/erp/ms-4/development mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_4?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false
vault kv put kv/erp/ms-4/stage mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_4?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false
vault kv put kv/erp/ms-4/production mongo_uri=mongodb://root:root@10.1.0.229:27017/erp_ms_4?authSource=admin&w=majority&readPreference=primary&retryWrites=true&ssl=false

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