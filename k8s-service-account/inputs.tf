variable "namespace" {
  description = "The Kubernetes namespace where the service account will be created."
  type        = string
}

variable "cluster_oidc_issuer" {
  description = "The issuer of the OIDC token for the cluster."
  type        = string
}

variable "federated_provider" {
  description = "The federated provider for the cluster."
  type        = string
}
