output "name" {
  description = "The name of the AWS S3 bucket."
  value       = aws_s3_bucket.bucket.bucket
}
