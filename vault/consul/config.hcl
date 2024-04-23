vault {
  address = "http://10.1.0.228:8200"
  enabled = true
  renew_token = false
  ssl {
    enabled = false
  }
}

template {
  source      = "/templates/postgres-config.tpl"
  destination = "/run/secrets/postgres_password"
  perms       = 0644
  command     = "echo 'Template processed'"
  command_timeout = "30s"
}