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

resource "aws_iam_policy" "policy" {
  name        = "bucket-permissions-policy-${var.bucket_name}-${random_id.suffix.hex}"
  description = "Permissions policy for bucket ${var.bucket_name}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*"
        ]
      }
    ]
  })
}