---
{{- with secret "database/creds/postgres_role" }}
username: "{{ .Data.username }}"
password: "{{ .Data.password }}"
database: "myapp"
{{- end }}
