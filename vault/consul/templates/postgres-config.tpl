{{ with secret "kv/data/databases/postgres" }}
export POSTGRES_PASSWORD='{{ .Data.data.password }}'
{{ end }}