#!/bin/bash

# fix permissions 
chown -R vault:vault /vault/config
chown -R vault:vault /vault/logs
chown -R vault:vault /vault/data

# start vault
# exec vault server -config=/vault/config/vault.hcl