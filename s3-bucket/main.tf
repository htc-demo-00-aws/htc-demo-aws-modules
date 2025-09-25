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

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.prefix}-${random_id.suffix.hex}"
}
