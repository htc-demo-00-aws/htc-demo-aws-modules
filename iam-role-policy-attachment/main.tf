terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 6.13.0"
    }
  }
}

resource "aws_iam_role_policy_attachment" "attachment" {
  role       = var.role_name[0]
  policy_arn = var.policy_arn[0]
}
