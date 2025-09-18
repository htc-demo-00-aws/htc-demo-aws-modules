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
  metadata {
    name = random_id.service_account_name.hex
    namespace = var.namespace

    annotations = {
    "eks.amazonaws.com/role-arn" = aws_iam_role.role.arn
  }
  }
}

# Resources below should be separated into modules

resource "aws_iam_policy" "policy" {
  name        = "demo-app-${random_id.service_account_name.hex}"
  description = "IAM policy for Humanitec runner - allows managing objects from S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          "arn:aws:s3:::*",
          "arn:aws:s3:::*/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "role" {
  name        = "demo-app-${random_id.service_account_name.hex}"
  description = "IAM Role for Humanitec runner"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = var.federated_provider
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${var.cluster_oidc_issuer}:aud" = "sts.amazonaws.com"
            "${var.cluster_oidc_issuer}:sub" = "system:serviceaccount:${var.namespace}:${random_id.service_account_name.hex}"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}
