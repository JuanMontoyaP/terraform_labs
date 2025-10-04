data "aws_iam_policy_document" "gh-actions-trust-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.gh-actions.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:JuanMontoyaP/terraform_labs:ref:refs/heads/main"]
    }
  }
}

