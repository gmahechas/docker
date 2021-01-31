# List, create, update, and delete key/value secrets

path "kv/data/+/dev/*"

{

  capabilities = ["create", "read", "update", "delete", "list"]

}


