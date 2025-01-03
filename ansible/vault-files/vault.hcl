ui = true

disable_mlock = true

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node1"
}

# kms for auto unseal
# seal "awskms" {
#  region = "sa-east-1"
#  kms_key_id = "arn:aws:kms:sa-east-1:682033465953:key/78c051e8-9a2f-4fb1-9aec-8f18ec00f057"
# }

listener "tcp" {
  address     = "0.0.0.0:8200"
  cluster_address = "0.0.0.0:8201"
  tls_disable = "true"
}

api_addr = "http://127.0.0.1:8200"
cluster_addr = "http://127.0.0.1:8201"