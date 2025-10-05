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

data "aws_iam_policy_document" "bastion-trust-policy" {
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

  statement {
    effect = "Allow"

    actions = [
      "dynamodb:DescribeTable",
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/tf-labs-locks-juan"
    ]
  }
}
