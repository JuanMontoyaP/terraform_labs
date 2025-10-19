output "gh_role_arm" {
  description = "The ARN of the GH actions role"
  value       = aws_iam_role.gh-actions-role.arn
}

output "ec2_role_arn" {
  description = "The ARN of the EC2 role"
  value       = aws_iam_role.ec2_role.arn
}
