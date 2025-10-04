resource "aws_iam_role" "bastion_role" {
  name               = "bastion_role"
  assume_role_policy = data.aws_iam_policy_document.gh-actions-trust-policy.json
}

resource "aws_iam_role_policy_attachment" "bastion-attachment" {
  role       = aws_iam_role.bastion_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
