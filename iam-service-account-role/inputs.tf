variable "federated_principal" {
  type = string
}

variable "cluster_oidc_issuer" {
  type = string
}

variable "namespace" {
  type = list(string)
}

variable "service_account_name" {
  type = list(string)
}
