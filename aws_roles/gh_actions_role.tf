resource "aws_iam_role" "gh-actions-role" {
  name               = "gh-actions-role"
  assume_role_policy = data.aws_iam_policy_document.gh-actions-trust-policy.json
}
