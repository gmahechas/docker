vault {
  address = "http://10.1.0.228:8200"
  renew_token = false
  ssl {
    enabled = false
  }
}

template {
  source      = "/templates/postgres-config.ctmpl"
  destination = "/run/secrets/postgres_password"
	create_dest_dirs = true
  perms       = 0644
  command     = "echo 'Template processed'"
  command_timeout = "30s"
}