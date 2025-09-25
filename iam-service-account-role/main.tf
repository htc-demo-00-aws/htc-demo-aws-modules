terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.13.0"
    }
  }
}

resource "random_id" "suffix" {
  byte_length = 8
}

resource "aws_iam_role" "role" {
  name        = "service-account-role-${random_id.suffix.hex}"
  description = "IAM Role for service account"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.federated_principal
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${var.cluster_oidc_issuer}:aud" = "sts.amazonaws.com"
            "${var.cluster_oidc_issuer}:sub" = "system:serviceaccount:${var.namespace[0]}:${var.service_account_name[0]}"
          }
        }
      }
    ]
  })
}
