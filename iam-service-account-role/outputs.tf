output "arn" {
  description = "The ARN of the IAM role."
  value       = aws_iam_role.role.arn
}

output "name" {
  description = "The name of the IAM role."
  value       = aws_iam_role.role.name
}
