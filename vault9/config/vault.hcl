cluster_name = "vault-dev-local"
ui = true

storage "mysql" {
  username = "root"
  password = "root"
  database = "vault"
  address = "10.1.0.229:3306"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = "true"
}
