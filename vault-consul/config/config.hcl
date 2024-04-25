vault {
  address = "http://10.1.0.228:8200"
  token = ""
  renew_token = false
  ssl {
    enabled = false
  }
}

template {
  source = "config/config.yml.tpl"
  destination = "config/config.yml"
  perms = 0644
  command = "echo 'watching templates'" # systemctl restart myapp.service
  command_timeout = "30s"
}