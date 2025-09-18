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
  bucket = "${var.aws_s3_bucket_name}-${random_id.suffix.hex}"
}
