output "bastion_role_arn" {
  description = "The ARN of the bastion role"
  value       = aws_iam_role.bastion_role.arn
}
