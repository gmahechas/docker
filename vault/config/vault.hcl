api_addr = "http://vault.gmahechas.local:8200"
ui = true

storage "file" {
  path = "/vault/data"
}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = "true"
}