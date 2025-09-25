terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.3"
    }
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.13.0"
    }
  }
}

resource "random_id" "service_account_name" {
  byte_length = 8
}

resource "kubernetes_service_account" "service_account" {
  lifecycle {
      ignore_changes = [
        metadata[0].annotations["eks.amazonaws.com/role-arn"]
      ]
    }
  
  metadata {
    name = random_id.service_account_name.hex
    namespace = var.namespace
  }
}
