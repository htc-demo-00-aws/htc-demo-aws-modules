terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
  }
}

resource "kubernetes_annotations" "ebs-csi-sa" {
  api_version = "v1"
  kind        = "ServiceAccount"

  metadata {
    name      = var.service_account_name
    namespace = var.namespace
  }

  annotations = {
    "eks.amazonaws.com/role-arn" = var.iam_role_arn
  }
}
