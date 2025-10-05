resource "aws_iam_role" "gh-actions-role" {
  name               = "gh-actions-role"
  assume_role_policy = data.aws_iam_policy_document.gh-actions-trust-policy.json
}

resource "aws_iam_policy" "gh-actions-tf-policy" {
  name        = "gh-actions-tf-policy"
  description = "Policy for GitHub Actions to manage Terraform state in S3 and DynamoDB"
  policy      = data.aws_iam_policy_document.gh-actions-tf-policy.json
}

resource "aws_iam_role_policy_attachment" "gh-actions-tf-policy" {
  role       = aws_iam_role.gh-actions-role.name
  policy_arn = aws_iam_policy.gh-actions-tf-policy.arn
}
