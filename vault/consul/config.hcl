vault {
  address = "http://10.1.0.228:8200"
  ssl {
    enabled = false
  }

	auth {
    enabled = true
    type = "approle"
    params {
      role_id = "tu_role_id"
      secret_id = "tu_secret_id"
    }
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