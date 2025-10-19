data "aws_iam_policy_document" "gh-actions-trust-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.gh-actions.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:JuanMontoyaP/terraform_labs:ref:refs/heads/*",
        "repo:JuanMontoyaP/terraform_labs:ref:refs/tags/*",
        "repo:JuanMontoyaP/terraform_labs:pull_request"
      ]
    }
  }
}

data "aws_iam_policy_document" "ec2-trust-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.user_arn, aws_iam_role.gh-actions-role.arn]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "gh-actions-tf-policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::tf-labs-state-juan",
      "arn:aws:s3:::tf-labs-state-juan/*",
    ]
  }
}
