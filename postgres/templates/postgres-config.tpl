{{ with secret "databases/postgres" }}
export POSTGRES_PASSWORD='{{ .Data.data.password }}'
{{ end }}