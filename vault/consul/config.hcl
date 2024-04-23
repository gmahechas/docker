vault {
  address = "http://10.1.0.228:8200"
  enabled = true
  renew_token = false
  ssl {
    enabled = false
  }

	auth {
    method = "approle"
    config = {
      role_id_file_path = "/etc/consul-template/role_id"
      secret_id_file_path = "/etc/consul-template/secret_id"
    }
  }
}

template {
  source      = "/templates/postgres-config.tpl"
  destination = "/run/secrets/postgres_password"
  perms       = 0644
  command     = "echo 'Template processed'"
  command_timeout = "30s"
}