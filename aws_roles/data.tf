data "aws_iam_policy_document" "ec2-trust-policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.user_arn, var.gh_actions_role_arn]
    }

    actions = ["sts:AssumeRole"]
  }
}
